import("stdfaust.lib");

// waveshaper :  saturator via Triangular Tabulation.

triwaveshape(g) = _*g : constrainedout
with{
    intreset(x)= x-int(x);
    triconditionpos(x) = (x<0.5)*(x) + ((x>0.5)*((x*-1)+1));
    trifunctionpos(x) = (x>0)*(x) : triconditionpos;
    triconditionneg(x) = (x>-0.5)*(x) + ((x<-0.5)*((x*-1)-1));
    trifunctionneg(x) = (x<0)*(x) : triconditionneg;
    constrainedout = (intreset <: trifunctionpos,trifunctionneg :> + : _*2);
};
process = triwaveshape(1) <: _,_;
