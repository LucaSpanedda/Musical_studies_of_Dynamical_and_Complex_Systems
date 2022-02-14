# PYTHON SCRIPT FOR PLOT A DATA GRAPH
# plot a serie of data numers written in a list like:
# 1
# 2
# 3
# ...

import matplotlib.pyplot as plt
import numpy as np

# External inputs from terminal
filename = input("Enter your data file name (add .txt extension): ")
plotname = input("Enter the name for your plot (add .png/.pdf/... extension): ")

x = np.loadtxt(filename)
plt.plot(x, label='signal')

plt.xlabel('x')
plt.ylabel('y')
plt.title('plot of the signal')
plt.legend()
plt.savefig(plotname)