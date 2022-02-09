import("stdfaust.lib");

// Van Der Pol Oscillator with 2 outs
vanderpol(x0,y0) = ( x+_,y+_ : loop  ) ~ si.bus(2)
    with {

        x = x0-x0';
        y = y0-y0';

        u = 10.2; // nonlinearity strength 
        dt = 0.1; // dt
        epsilon = 2.2204460492503131e-016; // dielectric constant
        // iterative times increasing
        q = 1.0;
        
        loop(x,y) = 
        x + (u * (x - x ^ 3 / 3 - y) * dt), 
        y + (x / max(u,epsilon) ) * dt ;

    };

routing(a,b) = a*0.2;

process = vanderpol(0.1,0.1) : routing <: _,_;
