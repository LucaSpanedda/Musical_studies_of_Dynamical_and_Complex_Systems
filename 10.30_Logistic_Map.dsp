// import Standard Faust library
// https://github.com/grame-cncm/faustlibraries/
import("stdfaust.lib");

// Logistic Map - simple non-linear dynamical equation
// starting population (x) = number from 0. to 1.
// resources of the population (r) = number from 0. to 4.

logisticmap(x,r) = mapfunc
with{
    Dirac(x) = x-(x:mem);
    lmap(x) = x*r*(1-x);
    mapfunc = x : Dirac : (+ : lmap)~ _;
    };

process = logisticmap(0.5,3.9468) <: _,_;