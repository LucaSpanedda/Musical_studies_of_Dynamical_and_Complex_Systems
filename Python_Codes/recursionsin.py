# ITERAZIONE DI UNA FUNZIONE

# ISTRUZIONI PER LA COMPILAZIONE
# Per la compilazione in un file .txt eseguire in bash il comando:
# $ sudo python3 file.py >> file.txt 
# (dove file è il nome del file da compilare)

import math

# PROCESSO:
# la funzione process(a) è il processo deterministico 
# su cui si vuole fare - feedback - reiterazione dell'output
# in return avviene l'operazione
def process(a):
    return a*0.9992

# ITERAZIONI:
# è definito qui quante iterazioni ripete il processo di caos deterministico:
iterazioni = int(10000)

# VALORE DI PARTENZA:
# valore di partenza del processo caos deterministico:
valore= float(100)

for j in range (0,iterazioni):
    # mando il valore nel process
    out=process(valore)
                    # - math.sin - rimuovere o lasciare per:
                    # recursionsin.py & recursionline.py
    valori = print(math.sin(out))
    # feedback: - prendo l'uscita da out e la reimmetto nel process
    valore=out