% File: SR_CBM3D.m 
%
% - Implements the super-resolution algorithm based on (C)BM3D, as in the paper
%   https://github.com/jwd0023/ELEC_7450/blob/master/papers/egiazarian_super_resolution_with_bm3d.pdf.


% Function: SR_CMB3D
%
% - Main function that implements the super-resolution algorithm.
%
% - Arguments:
%
%     - required
%         - input_image:     original (possibly noisy) input image
%         - scale:           scaling/upsampling ratio
%         - sigma:           sigma of additive white gaussian noise
%
%     - optional
%         - beta:            parameter used in stage 2 of algorithm       - default 1.75 (see paper)
%         - max_iterations:  limit number of iterations                   - default 40
%         - show_iterations: display updated output estimate at each step - default 1
%
function upsampled_image = SR_CBM3D(input_image, scale, sigma, beta, max_iterations)

    % Convert input image to double.
    input_image = double(input_image)/255;

    % Denoise the input image using CBM3D before upsampling (may not be needed).
    [~, filtered_input] = CBM3D(1, input_image, sigma);

    % Make initial estimate using bicubic interpolation.
    upsampled_image = imresize(filtered_input, scale, 'bicubic');
    
    % Set default values for optional parameters if they are not input.
    if (exist('beta') ~= 1)
        beta = 1.75;
    end
    
    if (exist('max_iterations') ~= 1)
        max_iterations = 40;
    end
    
    % Main loop that performs the main portion of the algorithm.
    for i = 1:max_iterations
    
        % Stage 1 - Apply CMB3D to current iterate.
        [~,upsampled_image] = CBM3D(1, upsampled_image, sigma);
        
        % Stage 2 - Next iterate is current iterate, plus the weighted, upsampled 
        %           difference between the original image and the downscaled version
        %           of the current iterate.
        downsampled_iterate = imresize(upsampled_image, 1/scale, 'bicubic');
        upsampled_image = upsampled_image + beta*imresize(filtered_input - downsampled_iterate, scale, 'bicubic');
    
    end
    
end
