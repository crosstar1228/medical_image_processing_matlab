%1
pre_lung=imread('lung.jpg');
sq=ones(3,3);
lung=imbinarize(pre_lung,0.5);
lung_d=imdilate(lung,sq);
lung_e=imerode(lung,sq);
figure;
subplot(1,3,1),imshow(lung);
subplot(1,3,2),imshow(lung_d);
subplot(1,3,3),imshow(lung_e);
%dilation: 영상이 진해짐. erosion: 영상이 가늘어짐.
[Y,X]=size(lung);
lung_d2=zeros(Y,X);
for i=2:Y-1
    for j=2:X-1
        if lung(i,j)~=0
            for a=i-1:i+1
                for b=j-1:j+1
                    lung_d2(a,b)=1;
                end;
            end;
        end;
    end;
end;
lung_e2=zeros(Y,X);
for i=2:Y-1
    for j=2:X-1
        mat=[lung(i-1,j-1),lung(i,j-1),lung(i+1,j-1);lung(i-1,j),lung(i,j),lung(i+1,j);lung(i-1,j+1),lung(i,j+1),lung(i+1,j+1)];
        if mat==sq
            lung_e2(i,j)=1;
        else
            lung_e2(i,j)=0;
        end;
    end;
end;
figure;
subplot(1,3,1),imshow(lung_d2);
subplot(1,3,2),imshow(lung_e2);
%e.같은 결과가 나온다
mor=lung_d-lung_e;
subplot(1,3,3),imshow(mor);
%2
lung_n=imnoise(double(lung),'salt & pepper',0.02);
figure;
subplot(2,2,1),imshow(lung_n);
cr=[0,1,0;1,1,1;0,1,0];
lung_n1=imerode(lung_n,cr);
lung_no=imdilate(lung_n1,cr);
subplot(2,2,2),imshow(lung_no);
lung_n2=imdilate(lung_n,cr);
lung_nc=imerode(lung_n2,cr);
subplot(2,2,3),imshow(lung_nc);
lung_mf=imclose(imopen(lung,cr),cr);
subplot(2,2,4),imshow(lung_mf);

%3
hand=imread('hand.jpg');
hand=double(hand);
MAX=max(max(hand));
MIN=min(min(hand));
hand=(hand-MIN)/(MAX-MIN);
hand=imbinarize(hand,0.3);
figure;
subplot(1,2,1),imshow(hand);
[K,N]=size(hand);
current=zeros(K,N);
last=zeros(K,N);
last(301,221)=1;
current=imdilate(last,sq)&~hand;
while any(current(:)~=last(:))
    last=current;
    current=imdilate(last,sq)&~hand;
end;
output=current;
subplot(1,2,2),imshow(output);
    
    


          
