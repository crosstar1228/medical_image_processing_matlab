sev=imread('cameraman.tif');
sev1=double(sev);
MAX=max(max(sev1));
MIN=min(min(sev1));
sev2=sev1/(MAX-MIN);
halfmat=ones(size(sev2))/2;

%restoration of noise added image
imn1=imnoise(sev2,'gaussian');
imn2=imnoise(sev2,'salt & pepper');
figure;
subplot(1,3,1),imhist(halfmat);
subplot(1,3,2),imhist(imn1);
subplot(1,3,3),imhist(imn2);
%gaussian: normally distributed한 noise
%salt and pepper: 급변하는 큰 intensity값의 noise

imn1_av=conv2(imn1,[1,1,1;1,1,1;1,1,1]/9);
imn2_av=conv2(imn2,[1,1,1;1,1,1;1,1,1]/9);
imn1_med=medfilt2(imn1);
imn2_med=medfilt2(imn2);


%Restoration of degraded image
x=imread('whatIsThis.png');
X=fftshift(fft2(image));
h=zeros(size(X));
filter=fspecial('gaussian',[15 15],sqrt(0.9));
siz=size(filter);
for i=1:siz(1)
    for j=1:siz(2)
        h(i,j)=filter(i,j);
    end;
end;
H=fftshift(fft2(h));
Y=X./H;%.*butter(x,40,10);
y=abs(ifft2(Y));
figure;
subplot(1,3,1),imshow(x);
subplot(1,3,2),imshow(mat2gray(y));


k=0.0001;
Y2=X.*(abs(H).^2./(abs(H).^2+k)./H);
y2=abs(ifft2(Y2));
subplot(1,3,3),imshow(mat2gray(y2));
%적절한 k값은? 0.0001~0.001 사잇값이 blurness와 sharpness을 절충한 좋은 이미지.
%noise가 고려된 Wiener filter가 더 낫다.



%Development of median filter

figure;
imn1_filt=MED(imn1);
subplot(1,2,1),imshow(imn1_filt);
imn2_filt=MED(imn2);
subplot(1,2,2),imshow(imn2_filt);


function c=MED(b)
SIZE=size(b)
c=zeros(SIZE(1)-4,SIZE(2)-4);
for i=3:SIZE(1)-2
    for j=3:SIZE(2)-2
        c(i-2,j-2)=median(median(b(i-2:i+2,j-2:j+2)));
    end;
end;
end



        




