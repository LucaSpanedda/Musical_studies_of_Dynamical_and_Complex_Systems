// import Standard Faust library
// https://github.com/grame-cncm/faustlibraries/
import("stdfaust.lib");

// basic circuit for the iteration of a function :
// for solve differential equations (without chaotic behaviors)

functioniteration(x,a) = output
with{
    Dirac(x) = x-(x:mem);
    differentialequation(x) = (x*1)/a;
    circuit = x : Dirac : (+ : differentialequation)~ _;
    output = sin(circuit);
    };

process = functioniteration(100, 1.001) <: _,_;