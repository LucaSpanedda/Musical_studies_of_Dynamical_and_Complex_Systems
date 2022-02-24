// import Standard Faust library
// https://github.com/grame-cncm/faustlibraries/
import("stdfaust.lib");

// TPT version of the SVF Filter by Vadim Zavalishin
// reference : (by Will Pirkle)
// http://www.willpirkle.com/Downloads/AN-4VirtualAnalogFilters.2.0.pdf

// SVFTPT filter function
SVFTPT(K, Q, CF, x) = circuitout
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
    circuitrouting(u1 , u2 , lp , hp , bp, notch, apf, ubp, peak, bshelf) = bshelf;
    circuitout = circuit ~ si.bus(2) : circuitrouting;
    };

// GUI for the Filter
CF = hslider("Frequency Cut", 1000, 20, 24000 - 20, .001);
Q = hslider("Filter-Q", 0, -60, 60, .001) : ba.db2linear;
K = hslider("Filter-K", 0, -60, 60, .001) : ba.db2linear;
// Filter parameters and input (x)
svftptfilter(x) = SVFTPT(K, Q, CF, x);

process = no.noise : svftptfilter;
