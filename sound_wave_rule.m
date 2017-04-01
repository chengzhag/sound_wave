doPlot=false;%是否绘图
allTime=10;

%麦克风
micTimeSample=0.035;%采样时间

%喇叭
waveFreSample=44100; %采样频率
waveFreAv=18500;
waveFreOffset=0;
wavePlay(waveFreAv,waveFreOffset,allTime);

%规则参数
% ruleThres=6;
ruleThres=11;
ruleFreCenterWidth=1;


tic
i=0;
downSums=[];
upSums=[];
allSums=[];
while toc<allTime
    vector=waveGet(micTimeSample,waveFreAv,doPlot);
    
    freCenterIndex=ceil(length(vector)/2);
    downVec=vector(freCenterIndex+ruleFreCenterWidth:end);
    upVec=vector(1:freCenterIndex-ruleFreCenterWidth);
    
    %为距中心频率较远的增加权重
%     ruleDownShiftWeight=log((1:length(downVec))*10+1);
    ruleDownShiftWeight=(1:length(downVec))*1+0.5;
    downSum=sum(downVec.*ruleDownShiftWeight);
    ruleUpShiftWeight=fliplr(ruleDownShiftWeight);
    upSum=sum(upVec.*ruleUpShiftWeight);
    
    %绘制downSum、upSum
    downSums=[downSums downSum];
    upSums=[upSums upSum];
    allSums=[allSums downSum+upSum];
    plot(downSums);
    hold on;
    plot(upSums);
    plot(allSums);
    hold off;
    
    if downSum+upSum>ruleThres*vector(freCenterIndex)
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

