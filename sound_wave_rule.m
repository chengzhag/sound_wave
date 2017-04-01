doPlot=false;%是否绘图
allTime=5;

%麦克风
micTimeSample=0.035;%采样时间

%喇叭
waveFreSample=44100; %采样频率
waveFreAv=18500;
waveFreOffset=0;
wavePlay(waveFreAv,waveFreOffset,allTime);

%规则参数
ruleDownThres=0.6;
ruleUpThres=0.5;
ruleFreCenterWidth=1;



tic
i=0;
while toc<allTime
    vector=waveGet(micTimeSample,waveFreAv,doPlot);
    
    freCenterIndex=ceil(length(vector)/2);
    downVec=vector(freCenterIndex+ruleFreCenterWidth:end);
    upVec=vector(1:freCenterIndex-ruleFreCenterWidth);
    
    %为距中心频率较远的增加权重
    ruleDownShiftWeight=log((1:length(downVec))*10+1);
    downSum=sum(downVec.*ruleDownShiftWeight);
    ruleUpShiftWeight=fliplr(ruleDownShiftWeight);
    upSum=sum(upVec.*ruleUpShiftWeight);
    
    if downSum>ruleDownThres || upSum>ruleUpThres
        if downSum>upSum
            disp('down');
        else
            disp('up');
        end
    else
        disp('steady');
    end
    i=i+1;
%     toc/i
end

