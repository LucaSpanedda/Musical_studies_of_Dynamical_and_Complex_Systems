// import Standard Faust library
// https://github.com/grame-cncm/faustlibraries/
import("stdfaust.lib");

// Constrained Lorenz System Osc
constrainedlorenz(x0,y0,z0) = 
( x+(_:constrain),y+(_:constrain),z+(_:constrain) : loop  ) ~ si.bus(3)
    with {

        x = x0-x0';
        y = y0-y0';
        z = z0-z0';

        sigma = 1; // a
        rho = 10; // b
        beta = 0.1; // c
        dt = 0.1; // d

        // iterative times increasing
        q = 1.2;
        
        loop(x,y,z) = 
        (x+(sigma*(y-x))*dt)*q  , 
        (y+ (rho*x -(x*z) -y)*dt)*q , 
        (z+ ((x*y)-(beta*z)) *dt)*q ;


        // dcblocker and soft clipping with tanhf
        constrain = clipandfilters
        with{
        // onezero + onepole = DC Blocker
        onezero =  _ <: _,mem : _,*(1) : -;
        onepole = + ~ *(0.95);
        // softclipping
        softclipping(L, x) = L * ma.tanh(x / L);
        // onezero ---> onepole ---> softclipping
        clipandfilters(in) = softclipping(0.4, (in : onezero : onepole));
        };

    };

routing(a,b,c) = a;

process = constrainedlorenz(1.2,1.3,1.6) : routing;
