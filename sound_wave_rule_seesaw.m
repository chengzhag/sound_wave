doFFTPlot=false;%是否绘频谱图
doSumAmpPlot=true;%是否绘高低频幅度和
allTime=10;

%麦克风
micTimeSample=0.06;%采样时间
micFreRange=600;

%喇叭
waveFreSample=44100; %采样频率
waveFreAv=18000;
waveFreOffset=0;
wavePlay(waveFreAv,waveFreOffset,allTime);

%规则参数
ruleThres=7;
ruleThresDis=1;
ruleFreCenterWidth=1;


tic
i=0;
if doSumAmpPlot
    downSums=[];
    upSums=[];
    allSums=[];
end
while toc<allTime
    vector=waveGet(micTimeSample,waveFreAv,micFreRange,doFFTPlot);
    
    freCenterIndex=ceil(length(vector)/2);
    downVec=vector(freCenterIndex+ruleFreCenterWidth:end);
    upVec=vector(1:freCenterIndex-ruleFreCenterWidth);
    
    %为距中心频率较远的增加权重
    ruleDownShiftWeight=log((1:length(downVec))*2)+2;
%     ruleDownShiftWeight=(1:length(downVec))*1+0.5;
    downSum=sum(downVec.*ruleDownShiftWeight)/vector(freCenterIndex);
    ruleUpShiftWeight=fliplr(ruleDownShiftWeight);
    upSum=sum(upVec.*ruleUpShiftWeight)/vector(freCenterIndex);
    
    %绘制downSum、upSum
    if doSumAmpPlot && i>3
        downSums=[downSums downSum];
        upSums=[upSums upSum];
        allSums=[allSums downSum+upSum];
        plot(downSums);
        hold on;
        plot(upSums);
        plot(allSums);
        hold off;
    end
    
%     if downSum>ruleThres && upSum>ruleThres
%         disp('seesaw');
%     elseif upSum>ruleThres
%         disp('up');
%     elseif downSum>ruleThres
%         disp('down');
%     end
    
    if downSum+upSum>ruleThres
        if downSum-upSum>ruleThresDis
            disp('down');
        elseif upSum-downSum>ruleThresDis
            disp('up');
        else
            disp('seesaw');
        end
    end
    
    i=i+1;
%     toc/i
end

