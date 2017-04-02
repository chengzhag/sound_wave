function gesture=getGesture(waveFreAv)

%麦克风
micTimeSample=0.06;%采样时间
micFreRange=600;

%规则参数
ruleThres=6;
ruleFreCenterWidth=1;


vector=waveGet(micTimeSample,waveFreAv,micFreRange,false);

freCenterIndex=ceil(length(vector)/2);
downVec=vector(freCenterIndex+ruleFreCenterWidth:end);
upVec=vector(1:freCenterIndex-ruleFreCenterWidth);

%为距中心频率较远的增加权重
ruleDownShiftWeight=log((1:length(downVec))*2)+2;
%     ruleDownShiftWeight=(1:length(downVec))*1+0.5;
downSum=sum(downVec.*ruleDownShiftWeight)/vector(freCenterIndex);
ruleUpShiftWeight=fliplr(ruleDownShiftWeight);
upSum=sum(upVec.*ruleUpShiftWeight)/vector(freCenterIndex);

gesture=0;
if downSum+upSum>ruleThres
    if downSum>upSum
        gesture=1;
    else
        gesture=2;
    end
end
