// import Standard Faust library
// https://github.com/grame-cncm/faustlibraries/
import("stdfaust.lib");

// Sine Map by Agostino Di Scipio
// reference : 
// https://citeseerx.ist.psu.edu/viewdoc/download?doi=10.1.1.33.5855&rep=rep1&type=pdf

sinemap(y0, mu) = y
    letrec {
        'y = mu * sin(ma.PI * y + y0 - y0');
    };

process = sinemap(0.5, 0.97) <: _,_;