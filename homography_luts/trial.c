#include <stdio.h>
struct coordsXY {float x; float y;};
#define HEIGHT 384
#define  WIDTH 1024
static struct coordsXY homogMap[384][1024];
int main ()
{

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
		{{ -0.000268253303997190	,-0.000529621966270592,	0.214332903554399},
				{0,0.00265998799991739,	-0.976755142385861},
				{0,-0.0000126218,0.00183578919962548}};
		int x,y;
		for(y = 0; y < HEIGHT; y++){
				for(x = 0; x < WIDTH; x++){
						float lambda = homogMat[2][0]*(x) + homogMat[2][1]*y + homogMat[2][2];
						homogMap[y][x].x = homogMat[0][0]*(x) + homogMat[0][1]*y + homogMat[0][2];
						homogMap[y][x].y = homogMat[1][0]*(x) + homogMat[1][1]*y + homogMat[1][2];
						homogMap[y][x].x /= lambda;
						homogMap[y][x].y /= lambda;
					//	homogMap[y][x].y = 384 - homogMap[y][x].y ;
						if (homogMap[y][x].x >1024 || homogMap[y][x].x < 0)
								printf( "%f\n" , homogMap[y][x].x);
				}
		}
}
