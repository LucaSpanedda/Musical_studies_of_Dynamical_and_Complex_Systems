// import Standard Faust library
// https://github.com/grame-cncm/faustlibraries/
import("stdfaust.lib");

// letrec based sinusoidal oscillator

osc(f,p) = sine
letrec{'fb=fb+(f/sr); 'phasor=fb:intblock; 'phase=phasor+p:intblock; 'sine=phase:sinefunc;}
with{sr=ma.SR; twopi=ma.PI*2; intblock(x)=x-int(x); sinefunc=sin((_)*twopi);};
process = osc(100,0),osc(100,0.5);