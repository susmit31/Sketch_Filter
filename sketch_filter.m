function sketch_filter(input_filename,  save=false, keep_top =.25, num_cols= 1),
	% Loading the image
  printf("Loading the image. Please wait...\n");
	img = rgb2gray(imread(input_filename));
  figure; imshow(img);
  printf("Loading finished. Proceeding to filter...\n"); 
	
	% Defining the convolutions
	horiz1 = [1,1,1;0,0,0;-1,-1,-1];
	vert1 = horiz1';
	horiz2 = [-1,-1,-1;0,0,0;1,1,1];
	vert2 = horiz2';
	
	% Applying the filters
  printf("Applying filter...\n");
	output_img = draw_outlines(img, keep_top=keep_top, num_cols=num_cols, horiz1, horiz2, vert1, vert2);
	printf("Done!\n");
  figure; imshow(output_img);
	% If save == true, save the output
	if save==true,
		output_filename = input("Please enter the filename: ","s");
		imwrite(output_img, output_filename);
    printf("Saved! Have a great day!");
	end
end
