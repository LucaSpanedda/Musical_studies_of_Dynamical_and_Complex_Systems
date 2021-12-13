# CAOS PROCESS inside the - ARRAY- for Pure Data


# Initializing the patch
# Standard definitions
canvas = print("#N canvas 605 244 388 332 10;")
tabread = print("#X obj 191 170 tabread4~ wavetable;")
phasor = print("#X obj 191 125 phasor~;")
outlet = print("#X obj 191 191 outlet~;")
inlet = print("#X obj 191 101 inlet;")
moltforread = print("#X obj 191 147 *~ 512;")
canvassub = print("#N canvas 0 0 450 300 (subpatch) 0;")

array = print("#X array wavetable 512 float 3;")
# WAVETABLE GENERATOR (inside the 512 samples array)
# -1 to +1
print("#A")

# -------- CAOS PROCESS INSIDE ARRAY
# PROCESSO:
# la funzione caosprocess(a) è il PROCESSO DETERMINISTICO MATEMATICO 
# su cui si vuole fare - feedback - reiterazione dell'output
# qui radice quadrata di a (una potenza a 0,5 corrisponde matematicamente alla radice quadrata)
def caosprocess(a):
    return pow(a,1.005)

# ITERAZIONI:
# è definito qui quante iterazioni ripete il processo di caos deterministico:
iterazioni = int(513)

# VALORE DI PARTENZA:
# valore di partenza del processo caos deterministico:
valore= float(2)

for j in range (0,iterazioni):
    # mando il valore nel caosprocess
    out=caosprocess(valore)
    
    # REGOLAZIONE: nel print regolo i valori dell'out in modo che siano fra 0 ed 1
    print(out / 8000)
    # feedback: - prendo l'uscita da out e la reimmetto nel caosprocess
    valore=out
    
# -------- END OF THE PROCESS INSIDE ARRAY

print(";")

# Closing the patch
# Standard definitions
xcordsa = print("#X coords 0 1 511 -1 70 70 1 0 0;")
xrestore = print("#X restore 106 131 graph;")
xca = print("#X connect 0 0 2 0;")
xcb = print("#X connect 1 0 4 0;")
xcc = print("#X connect 3 0 1 0;")
xcd = print("#X connect 4 0 0 0;")
xcordsb = print("#X coords 0 -1 1 1 82 108 1 100 100;")