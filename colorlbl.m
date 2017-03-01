function x=colorlbl(im)
[m,n]=size(im);
x=zeros(m,n,3);
for i=1:m
  for j=1:n  
      if (im(i,j)==1)          
             x(i,j,:)=[1,0,0];            
       elseif (im(i,j)==2)         
             x(i,j,:)=[0,1,0];
       elseif(im(i,j)==3)
             x(i,j,:)=[0,0,1];
       elseif(im(i,j)==4)
             x(i,j,:)=[1,1,0];
       elseif(im(i,j)==5)
              x(i,j,:)=[1,0,1];
       elseif(im(i,j)==6)
              x(i,j,:)=[0,1,1];
        elseif(im(i,j)==7)
             x(i,j,:)=[1,0.5,1];
        elseif(im(i,j)==8)
             x(i,j,:)=[1,0.2,0.5];
        elseif(im(i,j)==9)
             x(i,j,:)=[0.5,1,0.5];
        elseif(im(i,j)==10)
             x(i,j,:)=[1.0,0.8,0.2];
     end
end
end


