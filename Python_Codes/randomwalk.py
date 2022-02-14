# RANDOM WALK

from random import random

# PROCESSO:
# la funzione process(a) è il processo
# su cui si vuole fare - feedback - reiterazione dell'output
# plusminusrand è ad ogni ciclo un -1 o +1 su: a
def process(a):
    plusminusrand = ( (random() > 0.5)*2 -1 )
    return a + plusminusrand

# ITERAZIONI:
# è definito qui quante iterazioni ripete il processo stocastico:
iterazioni = int(100)

# VALORE DI PARTENZA:
# valore di partenza del processo stocastico:
valore= float(0)

for j in range (0,iterazioni):
    # mando il valore nel process
    out=process(valore)
    print(out)
    # feedback: - prendo l'uscita da out e la reimmetto nel process
    valore=out