%%本函数用于NR-IQA算法的�?�能比较
clc
clear
addpath(genpath(pwd))
warning('off')
p = parpool(4);
for i = 6:10

    BRISQUE_feat = zeros(2000,36);
    GLBP_feat = zeros(2000,50);
    [dis1,dis2,dis3,dis4,dis5,img_names] = textread(['D:\chengdi\kon10k\train2000\labeled\labeled_', num2str(i)],'%f%f%f%f%f%s');
    [dis_1,dis_2,dis_3,dis_4,dis_5,test_names] = textread(['D:\chengdi\kon10k\test2000\test_', num2str(i)],'%f%f%f%f%f%s');
    img_root = 'D:\chengdi\kon10k\1024x768';
    MOS = dis1*1+dis2*2+dis3*3+dis4*4+dis5*5;
    MOS_test = dis_1*1+dis_2*2+dis_3*3+dis_4*4+dis_5*5;
    for cnt = 1:length(img_names)
        tic
        img = img_names(cnt);
        disp(['The processing image is ' img])
        Img = imread([img_root, '\', char(img{1})]);
        Img = imresize(Img, 0.5);
        % for learning-free methods
        BRISQUE_feat(cnt, :) = brisque_feature(double(rgb2gray(uint8(Img))));
        FRIQUEE_feat(cnt, :) = extractFRIQUEEFeatures(Img);
        GLBP_feat(cnt, :) = gwhglbp_feature(double(rgb2gray(Img)));
        toc
        
    end
    save(['Features',num2str(i),'.mat'], 'BRISQUE_feat', 'FRIQUEE_feat', 'GLBP_feat',  'MOS')

    for cnt = 1:length(test_names)
        tic
        img = test_names(cnt);
        disp(['The processing image is ' img])
        Img = imread([img_root, '\', char(img{1})]);
        Img = imresize(Img, 0.5);
        % for learning-free methods
        BRISQUE_feat_test(cnt, :) = brisque_feature(double(rgb2gray(uint8(Img))));
        FRIQUEE_feat_test(cnt, :) = extractFRIQUEEFeatures(Img);
        GLBP_feat_test(cnt, :) = gwhglbp_feature(double(rgb2gray(Img)));
        clc
        toc
    end
    save(['Features_test',num2str(i),'.mat'], 'BRISQUE_feat_test', 'FRIQUEE_feat_test', 'GLBP_feat_test',  'MOS_test')
end

%% retraining the IQA models and have a test
% The numbe of image and repeatation times

% for i = 1:10
%     load(['Features',num2str(i),'.mat']) 
%     load(['Features_test',num2str(i),'.mat']) 
%     Ref_number = length(MOS); 
%     GLBP_feat_new = cat(1,GLBP_feat, GLBP_feat_test);
%     FRIQUEE_feat_new = cat(1,FRIQUEE_feat, FRIQUEE_feat_test);
%     BRISQUE_feat_new = cat(1,BRISQUE_feat, BRISQUE_feat_test);
%     MOS_new = cat(1, MOS, MOS_test);
%     for ii = 1:length(FRIQUEE_feat_new)
%         FRIQUEE_featnew(ii, :) = FRIQUEE_feat_new(ii).friqueeALL;
%     end
%     if size(MOS,1) == 1
%         MOS=MOS';
%     end
%     
%     [BRISQUE_Result_x, BRISQUE_Result_y, BRISQUE_Result_all] = IQA_predict(BRISQUE_feat_new, MOS_new);
%     [GLBP_Result_x, GLBP_Result_y, GLBP_Result_all] = IQA_predict(GLBP_feat_new, MOS_new);
%     [FRIQUEE_Result_x, FRIQUEE_Result_y, FRIQUEE_Result_all] = IQA_predict2(FRIQUEE_featnew, MOS_new);
% %             
%     
%     save(['result_',num2str(i),'.mat'])
% end
% figure, plot(x,y,'mo')
% axis([0 300 0 450])
% line([0 300],[0 300])
% set(gca,'FontSize',18);
% xlabel('Proposed')
% ylabel('MOS')        
           
rmpath(genpath(pwd))