function new_img = multi_conv(img, varargin)
    new_img = zeros(size(img));
    new_img = new_img + 255;
    img = cast(img,'double');
    ht_img = size(img)(1);
    wd_img = size(img)(2);
    filter1 = varargin{1};
    num_filters = length(varargin);
    size_filter = size(filter1)(1);
    size_halfbox = floor(size_filter/2);
    for i = 2:(ht_img-size_filter),
      for j = 2:(wd_img-size_filter),
        sub_img = img(i-size_halfbox:i+size_halfbox, j-size_halfbox:j+size_halfbox);
        convs = zeros(1,num_filters);
        for k=1:num_filters,
          convs(k) = sum(sum(sub_img.*varargin{k}));
        end
        new_img(i, j) = max([convs,0]);
      end
    end
    new_img = floor(new_img*255/max(max(new_img)));
    new_img = cast(new_img, 'uint8');
end