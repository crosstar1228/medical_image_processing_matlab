%1
lung=imbinarize(imread('lung.tif'));
filter=[1,2,4;8,16,32;64,128,256];
lung2=conv2(lung,filter);
xx=[1:512];
x2=str2num(dec2bin(xx));
yy=zeros(512,1);
for i=1:size(x2,1)
    if x2(i)>10000==1 && bitget(x2(i),5)==1
        if not (bitget(x2(i),2)==1 && bitget(x2(i),4)==1 && bitget(x2(i),6)==1 && bitget(x2(i),8)==1)
            yy(i)=1;
        else
            yy(i)=0;
        end;
    else
        yy(i)=0;
    end;
end;
figure,plot(yy);
lung3=yy(lung2+1);
figure;
subplot(1,2,1),imshow(lung);
subplot(1,2,2),imshow(lung3);

%2
mat=[inf,inf,inf,inf,inf,inf,inf,inf;inf,inf,inf,inf,inf,inf,inf,inf;inf,inf,inf,0,inf,inf,inf,inf;inf,inf,inf,0,0,inf,inf,inf;inf,inf,inf,0,inf,inf,inf,inf;inf,inf,0,0,0,0,inf,inf;inf,inf,inf,inf,inf,inf,inf,inf;inf,inf,inf,inf,inf,inf,inf,inf];
[Y,X]=size(mat);
for i=2:X-1
    for j=2:Y-1
        mat(i,j)=min([mat(i,j),mat(i+1,j)+1,mat(i-1,j)+1,mat(i,j-1)+1,mat(i,j+1)+1]);
    end;
end;
for i=2:X-1
    for j=2:Y-1
        mat(i,j)=min([mat(i,j),mat(i+1,j)+1,mat(i-1,j)+1,mat(i,j-1)+1,mat(i,j+1)+1]);
    end;
end;
for i=2:X-1
    for j=2:Y-1
        mat(i,j)=min([mat(i,j),mat(i+1,j)+1,mat(i-1,j)+1,mat(i,j-1)+1,mat(i,j+1)+1]);
    end;
end;
%3
mat2=[0,0,0,0,0,0,0;0,0,0,1,0,0,0;0,0,1,0,1,0,0;0,1,0,0,0,1,0;0,0,1,0,1,0,0;0,0,0,1,0,0,0;0,0,0,0,0,0,0];
[x,y]=ind2sub(size(mat2),find(mat2));
pos=[x,y];
comp=zeros(size(x));
for a=1:size(x)
    comp(a,1)=pos(a,1)+pos(a,2)*1i;
end
ft=fft(comp);
ft1=zeros(size(ft));
ft1(1:2)=ft(1:2);
figure;
plot(ifft(ft1));


%4
pet=imread('PET.jpg','jpg');
figure;
subplot(1,3,1),imshow(pet(:,:,1));
subplot(1,3,2),imshow(pet(:,:,2));
subplot(1,3,3),imshow(pet(:,:,3));
%R:배경이 까맣고 뇌의 테두리는 하얗고 속은 검다
%G: 배경이 까맣고 뇌가 전체적으로 하얗다
%B: 배경이 회색이고 뇌 테두리가 하얗고 속이 검다.
pet2=imnoise(pet,'salt & pepper');
figure;
subplot(2,2,1),imshow(pet2);
subplot(2,2,2),imshow(pet2(:,:,1));
subplot(2,2,3),imshow(pet2(:,:,2));
subplot(2,2,4),imshow(pet2(:,:,3));

pet2r=medfilt2(pet2(:,:,1));
pet2g=medfilt2(pet2(:,:,2));
pet2b=medfilt2(pet2(:,:,3));
pet_f=cat(3,pet2r,pet2g,pet2b);
figure;
imshow(pet_f);