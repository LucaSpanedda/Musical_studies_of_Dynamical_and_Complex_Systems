declare filename "constrainedcomb.dsp"; declare name "constrainedcomb"; 
// import Standard Faust library
// https://github.com/grame-cncm/faustlibraries/
import("stdfaust.lib");
dcblock(p) = _ <: _,mem : _,_ : - : + ~ *(p);
clip(v) = _ : min(v) : max(-v);
constrainedfunction(v,p) = _ : clip(v) : dcblock(p);
chaosfbcomb(del,g,v,p) = _ : (+ : @(del-1) : (_ : constrainedfunction(v,p)))~ *(g) : mem;
// uscita con il process:
process = _ : chaosfbcomb(1028, 1.02, 1, 0.995) <: _,_;
