clear all;
clc;
format long;
E=xlsread('C:\Users\于子豪\Desktop\Program\Program\Parameters 1.xlsx','A1:AN23');
r=1;
e1=E(1,r);
e2=E(2,r);
e3=E(3,r);
e4=E(4,r);
e5=E(5,r);
e6=E(6,r);
e7=E(7,r);
e8=E(8,r);
e9=E(9,r);
e10=E(10,r);
e11=E(11,r);
e12=E(12,r);
e13=E(13,r);
e14=E(14,r);
e15=E(15,r);
e16=E(16,r);
e17=E(17,r);
e18=E(18,r);
e19=E(19,r);
e20=E(20,r);
e21=E(21,r);
e22=E(22,r);
e23=E(23,r);
isnmax=30;
ispmax=30;
iemax=60;
tchange=0.5;
pset=-15;
qset=-15;
IL1=xlsread('C:\Users\于子豪\Desktop\Program\Program\Data\Load current 2(average).xlsx','C2:C401');
IL2=xlsread('C:\Users\于子豪\Desktop\Program\Program\Data\Load current 2(instantaneous).xlsx','B2:B402');
tlength=xlsread('C:\Users\于子豪\Desktop\Program\Program\Data\Inter-electrode potential 2.xlsx','A402:A402');
Vc=zeros(tlength/tchange+1,1);
Csn=(e5*e15)*ones(isnmax+1,1);
Csp=(e6*e16)*ones(ispmax+1,1);
Ce=e13*ones(iemax,1);
voltage=e14;
Vc(1,1)=voltage;
t=0;
n=0;
while t<=tlength-tchange
  Asn=diag([-ones(1,isnmax-1)+1./linspace(1,isnmax-1,isnmax-1),-1],-1)+diag([1,-ones(1,isnmax-1)-1./linspace(1,isnmax-1,isnmax-1)],1)+diag([-1,(e1/isnmax^2/tchange+2)*ones(1,isnmax-1),1],0);
  Bsn=diag([0,e1/isnmax^2/tchange*ones(1,isnmax-1),0],0)*Csn+[zeros(isnmax,1);-e3/isnmax*IL1(n+1,:)];
  Csn=Asn\Bsn; 
  Asp=diag([-ones(1,ispmax-1)+1./linspace(1,ispmax-1,ispmax-1),-1],-1)+diag([1,-ones(1,ispmax-1)-1./linspace(1,ispmax-1,ispmax-1)],1)+diag([-1,(e2/ispmax^2/tchange+2)*ones(1,ispmax-1),1],0);
  Bsp=diag([0,e2/ispmax^2/tchange*ones(1,ispmax-1),0],0)*Csp+[zeros(ispmax,1);-e4/ispmax*IL1(n+1,:)];
  Csp=Asp\Bsp;     
  Ae=diag([-ones(1,floor(e10*iemax)-1),-e12/(e12*(e10*iemax-floor(e10*iemax))+(1-e10*iemax+floor(e10*iemax))),-ones(1,iemax-2-floor(e10*iemax)-floor(e11*iemax)),-1/((-(3*e3*e8/e1)*e10*e12/(3*e4*e9/e2)/e11)*(e11*iemax-floor(e11*iemax))+(1-e11*iemax+floor(e11*iemax))),-ones(1,floor(e11*iemax))],-1)+diag([-ones(1,floor(e10*iemax)),-1/(e12*(e10*iemax-floor(e10*iemax))+(1-e10*iemax+floor(e10*iemax))),-ones(1,iemax-2-floor(e10*iemax)-floor(e11*iemax)),-(-(3*e3*e8/e1)*e10*e12/(3*e4*e9/e2)/e11)/((-(3*e3*e8/e1)*e10*e12/(3*e4*e9/e2)/e11)*(e11*iemax-floor(e11*iemax))+(1-e11*iemax+floor(e11*iemax))),-ones(1,floor(e11*iemax)-1)],1)+diag([e7/iemax^2/tchange+1,(e7/iemax^2/tchange+2)*ones(1,floor(e10*iemax)-1),e7/iemax^2/tchange+(e12+1)/(e12*(e10*iemax-floor(e10*iemax))+(1-e10*iemax+floor(e10*iemax))),(e7/iemax^2/tchange+2)*ones(1,iemax-2-floor(e10*iemax)-floor(e11*iemax)),e7/iemax^2/tchange+((-(3*e3*e8/e1)*e10*e12/(3*e4*e9/e2)/e11)+1)/((-(3*e3*e8/e1)*e10*e12/(3*e4*e9/e2)/e11)*(e11*iemax-floor(e11*iemax))+(1-e11*iemax+floor(e11*iemax))),(e7/iemax^2/tchange+2)*ones(1,floor(e11*iemax)-1),e7/iemax^2/tchange+1],0);
  Be=(e7/iemax^2/tchange)*Ce+(e7/iemax^2)*[(3*e3*e8/e1)*ones(1,floor(e10*iemax)),(3*e3*e8/e1)*(e10*iemax-floor(e10*iemax))/((e10*iemax-floor(e10*iemax))+(1-e10*iemax+floor(e10*iemax))/e12),0*ones(1,iemax-2-floor(e10*iemax)-floor(e11*iemax)),(3*e4*e9/e2)*(e11*iemax-floor(e11*iemax))/((e11*iemax-floor(e11*iemax))+(1-e11*iemax+floor(e11*iemax))/(-(3*e3*e8/e1)*e10*e12/(3*e4*e9/e2)/e11)),(3*e4*e9/e2)*ones(1,floor(e11*iemax))]'*IL1(n+1,:);
  Ce=Ae\Be;
  ocp=e14-(log(e16/(e6*e16)-1)-log(e15/(e5*e15)-1))/e17+(log(Ce(iemax,1))-log(Ce(1,1)))/e17+(log(e16/Csp(ispmax+1,1)-1)-log(e15/Csn(isnmax+1,1)-1))/e17;
  phi=-IL2(n+2,:)*e18;
  etan=0;
  etap=0;
  p=0;
  q=0;
  while p>=pset
    while sign(IL2(n+2,:))*(exp((1-e21)*e17*etan)-exp(-e21*e17*etan))<sign(IL2(n+2,:))*(IL2(n+2,:)*(e13^(1-e21)*e19/Ce(1,1)^(1-e21))/(e15-Csn(isnmax+1,1))^(1-e21)/Csn(isnmax+1,1)^e21)
      etan=etan+sign(IL2(n+2,:))*10^p;
    end
    etan=etan-sign(IL2(n+2,:))*10^p;
    p=p-1;
  end
  while q>=qset
    while sign(-IL2(n+2,:))*(exp((1-e22)*e17*etap)-exp(-e22*e17*etap))<sign(-IL2(n+2,:))*(IL2(n+2,:)*(e13^(1-e22)*e20/Ce(iemax,1)^(1-e22))/(e16-Csp(ispmax+1,1))^(1-e22)/Csp(ispmax+1,1)^e22)
      etap=etap+sign(-IL2(n+2,:))*10^q;
    end
    etap=etap-sign(-IL2(n+2,:))*10^q;
    q=q-1;
  end
  eta=etap-etan;
  zeta=(e23-1/e17)*(log(Ce(iemax,1))-log(Ce(1,1)));
  voltage=ocp+phi+eta+zeta;
  Vc(n+2,1)=voltage;
  t=t+tchange;
  n=n+1;
end
xlswrite('C:\Users\于子豪\Desktop\Program\Program\Data\Inter-electrode potential 2.xlsx',Vc,'C2:C402');