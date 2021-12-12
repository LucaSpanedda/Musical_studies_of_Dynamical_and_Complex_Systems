from random import random, seed
import matplotlib

# Markov di primo ordine
# Definiamo i passaggi secondo una matrice Markoviana
A1=[0, 1, 0, 0, 0]
A2=[0.5, 0, 0.5, 0, 0]
A3=[0, 0, 0.5, 0, 0.5]
A4=[0, 0.5, 0, 0.5, 0]
A5=[0, 0, 0, 1, 0]
# e definiamo le unità della matrice
Markov=[A1,A2,A3,A4,A5]
print(Markov)


# Definisco poi una tabella dove i numeri interi del codice
# - in uscita al termine della catena markoviana -
# verranno print-ati con dei caratteri corrispondenti al dizionario che costruisco qui:
def Numbers_To_Words (number):
    dictionary = {'1': "one", '2': "two", '3': "three", '4': "four", '5': "five", '6': "six",
            '7': "seven", '8': "eight", '9': "nine", '0': "zero"}
    return " ".join(map(lambda x: dictionary[x], str(number)))


# genero poi un nuovo seme per la generazione di un randomica
seed()


# Qui inizia l'Algoritmo della catena di Markov
def nuovo_stato(stato_precedente):
  number=random()
  accum=0;
  i=0;
  while accum<number:
      accum=accum+float(Markov[int(stato_precedente)][int(i)])
      i= i + 1
# nuovo stato del sistema
  return i - 1  
# gradino di partenza
stato_precedente= int(1)

# Calcolo dei primi 50 passaggi del sistema
# il numero 50 corrisponde ai passaggi degli elementi
# che verranno print-ati
for i in range(0,50):
    stato=nuovo_stato(stato_precedente)
    # stato attuale passa al precedente
    # obbligo a ripetere il ciclo nuovo_stato in - loop -
    # (vedere a def nuovo stato)
    stato_precedente=stato
    # number corrisponde al nuovo_stato(stato_precedente) +1
    number = nuovo_stato(stato_precedente) +1
    # e result che andrà print-ato obbliga number ad uscire
    # dalla tabella in alto - dizionario - Numbers_To_Words (number)
    result = Numbers_To_Words (number)
    
    # print del risultato passato per il dizionario
    print (result)
