/*********************************************************************
* Copyright John Morrice 2010.
* 
* Contact spoon@killersmurf.com
*
* This file is part of jwgif.
*
* jwgif is free software: you can redistribute it and/or modify
* it under the terms of the GNU General Public License as published by
* the Free Software Foundation, either version 3 of the License, or
* (at your option) any later version.
*
* jwgif is distributed in the hope that it will be useful,
* but WITHOUT ANY WARRANTY; without even the implied warranty of
* MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
* GNU General Public License for more details.
*
* You should have received a copy of the GNU General Public License
* along with jwgif.  If not, see <http://www.gnu.org/licenses/>.
**********************************************************************/

#include <stdio.h>
#include <plot.h>

#include "gif.h"

// Run this function to initialize libplot for sending GIF to stdout.
//
// size should be a string like 'widthxheight'
//
// width and height should be greater than 0
//
// Returns the libplot handle.
int
gif_start(char * size, unsigned int width, unsigned int height)
{
   int handle;

   // Set gif options
   pl_parampl("BITMAPSIZE", size);
   pl_parampl("BG_COLOR", "black");
   pl_parampl("GIF_DELAY", "25");
   pl_parampl("GIF_ITERATIONS", "65535");

   // Create the plotter
   handle = pl_newpl("gif", stdin, stdout, stderr);
   // We're using this handle
   pl_selectpl(handle);

   // Begin using graphics
   pl_openpl();
   // Specify coordinate system
   pl_space(0, 0, width - 1, height - 1);

   // The line thickness is 1
   pl_linewidth(1);
   // Objects should be filled
   pl_filltype(1);

   return handle;
}

// Shutdown libplot
//
// Take a libplot handle
void
gif_stop(int handle)
{
   // End using graphics.
   pl_closepl();
   // Select the default plotter
   pl_selectpl(0);
   // Delete the plotter
   pl_deletepl(handle);
}

// Draw a square of a given colour
void
gif_square(unsigned int x, unsigned int y, unsigned int size, char * colour)
{
   // Set the colour
   pl_pencolorname(colour);
   pl_fillcolorname(colour);

   // Draw the square
   pl_box(x, y, x + size, y + size);
}

// A new GIF animation frame
//
// Must be called before any squares can be drawn.
void
gif_frame()
{
   pl_erase();
}
