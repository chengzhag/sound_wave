doFFTPlot=false;%�Ƿ��Ƶ��ͼ
doSumAmpPlot=true;%�Ƿ��ߵ�Ƶ���Ⱥ�
allTime=10;

%��˷�
micTimeSample=0.06;%����ʱ��
micFreRange=600;

%����
waveFreSample=44100; %����Ƶ��
waveFreAv=18000;
waveFreOffset=0;
wavePlay(waveFreAv,waveFreOffset,allTime);

%�������
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

