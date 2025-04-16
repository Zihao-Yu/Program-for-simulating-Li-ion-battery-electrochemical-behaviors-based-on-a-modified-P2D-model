clear all;
clc;
format long;
rand('seed',sum(clock));
X=[-1,1];                                       
Y=[-1,1];        
aset=5;  
bset=40;
cset=400;
dset=20;
XX=zeros(1,bset);             
YY=zeros(1,bset);             
x1=min(X)+(max(X)-min(X))*rand;             
y1=min(Y)+(max(Y)-min(Y))*rand;             
a=1;
b=1;
c=1;
d=1;
while a<=aset
  while b<=bset
    while c<=cset
      x2=x1+(((min(X)-x1)+(max(X)-x1))+sign(rand-0.5)*((min(X)-x1)-(max(X)-x1)))/2^(1+19*rand)*rand;
      y2=y1+(((min(Y)-y1)+(max(Y)-y1))+sign(rand-0.5)*((min(Y)-y1)-(max(Y)-y1)))/2^(1+19*rand)*rand;
      if d~=dset
        if x1^2+y1^2>x2^2+y2^2
          x1=x2;
          y1=y2;
          c=c+1;
          d=1;
        else
          d=d+1;
        end
      else
        if x1^2+y1^2>x2^2+y2^2
          x1=x2;
          y1=y2;
          c=c+1;
          d=1;
        else
          c=c+1;
          d=1;
        end
      end
    end
    XX(1,b)=x1;
    YY(1,b)=y1;
    x1=min(X)+(max(X)-min(X))*rand;
    y1=min(Y)+(max(Y)-min(Y))*rand;
    b=b+1;
    c=1;
    d=1;
  end
  X=XX;
  Y=YY;
  XY=[X;Y];
  xlswrite('C:\Users\于子豪\Desktop\Program\Program\XY.xlsx',XY,'A1:AN2');
  XX=zeros(1,bset);
  YY=zeros(1,bset);
  x1=min(X)+(max(X)-min(X))*rand;
  y1=min(Y)+(max(Y)-min(Y))*rand;
  a=a+1;
  b=1;
  c=1;
  d=1;
end 
