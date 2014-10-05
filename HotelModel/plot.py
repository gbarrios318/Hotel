from buildingspy.io.outputfile import Reader
import matplotlib.pyplot as plt
from pylab import *
import numpy as np

rcParams['legend.loc'] = 'best'
r=Reader('HotelModel.mat','dymola')
(t1,y1)=r.values('CooLoa.y[1]')
(t2,y2)=r.values('GueRooDomWatDem.y[1]')
(t3,y3)=r.values('KitHotWatDem.y[1]')

y1=y1/1000
xlabind=[]
xlab=[]
x=(t1[len(t1)-1]-t1[0])/3600
for i in range(int(round(x+1))):
   xlabind.append(t1[0]+3600*i)
   xlab.append(str(i))
print xlabind
print xlab

ax1 = plt.subplot(2,1,1)
ax1.plot(t1,y1,color='black')
ax1.set_ylabel('Cooling Load(kW)')
ylim(400,420)
xtic=[1]
xticks(xtic,'')

ax2 = plt.subplot(2,1,2)
ax2.plot(t2,y2,color='black',label='Guest room',linestyle='--')
ax2.plot(t3,y3,color='black',label='Kitchen')
ax2.set_ylabel('Hot Water Demand(kg/s)')
ax2.set_xlabel('Hours')
ax2.legend(fontsize='10')
xticks(xlabind,xlab,fontsize='10')





plt.savefig('power.png',bbox_inches='tight')

print 'the optimization is completed'