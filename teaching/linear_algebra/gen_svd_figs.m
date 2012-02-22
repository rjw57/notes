% Run this file through MATLAB to generate the SVD figures.

% Load the image
I = imread('facepalm_picard_riker.jpg');

% Convert it to a luminance imagea
A = single(rgb2gray(I));

% Take the SVD
[U,S,V] = svd(A, 'econ');

% Write the original
imwrite(uint8(U*S*V'), 'svd_original.png');

% How many singular values?
sv_count = min(size(S));

% Form an image from half the singular values
count_50 = ceil(0.5 * sv_count);
im_50 = U(:,1:count_50) * S(1:count_50, 1:count_50) * V(:,1:count_50)';
imwrite(uint8(im_50), 'svd_50.png');
ratio_50 = (size(U,1) + size(V,1) + 1) * count_50 / prod(size(A))

% Form an image from a quarter of the singular values
count_25 = ceil(0.25 * sv_count);
im_25 = U(:,1:count_25) * S(1:count_25, 1:count_25) * V(:,1:count_25)';
imwrite(uint8(im_25), 'svd_25.png');
ratio_25 = (size(U,1) + size(V,1) + 1) * count_25 / prod(size(A))

% Form an image from 10% of the singular values
count_10 = ceil(0.1 * sv_count);
im_10 = U(:,1:count_10) * S(1:count_10, 1:count_10) * V(:,1:count_10)';
imwrite(uint8(im_10), 'svd_10.png');
ratio_10 = (size(U,1) + size(V,1) + 1) * count_10 / prod(size(A))

% Form an image from 5% of the singular values
count_5 = ceil(0.05 * sv_count);
im_5 = U(:,1:count_5) * S(1:count_5, 1:count_5) * V(:,1:count_5)';
imwrite(uint8(im_5), 'svd_5.png');
ratio_5 = (size(U,1) + size(V,1) + 1) * count_5 / prod(size(A))

% Form an image from 1% of the singular values
count_1 = ceil(0.01 * sv_count);
im_1 = U(:,1:count_1) * S(1:count_1, 1:count_1) * V(:,1:count_1)';
imwrite(uint8(im_1), 'svd_1.png');
ratio_1 = (size(U,1) + size(V,1) + 1) * count_1 / prod(size(A))

