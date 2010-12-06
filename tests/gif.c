#include "../gif.h"

int
main()
{
   int handle;
   handle = gif_start("200x200", 200, 200);
   gif_frame();
   gif_square(0, 0, 50, "blue");
   gif_frame();
   gif_square(50, 50, 50, "red");
   gif_frame();
   gif_square(100, 100, 50, "yellow");
   gif_frame();
   gif_square(150, 150, 50, "green");
   gif_stop(handle);
   return 0;
}
