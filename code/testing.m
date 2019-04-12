close all; clear;

% Run tests with same parameters.
scale = 2;
beta = 1.75;
max_iterations = 5;
sigma = 10;
noise = 30;

% Samford.
make_plots('test_images/samford.png',   ...
           scale,                       ...
           beta,                        ...
           max_iterations,              ...
           sigma,                       ...
           noise);

% Monarch.
make_plots('test_images/monarch.png',   ...
           scale,                       ...
           beta,                        ...
           max_iterations,              ...
           sigma,                       ...
           noise);

% Sails.
make_plots('test_images/sails.png',     ...
           scale,                       ...
           beta,                        ...
           max_iterations,              ...
           sigma,                       ...
           noise);
       
% Samo.
make_plots('test_images/samo.jpg',      ...
           scale,                       ...
           beta,                        ...
           max_iterations,              ...
           sigma,                       ...
           noise);

       
function make_plots(input_image, scale, beta, max_iterations, sigma, noise)

    hr_test = double(imread(input_image));
    lr_test = imresize(hr_test, 1/scale, 'bicubic');
    lr_test_noisy = lr_test + noise*rand(size(lr_test));

    % Test bicubic and SR_CBM3D interpolation.
    bicubic_interp_noisy = uint8(imresize(lr_test_noisy, scale, 'bicubic'));
    bm3d_interp_noisy = uint8(255 * SR_CBM3D(lr_test_noisy, scale, sigma, beta, max_iterations));

    bicubic_interp = uint8(imresize(lr_test, scale, 'bicubic'));
    bm3d_interp = uint8(255 * SR_CBM3D(lr_test, scale, .1, beta, max_iterations));

    upsampled_original_bm3d = uint8(255 * SR_CBM3D(hr_test, scale, .1, beta, max_iterations));
    upsampled_original_bicubic = uint8(imresize(hr_test, scale, 'bicubic'));
    
    % Display the original HR image, LR image, bicubic upsampling, and SR_CBM3D output.
    fig = figure; imagesc(uint8(hr_test)); 
    title('Original Image'); drawnow; axis off;
    
    figure; imagesc(uint8(upsampled_original_bm3d)); 
    title('Upsampled Original Image (SR\_CBM3D)'); drawnow; axis off;
    
    figure; imagesc(uint8(upsampled_original_bicubic)); 
    title('Upsampled Original Image (bicubic)'); drawnow; axis off;
    
    figure; imagesc(uint8(lr_test_noisy)); 
    title('Noisy Image'); drawnow; axis off;

    figure; imagesc(bicubic_interp_noisy); 
    title(['Bicubic Interpolation (with noise) - PSNR: ', ...
            num2str(psnr(bicubic_interp_noisy, uint8(hr_test))), ...
            ' - SSIM: ', num2str(ssim(bicubic_interp_noisy, uint8(hr_test)))]);
    drawnow; axis off;

    figure; imagesc(bm3d_interp_noisy); 
    title(['SR\_CBM3D Interpolation (with noise) - PNSR: ', ...
            num2str(psnr(bm3d_interp_noisy, uint8(hr_test))), ...
            ' - SSIM: ', num2str(ssim(bm3d_interp_noisy, uint8(hr_test)))]);
    drawnow; axis off;
        
    figure; imagesc(bicubic_interp); 
    title(['Bicubic Interpolation (no noise) - PSNR: ', ...
            num2str(psnr(bicubic_interp, uint8(hr_test))), ...
            ' - SSIM: ', num2str(ssim(bicubic_interp, uint8(hr_test)))]);
    drawnow; axis off;
        
    figure; imagesc(bm3d_interp); 
    title(['SR\_CBM3D Interpolation (no noise) - PNSR: ', ...
            num2str(psnr(bm3d_interp, uint8(hr_test))), ...
            ' - SSIM: ', num2str(ssim(bm3d_interp, uint8(hr_test)))]);
    drawnow; axis off;
        
end
