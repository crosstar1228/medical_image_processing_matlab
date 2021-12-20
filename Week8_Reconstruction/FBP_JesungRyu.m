sinogram=imread('sinogram_lownoise.png');
%2,3
[FI1,ramp]=frequency_filter(sinogram,'ramp');
FBP1=backprojection(FI1);
imwrite(FBP1,'FBP_001.png','png');
display_output(sinogram,FBP1,ramp);

[FI2,ham1]=frequency_filter(sinogram,'hamming',0.3);
FBP2=backprojection(FI2);
imwrite(FBP2,'FBP_002.png','png');
display_output(sinogram,FBP2,ham1);
%4. 3 is better.
%5,6,7
sinogram2=imread('sinogram_highnoise.png');

[FI3,ramp]=frequency_filter(sinogram2,'ramp');
FBP3=backprojection(FI3);
imwrite(FBP3,'FBP_003.png','png');
display_output(sinogram2,FBP3,ramp);


[FI4,ham1]=frequency_filter(sinogram2,'hamming',0.3);
FBP4=backprojection(FI4);
imwrite(FBP4,'FBP_004.png','png');
display_output(sinogram2,FBP4,ham1);

[FI5,ham2]=frequency_filter(sinogram2,'hamming',0.1);
FBP5=backprojection(FI5);
imwrite(FBP5,'FBP_005.png','png');
display_output(sinogram2,FBP5,ham2);

%8
%5ramp filter: high resolution, high noise
%6hamming 0.3: moderate resolution, moderate noise
%7hamming 0.1: low resolution, low noise





function [FI,f]=frequency_filter(sinogram,filter_option,cutoff)
[K,N]=size(sinogram);
sino_f=zeros(K,N);
for i=1:K
sino_f(i,:)=sino_f(i,:) + fftshift(fft(sinogram(i,:)));
end
v=-floor(N/2)+1:floor(N/2);
if strcmp(filter_option,'ramp')==1
    MAX=max(abs(v));
    f=abs(v)/MAX;
elseif strcmp(filter_option,'hamming')==1
    window=sin(2*pi*v/N);
    window(round(N/2+N/2*cutoff):N)=0
    window(1:round(N/2-N/2*cutoff))=0
    f=abs(window);
    
end;
FI=zeros(K,N);
for i=1:K
    FI(i,:)=ifft(ifftshift(sino_f(i,:).*f));
end;
end







function BPI=backprojection(sinogram)
[K,N]=size(sinogram)
BPI=zeros(N,N);
BPI_seg=zeros(N,N);
for i=1:K
    for j=1:K
        BPI_seg(j,:)=sinogram(i,:);
    end
    BPI_seg=imrotate(BPI_seg,360*(i-1)/K,'crop');
    BPI= BPI + BPI_seg;
    
end
MAX=max(max(BPI));
MIN=min(min(BPI));
BPI=real((BPI-MIN)/(MAX-MIN));
end
function display_output(input,output,filter)
figure;
subplot(1,3,1),imshow(input)
subplot(1,3,2),imshow(output)
subplot(1,3,3),plot(filter)
end
