%% 
% 2. Intensity Transformations: Gamma Mapping, Full-scale Contrast Stretch, 
% and Histogram Equalization

original_img = imread('books.tif'); 

% Gamma Intensity transformation
% normalizing the image
norm_img = double(original_img)/255;    
constant = 1;         
gamma = 0.5; 

% Power law transformation
gamma_img = constant*(norm_img).^gamma;   

% Full-contrast image
% min-max
n = original_img(:,:,1);
rmin = min(min(n));      % find the min. value of pixel in the image
rmax = max(max(n));      % find the max. value of pixel in the image
% finding slope and interception 
full_contrast = (255/(rmax - rmin))*n + (255 - (255/(rmax - rmin))*rmax);     

%Histogram Equalization
new_img = imread('C:\Users\Abinaya Ravichandran\Desktop\Fall 2020\ECE613\Homework2\Q2\books.tif'); 
hist_eq=zeros(1,256);
[norm_img, constant] = size(new_img);
pixel=norm_img*constant;

%Calculating Histogram
for n = 1 : norm_img
    for m = 1 : constant
        hist_eq(new_img(n,m)+1) = hist_eq(new_img(n,m)+1)+1;
    end
end

%Calculating Probability
for n=1:norm_img
    hist_eq(n)=hist_eq(n)/pixel;
end

%Calculating Cumulative Probability
temp = hist_eq(1);
for n=2:norm_img
    temp=temp+hist_eq(n);
    hist_eq(n)=temp;
end

% Mapping
for n=1:norm_img
    for m=1:constant
        new_img(n,m)=round(hist_eq(new_img(n,m)+1)*(norm_img-1));
    end
end

subplot(2,2,1); imshow(original_img); title('Original Image');
subplot(2,2,2); imshow(gamma_img); title('Power Gamma Image');
subplot(2,2,3); imshow(full_contrast); title('Full Constrast Image');
subplot(2,2,4); imshow(new_img); title('Histogram Equalized Image');

figure(2), 
subplot(2,2,1); histogram(original_img);  title('Histogram of Original Image');
subplot(2,2,2), histogram(gamma_img);  title('Histogram of Power Gamma Image');
subplot(2,2,3); histogram(full_contrast);title('Histogram of Full Constrast Image');
subplot(2,2,4); histogram(new_img);title('Histogram of Histogram Equalized Image');
%% 
% Observations: 
% 
% Gamma intensity transformation on the original image have increased the brightness 
% of the image but lacks contrast, also the histogram shows the pixels being shifted 
% but do not help in equalizing. Full Constrast image have increased the brightness 
% and sharpness of the original image, yet, black-point is not gained and the 
% pixel values are not wide spread enough. Histogram equalizer have enchanced 
% the image in means of bringtness, constrast, sharpness and also the histogram 
% shows that the pixels are almost equally distributed among the frame. Histogram 
% equalizer has efficiently transformed the original.