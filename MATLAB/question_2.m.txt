% Power Gamma Intensity transformation 
clc;
close all
itemp = imread('C:\Users\Abinaya Ravichandran\Desktop\Fall 2020\ECE613\Homework2\Q2\books.tif');   % read the image
%r = uint8(255 * mat2gray(itemp));
r = double(itemp)/255;    % normalise the image
subplot(2,2,1),imshow(r),title('Normalised Image');
c = 1;              % constant
gamma = 0.5; % to make image dark take value of gamma > 1, to make image bright take vlue of gamma < 1
s = c*(r).^gamma;   % formula to implement power law transformation
subplot(2,2,2),imshow(uint8(itemp)),title('Original Image');
subplot(2,2,3),imshow(s),title('Power Gamma Law Transformed Image');

% Full-contrast image
i = itemp(:,:,1);
rtemp = min(i);         % find the min. value of pixels in all the columns (row vector)
rmin = min(rtemp);      % find the min. value of pixel in the image
rtemp = max(i);         % find the max. value of pixels in all the columns (row vector)
rmax = max(rtemp);      % find the max. value of pixel in the image
m = 255/(rmax - rmin);  % find the slope of line joining point (0,255) to (rmin,rmax)
c1 = 255 - m*rmax;       % find the intercept of the straight line with the axis
i_new = m*i + c1;        % transform the image according to new slope
%subplot(1,2,1),imshow(uint8(itemp)),title('Original Image');
figure,subplot(1,2,1),imshow(i_new);title('Full contrast Image');   % display transformed image

%Histogram Equalization
x=imread('C:\Users\Abinaya Ravichandran\Desktop\Fall 2020\ECE613\Homework2\Q2\books.tif');
h=zeros(1,256);
[r, c]=size(x);
totla_no_of_pixels=r*c;
n=0:255; 
%Calculating Histogram without built-in function
for i=1:r
    for j=1:c
        h(x(i,j)+1)=h(x(i,j)+1)+1;
    end
end
%%
%Calculating Probability
for i=1:256
    h(i)=h(i)/totla_no_of_pixels;
end
%%
%Calculating Cumulative Probability
temp=h(1);
for i=2:256
    temp=temp+h(i);
    h(i)=temp;
end
%%
%Mapping
for i=1:r
    for j=1:c
        x(i,j)=round(h(x(i,j)+1)*255);
    end
end
figure,subplot(1,2,2);imshow(x);title('Histogram Equalized image using own code');
%subplot(1,2,2);imhist(x);title('Histogram Equalization using own code');

%Ques 2b
subplot(2,2,1)
imshow(itemp);
title('Original Image');
subplot(2,2,2)
imshow(s);
title('Power Gamma Image');
subplot(2,2,3)
imshow(i_new);
title('Full Constrast Image');
subplot(2,2,4)
imshow(x);
title('Histogram Equalized Image');

figure(2),
subplot(2,2,1)
imhist(itemp);
subplot(2,2,2)
imhist(s);
subplot(2,2,3)
imhist(i_new);
subplot(2,2,4)
imhist(x);

