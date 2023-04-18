%%本函数用于NR-IQA算法的�?�能比较
clc
clear
addpath(genpath(pwd))
warning('off')
for i = 1:10
    label_path = ['D:\chengdi\iqa_matlab\Comp_Methods\test_split\test_',num2str(i),'.txt'];
    [dis1,img_names] = textread(label_path,'%f%s');
    img_root = 'D:\chengdi\iqa_matlab\Comp_Methods\endo';
    % templateModel = load('templatemodel.mat');
    MOS = dis1
    [mu_prisparam cov_prisparam] = estimatemodelparam(img_names,96,96,0,0,0.75, i);
    
    for cnt = 1:length(img_names)
        img = img_names(cnt);
        warning('off')
        disp(['The processing image is ' img])
        warning('off')
    
        Img = imread([img_root, '\', char(img{1})]);
        Img = imresize(Img, [224,224]);
        qulity(cnt,:) = computequality(Img,96,96,0,0,mu_prisparam,cov_prisparam);
    end
        [delta,beta,x_niqe,y_niqe,diff] = findrmse2(qulity, MOS);
        R = [corr(x_niqe,y_niqe,'type','Pearson'), corr(x_niqe,y_niqe,'type','spearman'), corr(x_niqe,y_niqe,'type','kendall'), (mean(diff.^2))^0.5];
        save(['result_niqe_',num2str(i),'.mat'])
end