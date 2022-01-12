// import Standard Faust library
// https://github.com/grame-cncm/faustlibraries/
import("stdfaust.lib");

// GUI
sahfreq = hslider("frequency",1,1,100,1);

// SAMPLE AND HOLD - function
        sampleandhold(frequency) = sampleandholdout
        with{
            // PHASOR
            decimal(x)= x-int(x); // reset to 0 when int
            phase = frequency/ma.SR : (+ : decimal) ~ _; // phasor with frequency
            // PHASOR to 0 and 1
            saw = phase-0.5; // phasor : -0.5 to +0.5
            ifpos = (saw > 0); // phasor positive =1; phasor negative =0
            // PHASOR 1 to Impulse
            trainpulse = ( ifpos - ( ifpos:mem ) ) > 0; // impulse and delette all under 0
            // SAMPLE AND HOLD
            sampleandholdout(a) = (*(1 - trainpulse) + a * trainpulse) ~ _;
        };

// * 0 Avoid DC Offset
process = no.noise : sampleandhold(sahfreq) * 0;