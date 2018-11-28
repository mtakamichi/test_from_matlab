%% �ȒP��Harris�̃R�[�i�[���o
% 2018 Takamichi Miyata
clear;
close all;

%% --- ������
% �摜�ǂݍ���
I=im2single(imread('cameraman.tif'));
%I = im2single(rgb2gray(imread('checkerboard.png')));
filtersize=6;  % �p�b�`�T�C�Y
Th_c =  0.01;  % �R�[�i�[�������l
Th_e = -0.0004; % �G�b�W�������l
k = 0.04;  % 
% �p�b�`���̏d�݁i����͂��ׂĈ�l�Ƃ��邪�C��ʂɂ̓K�E�V�A���t�B���^�̌W�����g����j
filter2D = ones(filtersize, filtersize)/(filtersize^2);

%% --- Harris�R�[�i�[���o
% �����i���m�ɂ͍����ɂ������̋ߎ��j�̌v�Z
Ix = imfilter(I, [-1 0 1] , 'replicate', 'same'); %x�����̔���
Iy = imfilter(I, [-1 0 1]', 'replicate', 'same'); %y�����̔���
% �s��̊e�����ɑΉ�����摜���쐬
Ix2 = Ix.^2;
Iy2 = Iy.^2;
Ixy = Ix .* Iy;
% �p�b�`�����ς����
Ix2 = imfilter(Ix2, filter2D, 'replicate', 'same');
Iy2 = imfilter(Iy2, filter2D, 'replicate', 'same');
Ixy = imfilter(Ixy, filter2D, 'replicate', 'same');
% metric�̌v�Z
metricMatrix = (Ix2 .* Iy2) - (Ixy .^ 2) - k * ( Ix2 + Iy2 ) .^ 2;

%% --- ���ʂ̉���
I2 = repmat(I,[1 1 3]);
% �R�[�i�[�̈�͐Ԃ�
I2(:,:,[2 3])=~(metricMatrix >  Th_c).*I2(:,:,[2 3]);
% �G�b�W�̈�͗΂�
I2(:,:,[1 3])=~(metricMatrix <  Th_e).*I2(:,:,[1 3]);
% �\��
imshow(I2)
