import("stdfaust.lib");

// waveshaper : classical softclip saturator.
// based on the hyperbolic tangent function : 
// y(t) = tanh x(t)

softclip(g) = tanhf
with{
tanhf(x) = ma.tanh(x*g);
};

process = _ : softclip(1) <: _,_;
