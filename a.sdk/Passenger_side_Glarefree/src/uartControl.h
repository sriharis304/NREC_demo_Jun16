#define GPIO_BRIGHT_BASEADDR 0x41200000
#define GPIO_THRESH_BASEADDR 0x41210000
#include "xgpio.h"

extern XGpio Gpio_blanking;

char* gpioBrightAddr;
char* gpioThreshAddr;
int roadPosition;
int roadSizeRight;
int roadSizeLeft;
int calibrate;
int cross_row;
int schl_xing_row;
int start_blink;
int start_recording;
int playback_idx;
int road_vert_pos;
float framerate;

//UART Variables and Prototypes//


int setupUartControl();

