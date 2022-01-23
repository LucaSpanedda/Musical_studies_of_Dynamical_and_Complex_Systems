// import Standard Faust library
// https://github.com/grame-cncm/faustlibraries/
import("stdfaust.lib");

// Zavalishin's first-order zero-delay feedback lowpass

zdlowpass(cf, in) = y
    letrec {
        'y = (in - s) * G + s;
        's = 2 * (in - s) * G + s;
    }
        with {
            // gain value of the filter
            G = cf/(1+cf);
            // gain value + value conversion in frequency: G, w(f)
            // G = tan(w(cf) / 2) / (1 + tan(w(cf) / 2));
            // w(f) = 2 * ma.PI * f / ma.SR;
        };

process = zdlowpass(0.01,no.noise*0);
