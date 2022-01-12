// import Standard Faust library
// https://github.com/grame-cncm/faustlibraries/
import("stdfaust.lib");

// GUI
changeseed = hslider("[0] Change Seed ",1,1,1000,1);

// RANDOM
// Change the seed value for generate a different random number
random(seed) = randomout
with{
rescaleint(a) = a-int(a);
randomout = ((seed)*(1103515245)/2147483647.0) 
: rescaleint; 
};

// * 0 Avoid DC Offset
process = random(changeseed) * 0;