%1.
bw=imread('brain_whitenoise.jpg');
f1=fspecial('log');
cf1=filter2(f1,bw);
f2=fspecial('laplacian');
cf2=filter2(f2,bw);
figure;
subplot(1,2,1),imshow(cf1/100);
subplot(1,2,2),imshow(cf2/100);

%2.
ori=imread('body.jpg');
sma=imresize(ori,[32 32]);
figure;
imshow(sma);
nea=imresize(sma,[256 256],'nearest');
figure;
imshow(nea);
bil=imresize(sma,[256 256],'bilinear');
figure;
imshow(bil);
imwrite(nea,'nearest.bmp','bmp');
imwrite(bil,'bilinear.bmp','bmp');
%9) bilinear 영상이 더 부드럽고 덜 깨진다.

%3
nrot=imrotate(ori,30,'nearest');
figure;
subplot(1,2,1), imshow(nrot);
brot=imrotate(ori,30,'bilinear');
subplot(1,2,2), imshow(brot);
imwrite(nrot, 'nearest_rotate.bmp','bmp');
imwrite(brot, 'bilinear_rotate.bmp','bmp');
%6) bilinear 영상이 더 부드럽고 덜 깨진다.

%4.1)2)
sadimg=imread('sadimg.bmp');
oriimg=imread('img.jpg');
%oriimg2=imrotate(oriimg,30,'bicubic');
sadimg1=imresize(sadimg,[350,350]);
sadimg2=imrotate(sadimg1,-30,'bicubic');
sadimg3=medfilt2(sadimg2);
sadimg4=imresize(sadimg3,[350,350]);
figure;
subplot(2,2,1);imshow(sadimg1);
subplot(2,2,2);imshow(sadimg2);
subplot(2,2,3);imshow(sadimg3);
subplot(2,2,4);imshow(sadimg4);
%%%for문으로도 해볼것 - size, zeros 이용
siz=size(sadimg2);
sadimg_med=zeros(siz);
for i=2:siz(1)-1
    for j=2:siz(2)-1
        matrix=[sadimg2(i-1,j-1),sadimg2(i,j-1),sadimg2(i+1,j-1);sadimg2(i-1,j),sadimg2(i,j),sadimg2(i+1,j);sadimg2(i-1,j+1),sadimg2(i,j+1),sadimg2(i+1,j+1)];
        sadimg_med(i,j)=median(median(matrix));
    end;
end;
figure;
imshow(sadimg_med,[]);


%3)4)
I=imread('sadimg2.bmp','bmp');
figure;
subplot(1,2,1),imshow(I);
tform=maketform('affine',inv([1 0 0;0.5 1 0;0 0 1]));
J=imtransform(I,tform);
theta=30*pi/180
tform2=maketform('affine',inv([cos(theta) sin(theta) 0;-sin(theta) cos(theta) 0; 0 0 1]));
J2=imtransform(J,tform2);
subplot(1,2,2),imshow(J2);







