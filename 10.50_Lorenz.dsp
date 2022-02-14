// import Standard Faust library
// https://github.com/grame-cncm/faustlibraries/
import("stdfaust.lib");

// Lorenz System Osc with 3 Out
lorenz(x0,y0,z0) = ( x+_,y+_,z+_ : loop  ) ~ si.bus(3)
    with {

        x = x0-x0';
        y = y0-y0';
        z = z0-z0';

        sigma = 10.0; // a
        rho = 28; // b
        beta = 2.666667; // c
        dt = 0.005; // d

        // iterative times increasing
        q = 1.0;
        
        loop(x,y,z) = 
        (x+(sigma*(y-x))*dt)*q, 
        (y+ (rho*x -(x*z) -y)*dt)*q, 
        (z+ ((x*y)-(beta*z)) *dt)*q;

    };

routingamp(a,b,c) = a*0.04,b*0.04;

process = lorenz(1.2,1.3,1.6) : routingamp;