// import Standard Faust library
// https://github.com/grame-cncm/faustlibraries/
import("stdfaust.lib");

// Van Der Pol Oscillator of Second Grade
// by Dario Sanfilippo
m=2.6;
h=.01;

vanderpolsecgrade(init1, init2) = loop ~ _
    with {
        loop(fb) =  (h * m * (fb + init1_) ^ 3 + (-1 * h ^ 2 - h * m + 2) * (fb + init1_) - (fb'
        + init2_ + init1_')) / 
                    (h * m * (fb + init1_) ^ 2 - h * m + 1)
        with {
            init1_ = init1 - init1';
            init2_ = init2 - init2';
        };
    };

process = vanderpolsecgrade(1, 1) * 0.4;