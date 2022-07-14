# Phase Space 3D Plot

import numpy as np
from mpl_toolkits.mplot3d import axes3d, Axes3D
import matplotlib.pyplot as plt

# Plot

# name output
xcoor = input("Enter your x coordinates (without txt extension):")
ycoor = input("Enter your y coordinates (without txt extension):")
zcoor = input("Enter your y coordinates (without txt extension):")

xplt = np.loadtxt(xcoor+".txt")
yplt = np.loadtxt(ycoor+".txt")
zplt = np.loadtxt(zcoor+".txt")

# name output
nomeplot = input("Enter your file name (without extension):")


fig = plt.figure()
ax = Axes3D(fig) 

ax.plot(xplt, yplt, zplt, color='g', alpha=0.7, linewidth=0.6)
ax.set_xlabel("X Axis")
ax.set_ylabel("Y Axis")
ax.set_zlabel("Z Axis")
ax.set_title("Phase Space")

# save output
plt.savefig(nomeplot+".png")