# MAPPA LOGISTICA

# equazione differenziale della mappa logistica
def logisticmap(x, r):
    return x * r * (1 - x)
    
# anni = iterazioni del processo (cicli iterativi)
iterazioni = int(100)

# VALORI DI PARTENZA:
# valori di x ed r
x = float(0.5)
r = float(3.9468)


# loop degli anni, e passa i valori aggiornati nuovamente 
# all'interno dell'equazione differenziale
for j in range (0,iterazioni):
    # mando il valore nell'equazione differenziale
    out = logisticmap(x,r)
    # print dei valori in uscita
    print(out)
    # feedback:
    x=out