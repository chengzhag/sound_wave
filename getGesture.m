function gesture=getGesture(waveFreAv)

%��˷�
micTimeSample=0.06;%����ʱ��
micFreRange=600;

%����
waveFreAv=18000;
waveFreOffset=400;
% wavePlay(waveFreAv,waveFreOffset,allTime);

%�������
ruleThres=6.5;
ruleFreCenterWidth=1;


vector=waveGet(micTimeSample,waveFreAv,micFreRange,false);

[freCenterAmp,freCenterIndex]=max(vector);
downVec=vector(freCenterIndex+ruleFreCenterWidth:end)-min(vector);
upVec=vector(1:(freCenterIndex-ruleFreCenterWidth))-min(vector);

%Ϊ������Ƶ�ʽ�Զ������Ȩ��
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
