%1.
im=imread('skull.jpg','jpg');
whos im
im=imresize(im,[226 187]);

%2.
lpf=fspecial('gaussian',[5 5],2.0);
lpf=imresize(lpf,[30 30]);
surf(lpf);

%3.
imz=zeros([256 256]);
siz=size(im);
for i=1:siz(1)
    for j=1:siz(2)
        imz(i,j)=im(i,j);
    end;
end;

lpfz=zeros([256 256]);
siz=size(lpf);
for i=1:siz(1)
    for j=1:siz(2)
        lpfz(i,j)=lpf(i,j);
    end;
end;

IMZ=fft2(imz);
LPFZ=fft2(lpfz);
IMZ_SC=fftshift(IMZ);
LPFZ_SC=fftshift(LPFZ);

figure;
subplot(1,2,1),surf(abs(IMZ_SC));
subplot(1,2,2),surf(abs(LPFZ_SC));


%4.
g=mat2gray(fspecial('gaussian',256,2));
IMZSH=fftshift(IMZ);
imzsh=ifft2(IMZSH);
IML=IMZSH.*g;
iml_f=ifft2(IML);
whos iml_f
%허수 타입이다.
iml_f2=real(iml_f);
iml_f3=iml_f2(1:226,1:187);
MAX=max(max(iml_f3))
MIN=min(min(iml_f3))
iml_f4=(iml_f3-MIN)/(MAX-MIN)*255;
iml_conv=conv2(im,lpf);
figure,subplot(1,3,1),imshow(iml_f3,[]);
subplot(1,3,2),imshow(iml_f4,[]);
subplot(1,3,3),imshow(iml_conv,[]);


%5.
[x,y]= meshgrid(-128:127, -128:127);
z=sqrt(x.^2+y.^2);
c=(z>1);
figure,subplot(1,3,1),imshow(c);
IMZH=IMZ.*c;
subplot(1,3,2),fftshow(IMZH,'log');
IMZHI=ifft2(IMZH);
subplot(1,3,3),fftshow(IMZHI,'abs');

g1=mat2gray(fspecial('gaussian',256,1));
g2=mat2gray(fspecial('gaussian',256,50));
h1=1-g1;
h2=1-g2;
IMZG1=IMZ.*h1;
IMZG2=IMZ.*h2;
IMZGI1=ifft2(IMZG1);
IMZGI2=ifft2(IMZG2);
figure,subplot(1,2,1),fftshow(IMZGI1,'abs');
subplot(1,2,2),fftshow(IMZGI2,'abs');

%두 경우 다 숫자가 작을수록 윤곽이 진해지는 것으로 보인다. 
% filter radius:1, standard deviation: 1