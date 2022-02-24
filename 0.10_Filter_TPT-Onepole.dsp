// import Standard Faust library
// https://github.com/grame-cncm/faustlibraries/
import("stdfaust.lib");

// TPT version of the One-Pole Filter by Vadim Zavalishin
// reference : (by Will Pirkle)
// http://www.willpirkle.com/Downloads/AN-4VirtualAnalogFilters.2.0.pdf

// One-Pole filter function
ONEPOLETPT(CF, x) = circuitout
    with {
        g = tan(CF * ma.PI / ma.SR);
        G = g / (1.0 + g);
        circuit(s) = u , lp , hp , ap
            with {
                v = (x - s) * G;
                u = v + lp;
                lp = v + s;
                hp = x - lp;
                ap = lp - hp;
            };
    // choose the output from the ONEPOLE Filter (ex. lp)
    circuitrouting(lp , hp , ap) = lp;
    circuitout = circuit ~ _ : ! , si.bus(3) : circuitrouting;
    };

// GUI for the Filter
CF = hslider("Frequency Cut", 1000, 20, 24000 - 20, .001);
// Filter parameters and input (x)
onepoletptfilter(x) = ONEPOLETPT(CF, x);

process = no.noise : onepoletptfilter;
