% function [Result_median, Result_std, R] = IQA_predict(C_train, C_test, MOS, features)
% 
% [mos_new, ps] =mapminmax(MOS',0,100);
% mos_new=mos_new';
% [features, ~] =mapminmax(features',0,1);
% features=features';
% bestp = 1; 
% [mse,bestc,bestg] = SVMcgForRegress(mos_new,features,-5,5,-5,5,3,0.5,0.5,0.9);
% % bestc = 64;
% % bestg = 1;
% cmd = ['-c ',num2str(bestc),' -g ',num2str(bestg),' -s 3 -p ',num2str(bestp)];
% rts = 100;
% % SVR_model = svmtrain(mos, features, cmd);
% for rt=1:rts
%     current_id01 = C_train(rt,:);
%     train_data = features(current_id01',:);
%     train_mos = mos_new(current_id01',:);
%     current_id02 = C_test(rt,:);
%     test_data = features(current_id02',:);
%     test_mos = mos_new(current_id02',:);
% 
%     svr_model = fitcsvm(train_mos, train_data, cmd);
%     [pred_mos, ~, ~] = svmpredict(test_mos, test_data, svr_model);
%     
%     test_mos=mapminmax('reverse',test_mos',ps);
%     pred_mos=mapminmax('reverse',pred_mos',ps);
%     
%     [delta,beta,x,y,diff] = findrmse2(pred_mos', test_mos');
%     R(rt,:) = [corr(x,y,'type','Pearson'), corr(x,y,'type','spearman'), corr(x,y,'type','kendall'), (mean(diff.^2))^0.5];
% end 
% Result_median = median(R);
% Result_std = std(R);
% end

function [x, y, R] = IQA_predict(features, MOS)

% [mos_new, ps] =mapminmax(MOS',0,100);
mos_new=MOS;
% mos_new=mos_new';
% [features, ~] =mapminmax(features',0,1);
% features=features';
bestp = 1; 
% [mse,bestc,bestg] = SVMcgForRegress(mos_new,features,-5,5,-5,5,3,0.5,0.5,0.9);
bestc = 64;
bestg = 1;
cmd = ['-c ',num2str(bestc),' -g ',num2str(bestg),' -s 3 -p ',num2str(bestp)];
% SVR_model = svmtrain(mos, features, cmd);
features(isnan(features))=0;
mos_new(isnan(mos_new))=0;

train_data = features(1:1920,:);
train_mos = mos_new(1:1920,:);

test_data = features(1920:2400,:);
test_mos = mos_new(1920:2400,:);
svr_model = svmtrain(train_mos, train_data, cmd);
[pred_mos, ~, ~] = svmpredict(test_mos, test_data, svr_model);

% test_mos=mapminmax('reverse',test_mos',ps);
% pred_mos=mapminmax('reverse',pred_mos',ps);
pred_mos = pred_mos';
test_mos = test_mos';
[delta,beta,x,y,diff] = findrmse2(pred_mos', test_mos');
R = [corr(x,y,'type','Pearson'), corr(x,y,'type','spearman'), corr(x,y,'type','kendall'), (mean(diff.^2))^0.5];
end