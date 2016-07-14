/******************************************************************************
 *
 * Copyright (C) 2009 - 2014 Xilinx, Inc.  All rights reserved.
 *
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to deal
 * in the Software without restriction, including without limitation the rights
 * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included in
 * all copies or substantial portions of the Software.
 *
 * Use of the Software is limited solely to applications:
 * (a) running on a Xilinx device, or
 * (b) that interact with a Xilinx device through a bus or interconnect.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL
 * XILINX  BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
 * WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF
 * OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
 * SOFTWARE.
 *
 * Except as contained in this notice, the name of the Xilinx shall not be used
 * in advertising or otherwise to promote the sale, use or other dealings in
 * this Software without prior written authorization from Xilinx.
 *
 ******************************************************************************/

/*
 * helloworld.c: simple test application
 *
 * This application configures UART 16550 to baud rate 9600.
 * PS7 UART (Zynq) is not initialized by this application, since
 * bootrom/bsp configures it to baud rate 115200
 *
 * ------------------------------------------------
 * | UART TYPE   BAUD RATE                        |
 * ------------------------------------------------
 *   uartns550   9600
 *   uartlite    Configurable only in HW design
 *   ps7_uart    115200 (configured by bootrom/bsp)
 */

//#include <stdio.h>
#include <assert.h>
#include <math.h>
#include <string.h>
#include <stdio.h>
#include <stdlib.h>
#include <time.h>
#include <limits.h>
#include "uartControl.h"

#ifdef __linux__

#include <sys/mman.h>
#include <unistd.h>
#include <fcntl.h>
#include <stdint.h>
#define u16 uint16_t

#else

#include "platform.h"
#include <xbasic_types.h>
#include "xparameters.h"

#endif

#include "images.h"

//These are the dimensions and resolution of the buffer that holds what the image should look like on the road
#define FEET_WIDTH 32
#define FEET_LENGTH 256
#define INCHES_PER_FOOT 12
#define RES_PER_INCH 2
#define ROAD_WIDTH (FEET_WIDTH*INCHES_PER_FOOT*RES_PER_INCH)
#define ROAD_LENGTH (FEET_LENGTH*INCHES_PER_FOOT*RES_PER_INCH)
#define ROAD_BUFFER_SIZE_BYTES ((ROAD_WIDTH*ROAD_LENGTH/8))


#define WORD_WIDTH 16
#define NUM_TRIES 3
//Dimesions of projector image
#define WIDTH 1024
#define HEIGHT 384
#define BUF_SIZE_BYTES ((WIDTH * HEIGHT / 8))

//each bram address is for a projector image layer.  Currently 0 is full bright layer and 1 is adjustable brightness layer 
#define BRAM_BASEADDR0 0x40000000
#define BRAM_BASEADDR1 0x42000000

#define CLOCKS_PER_SEC_ADJ (CLOCKS_PER_SEC*13333) //constant seems to be off by approx 13333 times, this was determined by experiment, should figure out why and use actual numbers 
//number of frames to record so it can be played back at a higher rate
#define NUM_REC_FRAMES 1200
XGpio Gpio_blanking;

//These allow triangles to be rendered. not currently used and not sure if needed
// Defines a triangle with 3 2d points
typedef struct {
		float x0;
		float y0;
		float x1;
		float y1;
		float x2;
		float y2;
} triangle;

//variables that will hold the address of the bram (used as virual address if linux is booted)
static u16* maskAddr0;
static u16* maskAddr1;

static const int width = ROAD_WIDTH;
static const int height = ROAD_LENGTH;
static triangle tris[NUM_TRIES];
//roadBuffers hold what the image should look like on the road
static u16 roadBuffer0[ROAD_BUFFER_SIZE_BYTES / sizeof(u16)];
static u16 roadBuffer1[ROAD_BUFFER_SIZE_BYTES / sizeof(u16)];
//buffers hold what image will be projected after homography
static u16 buffer0[BUF_SIZE_BYTES / sizeof(u16)];
static u16 buffer1[BUF_SIZE_BYTES / sizeof(u16)];
//Hold the recorded frames of buffer so they can be played back at higher speeds
static u16 buffer0_rec[NUM_REC_FRAMES][BUF_SIZE_BYTES / sizeof(u16)];
static u16 buffer1_rec[NUM_REC_FRAMES][BUF_SIZE_BYTES / sizeof(u16)];
//needed to use mmap in a linux booted system
static unsigned page_offset0 = 0,  page_offset1 = 0;

//used to store the lookup table for the homography
struct coordsXY {float x; float y;};
static struct coordsXY homogMap[HEIGHT][WIDTH];

//number of frames currently recorded
int numFramesRecorded = 0;
//timer Variables
unsigned int * const TIMER_PTR = XPAR_PS7_SCUTIMER_0_BASEADDR + 0x04;
unsigned int * const TIMER_CONFIG_PTR = XPAR_PS7_SCUTIMER_0_BASEADDR + 0x08;
/* UNTESTED BUT SHOULD FIX THE ROLOVER ISSUE!!!!*/
unsigned int * const TIMER_LOAD_PTR = XPAR_PS7_SCUTIMER_0_BASEADDR;

//Finds the inverse of a 3by3 matrix. Thought it would be usefull for homography but wasn't needed.  left incase it becomes useful
void get3by3Inv(float matInv[3][3], float mat[3][3]){

		matInv[0][0]  = mat[1][1]*mat[2][2] - mat[1][2]*mat[2][1];
		matInv[0][1]  = mat[1][0]*mat[2][2] - mat[1][2]*mat[2][0];
		matInv[0][2]  = mat[1][0]*mat[2][1] - mat[1][1]*mat[2][0];

		float detMat = mat[0][0]*matInv[0][0] - mat[0][1]*matInv[0][1] +
				mat[0][2]*matInv[0][2];

		matInv[0][0] /= detMat;
		matInv[0][1] /= detMat;
		matInv[0][2] /= detMat;
		unsigned int i;
		unsigned int j;
		for(i = 1; i < 3; i++){
				for(j = 0; j < 3; j++){
						float a11 = mat[(i+1)%3][(j+1)%3];
						float a22 = mat[(i+2)%3][(j+2)%3];
						float a12 = mat[(i+1)%3][(j+2)%3];
						float a21 = mat[(i+2)%3][(j+1)%3];
						matInv[i][j] = a11*a22 - a12*a21;
						matInv[i][j] /= detMat;
				}
		}

}

//Creates the lookuptable for the current homography
void setHomography(){
		//Stores the 3 by 3 matrix computed from the matlab script
		float homogMat[3][3] =
				//RIGTH HEADLIGHT
				/*(  {{0.00002167, -.00019219, 0.05376644},
				  {0,-.00313967, 0.99854856},
				  {0,-.00000050, 0.00016892}};*/
				//RIGHT HEADLIGHT old
				/*{{0.0000222, -.0002044, 0.0510175},
				  {0,-.0033945,.9986919},
				  {0,-0.0000005, 0.0001705}};*/
				//LEFT HEADLIGHT
		{{0.00002227, -.00023068, 0.05311429},
				{0,-.00375642,.99858133},
				{0,-.00000060,0.00016931}};
		/*{{.0000212,-.0002061,.0529524},
		  {0,-.0033171,.9985915},
		  {0,-.0000005,0.0001670}};&/
		/*{{.0002123,-.0020588,0.5288135},
		{0,-0.0042736,0.8487230},
		{0,-.0000053,0.0016971}};*/

		/*{{.0002724,.0014441,-0.2860961},
		  {0,0.0030426,-0.9581948},
		  {0,.0000037,-0.0003784}};*/

		/*{{0.000312,.000457,-0.223691},
		  {0,0.002871,-0.974655},
		  {0,.000001,-0.000110}};*/
		int y;
		int x;
		for(y = 0; y < HEIGHT; y++){
				for(x = 0; x < WIDTH; x++){
						float lambda = homogMat[2][0]*(x) + homogMat[2][1]*y + homogMat[2][2];
						homogMap[y][x].x = homogMat[0][0]*(x) + homogMat[0][1]*y + homogMat[0][2];
						homogMap[y][x].y = homogMat[1][0]*(x) + homogMat[1][1]*y + homogMat[1][2];
						homogMap[y][x].x /= lambda;
						homogMap[y][x].y /= lambda;
				}
		}
}

//This function uses the lookup table to create the homographied version of the image
void transferHomog(u16 *destBuf, u16 *sourceBuf){

		u16 *charDest = destBuf;
		u16 *charSource = sourceBuf;
		int y;
		int x;
		int bit;
		//go to every location in the out image one by one
		for(y = 0; y < HEIGHT; y++){
				//only WIDTH/16 as many x locations because the word size is 16 bits and each pixel is a bit
				for(x = 0; x < WIDTH/16; x++){
						//temporary 16bit word set to all ones so bitwise and operations can be done to set each bit
						u16 curWord = 65535;
						//loop through each bit in the word and set it
						for(bit = 0; bit < 16; bit++){
								//set a 1 at the current bit
								u16 destBitMask = 1<<(15-bit);

								//get the x coordinate in the source buffer that maps to the current location in the destination buffer
								int sourceX = (int)(homogMap[y][x*16+bit].x + .5);
								//mod by 16 to get the bit index within the source word
								u16 sourceBit = sourceX%16;
								//create a source bit mask to extract the bit we want
								u16 sourceBitMask = 1 << (15-sourceBit);

								//get the source y location
								int sourceY = (int)(homogMap[y][x*16+bit].y + .5);
								//check if the location would be out of bounds on the road buffer, if so do nothing ad let it stay set to 1
								if(sourceX >=0 && sourceX < ROAD_WIDTH && sourceY >=0 && sourceY <
												ROAD_LENGTH){
										//determine if the source bit needs to be shifted left or right to allign with the destination bit
										if(sourceBit > bit){
												//mask shift and assign the bit from the source to the bit in the dest without altering the other bits in the word
												u16 shiftDiff = sourceBit - bit;
												u16 val = charSource[sourceY*ROAD_WIDTH/16  +
														sourceX/16] & sourceBitMask;
												curWord = curWord & (destBitMask ^ ~(val << shiftDiff));
										}else{
												//same as in the 'if' but uses right shift instead of left
												u16 shiftDiff = bit - sourceBit;
												u16 val = charSource[sourceY*ROAD_WIDTH/16  +
														sourceX/16] & sourceBitMask;
												curWord = curWord & (destBitMask ^ ~(val >>shiftDiff));
										}
								}
						}
						//assign the temporary word to the actual buffer
						charDest[y*WIDTH/16 + x] = curWord;
				}
		}

}

//More triangle functions currently unused
// Determines whether the testpoint (xt,yt) is 'inside' the other two lines
// This is used in triangle rasterization
int inside(double x0, double y0,
				double x1, double y1,
				double xt, double yt) {
		return ((x1 - x0) * (yt - y0) - (y1 - y0) * (xt - x0));
}

inline void setBit(int row, int col, u16 *buf) {
		int index = (row * width + col) / 16;
		int bitIndex = col % 16;
		u16 oldVal = buf[index];
		u16 newVal = oldVal | (0x8000 >> bitIndex);

		buf[index] = newVal;
}

// Accepts 3 points to be rasterized into the frame buffer.
// These are specified here in normalized space for convenience
void rasterize_triangle( triangle *tri) {
		double xmin, xmax, ymin, ymax;
		double x0, y0, x1, y1, x2, y2;
		int xmini, xmaxi, ymini, ymaxi;
		int xt, yt;
		int s1, s2, s3;
		u16 *buf;

		x0 = tri->x0;
		y0 = tri->y0;
		x1 = tri->x1;
		y1 = tri->y1;
		x2 = tri->x2;
		y2 = tri->y2;

		// Set the rendering buffer; this can be BRAM or local memory
		buf = roadBuffer0;

		// Order the points in counter-clockwise order
		if (inside(x0, y0, x1, y1, x2, y2) > 0) {
				// swap points x1,y1 and x2,y2
				double temp = x1;
				x1 = x2;
				x2 = temp;
				temp = y1;
				y1 = y2;
				y2 = temp;
		}

		xmin = x1 < x2 ? (x0 < x1 ? x0 : x1) : (x0 < x2 ? x0 : x2);
		ymin = y1 < y2 ? (y0 < y1 ? y0 : y1) : (y0 < y2 ? y0 : y2);
		xmax = x1 > x2 ? (x0 > x1 ? x0 : x1) : (x0 > x2 ? x0 : x2);
		ymax = y1 > y2 ? (y0 > y1 ? y0 : y1) : (y0 > y2 ? y0 : y2);

		xmini = (int) xmin;
		ymini = (int) ymin;
		xmaxi = ((int) xmax)+1;
		ymaxi = ((int) ymax)+1;

		for (yt = ymini; yt < ymaxi; yt++) {
				for (xt = xmini; xt < xmaxi; xt++) {
						if (xt < 0 || xt >= width ||
										yt < 0 || yt >= height) {
								continue;
						}

						// Calculate whether these points are 'inside' the line
						s1 = inside(x0, y0, x1, y1, xt, yt);
						s2 = inside(x1, y1, x2, y2, xt, yt);
						s3 = inside(x2, y2, x0, y0, xt, yt);

						if ((s1 >= 0 && s2 >= 0 && s3 >= 0) ||
										(s1 <= 0 && s2 <= 0 && s3 <= 0)) {
								setBit(yt, xt, buf);
						}
				}
		}
}

void walkTriangle(triangle *tri) {
		int w;
		const int s = 5;
		w = rand() % s;
		tri->x0 += w - 3;
		w = rand() % s;
		tri->y0 += w - 3;
		w = rand() % s;
		tri->x1 += w - 3;
		w = rand() % s;
		tri->y1 += w - 3;
		w = rand() % s;
		tri->x2 += w - 3;
		w = rand() % s;
		tri->y2 += w - 3;
}


// Renders the triangles in the buffer
void renderTriangles()
{
		int i;
		for (i = 0; i < NUM_TRIES; i++) {
				rasterize_triangle(&tris[i]);
				//walkTriangle(&tris[i]);
		}
}

//Renders 16 bits of a box in a image, must be called in a loop to render over the whole image
u16 renderBox(int row, int col0, int boxrow, int boxcol, int boxHeight, int boxWidth)
{
		u16 value = 0x00;
		// Note that this implies a coord space where the origin is at the top left of the image
		//const int boxLength = 350;
		const int left 		= boxcol - boxWidth/2;
		const int right 	= boxcol + boxWidth/2;
		const int top		= boxrow - boxHeight/2;
		const int bot		= boxrow + boxHeight/2;

		if (row >= top &&
						row < bot) {
				// Get the bit position of the start of the box, relative to col 0
				int colStart = left - col0;
				int colEnd = right - col0;

				// Clamp up to 0
				colStart = (colStart < 0) ? 0 : colStart;
				colEnd = (colEnd >= WORD_WIDTH) ? WORD_WIDTH - 1 : colEnd;

				// Check if the start and end overlap
				if (colStart < colEnd) {
						value = (unsigned)0xffff >> colStart;
						value = value ^ ((unsigned)0xffff >> (colEnd+1));
				}
		}
		return value;
}

//Draws an image in one buffer using exclusive or, this allows it to draw black on lit up areas or white on dark areas
//works one 16bit word at a time similar to render box
void drawImg(const u16 *imgBuf,int imgWidth, int imgHeight, int vertPos, int horzPos, int curRow, int curCol, u16 *buf0){
		int startRow = vertPos - imgHeight/2;
		int startCol = horzPos - imgWidth/2;
		int endRow = startRow + imgHeight;
		int endCol = startCol + imgWidth;
		if(curRow >= startRow && curRow < endRow && curCol >= startCol && curCol < endCol){
				int imageRow = (curRow - startRow);
				int imageCol = (curCol - startCol)/WORD_WIDTH;
				*buf0 = *buf0 ^ imgBuf[imageRow*(imgWidth/WORD_WIDTH) + imageCol];
		}
}

//similar to drawImage but only allows image to be drawn black on lit up areas.  Takes both buffers as arguments and wherever either is bright 
void drawImgAnd(const u16 *imgBuf,int imgWidth, int imgHeight, int vertPos, int horzPos, int curRow, int curCol, u16 *buf0, u16 *buf1){
		int startRow = vertPos - imgHeight/2;
		int startCol = horzPos - imgWidth/2;
		int endRow = startRow + imgHeight;
		int endCol = startCol + imgWidth;
		u16 anyRoad = *buf0 | *buf1;
		if(curRow >= startRow && curRow < endRow && curCol >= startCol && curCol < endCol){
				int imageRow = (curRow - startRow);
				int imageCol = (curCol - startCol)/WORD_WIDTH;
				*buf0 = anyRoad & imgBuf[imageRow*imgWidth/WORD_WIDTH + imageCol];
				*buf1 = *buf0;
		}
}
//The major function that creates the images to be projected
void write_frame()
{
		//Configure Timer
		static int previous_time = UINT_MAX;

		unsigned int cur_time = *TIMER_PTR;

		float time_per_frame = ((float)(previous_time - cur_time))/CLOCKS_PER_SEC_ADJ;
		printf("Time Per Frame: %f\n", time_per_frame);
		previous_time = cur_time;

		float cur_time_fl = ((float)cur_time)/CLOCKS_PER_SEC_ADJ;

		//Cross Walk Speed, moves by 17 pixels a frame, set to move at ~30mph when plated back at 60fps
		const int CROSS_SPEED_PX = 17;


		//this blinks the arrow slowly faster and faster
		//start time is when the arrow starts blinking
		static float blink_start_time = ((float)UINT_MAX)/CLOCKS_PER_SEC_ADJ;
		//Time the arrow stays on or off for 4 seconds, slowly gets shorter each blink
		static float blink_time = 4;
		//flag with whether to draw the arrow or not
		static int arrowOn = 0;
		//start_blink is set in uart controls
		if(start_blink == 1){
				blink_time = 4;
				start_blink = 0;
				blink_start_time = cur_time_fl;
				arrowOn = 1;
		}
		//Blink until the blink become too short
		if(blink_time){
				float time_since_blink = blink_start_time - cur_time_fl;
				//change the state of the arrrow and shorten the blink
				if(time_since_blink > blink_time){
						blink_start_time = cur_time_fl;
						arrowOn = !arrowOn;
						blink_time *= .8;
						if(blink_time < .01){
								blink_time = 0;
								arrowOn = 0;
						}
				}
		}

		//Lane Highlighting
		int row, col;//keep track of where in the image is currently being rendered
		int myLaneCol = roadPosition + roadSizeRight/2; //horizontal position of right lane
		int otherLaneCol = roadPosition - roadSizeLeft/2;//horizontal position of left lane


		for (row = 0; row < ROAD_LENGTH; row++) {
				//step by 16 horizontaly because wordwidth is 16
				for (col = 0; col < ROAD_WIDTH; col+=16) {
						int index = (row * ROAD_WIDTH + col)/16;
						assert(index < (ROAD_WIDTH * ROAD_LENGTH)/16);
						// We need to extend the address because every other set of 16 bits isn't used
						//get the address of the current word in the buffer
						u16 *addr0 = &roadBuffer0[index];
						//render that word of the buffer
						u16 value0 = renderBox(row, col, road_vert_pos, myLaneCol,ROAD_LENGTH, roadSizeRight);
						*addr0 = value0;

						//render the left road in the second buffer that can be dimed
						u16 *addr1 = &roadBuffer1[index];
						u16 value1 = renderBox(row, col, road_vert_pos, otherLaneCol, ROAD_LENGTH, roadSizeLeft);
						// This determines the actual pattern of the light
						*addr1 = value1;

						//render the images if they are in view
						if(schl_xing_row < ROAD_LENGTH){
								drawImgAnd(schoolXingImg,160,112,schl_xing_row,roadPosition+roadSizeRight/2,row,col,addr0,addr1);
						}
						if(cross_row < ROAD_LENGTH){
								drawImgAnd(crosswalkImg,768,192,cross_row,roadPosition,row,col,addr0,addr1);
						}
						if(arrowOn){
								drawImgAnd(arrowImg,80,352,ROAD_LENGTH - 30*RES_PER_INCH*INCHES_PER_FOOT, roadPosition + roadSizeRight/2, row,col,addr0,addr1);
						}
				}
		}

		//move the cross walk and school crossing down the screen
		cross_row += CROSS_SPEED_PX;
		schl_xing_row += CROSS_SPEED_PX;

		//apply homography to the image and transfer it to the projector buffer
		transferHomog(buffer0, roadBuffer0);//, homogMap);
		transferHomog(buffer1, roadBuffer1);
		//record the frame if it is set up to record and the buffer isn't full
		static int frame_idx = -1;
		if(start_recording ==1){
				frame_idx = 0;
				start_recording = 0;
				numFramesRecorded = 0;
				printf("\n\nStart Recording\n\n");
		}
		if(frame_idx >= NUM_REC_FRAMES){
				frame_idx = -1;
				printf("\n\nEnd Recording\n\n");
		}else if(frame_idx >=0){
				memcpy(buffer0_rec[frame_idx],buffer0,BUF_SIZE_BYTES);
				memcpy(buffer1_rec[frame_idx],buffer1,BUF_SIZE_BYTES);
				frame_idx ++;
				numFramesRecorded++;
		}

}

//works similar to the main loop in write_frame but only draws 4 boxes
void write_calibration()
{
		memset(buffer0,0,BUF_SIZE_BYTES);
		memset(buffer1,0,BUF_SIZE_BYTES);
		int row, col;
		//these are the locations of the 4 boxes needed in the matlab script
		int topRow = 75, bottomRow = 150;
		int leftCol = 112, rightCol = 912;
		for (row = 0; row < HEIGHT; row++) {
				for (col = 0; col < WIDTH; col+=16) {
						int index = (row * WIDTH + col)/16;
						assert(index < (WIDTH * HEIGHT)/16);
						// We need to extend the address because every other set of 16 bits isn't used
						u16 *addr0 = &buffer0[index];
						u16 value0 = renderBox(row, col, topRow, leftCol,25,50);
						u16 value1 = renderBox(row, col, bottomRow, leftCol,25,50);
						u16 value2 = renderBox(row, col, topRow, rightCol,25,50);
						u16 value3 = renderBox(row, col, bottomRow, rightCol,25,50);
						*addr0 = value0 | value1 | value2 | value3;
				}
		}

}

void initTriangles() {
		// It's easier to think in normalized coordinates, so these are all specified in [0,1]
		tris[0].x0 = 0.25;
		tris[0].y0 = 0.25;
		tris[0].x1 = 0.25;
		tris[0].y1 = 0.6;
		tris[0].x2 = 0.35;
		tris[0].y2 = 0.35;

		tris[1].x0 = 0.75;
		tris[1].y0 = 0.75;
		tris[1].x1 = 0.75;
		tris[1].y1 = 0.4;
		tris[1].x2 = 0.65;
		tris[1].y2 = 0.65;

		tris[2].x0 = 0.47;
		tris[2].y0 = 0.1;
		tris[2].x1 = 0.53;
		tris[2].y1 = 0.1;
		tris[2].x2 = 0.5;
		tris[2].y2 = 0.13;

		// Convert from normalized coordinates into pixel coordinates
		int i;
		for (i = 0; i < NUM_TRIES; i++) {
				tris[i].x0 *= width;
				tris[i].y0 *= height;
				tris[i].x1 *= width;
				tris[i].y1 *= height;
				tris[i].x2 *= width;
				tris[i].y2 *= height;
		}
}


//copies the frame to the fpga to be displayed
void copy_frame() {

		/*int i;
		  for(i = 0; i < HEIGHT; i++){
		  memcpy((maskAddr + page_offset +i*WIDTH/16), &roadBuffer[i*ROAD_WIDTH/8/sizeof(u16)], ROAD_WIDTH/8);
		  }*/
		//memcpy(maskAddr + page_offset, buffer,BUF_SIZE_BYTES);
		memcpy(maskAddr0 + page_offset0, buffer0,BUF_SIZE_BYTES);

		memcpy(maskAddr1 + page_offset1, buffer1,BUF_SIZE_BYTES);

		//memset(maskAddr0 + page_offset0, 255,BUF_SIZE_BYTES);

		//memset(maskAddr1 + page_offset1, 255,BUF_SIZE_BYTES);
}

//copies the recoded frames back at a set frame rate
void playback_frames(){
		static int previous_time = UINT_MAX;

		unsigned int cur_time = *TIMER_PTR;
		if(playback_idx == 0){
				previous_time = UINT_MAX;
		}
		//*TIMER_PTR = UINT_MAX; //reset timer to max amount
		float time_since_last = ((float)(previous_time - cur_time))/CLOCKS_PER_SEC_ADJ;
		printf("Playback time: %f\n", time_since_last);
		if(time_since_last > 1.0/framerate){
				memcpy(maskAddr0 + page_offset0, buffer0_rec[playback_idx], BUF_SIZE_BYTES);
				memcpy(maskAddr1 + page_offset0, buffer1_rec[playback_idx], BUF_SIZE_BYTES);
				previous_time = cur_time;
				printf("Playback Index: %d\n", playback_idx);
				playback_idx++;
				if(playback_idx == numFramesRecorded)
						playback_idx = -1;
		}
}

int main()
{
#ifdef __linux__
		//mmaps the physical address of the brams so writing to them can be done in linux
		unsigned page_addr;
		unsigned page_size=sysconf(_SC_PAGESIZE);
		int fd=open("/dev/mem",O_RDWR);
		unsigned int mmap_round_amt = BUF_SIZE_BYTES%page_size;
		unsigned int mmap_size = BUF_SIZE_BYTES + mmap_round_amt;
		if (fd < 1) {
				return -1;
		}
		page_addr = (BRAM_BASEADDR0 & (~(page_size-1)));
		page_offset0 = BRAM_BASEADDR0 - page_addr;
		maskAddr0 = mmap(NULL, mmap_size, PROT_READ|PROT_WRITE, MAP_SHARED, fd, page_addr);

		page_addr = (BRAM_BASEADDR1 & (~(page_size-1)));
		page_offset1 = BRAM_BASEADDR1 - page_addr;
		maskAddr1 = mmap(NULL, mmap_size, PROT_READ|PROT_WRITE, MAP_SHARED, fd, page_addr);

#else
		init_platform();
		//sets the bram addresses
		maskAddr0 = BRAM_BASEADDR0;
		maskAddr1 = BRAM_BASEADDR1;
		gpioBrightAddr = GPIO_BRIGHT_BASEADDR;
		gpioThreshAddr = GPIO_THRESH_BASEADDR;

		//sets up the uart interupt
		setupUartControl();

		//Configure timer

		*TIMER_CONFIG_PTR = 0x0000FF03;
		*TIMER_PTR = UINT_MAX; //count down from max amount
		/*!! UNTESTED BUT SHOULD FIX THE TIMER ROLLOVER !!*/
		*TIMER_LOAD_PTR = UINT_MAX; //Set rollover value to UINT_MAX
		int Status ;
		Status = XGpio_Initialize(&Gpio_blanking, XPAR_AXI_GPIO_2_DEVICE_ID);
		if (Status != XST_SUCCESS) {
				return XST_FAILURE;
		}
		/*
		   gc	 * Perform a self-test on the GPIO.  This is a minimal test and only
		   gc	 * verifies that there is not any bus error when reading the data
		   gc	 * register
		   gc	 */
		XGpio_SelfTest(&Gpio_blanking);
		//XGpio_SelfTest(&Gpio_fine);


		/*
		   gc	 * Setup direction register so the switch is an input and the LED is
		   gc	 * an output of the GPIO
		 */
		XGpio_SetDataDirection(&Gpio_blanking, 1, 0xFFFF);
		XGpio_SetDataDirection(&Gpio_blanking, 2, 0xFFFF);



#endif
		//Initial settings for variables controlled by the uart
		roadPosition = ROAD_WIDTH/2;
		roadSizeRight = ROAD_WIDTH/4;
		roadSizeLeft = ROAD_WIDTH/4;
		calibrate = 0;
		playback_idx = -1;
		framerate = 60.0;
		road_vert_pos = ROAD_LENGTH/2;

		//Create the homography lookup table
		setHomography();
		//main loop, can playback frames, show calibration squares, and copy the frames out
		while (1) {
				//printf("HERE!\n");
				if(playback_idx >= 0){

						playback_frames();
				}
				else{
						if(calibrate)
								write_calibration();
						else
								write_frame();
						copy_frame();
				}
		}

		cleanup_platform();
		return 0;
}
