# ATTRATTORE DI LORENZ

# definizione dell'equazione differenziale
def lorenz(x, y, z, sigma=10, rho=28, beta=2.666667, dt=0.005, q = 1.0):
    x_0 = (x+(sigma*(y-x))*dt)*q
    y_0 = (y+ (rho*x -(x*z) -y)*dt)*q
    z_0 = (z+ ((x*y)-(beta*z)) *dt)*q
    return x_0, y_0, z_0
    
    
# iterazioni del processo (cicli iterativi)
iterazioni = int(1000)

# VALORI DI PARTENZA x,y,z:
x = float(1.2)
y = float(1.3)
z = float(1.6)


# sviluppo e feedback dell'equazione differenziale
for j in range (0,iterazioni):
    # mando i valori nell'equazione differenziale
    out = lorenz(x,y,z)
    # print solo della variabile x
    # per altri outs sostituire con: y,z, o(x,y,z)
    print(x)
    # feedback delle tre variabili x,y,z:
    (x,y,z)=out