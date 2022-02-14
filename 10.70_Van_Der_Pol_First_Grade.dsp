// import Standard Faust library
// https://github.com/grame-cncm/faustlibraries/
import("stdfaust.lib");

// Van Der Pol Oscillator of First Grade
vanderpol(x0,y0) = ( x+_,y+_ : loop  ) ~ si.bus(2)
    with {

        x = x0-x0';
        y = y0-y0';

        u = 1.0; // nonlinearity strength 
        dt = 0.01; // dt
        epsilon = 2.2204460492503131e-016; // dielectric constant
        
        loop(x,y) = 
        x + (u * (x - x ^ 3 / 3 - y) * dt), 
        y + (x / max(u,epsilon) ) * dt ;

    };

routing(a,b) = a*0.2;

process = vanderpol(1,1) : routing <: _,_;