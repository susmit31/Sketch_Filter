function newimg = draw_outlines(img, keep_top = .25, num_cols = 1, varargin )
  img_copy = [ zeros(1, size(img)(2)+2);
zeros(size(img)(1),1) img zeros(size(img)(1),1);
zeros(1, size(img)(2)+2) ];
  convd_img = multi_conv(img_copy, varargin{:})(1:end-1,1:end-1);
  thresholds  = zeros(1,num_cols);
  n_colour = zeros(size(convd_img));
  for i=1:num_cols,
    thresholds(i) = quantile( quantile( convd_img, 1 - i*keep_top/num_cols ), 1 - i*keep_top/num_cols );
    n_colour += (convd_img>thresholds(i));
  end
  n_colour = cast(n_colour,'double')*255/num_cols;
  colourflip_two_colour = -cast(n_colour,'double')+255;
  newimg = cast(colourflip_two_colour,'uint8');
end