%%本函数用于NR-IQA算法的性能比较
clc
clear
addpath(genpath(pwd))
warning('off')

for i = 1:10
    load(['result_niqe_',num2str(i),'.mat'])
    NIQE_R(i,:) = R;
end
median(NIQE_R)
% figure, plot(x,y,'mo')
% axis([0 300 0 450])
% line([0 300],[0 300])
% set(gca,'FontSize',18);
% xlabel('Proposed')
% ylabel('MOS')        
           
rmpath(genpath(pwd))