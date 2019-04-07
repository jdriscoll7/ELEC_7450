% File: SR_CBM3D.m 
%
% - Implements the super-resolution algorithm based on (C)BM3D, as in the paper
%   https://github.com/jwd0023/ELEC_7450/blob/master/papers/egiazarian_super_resolution_with_bm3d.pdf.


% Function: SR_CMB3D
%
% - Main function that implements the super-resolution algorithm.
%
% - Arguments:
%     - required
%         - input_image:     original (possibly noisy) input image
%         - scale:           scaling/upsampling ratio
%         - sigma:           sigma of additive white gaussian noise
%     - optional
%         - max_iterations:  limit number of iterations - default 40
%         - show_iterations: display updated output estimate at each step
%
function upsampled_image = SR_CBM3D(input_image, scale, sigma, max_iterations, show_iterations)

    % Denoise the input image using BM3D before upsampling (may not be needed).
    [unused, filtered_input] = BM3D(1, input_image, sigma);

    % Make initial estimate using bicubic interpolation.
    upsampled_image = imresize(input_image, scale, 'bicubic');
    
    % Set default parameters 
    
end
