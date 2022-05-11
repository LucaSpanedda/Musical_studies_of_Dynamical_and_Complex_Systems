//Faust Standard Library
import("stdfaust.lib");
// Feedback counterbalancing via simple "LAR" mechanism
// LAR mechanism: Audio Feedback with Self-regulated Gain - REFERENCE (Agostino Di Scipio)
// https://echo.orpheusinstituut.be/article/a-relational-ontology-of-feedback#audio
process = (_:fi.dcblocker)<:_*(1-an.rms_envelope_rect(0.01));
