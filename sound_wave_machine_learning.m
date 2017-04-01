doPlot=true;%是否绘图
allTime=10;

%麦克风
micTimeSample=0.1;%采样时间

%喇叭
waveFreSample=44100; %采样频率
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


%% 播放声波并分析频谱，返回指定数量的频谱向量
function vectors=dopplerGet(vectorNum,doPlot)
%麦克风
micTimeSample=0.1;%采样时间

%喇叭
waveFreSample=44100; %采样频率
waveFreAv=18500;
waveFreOffset=200;
wavePlay(waveFreAv,waveFreOffset,micTimeSample*vectorNum*1.8+0.3);
pause(0.3);%等待扬声器稳定

%初始化储存频谱的矩阵
vectors=cell(vectorNum,1);
for i=1:vectorNum
    vectors{i}=waveGet(micTimeSample,waveFreAv,doPlot);
end
vectors=cat(1,vectors{:});
end

% %% 归一化特征向量,
% function vectorsOut=vectorNormalize(vectorsIn)
%     vectorsOut=vectorsIn/max(vectorsIn
% end