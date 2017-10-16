%Inclass 13

%Part 1. In this directory, you will find an image of some cells expressing a 
% fluorescent protein in the nucleus. 
filename = 'Dish1Well8Hyb1Before_w0001_m0006.tif';
img = imread(filename)
%% 
% A. Create a new image with intensity normalization so that all the cell
% nuclei appear approximately eqully bright.

img_double = im2double(img);
img_dilate = imdilate(img_double,strel('disk',13));
img_normalize = img_double./img_dilate;
imshow(img_normalize,[])

% B. Threshold this normalized image to produce a binary mask where the nuclei are marked true. 

mask1 = img_normalize > 0.95;
imshow(mask1);
mask2 = imdilate(imerode(mask1,strel('disk',2)),strel('disk',2))

% C. Run an edge detection algorithm and make a binary mask where the edges
% are marked true.

img_edge = edge(img,'canny');
imshow(img_edge)

% D. Display a three color image where the orignal image is red, the
% nuclear mask is green, and the edge mask is blue. 

img_ed = uint16(img_edge * 20000);
img_mask = uint16(mask2 * 20000);
img_cat = cat(3, img, img_mask, img_ed);
imshow(img_cat)

%Part 2. Continue with your nuclear mask from part 1. 
%A. Use regionprops to find the centers of the objects

stats = regionprops(mask2,'centroid');
centroids = cat(1,stats.Centroid);

%B. display the mask and plot the centers of the objects on top of the
%objects

imshow(mask2);
hold on;
plot(centroids(:,1), centroids(:,2), '*','Markersize',4);
hold off

%C. Make a new figure without the image and plot the centers of the objects
%so they appear in the same positions as when you plot on the image (Hint: remember
%Image coordinates). 

plot(centroids(:,1), centroids(:,2)*(-1), '*')