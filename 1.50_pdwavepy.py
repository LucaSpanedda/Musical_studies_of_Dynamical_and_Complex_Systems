# Python wavetable  -patch/with/array creator- for Pure Data
#
# For excute the script into the bash terminal:
# $	for i in {1..100}; do python3 pdwavepy.py >> "wavetable"$i.pd; done
# this will generate 100 pd patch with different arrays

# Import the libraries
import random

# Initializing the patch
# Standard definitions
canvas = print("#N canvas 605 244 388 332 10;")
tabread = print("#X obj 191 170 tabread4~ wavetable;")
phasor = print("#X obj 191 125 phasor~;")
outlet = print("#X obj 191 191 outlet~;")
inlet = print("#X obj 191 101 inlet;")
moltforread = print("#X obj 191 147 *~ 512;")
canvassub = print("#N canvas 0 0 450 300 (subpatch) 0;")

array = print("#X array wavetable 512 float 3;")
# WAVETABLE GENERATOR (inside the 512 samples array)
# -1 to +1
print("#A")
i = -1
while i <= 1:
    print(i*(random.randint(1, 1000)/1000))
    i += 1/256
print(";")

# Closing the patch
# Standard definitions
xcordsa = print("#X coords 0 1 511 -1 70 70 1 0 0;")
xrestore = print("#X restore 106 131 graph;")
xca = print("#X connect 0 0 2 0;")
xcb = print("#X connect 1 0 4 0;")
xcc = print("#X connect 3 0 1 0;")
xcd = print("#X connect 4 0 0 0;")
xcordsb = print("#X coords 0 -1 1 1 82 108 1 100 100;")
