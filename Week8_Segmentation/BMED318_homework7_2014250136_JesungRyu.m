Ibui=imread('img_building.tif');
sy=[-1 -2 -1;0 0 0;1 2 1];
bui_sy=filter2(sy,bui);
figure,subplot(2,2,1),imshow(bui_sy/255);
%음수값: gradient가 음수이다.edge intensity 감소
sx=sy'
bui_sx=filter2(sx,bui);
subplot(2,2,2),imshow(bui_sx/255);
bui_combined=bui_sx+bui_sy;
subplot(2,2,3),imshow(bui_combined/255);

avgf=ones(5,5)/9;
bui_avg=filter2(avgf,bui);
bui_avg_sy=filter2(sy,bui_avg);
bui_avg_sx=filter2(sx,bui_avg);
figure,subplot(2,2,1),imshow(bui_avg);
subplot(2,2,2),imshow(bui_avg_sy/255);
subplot(2,2,3),imshow(bui_avg_sx/255);
bui_avg_combined=bui_avg_sx+bui_avg_sy
subplot(2,2,4),imshow(bui_avg_combined/255);
%average filter 적용시킨게 더 결과가 noise가적다.
MAX=max(max(bui_avg_combined));
figure,imshow(bui_avg_combined>MAX*0.1);

G=fspecial('gaussian',13,2);
bui_avg_G=conv2(bui_avg,G);
L=fspecial('laplacian',0.5);
bui_avg_LoG=conv2(bui_avg_G,L);
figure,imshow(bui_avg_LoG>5);

%2threshold(otsu method)
finger=imread('img_fingerprint.tif');
figure,subplot(1,3,1),imhist(finger);
subplot(1,3,2),imshow(finger);
thres2=otsuMethod(finger);
subplot(1,3,3),imshow(finger>thres2);


%3Moving average
img3=imread('img_shadedText.tif');
figure,subplot(1,3,1),imshow(img3);
thres3=otsuMethod(img3);
subplot(1,3,2),imshow(img3>thres3);
%background가 일정하지 않으면 background가 threshold에의해 잘림.global한 threshold값을 정했지만 block별로 local threshold를
%정해야함.
img3_2=movingaverage(img3,20,0.5);
subplot(1,3,3), imshow(img3_2);


function result=otsuMethod(image)
imghist=imhist(image);
L=size(imghist,1);
imghist_p=imghist/(size(image,1)*size(image,2))
avg=sum([1:L-1]'.*imghist_p(1:L-1));
k_sum=0;
k_avg=0;
max_var=0;
for k=1:L-1
    k_sum=sum(imghist_p(1:k))
    k_avg=sum([1:k]'.*imghist_p(1:k))
    k_var=(avg*k_sum-k_avg)^2/(k_sum*(1-k_sum))
    if k_var>max_var
        max_var=k_var
        kstar=k
    end
end
result=kstar;
end

        
    


