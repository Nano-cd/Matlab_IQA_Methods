%%本函数用于NR-IQA算法的性能比较
clc
clear
addpath(genpath(pwd))
warning('off')

for i = 1:10
    load(['result_',num2str(i),'.mat'])
    BRISQUE_R(i,:) = BRISQUE_Result_all;
    GLBP_R(i,:) = GLBP_Result_all;
    FRIQUEE_R(i,:) = FRIQUEE_Result_all;
end
median(BRISQUE_R)
median(GLBP_R)
median(FRIQUEE_R)
% figure, plot(x,y,'mo')
% axis([0 300 0 450])
% line([0 300],[0 300])
% set(gca,'FontSize',18);
% xlabel('Proposed')
% ylabel('MOS')        
           
rmpath(genpath(pwd))