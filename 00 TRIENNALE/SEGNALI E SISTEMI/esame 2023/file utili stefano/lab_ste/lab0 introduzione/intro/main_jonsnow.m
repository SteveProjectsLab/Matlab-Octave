img = imread('jonsnow2.jpg');
figure, imshow(img)

img50 = img(1:50:end,1:50:end,:);
figure, imshow(img50)

img_filtrata = imgaussfilt(img, 20);
figure, imshow(img_filtrata)

img_filtrata50 = img_filtrata(1:50:end,1:50:end,:);
figure, imshow(img_filtrata50)