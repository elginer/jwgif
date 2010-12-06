FileStream fileIn: 'gif.st'.

handle := Gif width: 200 height: 200.
Gif frame.
Gif x: 0 y: 0 size: 50 colour: 'blue'.
Gif frame.
Gif x: 50 y: 50 size: 50 colour: 'red'.
Gif frame.
Gif x: 100 y: 100 size: 50 colour: 'yellow'.
Gif frame.
Gif x: 150 y: 150 size: 50 colour: 'green'.
Gif stop: handle.
