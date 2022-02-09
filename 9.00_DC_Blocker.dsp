// import Standard Faust library
// https://github.com/grame-cncm/faustlibraries/
import("stdfaust.lib");

// DC Blocker 
// The dc blocker is a small recursive filter specified by the difference equation
// It is needed to remove the dc component of the signal.
// y(n) = x(n) -x(n-1)+Ry(n-1)
// R is a parameter that is typically somewhere between 0.9 and 1.0
// reference : 
// https://ccrma.stanford.edu/~jos/fp/DC_Blocker.html

dcblocker(zero,pole) = dcblockerout
with{
    onezero =  _ <: _,mem : _,*(zero) : -;
    onepole = + ~ *(pole);
    dcblockerout = _ : onezero : onepole;
};

process = _ : dcblocker(1,0.998);
