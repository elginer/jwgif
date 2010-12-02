Object subclass: #WireTable.

WireTable class extend

Object subclass: #Wireworld.

Wireworld class extend [

   run: filename [
      "This method runs the wireworld simulation, given a path to a wireworld file."
      | table world |
      table := WireTable new filename.
      world := Wireworld new: table.
      world run 
   ]
]
