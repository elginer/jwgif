Object subclass: #Conductor.

Conductor comment:
'I am a Wireworld conductor.  The next state is an electron Head if there are 1 or 2 electron Heads nearby.'.

Conductor extend [

   next: neighbours [
      "This method returns an Electron Head if 1 or 2 of the neighbours are in Electron head state."
      | heads |
      heads := 0
      neighbours do: [ :other |
         (other what = #Head) ifTrue: [heads := heads + 1]
      ].
      ((heads = 1) or: (heads = 2)) 
      ifTrue: 
         [^ Head new]
      ifFalse:
         [^ self]
   ]   

]

Object subclass: #Head.

Head comment:
'I am an Electron Head.  The next state is an electron tail.'.

Head extend [

   next: neighbours [
      ^ Tail new
   ]

]

Object subclass: #Tail.

Tail comment:
'I am an Electron Tail.  The next state is a conductor.'.

Tail extend [

   next: neighbours [
      ^ Conductor new
   ]

]

Object subclass #Empty

Empty comment:
'I am the empty WireWorld cell. The next state is Empty.'.

Empty extend [

   next: neighbours[
      ^ Empty new
   ]

]

Object subclass: #Cell.

Cell comment:
'I am a cell in the Wireworld cellular automaton.  I use the State pattern (see Gang of Four), where I use CellState classes make me appear to change my own class.'.

Cell instanceVariableNames: 'neighbours state'.

Cell class extend [

   new: state [
      "This method creates a new cell with a given initial state."
      | cell |
      cell := super new.
      cell change: state.
      ^ cell
   ]

   parse: char [
      "This method creates a cell in a given state, corresponding to the input character - H for electron head, t for electron tail, . for conductor and space for empty."
      | choices |
      choices := Dictionary new.
      choices at: $. put: [Cell new: Conductor new].
      choices at: $H put: [Cell new: Head new].
      choices at: $t put: [Cell new: Tail new].
      choices at: $  put: [Cell new: Empty new].
      ^ (choices at: char) value
   ]

]

Cell extend [

   step [
      "This method puts the Cell into its next state."
      self change: state next: neighbours
   ]

   change: behaviour [
      "This method changes the state of the Cell."
      state := behaviour
   ]

   what [
      "This method describes the state of the cell, returning either #Conductor, #Head, #Tail or #Empty."
      state class name
   ]

]

Object subclass: #WireTable.

WireTable comment:
'I am the current state of a Wireworld program - a tabular grid of Wireworld cells.'.

WireTable instanceVariableNames: 'table lastrow lastcol'.

WireTable class extend [

   new: filename [
      "This method reads the wireworld file to create the WireTable."
      | file lns width height table |
      file := FileStream open: filename mode: #read.
      lns := file lines contents.
      file close.
      height := lns size.
      width := (lns collect: [:ln | ln size]) sort last.
      table := super new.
      table columns: width rows: height rowdata: lns.
      ^ table
   ]
]

WireTable extend [

   lines: lns [
      "This method parses the lines into a table"
      lastrow := height.
      lastcol := width.
      table := (Array new: height) collect: [Array new: width withAll: Cell new: Empty new].
      lns doWithIndex: [:ln :rownum |
         | row |
         row := table at: rownum
         ln doWithIndex: [:ch :colnum |
            row at: colnum put: (Cell parse: ch).
         ]
      ].
      self addNeighbours
   ]

   setNeighbours [
      "This method sets the neighbours for all cells."
      self withCells: [:cell :y :x |
         | a b l r raw neighpts |
         "above"
         a := y - 1.
         "below"
         b := y + 1.
         "left"
         l := x - 1.
         "right"
         r := x + 1.
         raw := Array new.
         raw at: 1 put: a@l.
         raw at: 2 put: a@x.
         raw at: 3 put: a@r.
         raw at: 4 put: y@l.
         raw at: 5 put: y@r.
         raw at: 6 put: b@l.
         raw at: 7 put: b@x.
         raw at: 8 put: b@r.
         neighpts := raw reject: [:p |
            (p y < 1) or:
            (p y > lastrow) or:
            (p x < 1) or:
            (p x > lastcol)
         ].
         neighpts do: [:pt |
            cell addNeighbour: (table at: (pt y)) at: pt x
         ]
      ]
   ]

   frame [
      "This method performs one execution step."
      self withCells: [:cell |
         cell step.
      ]
   ]

   withCells: blk [
      "This method performs a computation for each cell.  The blk must take at least 1 argument, the cell, but may at most take 3; the row and column also."
      table doWithIndex: [:col :rownum |
         col doWithIndex: [:cell :collnum |
            blk cull: cell cull: rownum cull: collnum
         ] 
      ]
   ]

   drawTo: renderer [
      renderer cells: table collect: [:col | col collect: [:cell | cell class name]]
   ]

]

Object subclass: #WireWorld.

WireWorld instanceVariableNames: 'table renderer'.

WireWorld comment:
'I am a flexible implementation of the Wireworld cellular automation.'.

WireWorld class extend [

   new: table drawWith: renderer [
      "This method creates a new wireworld from a table."
      | world |
      world := super new.
      ^ world state: table canvas: renderer.
   ]

   load: filename drawWith: renderer [
      "This method loads the Wireworld and returns it."
      | table |
      table := WireTable new: filename.
      ^ WireWporld new: table drawWith: renderer
   ]
]

WireWorld extend [

   state: prog canvas: outdev [
      "This method sets the state of the wireworld.  It is intended to be used to initialize a WireWorld object."
      table := prog.
      renderer := outdev
   ]

   run: n [
      "This method runs the wireworld simulation."
      1 to: n do: [
         table frame.
         table drawTo: renderer
      ]
   ]
]
