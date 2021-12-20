%0.
help conv2
help filter2
help imfilter

%conv2는 convolution의 의미가 강하고, filter2는 correlation의 의미가 강하다.mask 변수 입력을
%convolution은 2번째 항목에, filter2는 첫번째 항목에 한다. 
%imfilter는 upgrade 버전으로, n차원 영상의 n차원 필터링이 가능하며, 데이터 종류가 서로 달라도 다룰 수 있다. 
%1.
ri= imread('roundimage.png','png');

%2.
af =fspecial('average',15);
afr=imfilter(ri,af);
figure;
subplot(1,2,1);
imshow(ri);
subplot(1,2,2);
imshow(afr,[]);
figure,plot(ri(128,:),'linewidth',3);
hold all;
plot(afr(129,:),'linewidth',3,'linestyle','--');
%mean filtering을 진행하여 lowpass filtering 되었기 때문이다.

%3.
gf=fspecial('gaussian',3,.5)
lf=fspecial('laplacian',.5)
pf=fspecial('prewitt')
sf=fspecial('sobel')

%4.
sfr1=filter2(sf,ri);
pfr1=filter2(pf,ri);
figure;
subplot(1,2,1),imshow(sfr1,[]);
subplot(1,2,2),imshow(pfr1,[]);
sfr2=filter2(sf',sfr1);
pfr2=filter2(pf',pfr1);
df=abs(sfr2-pfr2);
figure;
subplot(1,2,1),imshow(sfr2,[]);
subplot(1,2,2),imshow(pfr2,[]);

%%f)sobel은 edge가 prewitt보다 더 뚜렷하고 대각선 방향 edge도 표현함.

%5.
chest=imread('chest.png','png');
lfChest=filter2(lf,chest);
new_chest=filter2(lf,lfChest);
figure;
subplot(1,3,1),imshow(chest);
subplot(1,3,2),imshow(lfChest);
subplot(1,3,3),imshow(new_chest);


