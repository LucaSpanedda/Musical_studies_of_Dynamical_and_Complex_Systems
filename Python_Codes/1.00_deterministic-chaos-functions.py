# CAOS DETERMINISTICO


# PROCESSO:
# la funzione caosprocess(a) è il PROCESSO DETERMINISTICO MATEMATICO 
# su cui si vuole fare - feedback - reiterazione dell'output
# qui radice quadrata di a (una potenza a 0,5 corrisponde matematicamente alla radice quadrata)
def caosprocess(a):
    return pow(a,0.5)

# ITERAZIONI:
# è definito qui quante iterazioni ripete il processo di caos deterministico:
iterazioni = int(512)

# VALORE DI PARTENZA:
# valore di partenza del processo caos deterministico:
valore= float(140202)

for j in range (0,iterazioni):
    # mando il valore nel caosprocess
    out=caosprocess(valore)
    print(j+1,"    ",out)
    # feedback: - prendo l'uscita da out e la reimmetto nel caosprocess
    valore=out