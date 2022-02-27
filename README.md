# Musical_studies_of_Dynamical_and_Complex_Systems 
## - Codes Index

A repository for the studies and the applications of different Dynamic and Complex Systems for Music and DSP
### Python Codes
### 0.00 - Filters
### 10.00 - Chaotic Signals
### 2.00 - Utilities
### 8.00 - Saturators
### 9.00 - DC Blocker

## - Definition of the study:

## Sistemi Dinamici e Sistemi Complessi:
Un sistema dinamico è un modello matematico che rappresenta un oggetto (sistema) con un numero finito di gradi di libertà che evolve nel tempo secondo una legge deterministica; Mentre per sistema complesso si intende un sistema dinamico a multicomponenti, 
ovvero composto da diversi sottosistemi che tipicamente interagiscono tra loro.

Tipicamente un sistema dinamico viene rappresentato analiticamente da un'equazione differenziale, espressa poi in vari formalismi, e identificato da un vettore nello spazio delle fasi, lo spazio degli stati del sistema, dove "stato" è un termine che indica l'insieme delle grandezze fisiche, dette variabili di stato, i cui valori effettivi "descrivono" il sistema in un certo istante temporale.

Si possono identificare due tipologie di sistema dinamico:

Se l'evoluzione avviene ad intervalli discreti di tempo il sistema viene chiamato sistema dinamico discreto ed è definito dall'iterazione di una funzione.
Se l'evoluzione è continua e definita da un'equazione differenziale, il sistema viene chiamato sistema dinamico continuo.
Ci sono sistemi che possono non variare nel passare del tempo e sono detti:
- Sistemi tempo-invarianti.
Mentre quando da questi ci si aspetta un effettivo cambiamento sono detti
- Sistemi tempo-varianti.


## Sistemi Caotici:

«Può il battito delle ali di una farfalla in Brasile scatenare un tornado in Texas ?»

(Lorenz all'American Association for the Advancement of Sciences, 1979)

<<La teoria del caos postula che esista una classe di fenomeni naturali che possono essere modellati da sistemi deterministici non lineari. Il valore di ciascuna variabile nel sistema può essere molto irregolare e molto sensibile a piccole variazioni delle condizioni iniziali. In alcuni sistemi, con determinate condizioni iniziali i valori di ciascuna variabile si libreranno attorno a due o più valori (attrattori), questo assumendo una "oscillazione non periodica" - un'orbita che esiste entro limiti definiti ma non si ripete mai esattamente...
...anche se non presi da una prospettiva di modellazione fisica, i segnali caotici, e in particolare le oscillazioni non periodiche, rappresentano una sorta di via di mezzo tra il rumore casuale e le forme d'onda periodiche. Possono essere usati per espandere le possibilità di sintesi nella generazione di ricche texture semi-casuali con controlli di parametro precisi.>>
– Jamie Dunkle, 15/4/2015

Ciò che accomuna un sistema complesso a un sistema caotico è la non linearità. 
In questa visione di complessità i sistemi caotici sono considerati un sottoinsieme dei sistemi complessi: 
la complessità si manifesta infatti sulla soglia della caoticità.
L'ipotesi che sistemi deterministici possano sviluppare comportamenti impredicibili 
fu teorizzata per la prima volta dal matematico francese H. Poincarè 
già nello studio del problema dei tre corpi (1890).
Dunque quando si parla di caos ci si riferisce ad un certo tipo di comportamento del sistema 
guidato da un'elevata sensibilità alle condizioni iniziali.
In altri termini un sistema caotico amplifica le piccole differenze: porta i fenomeni microscopici a un livello macroscopico. E’ dunque nell’amplificazione di queste piccole caratteristiche che sorge il caso. 
Il sistema solare è stabile e regolare su una scala dell’ordine del milione di anni, ed è caotico su una scala di cento milioni di anni. Una differenza per quanto inizialmente trascurabile, tende ad amplificarsi e a mettere in dubbio la validità delle predizioni a lungo termine proprio come un’imprecisione sulla posiazione iniziale o degli errori di arrotondamento nel corso del calcolo possono mettere in discussione il risultato finale. 
Il problema però non è esattamente lo stesso, poiché l’errore non è nei dati ma nel modello. 
Non è più un errore sulle variabili ma sulle equazioni. 
I sistemi caotici, proprio come quelli stocastici, appartengono alla classe dei sistemi dinamici e
dei sistemi complessi. Solo che mentre nei sistemi caotici i comportamenti sono deterministici
ed è possibile prevedere il risultato se si conoscono le condizioni iniziali del sistema ed il suo
comportamento, e dunque a parità delle condizioni iniziali il risultato è prevedibile.
Nei modelli stocastici il comportamento dipende da delle probabilità, che possono essere calcolate
tramite il calcolo delle probabilità. Non è possibile dunque determinare a parità delle condizioni
iniziali il proprio comportamento:

- Modelli Stocastici
- Modelli Deterministici

## Equazioni differenziali:

Un'equazione differenziale è un'equazione che lega una funzione incognita alle sue derivate. La funzione derivata di una funzione rappresenta il tasso di cambiamento di una funzione rispetto a una variabile, vale a dire quindi la crescita (o decrescita) che avrebbe una funzione in uno specifico punto spostandosi di pochissimo dal punto considerato.

Può essere anche descritta come un set di equazioni relative al raggio di cambiamento di un numero sconosciuto e la sua derivata.

ad esempio: Y = sin(Y)

Esistono dei modelli di equazioni differenziali a comportamenti caotici. I segnali caotici possono infatti essere generati trovando soluzioni numeriche a determinate equazioni differenziali, o mediante l'uso iterativo di mappe di primo ritorno. Alcune delle equazioni differenziali più utilizzate in grado di generare segnali caotici sono: 

- Lotka-Volterra 
- Van der Pol
- Lorenz
- Rössler
- Hindmarsh-Rose
- Thomas
- Duffing oscillator.


## Costringere le funzioni:

In matematica, una costrizione è una condizione di un problema 
di ottimizzazione che la soluzione deve soddisfare. 
Nel nostro caso si intende adottare una serie di strumenti
per costringere le equazioni differenziali ed altri segnali
a contenere il sistema in un range di valori desiderati.

alcuni metodi possono essere:

- Il Wavefolding
- Il Waveshaping
per la saturazione del segnale.
Ad esempio il Soft Clipping tramite la funzione tangente, 
costringe il segnale mappando come massimo o minimo valore
numeri tra - e + infinito ad numeri fra -1 ed +1. 
In questo modo posso esplorare diversi velori del sistema.

Oppure:
- Il DC Blocker
per costringere un valore fisso, ad essere interpretato
come un valore all'interno delle fasi e ad essere attenuato e riportato a 0.
Infatti un valore DC può essere interpretato come un segnale a frequenza 0.
Il DC Blocker interviene nella differenza fra due numeri, più due campioni hanno di differenza meno sarà 
l'attenuazione, se due numeri sono vicini l'attenuazione invece tenderà ad azzerarli.
il DC blocker più semplice è la derivata prima, con il polo prima o dopo si tende a recuperare parte della
zona attenuata (cancellata).

Il filtro di Zavalishin non crea problemi nelle fasi a differenza del onepole nel lowpass.
Il onepole crea problemi con segnali tempovarianti.
Lo state variable filter di Zavalishin permette di avere uno strumento che al variare di coefficenti,
varia comportamenti e permette di ottenere uno strumento di regolazione variabile ad-hoc.


## Principi di Feedback nei sistemi audio digitali e analogici:

Il feedback è un importante condizione alla base dei sistemi caotici dinamici:
avviene quando vi è circolarità fra causa ed effetti;
ovvero quando gli effetti di un processo tornano ad influenzare 
il processo stesso.
Il feedback acustico consiste nel ritorno di un suono fra una sorgente e un recettore,
(ad esempio un microfono ed un altoparlante)
in un circuito di retroazione a guadagno potenzialmente infinito.
Nel feedback analogico il segnale viene emesso da una sorgente 
e captato da un ricettore all'interno di un ambiente.
E a seconda delle variabili del sistema, quali: 
condizioni dell'ambiente, distanza fra sorgente e ricettore, 
risposta in frequenza dei due e risonanze della stanza, 
e più in generale ogni minimo trasferimento 
non lineare in qualsiasi componente relativa al suono,
porterà all'influenza in qualche modo del processo di feedback.
In alcuni casi  una frequenza in fase con il segnale viene a sommarsi ad esso 
e viene amplificata e riprodotta a sua volta con ampiezza via via crescente 
- Effetto Larsen -
in altri casi, per evitare questo comportamento,
e dunque l'intonazione del feedback ad una determinata frequenza, 
bisogna introdurre delle non linearità nel sistema di feedback. 
Queste non linearità nel mondo fisico appartengono alla sua natura stessa
e corrispondono al controllo di tutte le variabili elencate in precedenza.
Nel mondo digitale invece le non linearità devono essere implementate.
Infatti di norma i comportamenti del computer a differenza di quelli in natura sono lineari.


## Retroazione positiva e negativa, linearità e non-linearità:

- Retroazione Positiva
- Retroazione Negativa

La retroazione positiva tende ad accelerare un processo, 
mentre la retroazione negativa a rallentarlo. 
La retroazione negativa aiuta a mantenere la stabilità di un sistema, 
contrastando i cambiamenti dell'ambiente esterno.
Mentre la positiva tende alla complessità.
Nel controllo di un sistema complesso,
come può essere ad esempio quello del feedback acustico di cui abbiamo parlato,
introdurre delle linearità tramite retroazione vuole dire costringere la complessità 
a dei comportamenti prevedibili, si può pensare ad esempio all'intonazione del feedback,
che da un comportamento complesso della sorgente e del ricettore arriva ad uno lineare. 
Mentre introdurre delle non-linearità nel sistema tramite la retroazione, 
(ma delle non-linearità possono essere introdotte anche in altro modo)
vuole dire portare questo verso comportamenti non prevedibili, complessi.
Questi due comportamenti possono essere ottenuti per l'appunto
sia velocizzando che rallentando questi processi, 
in maniera dipendente dal caso specifico.
I filtri digitali o analogici per l'audio,
possono essere pensati ad esempio come uno strumento
di contrasto rispetto a questo tipo di comportamenti:
dove se si allineano le fasi si creano dei poli,
mentre se si disallineano si punta alla complessità del sistema.

## L'auto-organizzazione:
Una condizione necessaria affinché un sistema possa essere definito 
complesso è che questo tenda ad un qualce tipo di ordine spontaneo.
Tuttavia l'ordine di cui parliamo nei sistemi complessi non
è un concetto di ordine assoluto globale degli elementi,
ma piuttosto un concetto di stabilità distribuito.
Si può dunque parlare di condizioni di

- Stabilità del sistema
- Instabilità del sistema

Quando si vuole raggiungere un qualche tipo di equilibrio di un sistema
instabile ci si sta ponendo un problema di adattività, ed ottimizzazione.
Uno strumento per l'adattività come abbiamo visto sono le costrizioni matematiche.

## L'Organizzazione Gerarchica:
Spesso nei sistemi complessi sono presenti più livelli di organizzazione
che possono essere pensati come se formassero una struttura gerarchica
di più sistemi e sottoinsiemi interagenti. 
Basti pensare al cervello, ad un ecosistema, o a una cellula...
o in scala più grande all'universo stesso che a sua volta contiene tutti gli elementi precedenti.


# Bibliography

Clutterbuck Tristan, Mudd Tom, Sanfilippo D. - A Practical and Theoretical Introduction to Chaotic Musical Systems.

Di Scipio Agostino - ‘Sound is the interface’ from interactive to ecosystemic signal processing.

Di Scipio Agostino - Listening to Yourself through the Otherself On Background Noise Study.

Di Scipio Agostino - The Politics of Sound and the Biopolitics of Music Weaving together sound-making, irreducible listening, and the physical and cultural environment.

Manousakis Stelios - Musical Cybernetics - The Human And The Computational.

Phivos-Angelos KOLLIAS - Music and Systems Thinking.

Pickles Daren - Cybernetics in Music (PhD).

Sanfilippo Dario - Complex Musical Behaviours via Time-Variant Audio Feedback Networks and Distributed Adaptation - a Study of Autopoietic Infrastructures for Real-Time Performance Systems (PhD).

Sanfilippo Dario - Dynamical infrastructures and multi-adaptivity: higher degrees of variety and complexity in autonomous music feedback systems

Sanfilippo Dario,  Valle Andrea - Feedback Systems An Analytical Framework.

Sanfilippo Dario,  Valle Andrea - Towards a typology of feedback systems.

Wiener  Norbert - La cibernetica. Controllo e comunicazione nell'animale e nella macchina (1982, Il Saggiatore).

Wiener  Norbert - The Human Use of Human Beings Cybernetics and Society.

Wishart Trevor - On Sonic Art (Contemporary Music Studies).
