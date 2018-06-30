mkdir('C:\Users\levyn\Desktop\BWPics');

my_struct = extractFileInfoFromDataDir('C:\Users\levyn\Desktop\study\psySeminar\data');

outDir = 'C:\Users\levyn\Desktop\BWPics\BWImages80';
mkdir(outDir);
dapi4mag80accuracy = 0.04;
dapi5mag80accuracy = 0.04;
dapi20mag80accuracy = 0.07;
fos4mag80accuracy = 0.05;
fos5mag80accuracy = 0.09;
fos20mag80accuracy = 0.18;
getAllContrastedImages(my_struct, dapi4mag80accuracy, dapi5mag80accuracy, dapi20mag80accuracy, fos4mag80accuracy, fos5mag80accuracy, fos20mag80accuracy, outDir);

load('my_struct.mat');
outDir = 'C:\Users\levyn\Desktop\BWPics\BWImages70';
mkdir(outDir);
dapi20mag70accuracy = 0.05;
fos5mag70accuracy = 0.06;
fos20mag70accuracy = 0.15;
getAllContrastedImages(my_struct, 0, 0, dapi20mag70accuracy, 0, fos5mag70accuracy, fos20mag70accuracy, outDir);

load('my_struct.mat');
outDir = 'C:\Users\levyn\Desktop\BWPics\BWImages60';
mkdir(outDir);
fos20mag60accuracy = 0.09;
getAllContrastedImages(my_struct, 0, 0, 0, 0, 0, fos20mag60accuracy, outDir);