close all; clear;

% Samford image.
scale = 2;
beta = 1.75;
max_iterations = 10;
sigma = 12;
noise = 30;

hr_test = double(imread('test_images/samford.PNG'));
lr_test = imresize(hr_test, 1/scale, 'bicubic');
lr_test_noisy = lr_test + noise*rand(size(lr_test));

% Test bicubic and SR_CBM3D interpolation.
bicubic_interp = uint8(imresize(lr_test_noisy, scale, 'bicubic'));
bm3d_interp = uint8(255 * SR_CBM3D(lr_test_noisy, scale, 10, beta, max_iterations));

% Display the original HR image, LR image, bicubic upsampling, and SR_CBM3D output.
figure;
subplot(221); imagesc(uint8(hr_test)); 
title('Original Image');

subplot(222); imagesc(uint8(lr_test_noisy)); 
title('Noisy Image');

subplot(223); imagesc(bicubic_interp); 
title(['Bicubic Interpolation - PSNR: ', num2str(psnr(bicubic_interp, uint8(hr_test))), ' - SSIM: ', num2str(ssim(bicubic_interp, uint8(hr_test)))]);

subplot(224); imagesc(bm3d_interp); 
title(['SR\_CBM3D Interpolation - PNSR: ', num2str(psnr(bm3d_interp, uint8(hr_test))), ' - SSIM: ', num2str(ssim(bm3d_interp, uint8(hr_test)))]);



% % Butterfly wings.
% hr_test = imread('test_images/test_bw.PNG');
% scale = 8;
% beta = 1.75;
% max_iterations = 3;
% sigma = 10;
% 
% % LR image from HR image
% lr_test = imresize(hr_test, 1/scale, 'bicubic');
% 
% % Display the original HR image, LR image, bicubic upsampling, and SR_CBM3D output.
% figure; 
% subplot(221); imagesc(hr_test); title('Original HR Image');
% subplot(222); imagesc(lr_test); title('LR Image');
% subplot(223); imagesc(imresize(lr_test, scale, 'bicubic')); title('Bicubic Interpolation');
% subplot(224); imagesc(SR_CBM3D(lr_test, scale, sigma, beta, max_iterations)); title('SR\_CBM3D Interpolation');
