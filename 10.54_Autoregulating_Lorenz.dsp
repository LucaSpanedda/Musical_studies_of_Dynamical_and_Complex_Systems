// import Standard Faust library
// https://github.com/grame-cncm/faustlibraries/
import("stdfaust.lib");

// Autoregulating Lorenz System
autolorenz(x0,y0,z0,dcfc,l) = loop ~ si.bus(7): par(i, 7, /(l)): mixer
    with {
        x_init = x0-x0';
        y_init = y0-y0';
        z_init = z0-z0';
        saturator(lim,x) = lim*ma.tanh(x/(max(lim,ma.EPSILON)));
        dcblock(dcfc,x) = fi.highpass(1, dcfc, x);
        loop(x, y, z, sigma, dt, rho, beta) = 
            saturator(l, dcblock(10,(x + sigma * (y - x) * dt + x_init))), 
            saturator(l, dcblock(10,(y + (rho * x - x * z - y) * dt + y_init))), 
            saturator(l, dcblock(10,(z + (x * y - beta * z) * dt + z_init))),
            ((x+y+z)/3)*8, 
            ((x+y+z)/3)*5,
            ((x+y+z)/3)*4,
            ((x+y+z)/3)*1;
        mixer(a,b,c,d,e,f,g) = (a+b+c)/3, (a+b+c)/3;
    };

process = autolorenz(1.2,1.2,1.2,10,1);
