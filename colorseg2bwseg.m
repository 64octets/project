function imgOut=colorseg2bwseg(img,whiteout)

if nargin < 2
    whiteout=.3;
end

%Find outlines
redSegs=find(img(:,:,1)>.6 & img(:,:,2)<.4);

%Whiten image
imgOut=img(:,:,2);
imgOut=imgOut./max(max(imgOut));
imgOut=imgOut.^whiteout;

%Black out segments
imgOut(redSegs)=0;
