vectorNum=1;%���ζ����ɼ�����
doPlot=true;%�Ƿ��ͼ
gestureTImes=20;%�����������Դ���


% classNames={'steady' 'sweepLeft' 'sweepRight' 'sweepUp' 'sweepDown'};
classNames={'steady' 'sweepUp' 'sweepDown'};
samples=cell(length(classNames)*gestureTImes,1);
index=1;
for i=1:length(classNames)
    fprintf('��%d������\n',i);
    disp(classNames{i});
    pause(2);
    for j=1:gestureTImes
        fprintf('��%d�β���\n',j);
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

%% ��������������Ƶ�ף�����ָ��������Ƶ������
function vectors=dopplerGet(vectorNum,doPlot)
%��˷�
micTimeSample=0.1;%����ʱ��

%����
waveFreSample=48000; %����Ƶ��
waveFreAv=18500;
waveFreOffset=0;
wavePlay(waveFreAv,waveFreOffset,micTimeSample*vectorNum*1.8+0.3);
pause(0.3);%�ȴ��������ȶ�

%��ʼ������Ƶ�׵ľ���
vectors=cell(vectorNum,1);
for i=1:vectorNum
    disp('now!');
    vectors{i}=waveGet(micTimeSample,waveFreAv,doPlot);
end
vectors=cat(1,vectors{:});
end

% %% ��һ����������,
% function vectorsOut=vectorNormalize(vectorsIn)
%     vectorsOut=vectorsIn/max(vectorsIn
% end