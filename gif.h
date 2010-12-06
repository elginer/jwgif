// Run this function to initialize libplot for sending GIF to stdout.
//
// size should be a string like 'widthxheight'
//
// width and height should be greater than 0
//
// Returns the libplot handle.
int
gif_start(char * size, unsigned int width, unsigned int height);

// Shutdown libplot
//
// Take a libplot handle
void
gif_stop(int handle);

// Draw a square of a given colour
void
gif_square(unsigned int x, unsigned int y, unsigned int size, char * colour);

// A new GIF animation frame
//
// Must be called before any squares can be drawn.
void
gif_frame();
