from buildingspy.io.outputfile import Reader
import matplotlib.pyplot as plt
from pylab import *
import numpy as np

rcParams['legend.loc'] = 'best'
r=Reader('HotelModel_Annual.mat','dymola')
(t1,y1)=r.values('realExpression.y')
(t2,y2)=r.values('supCon.y')
y1=y1*100
t1d=[]
t2d=[]


y1d=[]
y2d=[]


for i in range(len(y1)):
   if t1[i]>3715200 and t1[i]<3801600:
    t1d.append(t1[i])
    y1d.append(y1[i])
	
for i in range(len(y2)):
   if t2[i]>3715200 and t2[i]<3801600:
    t2d.append(t2[i])
    y2d.append(y2[i])	




xlabind=[]
xlab=[]
x=(t1d[len(t1d)-1]-t1d[0])/3600
for i in range(int(round(x+1))):
   xlabind.append(t1d[0]+3600*i)
   xlab.append(str(i))
print xlabind
print xlab

ax1 = plt.subplot(2,1,1)
ax1.plot(t2d,y2d,color='black')
ax1.set_ylabel('Stage')
ylim(0,8)
xtic=[1]
xticks(xtic,'')

ax2 = plt.subplot(2,1,2)
ax2.plot(t1d,y1d,color='black')
ax2.set_ylabel('Hot Energy saving ratio(%)')
ax2.set_xlabel('Hours')
ylim(0,30)
ax2.legend(fontsize='10')
xticks(xlabind,xlab,fontsize='10')





plt.savefig('power2.png',bbox_inches='tight')

print 'the optimization is completed'