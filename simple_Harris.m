%% 簡単なHarrisのコーナー検出
% 2018 Takamichi Miyata
clear;
close all;

%% --- 初期化
% 画像読み込み
I=im2single(imread('cameraman.tif'));
%I = im2single(rgb2gray(imread('checkerboard.png')));
filtersize=6;  % パッチサイズ
Th_c =  0.01;  % コーナーしきい値
Th_e = -0.0004; % エッジしきい値
k = 0.04;  % 
% パッチ内の重み（今回はすべて一様とするが，一般にはガウシアンフィルタの係数が使われる）
filter2D = ones(filtersize, filtersize)/(filtersize^2);

%% --- Harrisコーナー検出
% 微分（正確には差分による微分の近似）の計算
Ix = imfilter(I, [-1 0 1] , 'replicate', 'same'); %x方向の微分
Iy = imfilter(I, [-1 0 1]', 'replicate', 'same'); %y方向の微分
% 行列の各成分に対応する画像を作成
Ix2 = Ix.^2;
Iy2 = Iy.^2;
Ixy = Ix .* Iy;
% パッチ内平均を取る
Ix2 = imfilter(Ix2, filter2D, 'replicate', 'same');
Iy2 = imfilter(Iy2, filter2D, 'replicate', 'same');
Ixy = imfilter(Ixy, filter2D, 'replicate', 'same');
% metricの計算
metricMatrix = (Ix2 .* Iy2) - (Ixy .^ 2) - k * ( Ix2 + Iy2 ) .^ 2;

%% --- 結果の可視化
I2 = repmat(I,[1 1 3]);
% コーナー領域は赤に
I2(:,:,[2 3])=~(metricMatrix >  Th_c).*I2(:,:,[2 3]);
% エッジ領域は緑に
I2(:,:,[1 3])=~(metricMatrix <  Th_e).*I2(:,:,[1 3]);
% 表示
imshow(I2)
