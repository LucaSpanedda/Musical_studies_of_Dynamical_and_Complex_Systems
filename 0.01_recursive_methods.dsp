// import Standard Faust library
// https://github.com/grame-cncm/faustlibraries/
import("stdfaust.lib");

// phasor via three different recursive methods

// phasor in letrec
phasor(f,sr) = floatc
letrec{'fb=fb+(f/sr); 'floatc=fb-int(fb);};
process = phasor(1,44100)*0;

// phasor in with
phasorwith(f) = fb
with{floatc(in)=in-int(in); fb= f/ma.SR : (+ : floatc)~ _;};
// process = phasorwith(100);

// phasor with basic syntaxt
floatc(x)=x-int(x); 
phasorbasic(f)=f/ma.SR : (+ : floatc)~ _;
// process = phasorbasic(100);