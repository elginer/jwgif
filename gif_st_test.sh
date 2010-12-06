#! /bin/bash
export LD_LIBRARY_PATH=out
gst -g tests/gif.st > anim_st.gif
