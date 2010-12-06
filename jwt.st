FileStream fileIn: 'wireworld.st'.

Object subclass: #TextRenderer.

TextRenderer comment: 
'I am a Wireworld renderer which produces output in ASCII.  I produce H for Head, t for Tail, . for Conductor and space for empty.'.

TextRenderer extend [

   draw: rows frameNo: frame [
      "This method takes a 2d array of wireworld cell descriptions and outputs a text representation of that table."
      'Frame #' display.
      frame displayNl.
      rows do: [:row |
         row do: [:cell |
            | choices |
            choices := Dictionary new.
            choices at: #Empty put: $ .
            choices at: #Conductor put: $..
            choices at: #Head put: $H.
            choices at: #Tail put: $t.
            (choices at: cell) display.
         ].
         Character nl display.
      ].
      Character nl display.
   ]
]

filename := (Smalltalk arguments) at: 1.

world := WireWorld load: filename drawWith: (TextRenderer new).
world run: 10.
