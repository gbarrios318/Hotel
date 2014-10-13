from buildingspy.io.outputfile import Reader
import matplotlib.pyplot as plt
from pylab import *
import numpy as np

rcParams['legend.loc'] = 'best'
r=Reader('HotelModel_Annual.mat','dymola')
(t1,y1)=r.values('realExpression.y')
(t2,y2)=r.values('supCon.y')


y1=y1*100
xlabind=[]
xlab=['Jan','Feb','Mar','Apr','May','Jun','Jul','Aug','Sep','Oct','Dec','Nov']
x=(t1[len(t1)-1]-t1[0])/12
for i in range(12):
   xlabind.append(t1[0]+x*(0.5+i))
   xlab.append(str(i))

ax1 = plt.subplot(2,1,1)
ax1.scatter(t2,y2,color='black',s=0.2)
ax1.set_ylabel('Stage')
ylim(0,8)
xtic=[1]
xticks(xtic,'')

ax2 = plt.subplot(2,1,2)
ax2.scatter(t1,y1,color='black',s=0.2)
ax2.set_ylabel('Hot Energy saving ratio(%)')
ylim(0,35)
ax2.legend(fontsize='10')
xticks(xlabind,xlab,fontsize='10')





plt.savefig('power2.png',bbox_inches='tight')

print 'the optimization is completed'