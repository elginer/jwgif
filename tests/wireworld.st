FileStream fileIn: 'wireworld.st'.

WireTable class extend [

   test [
      | table lns |
      lns := #('tH.........' '.   .' '   ...' '.   .' 'Ht.. ......').
      table := super new.
      table lines: lns.
      ^ table
   ]

]

Cell class extend [

   new: state [
      "This method creates a new cell with a given initial state."
      | cell |
      state class displayNl.
      cell := super new.
      cell change: state.
      cell newNeighbours.
      ^ cell
   ]
]

Cell extend [
   
   display [
      '(' display.
      self what display.
      ')' display.
   ]

   becomeHead [
      |n m|
      n := Cell new: Head new.
      m := Cell new: Head new.
      self addNeighbour: n.
      self addNeighbour: m.
      self findStep.
      self takeStep.
   ]

   stayConductor [
      |n m|
      n := Cell new: Conductor new.
      m := Cell new: Conductor new.
      self addNeighbour: n.
      self addNeighbour: m.
      self findStep.
      self takeStep.

   ]

]

WireTable extend [

   lines: lns [
      self setBounds: lns.
      self createTable.
      'Initial table:' displayNl.
      table inspect.
      self createCells: lns.
      'Cells created:' displayNl.
      self setNeighbours
   ]

   withCells: blk [
      "This method performs a computation for each cell.  The blk must take at least 1 argument, the cell, but may at most take 3; the row and column also."
      table doWithIndex: [:row :rownum |
         row doWithIndex: [:cell :collnum |
            blk cull: cell cull: rownum cull: collnum
         ] 
      ]
   ]

   inspect [
      'WireTable: ' displayNl.
      '(' display.
      table do: [:row |
         '(' display.
         row do: [:cell |
            cell display.
            ' ' display
         ].
         ')' displayNl.
      ].
      ')' displayNl.
   ]

]

'*** Wiretable test ***' displayNl.

table := WireTable test.

(0 to: 10) do: [:x |
   'Table at iteration #' display.
   x displayNl.
   table inspect.
   table frame
]


'*** Cell test ***' displayNl.

cond := Cell new: Conductor new.
'Should become Head' displayNl.
cond becomeHead.
cond display.

Character nl display.

cond := Cell new: Conductor new.
'Should stay conductor' displayNl.
cond stayConductor.
cond display.

Character nl display.
