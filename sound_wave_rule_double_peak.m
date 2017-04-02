doFFTPlot=true;%�Ƿ��Ƶ��ͼ
doSumAmpPlot=false;%�Ƿ��ߵ�Ƶ���Ⱥ�
allTime=10;

%��˷�
micTimeSample=0.06;%����ʱ��
micFreRange=1000;

%����
waveFreSample=48000; %����Ƶ��
waveFreAv=18500;
waveFreOffset=400;
wavePlay(waveFreAv,waveFreOffset,allTime);

%�������
ruleThres=7;
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
    
    %Ϊ������Ƶ�ʽ�Զ������Ȩ��
    ruleDownShiftWeight=log((1:length(downVec))*2)+2;
%     ruleDownShiftWeight=(1:length(downVec))*1+0.5;
    downSum=sum(downVec.*ruleDownShiftWeight)/vector(freCenterIndex);
    ruleUpShiftWeight=fliplr(ruleDownShiftWeight);
    upSum=sum(upVec.*ruleUpShiftWeight)/vector(freCenterIndex);
    
    %����downSum��upSum
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
    
    if downSum+upSum>ruleThres
        if downSum>upSum
            disp('down');
        else
            disp('up');
        end
%     else
%         disp('steady');
    end
    i=i+1;
%     toc/i
end

