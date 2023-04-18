%%本函数用于NR-IQA算法的性能比较
clc
clear
addpath(genpath(pwd))
warning('off')

% for i = 1:10
% 
%     SSEQ_feat = zeros(2000,12);
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
%         SSEQ_feat(cnt,:) = feature_extract(Img, 3);
%         toc
%         
%     end
%     save(['Features',num2str(i),'.mat'], 'SSEQ_feat','MOS')
% 
%     for cnt = 1:length(test_names)
%         tic
%         img = test_names(cnt);
%         disp(['The processing image is ' img])
%         Img = imread([img_root, '\', char(img{1})]);
%         Img = imresize(Img, 0.5);
%         % for learning-free methods
%         SSEQ_feat_test(cnt, :) = feature_extract(Img, 3);
%         clc
%         toc
%     end
%     save(['Features_test',num2str(i),'.mat'],'SSEQ_feat_test', 'MOS_test')
% end

for i = 1:10
    load(['Features',num2str(i),'.mat']) 
    load(['Features_test',num2str(i),'.mat']) 
    Ref_number = length(MOS); 
    SSEQ_feat_new = cat(1,SSEQ_feat, SSEQ_feat_test);
    MOS_new = cat(1, MOS, MOS_test);
    if size(MOS,1) == 1
        MOS=MOS';
    end
    
    [SSEQ_x, SSEQ_y, SSEQ_Result_all] = IQA_predict(SSEQ_feat_new, MOS_new);       
    
    save(['result_',num2str(i),'.mat'])
end
% figure, plot(x,y,'mo')
% axis([0 300 0 450])
% line([0 300],[0 300])
% set(gca,'FontSize',18);
% xlabel('Proposed')
% ylabel('MOS')        
           
rmpath(genpath(pwd))