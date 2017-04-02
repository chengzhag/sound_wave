vectorNum=1;%单次动作采集次数
doPlot=true;%是否绘图
gestureTImes=20;%单个动作测试次数


% classNames={'steady' 'sweepLeft' 'sweepRight' 'sweepUp' 'sweepDown'};
classNames={'steady' 'sweepUp' 'sweepDown'};
samples=cell(length(classNames)*gestureTImes,1);
index=1;
for i=1:length(classNames)
    fprintf('第%d个动作\n',i);
    disp(classNames{i});
    pause(2);
    for j=1:gestureTImes
        fprintf('第%d次测试\n',j);
        vectors=dopplerGet(vectorNum,doPlot);
        vectors=vectors/max(vectors,[],2);
        samples{index}=[ones(vectorNum,1)*i vectors];
        pause(1);
        index=index+1;
    end
end
samples=cat(1,samples{:});


% vectors=log(vectors);
% imshow(vectors,[]);

%% 播放声波并分析频谱，返回指定数量的频谱向量
function vectors=dopplerGet(vectorNum,doPlot)
%麦克风
micTimeSample=0.1;%采样时间

%喇叭
waveFreSample=48000; %采样频率
waveFreAv=18500;
waveFreOffset=0;
wavePlay(waveFreAv,waveFreOffset,micTimeSample*vectorNum*1.8+0.3);
pause(0.3);%等待扬声器稳定

%初始化储存频谱的矩阵
vectors=cell(vectorNum,1);
for i=1:vectorNum
    disp('now!');
    vectors{i}=waveGet(micTimeSample,waveFreAv,doPlot);
end
vectors=cat(1,vectors{:});
end

% %% 归一化特征向量,
% function vectorsOut=vectorNormalize(vectorsIn)
%     vectorsOut=vectorsIn/max(vectorsIn
% end