function newimg = draw_outlines(img, keep_top = .25, num_cols = 1, varargin )
  [im_ht,im_wd] = size(img);
  % Adding some padding to the image
  img_copy = [ zeros(1, im_wd+2);
  zeros(im_ht,1) img zeros(im_ht,1);
  zeros(1, im_wd+2) ];
  
  % Convolving with the given filters
  convd_img = multi_conv(img_copy, varargin{:})(1:end-1,1:end-1);
  [convd_ht ,convd_wd] = size(convd_img);
  
  thresholds  = zeros(1,num_cols);
  n_colour = zeros(size(convd_img));
  
  % Calculating the quantiles, followed by thresholds for each quantile
  qts = 1 - (1:num_cols)*keep_top/num_cols;
  thresholds = quantile(quantile(convd_img, qts), qts, 2);
  thresholds = diag(thresholds,0);
  
  % Calculating the brightness grading of pixels
  n_colour = reshape(convd_img, convd_ht*convd_wd, 1) < thresholds';
  n_colour = sum(n_colour,2);
  n_colour = reshape(n_colour, convd_ht, convd_wd);
  
  % Rescaling the graded array followed by converting it to uint8
  n_colour = cast(n_colour,'double')*255/num_cols;
  newimg = cast(n_colour,'uint8');

end