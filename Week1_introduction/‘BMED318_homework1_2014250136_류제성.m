%1. File I/O
img1=load('lenna.txt','ASCII');%1)
figure;
imshow(img1);%2)
save('lenna.mat','img1');%3)
img2=imread('lenna.bmp','bmp');
figure;
imshow(img2);
imwrite(img2,'lenna.mat','bmp');%4)

%2. Simple image processing 1
ori_image=imread('chest_xray.jpg','jpg');%1)
ori_image_size=size(ori_image)
ori_image_min=min(min(ori_image))
ori_image_max=max(max(ori_image))%2)
rev_image=zeros(ori_image_size);%3)
for i=1:ori_image_size(1)
    for j=1:ori_image_size(2)
        rev_image(i,j)=ori_image_max-ori_image(i,j);
    end;
end;
figure;
subplot(1,2,1);
imshow(ori_image);
subplot(1,2,2);
imshow(rev_image);%5)
imwrite(rev_image,'chest_xray.bmp','bmp');%6)

%3.Simple image processing 2
image1=imread('lenna.bmp','bmp');
figure;
subplot(1,3,1);
imshow(image1);
image1size=size(image1);
image1_sum=sum(sum(image1));
mean_value=image1_sum/(image1size(1)*image1size(2))%2)
image2=zeros(image1size);
image3=zeros(image1size);%3)
image2=image1;
image2(image1<mean_value)=0%4)
subplot(1,3,2);
imshow(image2);%5) 참고 - 2-6)문제는 파일 맨 아래쪽에 있습니다.
image3=func1(image1);
subplot(1,3,3);
imshow(image3);%7)


%4.image type
a=imread('koreaUniversity.jpg','jpg');%1)
figure;
imshow(a);%2)
figure;
imshow(a(:,:,1));
figure;
imshow(a(:,:,2));
figure;
imshow(a(:,:,3));%3)
b=RGB_to_gray(a);
b2=rgb2gray(a);
figure;%4) 함수는 파일 맨아래편 참고
imshow(b);%5)
c=imbinarize(b,0.5);%6)
figure;
imshow(c);%7)
imwrite(a,'RGB.png');
imwrite(b,'gray.png');
imwrite(c,'binary.png','Bitdepth',1);%8)
whos a
whos b
whos c
%9)the size of 'a' is the biggest as 128*512*3.the size of the others are same as 128*512.
%10)RGB file
%11)b,c

%5.Sampling
lenna=imread('lenna.bmp','bmp');%1)
figure;
imshow(lenna);%2)
whos lenna%3)
lenna2=imresize(lenna,0.5);%5)
lenna3=imresize(lenna,0.25);%6)
lenna4=imresize(lenna,0.125);%7)
lenna2=imresize(lenna2,2);
lenna3=imresize(lenna3,4);
lenna4=imresize(lenna4,8);%(a)
figure;
subplot(2,2,1);
imshow(lenna);
subplot(2,2,2);
imshow(lenna2);
subplot(2,2,3);
imshow(lenna3);
subplot(2,2,4);
imshow(lenna4);%(b)
%hair, face, hat, eyes, nose, lips(c)

%6.Exercise-4.
myimage=imread('C:\Program Files\MATLAB\R2018b\toolbox\images\imdata\baby.jpg');
whos myimage
%a) true color image(m*n*3의형태)
size(myimage);
%b)[3600,2250,3]
figure;
imshow(myimage);
%c)baby is at the front and the scenery of the city is at the back.

%Exercise-7.

bin = hexToBinaryVector([000000 8950 4e47 0d0*a 1*a0a 0000 000*d 4948 4452;000010 0000 012*c 0000 00*f6 0800 0000 0049 c4e5;000020 5400 0000 0774 494*d 4507 d209 1314 1*f0c;000030 035*d c49d 0000 0027 7445 5874 436*f 7079])
%.height:300,width:246 grayscale

function y=func1(x)
if ~ismatrix(x)
    error('input must be matrix')
end;
y=x;
y(x<(sum(sum(x))/prod(size(x))))=0;
end%6)
function y=RGB_to_gray(x)
y=x(:,:,1)*0.3+x(:,:,2)*0.59+x(:,:,3)*0.11
end
function s=hex2bin(x,n)
if nargin<2
    s=dec2bin(hex2dec(x));
else
    s=dec2bin(hex2dec(x),n);
end
end