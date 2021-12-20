%1
a=zeros(1,100);
for i=1:100
    a(i)=i;
end
a2=fft(a);
for i=51:100
    a2(i)=0;
end
a3=abs(ifft(a2));
figure;
subplot(1,2,1),plot(a3);
a4=dct(a);
for i=51:100
    a4(i)=0;
end
a5=idct(a4);
subplot(1,2,2),plot(a5);
%f FT는 선형에 가깝게 복원이 되지 않는다. 변형이 많다. DCT는 원래 행렬 즉 선형에 가깝게 복원이 된다.

%2
%1)dc coefficient: -34
%2)(3,-1)
%3)EOB
%4)-20
%5)[-20 0 0 0 -1 EOB]
%6
quantized_matrix=zeros(8,8);
quantized_matrix(1,1)=-20;
quantized_matrix(2,2)=-1; %DCT coefficient
%7)
lum=[16 11 10 16 24 40 51 61;12 12 14 19 26 58 60 55;14 13 16 24 40 57 69 56;14 17 22 29 51 87 80 62;18 22 37 56 68 109 103 77;24,35,55,64,81,104,113,92;49,64,78,87,103,121,120,101;72,92,95,98,112,100,103,99];
DCTmatrix=quantized_matrix.*lum;
%8)
IDCTmatrix=idct2(DCTmatrix);
%9)
shiftedmatrix=IDCTmatrix+128;
%10)
original=[86,89,88,92,92,92,93,93;89,88,86,92,90,89,94,91;88,89,88,89,89,89,92,91;92,88,88,89,90,90,90,91;89,92,89,90,87,91,90,91;90,92,89,93,88,87,87,86;91,92,91,90,92,86,89,90;91,93,89,89,92,87,86,89];
diff=shiftedmatrix-original;
squared_diff=diff.^2;
mean=sum(sum(squared_diff))/64;
rmse=sqrt(mean);
%rmse=2.3570