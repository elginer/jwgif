FileStream fileIn: 'wireworld.st'.
FileStream fileIn: 'gif.st'.

Object subclass: #GIFRenderer.

GIFRenderer instanceVariableNames: 'size handle'.

GIFRenderer comment:
'I am a Wireworld renderer which produces animated GIFs.  I produce red squares for electron heads, blue squares for electron tails, green squares for conductors and black squares for empty.'.

GIFRenderer extend [

   width: w height: h size: s [
      "This method sets the width and height of the gif and the size of the squares."
      handle := Gif width: w height: h.
      size := s.
   ]

   draw: rows frameNo: frame [
      "This method takes a 2d array of wireworld cell descriptions and sends an animated gif to stdout."
      | x y |
      Gif frame.
      y := 0.
      rows reverse do: [:row |
         x := 0.
         row do: [:cell |
            self draw: cell here: x@y.
            x := x + size.
         ].
         y := y + size.
      ]
   ]

   draw: cell here: pt [
      "This method draws a cell at the given point."
      | col choices |
      choices := Dictionary new.
      choices at: #Conductor put: 'green'.
      choices at: #Head put: 'red'.
      choices at: #Tail put: 'blue'.
      choices at: #Empty put: 'black'.
      col := choices at: cell.
      Gif x: (pt x) y: (pt y) size: size colour: col
   ]

   stop [
      "This method shuts down the drawing subsystem."
      Gif stop: handle.
   ]

]

args := Smalltalk arguments.

"Check for correct number of arguments."
(args size = 5) ifTrue: [
   filename := args at: 1.
   generations := (args at: 2) asNumber.
   w := (args at: 3) asNumber.
   h := (args at: 4) asNumber.
   s := (args at: 5) asNumber.
   gr := GIFRenderer new.
   gr width: w height: h size: s.
   world := WireWorld load: filename drawWith: gr.
   world run: generations. 
   gr stop.
]
ifFalse: [
   'Usage: jwgif FILENAME GENERATIONS WIDTH HEIGHT SQUARESIZE' displayNl.
]
