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
lorenz(x0,y0,z0,sigma,rho,beta,dt,l) = loop ~ si.bus(3) : par(i, 3, /(l))
    with {
        x_init = x0-x0';
        y_init = y0-y0';
        z_init = z0-z0';

        loop(x, y, z) = 
            saturator(l, dcblocker(1,0.995,(x + sigma * (y - x) * dt + x_init))), 
            saturator(l, dcblocker(1,0.995,(y + (rho * x - x * z - y) * dt + y_init))), 
            saturator(l, dcblocker(1,0.995,(z + (x * y - beta * z) * dt + z_init)));
    };


process = lorenz(1.2,1.3,1.6,48,3,1,0.5,32) :> /(3) <: _ , _;
