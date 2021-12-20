%1 LUT �����Ͻÿ�

x=[0:255]

lut1=2*x;
lut2=1/2*x;
lut3=-x+255;
t1=32/96*[1:96];
t2=(192-32)/(200-96)*([97:200]-96)+32;
t3=(255-192)/(255-200)*([201:255]-200)+192;
lut4=uint8(floor([t1 t2 t3]));
%2.
figure;
subplot(2,2,1);
plot(lut1);
subplot(2,2,2);
plot(lut2);
subplot(2,2,3);
plot(lut3);
subplot(2,2,4);
plot(lut4);
%3.
x=imread('x-ray.png','png');
x1=Image_Adjust_LUT(x,lut1);
x2=Image_Adjust_LUT(x,lut2);
x3=Image_Adjust_LUT(x,lut3);
x4=Image_Adjust_LUT(x,lut4);

figure;
subplot(2,2,1);
imshow(x1);
subplot(2,2,2);
imshow(x2);
subplot(2,2,3);
imshow(x3);
subplot(2,2,4);
imshow(x4);
%4
figure;
subplot(1,2,1),imshow(x2);
subplot(1,2,2),imshow(x2,[]);
%5.[]�� [min(I(:)) max(I(:))]�� �ǹ��ϸ� matrix �� ���� �ִ� �ּڰ��� ������ ���´ٴ� ���̴�.
%[]�� ������ ���� ������ �ȵ�ä�� �״�� �������µ�, []�� �ٿ��ָ� �ּڰ��� ��, �ִ��� ������� ǥ���ȴ�.
%6.
xbound=[0:255];
LUT4_1=4*xbound;
LUT4_2=(1/4)*xbound;
LUT16_1=16*xbound;
LUT16_2=(1/16)*xbound;
LUT64_1=64*xbound;
LUT64_2=(1/64)*xbound;

x51=Image_Adjust_LUT(x,LUT4_2);
x52=Image_Adjust_LUT(x,LUT16_2);
x53=Image_Adjust_LUT(x,LUT64_2);

x54=Image_Adjust_LUT(x,LUT4_1);
x55=Image_Adjust_LUT(x,LUT16_1);
x56=Image_Adjust_LUT(x,LUT64_1);

figure;
subplot(1,3,1),imshow(x51);
subplot(1,3,2),imshow(x52);
subplot(1,3,3),imshow(x53);


figure;
subplot(1,3,1),imshow(x54);
subplot(1,3,2),imshow(x55);
subplot(1,3,3),imshow(x56);
%i)�ƴ�.integer ���¶� 16���� 1�ϴϱ� 0���� �׾���.
%ii)d
%iii)����>�Ѽ�>����

%7.
function c=Image_Adjust_LUT(a,b)
c=zeros(size(a));
for i=1:size(a,1)
    for j=1:size(a,2)
        c(i,j)=b(a(i,j)+1);
    end;
end;
end