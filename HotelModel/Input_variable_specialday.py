from buildingspy.io.outputfile import Reader
import matplotlib.pyplot as plt
from pylab import *
import numpy as np

rcParams['legend.loc'] = 'best'
r=Reader('HotelModel_annual.mat','dymola')
(t1,y1)=r.values('Loa.Loa')
(t2,y2)=r.values('GueRooDomWatDem.y[1]')
(t3,y3)=r.values('KitHotWatDem.y[1]')
y1=y1/1000
t1d=[]
t2d=[]
t3d=[]

y1d=[]
y2d=[]
y3d=[]

for i in range(len(y1)):
   if t1[i]>3715200 and t1[i]<3801600:
    t1d.append(t1[i])
    y1d.append(y1[i])
	
for i in range(len(y2)):
   if t2[i]>3715200 and t2[i]<3801600:
    t2d.append(t2[i])
    y2d.append(y2[i])	

for i in range(len(y3)):
   if t3[i]>3715200 and t3[i]<3801600:
    t3d.append(t3[i])
    y3d.append(y3[i])	


xlabind=[]
xlab=[]
x=(t1d[len(t1d)-1]-t1d[0])/3600
for i in range(int(round(x+1))):
   xlabind.append(t1d[0]+3600*i)
   xlab.append(str(i))
print xlabind
print xlab

ax1 = plt.subplot(2,1,1)
ax1.plot(t1d,y1d,color='black')
ax1.set_ylabel('Cooling\Heating Load(kW)')
xtic=[1]
xticks(xtic,'')

ax2 = plt.subplot(2,1,2)
ax2.plot(t2d,y2d,color='black',label='Guest room',linestyle='--')
ax2.plot(t3d,y3d,color='black',label='Kitchen')
ax2.set_ylabel('Hot Water Demand(kg/s)')
ax2.set_xlabel('Hours')
ax2.legend(fontsize='10')
xticks(xlabind,xlab,fontsize='10')





plt.savefig('power.png',bbox_inches='tight')

print 'the optimization is completed'