# Libraries

import numpy as np
from mpl_toolkits.mplot3d import axes3d, Axes3D
import matplotlib.pyplot as plt

iterations = 10000


x_init = 1.2
y_init = 1.3
z_init = 1.6

dt = 0.005

def lorenz(x, y, z, sigma = 10, rho = 28 , beta = 2.666667, q = 1.0): 
    """
    x_0 = (x+(sigma*(y-x))*dt)*q
    y_0 = (y+ (rho*x -(x*z) -y)*dt)*q
    z_0 = (z+ ((x*y)-(beta*z)) *dt)*q
    """
    x_0 = ((sigma*(y - x)) * dt) * q
    y_0 = ((rho*x - y - x*z) * dt) * q
    z_0 = ((x*y - beta*z) * dt) * q
    return x_0, y_0, z_0


# Need one more for the initial values
xs = np.empty(iterations + 1)
ys = np.empty(iterations + 1)
zs = np.empty(iterations + 1)

# Set initial values
xs[0], ys[0], zs[0] = (x_init, y_init, z_init)

# Step through "time", calculating the partial derivatives at the current point
# and using them to estimate the next point
for i in range(iterations):
    x_0, y_0, z_0 = lorenz(xs[i], ys[i], zs[i])
    xs[i + 1] = xs[i] + (x_0) 
    ys[i + 1] = ys[i] + (y_0)
    zs[i + 1] = zs[i] + (z_0)


# Plot

# name output
nomeplot = input("Enter your file name (without extension):")

fig = plt.figure()
ax = Axes3D(fig) 

ax.plot(xs, ys, zs, color='g', alpha=0.7, linewidth=0.6)
ax.set_xlabel("X Axis")
ax.set_ylabel("Y Axis")
ax.set_zlabel("Z Axis")
ax.set_title("Lorenz Attractor")

# save output
plt.savefig(nomeplot+".png")
