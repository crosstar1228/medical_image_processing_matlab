%0.
help conv2
help filter2
help imfilter

%conv2�� convolution�� �ǹ̰� ���ϰ�, filter2�� correlation�� �ǹ̰� ���ϴ�.mask ���� �Է���
%convolution�� 2��° �׸�, filter2�� ù��° �׸� �Ѵ�. 
%imfilter�� upgrade ��������, n���� ������ n���� ���͸��� �����ϸ�, ������ ������ ���� �޶� �ٷ� �� �ִ�. 
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
%mean filtering�� �����Ͽ� lowpass filtering �Ǿ��� �����̴�.

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

%%f)sobel�� edge�� prewitt���� �� �ѷ��ϰ� �밢�� ���� edge�� ǥ����.

%5.
chest=imread('chest.png','png');
lfChest=filter2(lf,chest);
new_chest=filter2(lf,lfChest);
figure;
subplot(1,3,1),imshow(chest);
subplot(1,3,2),imshow(lfChest);
subplot(1,3,3),imshow(new_chest);


