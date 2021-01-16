% Reading input image : input_image 
input_image = imread('C:\Users\Abinaya Ravichandran\Desktop\Fall 2020\ECE613\Homework2\Q3\bridge.tif'); 
% imshow(input_image)
%Apply 2D-DFT to the original image
FT_img = fft2(input_image); 
%Shift the DC component to the center
img_shift = fftshift(FT_img);

%%%%%%%%%%%%%%%%%%%% Ideal Low Pass Filter %%%%%%%%%%%%%%%%%%%%%%%%

[M, N] = size(img_shift); 

% Assign Cut-off Frequency pi/8 as given in question %%% NOT SURE!!!
D0 = 12.5; % assuming 1/8 OF 100% of the image

u = 0:(M-1); 
idx = find(u>M/2); 
u(idx) = u(idx)-M; 
v = 0:(N-1); 
idy = find(v>N/2); 
v(idy) = v(idy)-N; 
[V, U] = meshgrid(v, u);
% Calculating Euclidean Distance 
D = sqrt(U.^2+V.^2);
H = D<=D0; 

G_1 = H.*img_shift; 

%%%%%%%%%%%%%%%%%%%% Ideal High Pass Filter %%%%%%%%%%%%%%%%%%%%%%%%%

[M, N] = size(img_shift); 

% Assign Cut-off Frequency pi/8 as given in question %%% NOT SURE!!!
D0 = 50; % assuming 1/2 of 100% of the image 

u = 0:(M-1); 
idx = find(u>M/2); 
u(idx) = u(idx)-M; 
v = 0:(N-1); 
idy = find(v>N/2); 
v(idy) = v(idy)-N; 
[V, U] = meshgrid(v, u); 
D = sqrt(U.^2+V.^2); 
H = (D > D0); 

G_2 = H.*img_shift; 

%%%%%%%%%%%%%%%%%%%% Ideal Band Pass Filter %%%%%%%%%%%%%%%%%%%%%%%%%

[M, N] = size(img_shift); 

% Assign Cut-off Frequency pi/8 as given in question %%% NOT SURE!!!
D0 = 12.5; % assuming 1/8 of 100% of the image 
D1 = 50; % assuming 1/2 of 100% of the image 
u = 0:(M-1); 
idx = find(u>M/2); 
u(idx) = u(idx)-M; 
v = 0:(N-1); 
idy = find(v>N/2); 
v(idy) = v(idy)-N; 
[V, U] = meshgrid(v, u); 
D = sqrt(U.^2+V.^2); 
H = (D0 < D) & (D < D1); 

G_3 = H.*img_shift; 

%%%%%%%%%%%%%%%%%%%%%%%% Spatial Domain %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Shifting back & inverse

% output_original_image = ifftshift(real(ifft2(img_shift)));
output_image_ideal_lowpass = ifftshift(real(ifft2(G_1)));
output_image_ideal_highpass = ifftshift(real(ifft2(G_2)));
output_image_ideal_bandpass = ifftshift(real(ifft2(G_3)));

%%%%%%%%%%%%%%%%%%%%%%%%%% OUTPUTS %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Figure 1 

if true
    figure,
    subplot(2,2,1); imshow(input_image);title('Original Image');
    subplot(2,2,2); imshow(output_image_ideal_lowpass, [ ]);title('ILP'); 
    subplot(2,2,3); imshow(imadd(output_image_ideal_highpass,128), [ ]);title('IHP');
    subplot(2,2,4); imshow(imadd(output_image_ideal_bandpass,128), [ ]);title('IBP'); 
end
% Intensity transformation of logn(1+x)
log_original = real(log(1+abs(img_shift)));
log_lp = real(log(1+abs(G_1)));
log_hp = real(log(1+abs(G_2)));
log_bp = real(log(1+abs(G_3)));

% Figure 2

if true
    figure,
    subplot(2,2,1); imshow(log_original, [ ]);title('Original Image');
    subplot(2,2,2); imshow(log_lp, [ ]);title('ILP'); 
    subplot(2,2,3); imshow(log_hp, [ ]);title('IHP');
    subplot(2,2,4); imshow(log_bp, [ ]);title('IBP'); 
end