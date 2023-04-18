%%本函数用于NR-IQA算法的�?�能比较
clc
clear
addpath(genpath(pwd))
warning('off')

for i = 1
    load(['result_',num2str(i),'.mat'])
    SSEQ_R(i,:) = SSEQ_Result_all;
end
median(SSEQ_R)

figure, plot(SSEQ_x,SSEQ_y,'mo')
axis([1 5 1 5])
line([1 5],[1 5])
set(gca,'FontSize',18);
xlabel('SSEQ')
ylabel('MOS')        
           
rmpath(genpath(pwd))