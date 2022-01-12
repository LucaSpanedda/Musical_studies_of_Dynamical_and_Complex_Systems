// import Standard Faust library
// https://github.com/grame-cncm/faustlibraries/
import("stdfaust.lib");

// GUI
changeseed = hslider("[0] Change Seed",1,1,20000,1);

// NOISE
// Change the seed value for generate differents random numbers
noise(seed) = variablenoiseout
with{
rescaleint(a) = a-int(a);
variablenoiseout = ((+(1457932343)~*(1103515245)) * seed)
/ (2147483647.0) : rescaleint;
};

// for start remove * 0 
process = noise(changeseed) * 0;