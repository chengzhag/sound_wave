doPlot=true;%�Ƿ��ͼ
allTime=10;

%��˷�
micTimeSample=0.1;%����ʱ��

%����
waveFreSample=44100; %����Ƶ��
waveFreAv=18500;
waveFreOffset=0;
wavePlay(waveFreAv,waveFreOffset,allTime);

% classNames={'steady' 'sweepLeft' 'sweepRight' 'sweepUp' 'sweepDown'};
classNames={'steady' 'sweepUp' 'sweepDown'};

tic
while toc<allTime
    vector=waveGet(micTimeSample,waveFreAv,doPlot);
    vector=vector/max(vector);
    disp(classNames{trainedClassifier.predictFcn(vector)});
end


%% ��������������Ƶ�ף�����ָ��������Ƶ������
function vectors=dopplerGet(vectorNum,doPlot)
%��˷�
micTimeSample=0.1;%����ʱ��

%����
waveFreSample=44100; %����Ƶ��
waveFreAv=18500;
waveFreOffset=200;
wavePlay(waveFreAv,waveFreOffset,micTimeSample*vectorNum*1.8+0.3);
pause(0.3);%�ȴ��������ȶ�

%��ʼ������Ƶ�׵ľ���
vectors=cell(vectorNum,1);
for i=1:vectorNum
    vectors{i}=waveGet(micTimeSample,waveFreAv,doPlot);
end
vectors=cat(1,vectors{:});
end

% %% ��һ����������,
% function vectorsOut=vectorNormalize(vectorsIn)
%     vectorsOut=vectorsIn/max(vectorsIn
% end