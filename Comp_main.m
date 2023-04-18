%%本函数用于NR-IQA算法的性能比较
clc
clear
addpath(genpath(pwd))
warning('off')
% p = parpool(4);
% for i = 6:10
% 
%     BRISQUE_feat = zeros(2000,36);
%     GLBP_feat = zeros(2000,50);
%     [dis1,dis2,dis3,dis4,dis5,img_names] = textread(['D:\chengdi\kon10k\train2000\labeled\labeled_', num2str(i)],'%f%f%f%f%f%s');
%     [dis_1,dis_2,dis_3,dis_4,dis_5,test_names] = textread(['D:\chengdi\kon10k\test2000\test_', num2str(i)],'%f%f%f%f%f%s');
%     img_root = 'D:\chengdi\kon10k\1024x768';
%     MOS = dis1*1+dis2*2+dis3*3+dis4*4+dis5*5;
%     MOS_test = dis_1*1+dis_2*2+dis_3*3+dis_4*4+dis_5*5;
%     for cnt = 1:length(img_names)
%         tic
%         img = img_names(cnt);
%         disp(['The processing image is ' img])
%         Img = imread([img_root, '\', char(img{1})]);
%         Img = imresize(Img, 0.5);
%         % for learning-free methods
%         BRISQUE_feat(cnt, :) = brisque_feature(double(rgb2gray(uint8(Img))));
%         FRIQUEE_feat(cnt, :) = extractFRIQUEEFeatures(Img);
%         GLBP_feat(cnt, :) = gwhglbp_feature(double(rgb2gray(Img)));
%         toc
%         
%     end
%     save(['Features',num2str(i),'.mat'], 'BRISQUE_feat', 'FRIQUEE_feat', 'GLBP_feat',  'MOS')
% 
%     for cnt = 1:length(test_names)
%         tic
%         img = test_names(cnt);
%         disp(['The processing image is ' img])
%         Img = imread([img_root, '\', char(img{1})]);
%         Img = imresize(Img, 0.5);
%         % for learning-free methods
%         BRISQUE_feat_test(cnt, :) = brisque_feature(double(rgb2gray(uint8(Img))));
%         FRIQUEE_feat_test(cnt, :) = extractFRIQUEEFeatures(Img);
%         GLBP_feat_test(cnt, :) = gwhglbp_feature(double(rgb2gray(Img)));
%         clc
%         toc
%     end
%     save(['Features_test',num2str(i),'.mat'], 'BRISQUE_feat_test', 'FRIQUEE_feat_test', 'GLBP_feat_test',  'MOS_test')
% end

%% retraining the IQA models and have a test
% The numbe of image and repeatation times
load Features1.mat
load Features_test1.mat
Ref_number = length(MOS); 
rts = 100; 
% splitting the databases acroding to the reference index
REF = round(Ref_number*0.8);
C_train = zeros(rts, REF);
C_test = zeros(rts, Ref_number - REF);
for j = 1:rts
    rand_order = randperm(Ref_number);
    C_train(j,:) = rand_order(1:REF);
    C_test(j,:) = rand_order(REF+1:end);
end

for ii = 1:length(FRIQUEE_feat)
    FRIQUEE_featnew(ii, :) = FRIQUEE_feat(ii).friqueeALL;
end
for ii = 1:length(FRIQUEE_feat_test)
    FRIQUEE_featnew_test(ii, :) = FRIQUEE_feat_test(ii).friqueeALL;
end
if size(MOS,1) == 1
    MOS=MOS';
end
% [BMPRI_Result_median, BMPRI_Result_std, BMPRI_Result_all] = IQA_predict(C_train, C_test, MOS, BMPRI_feat);
[BRISQUE_Result_median, BRISQUE_Result_std, BRISQUE_Result_all] = IQA_predict(C_train, C_test, MOS, BRISQUE_feat);
% [NR_CON_Result_median, NR_CON_Result_std, NR_CON_Result_all] = IQA_predict(C_train, C_test, MOS, NR_CON_feat);

% [Grad_LOG_Result_median, Grad_LOG_Result_std, Grad_LOG_Result_all] = IQA_predict(C_train, C_test, MOS, Grad_LOG_feat);
[GLBP_Result_median, GLBP_Result_std, GLBP_Result_all] = IQA_predict(C_train, C_test, MOS, GLBP_feat);
% [MDM_Result_median, MDM_Result_std, MDM_Result_all] = IQA_predict(C_train, C_test, MOS, MDM_feat);
[FRIQUEE_Result_median, FRIQUEE_Result_std, FRIQUEE_Result_all] = IQA_predict(C_train, C_test, MOS, FRIQUEE_featnew);
        
% [delta,beta,x,y,diff] = findrmse2(BPRI_s, MOS);
% BPRI_R = [corr(x,y,'type','Pearson'), corr(x,y,'type','spearman'), corr(x,y,'type','kendall'), (mean(diff.^2))^0.5];
% [delta,beta,x,y,diff] = findrmse2(NIQMC_s, MOS);
% NIQMC_R = [corr(x,y,'type','Pearson'), corr(x,y,'type','spearman'), corr(x,y,'type','kendall'), (mean(diff.^2))^0.5];
% [delta,beta,x,y,diff] = findrmse2(ILNIQE_s, MOS);
% ILNIQE_R = [corr(x,y,'type','Pearson'), corr(x,y,'type','spearman'), corr(x,y,'type','kendall'), (mean(diff.^2))^0.5];

save('Results02.mat')

% figure, plot(x,y,'mo')
% axis([0 300 0 450])
% line([0 300],[0 300])
% set(gca,'FontSize',18);
% xlabel('Proposed')
% ylabel('MOS')        
           
rmpath(genpath(pwd))