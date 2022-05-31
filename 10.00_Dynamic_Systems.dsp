// FAUST standard library
import("stdfaust.lib");

/*
Laplace's determinism finds its own mathematical formulation
in the modern definition of dynamic system.
A discrete-time dynamic system is given by the pair: X, f
where X indicates the phase space
f is a transformation that associates each point of X with another point.
The behavior of the system relative to study times
it is called the law of evolution, and it describes orbits
which are obtained by iterating the same one over and over again.
An infinite succession of points is associated with each starting point X0 of X
obtained by applying the law of evolution iteratively,
from X0 we then pass to point X1: X1 = f (X0).
If we denote by Xn the point of arrival, the next point of the orbit
will be: Xn + 1 = f (xn)
*/

/*
Il determinismo di Laplace trova una sua formulazione matematica
nella moderna definizione di sistema dinamico.
Un sistema dinamico a tempo discreto è dato dalla coppia: X, f
dove X indica lo spazio delle fasi
f è una trasformazione che associa ogni punto di X ad un altro punto.
Il comportamento del sistema rispetto ai tempi di studio
è chiamata la legge dell'evoluzione e descrive le orbite
che si ottengono ripetendo lo stesso più e più volte.
Ad ogni punto iniziale X0 di X è associata una successione infinita di punti
ottenuto applicando la legge dell'evoluzione in modo iterativo,
da X0 si passa quindi al punto X1: X1 = f (X0).
Se indichiamo con Xn il punto di arrivo, il prossimo punto dell'orbita
sarà: Xn + 1 = f (xn)
*/

Ramp = Xn
    letrec{
        'Xn = Xn+1;
        };

Counter = Ramp / ma.SR : int;

Phasor(f) = Xn
    letrec{
        'Xn = (Xn+(f/ma.SR))-int(Xn);
        };

process = Counter;
