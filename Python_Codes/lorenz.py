#######################################

# ATTRATTORE DI LORENZ by Luca Spanedda

#######################################

# Librerie
import sys
import numpy as np
from mpl_toolkits.mplot3d import axes3d, Axes3D
import matplotlib.pyplot as plt

# definizione dell'equazione differenziale
def lorenz(x, y, z, sigma=10, rho=28, beta=2.666667, dt=0.005, q = 1.0):
    x_0 = (x+(sigma*(y-x))*dt)*q
    y_0 = (y+ (rho*x -(x*z) -y)*dt)*q
    z_0 = (z+ ((x*y)-(beta*z)) *dt)*q
    return x_0, y_0, z_0
    
# iterazioni del processo (cicli iterativi)
iterazioni = 10000

# VALORI DI PARTENZA x,y,z:
x = float(1.2)
y = float(1.3)
z = float(1.6)

# Apre tre file di testo per i valori di X, Y, Z
xwrite=open('x.txt','w')
ywrite=open('y.txt','w')
zwrite=open('z.txt','w')

# sviluppo e feedback dell'equazione differenziale
for j in range (0,iterazioni):
    # mando i valori nell'equazione differenziale
    out = lorenz(x,y,z)

    # print dei risultati in file X
    xwrite.write(str(x))
    xwrite.write('\n')
    # print dei risultati in file Y
    ywrite.write(str(y))
    ywrite.write('\n')
    # print dei risultati in file Z
    zwrite.write(str(z))
    zwrite.write('\n')

    # rimanda l'output in input
    (x,y,z) = out

# chiudi i tre file di testo
xwrite.close()
ywrite.close()
zwrite.close()



#######################################

# Phase Space 3D Plot

#######################################

# Plot
xplt = np.loadtxt("x.txt")
yplt = np.loadtxt("y.txt")
zplt = np.loadtxt("z.txt")

# name output
nomeplot = input("Enter your file name (without extension):")

fig = plt.figure()
ax = Axes3D(fig) 

ax.plot(xplt, yplt, zplt, color='g', alpha=0.7, linewidth=0.6)
ax.set_xlabel("X")
ax.set_ylabel("Y")
ax.set_zlabel("Z")
ax.set_title("Phase Space")

# save output
plt.savefig(nomeplot+".png")
