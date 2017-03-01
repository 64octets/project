function [imgc,img,centriod]=fmean(im,cent,k)
[m,n]=size(im);
length=m*n;
x=double(reshape(im,1,length));
dif=zeros(k,length);
oldcent=cent;
for l=1:40
for i=1:k
dif(i,:)=((x-cent(i)).^2);      
end
new=zeros(k,length);
for i=1:length
[v,ind]=min(dif(:,i));
new(ind,i)=x(i);
end
n1=0;sum=0;
for  i=1:k
n1=0;sum=0.0;
for j=1:length
sum=sum+new(i,j);
if(new(i,j) > 0 )
n1=n1+1;
end
end
if (n1 > 0)
cent(i)=sum/n1;
end
end
if (oldcent == cent)    
    break;
else
oldcent=cent;
end
end
img=zeros(m,n);
for i=1:k
a=reshape(new(i,:),m,n);
for j=1:m
for l=1:n
if (a(j,l) > 0)
  img(j,l)=i;                
end
end
end
end
imgc=colorlbl(img);
centriod=cent;