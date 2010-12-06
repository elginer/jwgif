#! /bin/bash
export LD_LIBRARY_PATH=.
gst -g tests/gif.st > anim_st.gif
