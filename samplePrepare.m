vectorNum=1;
fftDoPlot=true;

vectors=dopplerGet(vectorNum,fftDoPlot);
vectors=log(vectors);
imshow(vectors,[]);

%% ��������������Ƶ�ף�����ָ��������Ƶ������
function vectors=dopplerGet(vectorNum,doPlot)
%��˷�
micTimeSample=0.1;%����ʱ��

%����
waveFreSample=44100; %����Ƶ��
waveFreAv=18000;
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