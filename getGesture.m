function gesture=getGesture(waveFreAv)

%麦克风
micTimeSample=0.06;%采样时间
micFreRange=600;

%喇叭
waveFreAv=18000;
waveFreOffset=400;
% wavePlay(waveFreAv,waveFreOffset,allTime);

%规则参数
ruleThres=6.5;
ruleFreCenterWidth=1;


vector=waveGet(micTimeSample,waveFreAv,micFreRange,false);

[freCenterAmp,freCenterIndex]=max(vector);
downVec=vector(freCenterIndex+ruleFreCenterWidth:end)-min(vector);
upVec=vector(1:(freCenterIndex-ruleFreCenterWidth))-min(vector);

%为距中心频率较远的增加权重
ruleDownShiftWeight=log((1:length(downVec))*2)+2;
%     ruleDownShiftWeight=(1:length(downVec))*1+0.5;
downSum=sum(downVec.*ruleDownShiftWeight)/freCenterAmp;
ruleUpShiftWeight=log((length(upVec):-1:1)*2)+2;
upSum=sum(upVec.*ruleUpShiftWeight)/freCenterAmp;

gesture=0;
if downSum+upSum>ruleThres
    if downSum>upSum
        gesture=1;
    else
        gesture=2;
    end
end
