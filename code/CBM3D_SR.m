% File: SR_CBM3D.m 
%
% - Implements the super-resolution algorithm based on (C)BM3D, as in the paper
%   https://github.com/jwd0023/ELEC_7450/blob/master/papers/egiazarian_super_resolution_with_bm3d.pdf.


% Function: SR_CMB3D
%
% - Main function that implements the super-resolution algorithm.
%
% - Arguments:
%     - input_image: original (possibly noisy) input image
%     - scale:       mxn scaling/upsampling ratio
%     - sigma:       sigma of additive white gaussian noise
%
function upsampled_image = SR_CBM3D(input_image, scale, sigma)
