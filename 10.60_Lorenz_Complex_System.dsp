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


// SVFTPT filter function
SVFTPT(K, Q, CF, Glp , Ghp , Gbp, Gnotch, Gapf, Gubp, Gpeak, Gbshelf, x) = circuitout
    with {
        g = tan(CF * ma.PI / ma.SR);
        R = 1.0 / (2.0 * Q);
        G1 = 1.0 / (1.0 + 2.0 * R * g + g * g);
        G2 = 2.0 * R + g;

        circuit(s1, s2) = u1 , u2 , lp , hp , bp, notch, apf, ubp, peak, bshelf
            with {
                hp = (x - s1 * G2 - s2) * G1;
                v1 = hp * g;
                bp = s1 + v1;
                v2 = bp * g;
                lp = s2 + v2;
                u1 = v1 + bp;
                u2 = v2 + lp;
                notch = x - ((2*R)*bp);
                apf = x - ((4*R)*bp);
                ubp = ((2*R)*bp);
                peak = lp -hp;
                bshelf = x + (((2*K)*R)*bp);
            };

    // choose the output from the SVF Filter (ex. bshelf)
    circuitrouting(u1 , u2 , lp , hp , bp, notch, apf, ubp, peak, bshelf) = 
    lp*Glp+hp*Ghp+bp*Gbp+notch*Gnotch+apf*Gapf+ubp*Gubp+peak*Gpeak+bshelf*Gbshelf;
    circuitout = circuit ~ si.bus(2) : circuitrouting;
    };

// GUI for the Filter
CF = hslider("Frequency Cut", 1000, 20, 24000 - 20, .001);
Q = hslider("Filter-Q", 0, -60, 60, .001) : ba.db2linear;
K = hslider("Filter-K", 0, -60, 60, .001) : ba.db2linear;
BGlp = checkbox("lowpass"); 
BGhp = checkbox("highpass"); 
BGbp = checkbox("bandpass"); 
BGnotch = checkbox("notch"); 
BGapf = checkbox("allpass"); 
BGubp = checkbox("ubandpass"); 
BGpeak = checkbox("peak"); 
BGbshelf = checkbox("bshelf"); 

// Filter parameters and input (x)
svftptfilter(x) = 
SVFTPT(K, Q, CF, BGlp , BGhp , BGbp, BGnotch, BGapf, BGubp, BGpeak, BGbshelf, x);


// Lorenz System Osc with 3 Out
lorenz(in,x0,y0,z0,sigma,rho,beta,dt,l) = loop ~ si.bus(3) : par(i, 3, /(l))
    with {

        x_init = (x0-x0')+in;
        y_init = (y0-y0')+in;
        z_init = (z0-z0')+in;

        loop(x, y, z) = 
            
            saturator(l, svftptfilter(dcblocker(1,0.995,(x + sigma * (y - x) * dt + x_init)))), 
            
            saturator(l, svftptfilter(dcblocker(1,0.995,(y + (rho * x - x * z - y) * dt + y_init)))), 
            
            saturator(l, svftptfilter(dcblocker(1,0.995,(z + (x * y - beta * z) * dt + z_init))));
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
