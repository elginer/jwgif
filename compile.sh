#! /bin/bash

# Compiles gif.c into shared object
gcc -W -shared -fPIC -lplot gif.c -o libwiregif.so
