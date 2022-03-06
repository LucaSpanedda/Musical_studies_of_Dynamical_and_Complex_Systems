// import Standard Faust library
// https://github.com/grame-cncm/faustlibraries/
import("stdfaust.lib");

// costrained = input --> SVFTPT --> dcblocker --> saturator
costrained(Treshold,CFblock, K, Q, CF, Glp , Ghp , Gbp, Gnotch, Gapf, Gubp, Gpeak, Gbshelf, x) 
= routingout
with{

saturator(Treshold,x) = Treshold*ma.tanh(x/(max(Treshold,ma.EPSILON)));
dcblocker(CFblock,x) = x : fi.highpass(1,CFblock);
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
    circuitrouting(u1 , u2 , lp , hp , bp, notch, apf, ubp, peak, bshelf) = 
    lp*Glp+hp*Ghp+bp*Gbp+notch*Gnotch+apf*Gapf+ubp*Gubp+peak*Gpeak+bshelf*Gbshelf;
    circuitout = circuit ~ si.bus(2) : circuitrouting;
    };

    routingout = 
        saturator(Treshold,
            dcblocker(CFblock,
                SVFTPT(K, Q, CF, Glp , Ghp , Gbp, Gnotch, Gapf, Gubp, Gpeak, Gbshelf, x)
            )
        );

    };

// GUI for the Filter
Treshold = hslider("Saturation limit", 4, 1, 1024, .000001);
CFblock = hslider("DC Blocker FCut", 20, ma.EPSILON, 100, .001);
CF = hslider("Frequency Cut", 1000, 20, 24000 - 20, .001);
Q = hslider("Filter-Q", 0, -60, 60, .001) : ba.db2linear;
K = hslider("Filter-K", 0, -60, 60, .001) : ba.db2linear;
Glp = checkbox("lowpass"); 
Ghp = checkbox("highpass"); 
Gbp = checkbox("bandpass"); 
Gnotch = checkbox("notch"); 
Gapf = checkbox("allpass"); 
Gubp = checkbox("ubandpass"); 
Gpeak = checkbox("peak"); 
Gbshelf = checkbox("bshelf"); 
Dirac = button("[0] Dirac");
s = hslider("[1] Sigma", 10, 0, 100, 0.000001);
r = hslider("[2] Rho", 28, 0, 100, 0.000001);
b = hslider("[3] Beta", 8/3, 0, 100, 0.000001);                
dt = hslider("[4] dt (integration step)", 0.005, 0.000001, 1, .000001);

// (lorenz eq. ---> costrained) x3
lorenz(x0,y0,z0,sigma,rho,beta,dt,Treshold,CFblock, K, Q, CF, Glp , Ghp , Gbp, Gnotch, Gapf, Gubp, Gpeak, Gbshelf) = loop ~ si.bus(3) : par(i, 3, /(Treshold))
    with {

        x_init = (x0-x0');
        y_init = (y0-y0');
        z_init = (z0-z0');

        loop(x, y, z) = 
        costrained(Treshold,CFblock, K, Q, CF, Glp , Ghp , Gbp, Gnotch, Gapf, Gubp, Gpeak, Gbshelf, 
            (x + sigma * (y - x) *dt+(x_init)) 
        ),
        costrained(Treshold,CFblock, K, Q, CF, Glp , Ghp , Gbp, Gnotch, Gapf, Gubp, Gpeak, Gbshelf, 
            (y + (rho * x - x * z - y) *dt+(y_init)) 
        ),
        costrained(Treshold,CFblock, K, Q, CF, Glp , Ghp , Gbp, Gnotch, Gapf, Gubp, Gpeak, Gbshelf, 
            (z + (x * y - beta * z) *dt +(z_init)) 
        );
        
    };

routing(a,b,c) = (a+b+c)/3;
process = 
lorenz(Dirac*1.2,Dirac*1.3,Dirac*1.6,s,r,b,dt,
Treshold, CFblock, K, Q, CF, Glp , Ghp , Gbp, Gnotch, Gapf, Gubp, Gpeak, Gbshelf) : routing <: _,_;
