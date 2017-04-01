allTime=5;

%��˷�
micTimeSample=0.1;%����ʱ��
micFreSample=44100;%������
micFreRange=1000;
micPointsSample=2048;
micRecorder = audiorecorder( micFreSample, 16 ,1 );%���ò����ʡ���������uint16��������

%����
waveFreSample=44100; %����Ƶ��
waveFreAv=18500;
waveFreOffset=200;
waveFreLeft=18500-waveFreOffset;%�������Ƶ��
waveFreRight=18500+waveFreOffset;%�������Ƶ��

waveTimePoint=0: 1/waveFreSample: allTime;
waveAmpPoint=sin(2*pi*waveFreLeft*waveTimePoint);
waveAmpPoint(2,:)=sin(2*pi*waveFreRight*waveTimePoint);
sound(waveAmpPoint, waveFreSample);

tic;
while toc<allTime
    %     pause(0.2);
    recordblocking(micRecorder,micTimeSample);%¼����Ƶ
    micData=getaudiodata(micRecorder);%��ȡ����
    micData=micData((end-micPointsSample-1):end);%��ȥ��Ƶ�ź�ǰ���ȶ��Ĳ���
    subplot(2,1,1);
    plot(micData);
    axis([0,length(micData),-0.5,0.5]);
    grid on
    
    %     subplot(2,1,2);
    %     fftA=abs(fft(data));%���и���Ҷ�任
    %     fftA=fftA(1:floor(end/2));%ȡһ��
    %     plot(fftA);
    %     axis([860-33,860+33,0,200]);
    %     grid on
    
    subplot(2,1,2);
    [fftFre,fftAmp]=zfft(micData', waveFreAv-micFreRange,waveFreAv+micFreRange, micFreSample);
    plot(fftFre,fftAmp);
    axis([waveFreAv-micFreRange,waveFreAv+micFreRange,0,0.1]);
end

function vectors=dopplerGet(allTime,doPlot)
%��˷�
micTimeSample=0.1;%����ʱ��
micFreSample=44100;%������
micFreRange=1000;
micPointsSample=2048;
micRecorder = audiorecorder( micFreSample, 16 ,1 );%���ò����ʡ���������uint16��������

%����
waveFreSample=44100; %����Ƶ��
waveFreAv=18500;
waveFreOffset=200;
waveFreLeft=18500-waveFreOffset;%�������Ƶ��
waveFreRight=18500+waveFreOffset;%�������Ƶ��

waveTimePoint=0: 1/waveFreSample: allTime;
waveAmpPoint=sin(2*pi*waveFreLeft*waveTimePoint);
waveAmpPoint(2,:)=sin(2*pi*waveFreRight*waveTimePoint);
sound(waveAmpPoint, waveFreSample);

tic;
while toc<allTime
%     pause(0.2);
    recordblocking(micRecorder,micTimeSample);%¼����Ƶ
    micData=getaudiodata(micRecorder);%��ȡ����
    micData=micData((end-micPointsSample-1):end);%��ȥ��Ƶ�ź�ǰ���ȶ��Ĳ���
    [fftFre,fftAmp]=zfft(micData', waveFreAv-micFreRange,waveFreAv+micFreRange, micFreSample);

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