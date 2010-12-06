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
