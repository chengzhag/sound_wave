doPlot=false;%�Ƿ��ͼ
allTime=10;

%��˷�
micTimeSample=0.035;%����ʱ��

%����
waveFreSample=44100; %����Ƶ��
waveFreAv=18500;
waveFreOffset=0;
wavePlay(waveFreAv,waveFreOffset,allTime);

%�������
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
    
    %Ϊ������Ƶ�ʽ�Զ������Ȩ��
%     ruleDownShiftWeight=log((1:length(downVec))*10+1);
    ruleDownShiftWeight=(1:length(downVec))*1+0.5;
    downSum=sum(downVec.*ruleDownShiftWeight);
    ruleUpShiftWeight=fliplr(ruleDownShiftWeight);
    upSum=sum(upVec.*ruleUpShiftWeight);
    
    %����downSum��upSum
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

