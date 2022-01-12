// import Standard Faust library
// https://github.com/grame-cncm/faustlibraries/
import("stdfaust.lib");

// GUI
walkfgui = hslider("[2] Walk frequency",1,1,100,1);
noisefgui = hslider("[1] Noise frequency",1,1,100,1);
changeseed = hslider("[0] Change Seed",1,1,20000,1);

// RANDOM WALK - function
    randomwalk(walkfreq,noisefreq,noiseseed) = randomwalkout
    with{

        // NOISE GENERATION - function
        noise(seed) = variablenoiseout
        with{
        rescaleint(a) = a-int(a);
        variablenoiseout = ((+(1457932343)~*(1103515245)) * seed)
        / (2147483647.0) : rescaleint;
        };


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


            // RANDOM WALK:
            // SAMPLE AND HOLD THE NOISE: noise ---> sample and hold ---> pos
            sahnoise = noise(noiseseed) : sampleandhold(noisefreq);
            // BINARY NOISE (-1 and +1)
            plusminuscond(a) = (a>0)+(a<0)*-1;
            noisebinary = sahnoise : plusminuscond;
            // PHASOR GENERATION
            randomwalkout = (walkfreq/ma.SR)*noisebinary : + ~ _;

    };

// * 0 Avoid DC Offset 
// randomwalk(walkfreq,noisefreq,noiseseed)
process = randomwalk(walkfgui,noisefgui,changeseed) * 0;