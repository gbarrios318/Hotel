from buildingspy.io.outputfile import Reader
import matplotlib.pyplot as plt
from pylab import *
import numpy as np

rcParams['legend.loc'] = 'best'
r=Reader('HotelModel_cooling.mat','dymola')
(t1,y1)=r.values('realExpression.y')
(t2,y2)=r.values('supCon.y')


y1=y1*100
xlabind=[]
xlab=[]
x=(t1[len(t1)-1]-t1[0])/3600
for i in range(int(round(x+1))):
   xlabind.append(t1[0]+3600*i)
   xlab.append(str(i))
print xlabind
print xlab

ax1 = plt.subplot(2,1,1)
ax1.plot(t2,y2,color='black')
ax1.set_ylabel('Stage')
ylim(4,8)
xtic=[1]
xticks(xtic,'')

ax2 = plt.subplot(2,1,2)
ax2.plot(t1,y1,color='black')
ax2.set_ylabel('Hot Energy saving ratio(%)')
ax2.set_xlabel('Hours')
ylim(0,30)
ax2.legend(fontsize='10')
xticks(xlabind,xlab,fontsize='10')





plt.savefig('power2.png',bbox_inches='tight')

print 'the optimization is completed'