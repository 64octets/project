
tic;
info_tupu = mhd_read_image('F:\gailutupu\liji\new-result\liver-map.mhd');
imghuidu_tupu = mhd_read_image('F:\gailutupu\liji\new-result\huidu-256.mhd');
imgrandomwalker_tupu = mhd_read_image('F:\gailutupu\liji\new-result\randomwalker-256.mhd');
Iorign = mhd_read_image('F:\gailutupu\liji\new-result\liver-orig003.mhd');
result_tupu = zeros(256,256,50);
for i = 1 : 256
    for j = 1 : 256
        for k = 1 : 50%
            result_tupu(i,j,k) = (double(imghuidu_tupu.data(i,j,k))/255)*(double(imgrandomwalker_tupu.data(i,j,k))/255)*(double(info_tupu.data(i,j,k))/19);
            if   result_tupu(i,j,k) > 0.1%0.2 for original huidu tupu
                 result_tupu(i,j,k) = 1;
            else
                 result_tupu(i,j,k) = 0;
            end
        end
    end
end
 
for k = 1 : 50
    [L,num] = bwlabel(result_tupu(:,:,k),4); 
    for i = 1:num
        [r,c] = find(L == i);
        if length(r) < 100
            for j = 1:length(r)
                result_tupu(r(j),c(j),k) = 0;
            end
        end
    end
end

se1 = strel('disk',1);
for k = 1 : 50
    result_tupu(:,:,k) = imerode(result_tupu(:,:,k),se1);
    result_tupu(:,:,k) = imdilate(result_tupu(:,:,k),se1);
end

for k = 1 : 50
    result_tupu(:,:,k) = imfill(result_tupu(:,:,k),'holes');
end

for  k=1:50
 if  k==40
        figure;
        imshow(Iorign.data(:,:,k),[]);
        hold on;
        contour(result_tupu(:,:,k),'r','linewidth',1);
        hold off;
 end
        str1='F:\gailutupu\liji\new-result\';
        str2= num2str(k);
        str3='.bmp';
        path=strcat(str1,str2,str3);
        for m=1:256
            for n=1:256
                if result_tupu(m,n,k)==1
                    result_tupu(m,n,k)=Iorign.data(m,n,k);
                end
            end
        end
%         imwrite(uint8(result_tupu(:,:,k)),path);
%  end
end

fname = 'F:\gailutupu\liji\new-result\yuanshi-result-256.raw';
writebinary(fname, result_tupu, 'int16');
toc;
%%
%%计算分割精度
img =mhd_read_image('F:\gailutupu\liji\new-result\liver-seg003.mhd');
pre1=0;
for k=1:50
    s1=0;
    s2=0;
    for i = 1 : 256
        for j = 1 : 256
            if img.data(i,j,k)~=0 && result_tupu(i,j,k)~=0
                s1=s1+1;
            end
            if img.data(i,j,k)~=0 
                s2=s2+1;
            end
             if result_tupu(i,j,k)~=0 
                s2=s2+1;
            end
        end
    end
    pre1=[pre1;2*s1/s2];
end


 