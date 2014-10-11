from buildingspy.io.outputfile import Reader
import matplotlib.pyplot as plt
from pylab import *
import numpy as np

rcParams['legend.loc'] = 'best'
r=Reader('HotelModel_Annual.mat','dymola')
(t1,y1)=r.values('Loa.Loa')
(t2,y2)=r.values('GueRooDomWatDem.y[1]')
(t3,y3)=r.values('KitHotWatDem.y[1]')

y1=y1/1000
xlabind=[]
xlab=['Jan','Feb','Mar','Apr','May','Jun','Jul','Aug','Sep','Oct','Dec','Nov']
x=(t1[len(t1)-1]-t1[0])/12
for i in range(12):
   xlabind.append(t1[0]+x*(0.5+i))
   xlab.append(str(i))

t2d=[]
t3d=[]
y2d=[]
y3d=[]
for i in range(len(y2)):
   if t2[i]<86400:
    t2d.append(t2[i])
    y2d.append(y2[i])	

for i in range(len(y3)):
   if t3[i]<86400:
    t3d.append(t3[i])
    y3d.append(y3[i])
	
print xlabind
print xlab

xlabindd=[]
xlabd=[]
x=(t2d[len(t2d)-1]-t2d[0])/3600
for i in range(int(round(x+1))):
   xlabindd.append(t2d[0]+3600*i)
   xlabd.append(str(i))
print xlabindd
print xlabd

ax1 = plt.subplot(2,1,1)
ax1.scatter(t1,y1,color='black',s=0.1)
ax1.set_xlabel('HVAC Load(kW)',fontsize='10')
xticks(xlabind,xlab,fontsize='10')

ax2 = plt.subplot(2,1,2)
ax2.plot(t2d,y2d,color='black',label='Guest room',linestyle='--')
ax2.plot(t3d,y3d,color='black',label='Kitchen')

ax2.set_xlabel('Daily Hot Water Demand(kg/s,repeating periodically)',fontsize='10')
xticks(xlabindd,xlabd,fontsize='10')





plt.savefig('power.png',bbox_inches='tight')

print 'the optimization is completed'