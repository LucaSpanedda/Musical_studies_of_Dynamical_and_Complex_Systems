// import Standard Faust library
// https://github.com/grame-cncm/faustlibraries/
import("stdfaust.lib");

// Lorenz System Synth
lorenzsynth
(X_in,Y_in,Z_in,
Sigma_in,Rho_in,Beta_in,Dt_in,
Qoffset,Qamp,FreqCut) = 
( x0+_,y0+_,z0+_ : loop  ) ~ si.bus(3)
with{
        loop(x,y,z) = 
        ma.tanh(filterTPT(FreqCut,
        ((x+(sigma*(y-x))*dt)*(nonlinearQ) : dcblocker(1,0.98)))), 
        ma.tanh(filterTPT(FreqCut,
        (y+ (rho*x -(x*z) -y)*dt)*(nonlinearQ) : dcblocker(1,0.98))), 
        ma.tanh(filterTPT(FreqCut,
        (z+ ((x*y)-(beta*z)) *dt)*(nonlinearQ) : dcblocker(1,0.98)));
    
        
        // System Variables
        x0 = X_in-X_in'; 
        y0 = Y_in-Y_in';
        z0 = Z_in-Z_in';
        sigma = Sigma_in; // a
        rho = Rho_in; // b
        beta = Beta_in; // c
        dt = Dt_in; // d

        // Noise (positive 0-1)
        noise(seed) = variablenoiseout
        with{
        rescaleint(a) = ((a-int(a))+1)*0.5;
        variablenoiseout = ((+(1457932343)~*(1103515245)) * seed)
        / (2147483647.0) : rescaleint;
        };
        // NON-Linear iterative times increasing
        nonlinearQ = noise(24215682)*Qamp+Qoffset;
        // Filter Section : DC Block & Filter
        dcblocker(zero,pole) = dcblockerout
        with{
        onezero =  _ <: _,mem : _,*(zero) : -;
        onepole = + ~ *(pole);
        dcblockerout = _ : onezero : onepole;
        };
        // TPTfilter - Lowpass Out
        filterTPT(CF, x) = loop ~ _ : ! , si.bus(3) : _,!,!
        with {
        g = tan(CF * ma.PI / ma.SR);
        G = g / (1.0 + g);
        loop(s) = u , lp , hp , ap
            with {
                v = (x - s) * G;
                u = v + lp;
                lp = v + s;
                hp = x - lp;
                ap = lp - hp;
            };
    };
};


// GUI
Qoffset = hslider("Q-Offset",10,1,100,0.01) : si.smoo;
Qamp = hslider("Nonlinear-Q-Amp",0,0,10,0.01) : si.smoo;
CF = hslider("Lowpass Cut Hz", 1000, 20, 20000, .001): si.smoo;
routingamp1(a,b,c) = 
a*(hslider("X-OUT1",1,0,1,0.01) : si.smoo) +
b*(hslider("Y-OUT1",0,0,1,0.01) : si.smoo) +
c*(hslider("Z-OUT1",0,0,1,0.01) : si.smoo) ;
routingamp2(a,b,c) = 
a*(hslider("X-OUT2",1,0,1,0.01) : si.smoo) +
b*(hslider("Y-OUT2",0,0,1,0.01) : si.smoo) +
c*(hslider("Z-OUT2",0,0,1,0.01) : si.smoo) ;

process = 
lorenzsynth
(1.2,1.3,1.6, // X,Y,Z
10,28,2.65,0.01, //Sigma, Rho, Beta, Dt
Qoffset,Qamp,CF) <: routingamp1, routingamp2; // GUI
