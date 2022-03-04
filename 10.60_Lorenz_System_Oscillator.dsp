// import Standard Faust library
// https://github.com/grame-cncm/faustlibraries/
import("stdfaust.lib");

// DC Blocker: zero value, pole value, input
// The dcblocker is a small recursive filter specified by the difference equation
// It is needed to remove the dc component of the signal.
dcblocker(zero,pole,x) = x : dcblockerout
with{
    onezero =  _ <: _,mem : _,*(zero) : -;
    onepole = + ~ *(pole);
    dcblockerout = _ : onezero : onepole;
};

// ma.EPSILON is a constant number for avoid nan numbers
// ma.EPSILON set the minimum value in a number different from 0
// Saturator = waveshaper, classical softclip saturator.
// based on the hyperbolic tangent function : 
// y(t) = tanh x(t)
saturator(treshold,x) = treshold*ma.tanh(x/(max(treshold,ma.EPSILON)));

// Lorenz System Osc with 3 Out
lorenz(in,x0,y0,z0,sigma,rho,beta,dt,l) = loop ~ si.bus(3) : par(i, 3, /(l))
    with {

        x_init = (x0-x0')+in;
        y_init = (y0-y0')+in;
        z_init = (z0-z0')+in;

        loop(x, y, z) = 
            saturator(l, dcblocker(1,0.995,(x + sigma * (y - x) * dt + x_init))), 
            saturator(l, dcblocker(1,0.995,(y + (rho * x - x * z - y) * dt + y_init))), 
            saturator(l, dcblocker(1,0.995,(z + (x * y - beta * z) * dt + z_init)));
    };


// GUI
DiracGUI = button("[0] Dirac");
s = hslider("[1] Sigma", 10, 0, 100, 0.000001);
r = hslider("[2] Rho", 28, 0, 100, 0.000001);
b = hslider("[3] Beta", 8/3, 0, 100, 0.000001);                
dt = hslider("[4] dt (integration step)", 0.005, 0.000001, 1, .000001);
l = hslider("[5] Saturation limit", 4, 1, 1024, .000001);
extin = hslider("[6] External Input", 0, 0, 10, .000001);
Dirac = DiracGUI-DiracGUI' > 0;

routing(a,b,c) = (a+b+c)/3;
process = _ <: lorenz(_*extin,Dirac*1.2,Dirac*1.3,Dirac*1.6,s,r,b,dt,l) : routing <: _,_;
