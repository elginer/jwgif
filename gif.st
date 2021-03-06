"===================================================================== 
| Copyright John Morrice 2010.
|
| Contact spoon@killersmurf.com
|
| This file is part of jwgif.
|
| jwgif is free software: you can redistribute it and/or modify
| it under the terms of the GNU General Public License as published by
| the Free Software Foundation, either version 3 of the License, or
| (at your option) any later version.
|
| jwgif is distributed in the hope that it will be useful,
| but WITHOUT ANY WARRANTY; without even the implied warranty of
| MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
| GNU General Public License for more details.
|
| You should have received a copy of the GNU General Public License
| along with jwgif.  If not, see <http://www.gnu.org/licenses/>.
======================================================================"

DLD addLibrary: 'libwiregif'.

DLD defineCFunc: 'gif_start' as: gif_start.
DLD defineCFunc: 'gif_stop' as: gif_stop.
DLD defineCFunc: 'gif_square' as: gif_square.
DLD defineCFunc: 'gif_frame' as: gif_frame.

Object subclass: #Gif.

Gif comment:
'I am a class which provides methods for creating simple animated gifs.'.

Gif class extend [

   size: s width: w height: h [
      "This method is used internally to start the gif drawing subsystem."
      <cCall: 'gif_start' returning: #int args: #(#string #uInt #uInt)>
   ]

   stop: handle [
      "This method shuts down the gif drawing system."
      <cCall: 'gif_stop' returning: #void args: #(#int)>
   ]

   x: hpos y: vpos size: len colour: col [
      "This method draws a square."
      <cCall: 'gif_square' returning: #void args: #(#uInt #uInt #uInt #string)>
   ]

   frame [
      "This method creates a new frame."
      <cCall: 'gif_frame' returning: #void args: #()>
   ]

   width: w height: h [
      "This method initializes the gif drawing system."
      ^ self size: ((w asString), 'x', (h asString)) width: w height: h
   ]

]
