// import Standard Faust library
// https://github.com/grame-cncm/faustlibraries/
import("stdfaust.lib");


constrainedwalk(cwalkfreq,cnoisefreq,cnoiseseed) = crwlkout
with{


    randomwalk(walkfreq,noisefreq,noiseseed) = randomwalkout
    with{

        // NOISE GENERATION - function
        noise(seed) = noiseout
        with{  
        noiseout = (+(seed)~*(1103515245))/2147483647.0;
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


        
            // SAMPLE AND HOLD THE NOISE: noise ---> sample and hold ---> pos
            sahnoise = noise(noiseseed) : sampleandhold(noisefreq);
            // BINARY NOISE (-1 and +1)
            plusminuscond(a) = (a>0)+(a<0)*-1;
            noisebinary = sahnoise : plusminuscond;
            // PHASOR GENERATION
            randomwalkout = (walkfreq/ma.SR)*noisebinary : + ~ _;

    };


    // CONSTRAINED - function
    constrainedfunction = constrainedout
    with{

        intreset(x)= x-int(x);
        triconditionpos(x) = (x<0.5)*(x) + ((x>0.5)*((x*-1)+1));
        trifunctionpos(x) = (x>0)*(x) : triconditionpos;
        triconditionneg(x) = (x>-0.5)*(x) + ((x<-0.5)*((x*-1)-1));
        trifunctionneg(x) = (x<0)*(x) : triconditionneg;
        constrainedout = intreset <: trifunctionpos,trifunctionneg :> + : _*2;

    };


crwlkout = randomwalk(cwalkfreq,cnoisefreq,cnoiseseed) : constrainedfunction : _+1 : _*0.5;

};


// *0 Avoid DC Offset
process = constrainedwalk(1,1,42911242)*0;
