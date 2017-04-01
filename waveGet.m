%% ¼��ָ��ʱ�䣬����ָ��Ƶ�ʸ�������zoomFFT�任������Ƶ��
function vector=waveGet(micTimeSample,waveFreAv,doPlot)
%��˷�
micFreSample=44100;%������
micFreRange=600;
micPointsSample=1024;
micRecorder = audiorecorder( micFreSample, 16 ,1 );%���ò����ʡ���������uint16��������

recordblocking(micRecorder,micTimeSample);%¼����Ƶ
micData=getaudiodata(micRecorder);%��ȡ����
micData=micData((end-micPointsSample-1):end);%��ȥ��Ƶ�ź�ǰ���ȶ��Ĳ���
[fftFre,fftAmp]=zfft(micData', waveFreAv-micFreRange,waveFreAv+micFreRange, micFreSample);
vector=fftAmp;

if doPlot
    subplot(2,1,1);
    plot(micData);
    axis([0,length(micData),-0.5,0.5]);
    grid on
    
    subplot(2,1,2);
    plot(fftFre,fftAmp);
    axis([waveFreAv-micFreRange,waveFreAv+micFreRange,0,0.1]);
end
end