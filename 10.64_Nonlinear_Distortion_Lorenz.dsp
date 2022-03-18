// import Standard Faust library
// https://github.com/grame-cncm/faustlibraries/
import("stdfaust.lib");


// Lorenz x y z
x = 1.2;
y = 1.3;
z = 1.6;


// costrained = input --> SVFTPT --> dcblocker --> saturator --> delay
costrained(Delsamps,Treshold,CFblock, x) 
= routingout
with{
saturator(Treshold,x) = Treshold*ma.tanh(x/(max(Treshold,ma.EPSILON)));
dcblocker(CFblock,x) = x : fi.highpass(1,CFblock);
vardelay(memdim,delay,inter,fb) = delcircuit
with 
{ 
    delcircuit = (+ : de.sdelay(buffer, it, dt)) ~ *(fb);
    buffer = int(memdim);
    it = inter; 
    dt = delay;
};


routingout = saturator(Treshold,dcblocker(CFblock,x)):vardelay(196000,Delsamps,ma.SR/1000.0,0);
};


// (lorenz eq. ---> costrained) x3
lorenz(x0,y0,z0,sigma,rho,beta,dt,Dt1,Dt2,Dt3,Treshold,CFblock,gain) 
= loop ~ si.bus(3) : par(i, 3, /(Treshold))
    with {

        x_init = (x0);
        y_init = (y0);
        z_init = (z0);

        loop(x, y, z) = 
        costrained(Dt1,Treshold,CFblock, 
            (x + sigma * (y - x) *dt+(x_init)) 
        )*gain,
        costrained(Dt2,Treshold,CFblock, 
            (y + (rho * x - x * z - y) *dt+(y_init)) 
        )*gain,
        costrained(Dt3,Treshold,CFblock, 
            (z + (x * y - beta * z) *dt +(z_init)) 
        )*gain;
        
    };


// kind of routing for 2 different signals in out
routing(a,b,c) = (a+b+c)/3;

// out
lorenzsystem1(a,b,c) = lorenz (a,b,c, 1,3,1,0.1, ma.SR/10, ma.SR/11, ma.SR/12, 1, 40, 1):routing;
lorenzsystem2(a,b,c) = lorenz (a,b,c, 1,3,1,0.1, ma.SR/10, ma.SR/11, ma.SR/12, 1, 40, 1):routing;

process = _ <: lorenzsystem1,lorenzsystem2;
