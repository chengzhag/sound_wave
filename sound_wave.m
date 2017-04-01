allTime=5;

%麦克风
micTimeSample=0.1;%采样时间
micFreSample=44100;%采样率
micFreRange=1000;
micPointsSample=2048;
micRecorder = audiorecorder( micFreSample, 16 ,1 );%设置采样率、数据类型uint16、单声道

%喇叭
waveFreSample=44100; %采样频率
waveFreAv=18500;
waveFreOffset=200;
waveFreLeft=18500-waveFreOffset;%输出声波频率
waveFreRight=18500+waveFreOffset;%输出声波频率

waveTimePoint=0: 1/waveFreSample: allTime;
waveAmpPoint=sin(2*pi*waveFreLeft*waveTimePoint);
waveAmpPoint(2,:)=sin(2*pi*waveFreRight*waveTimePoint);
sound(waveAmpPoint, waveFreSample);

tic;
while toc<allTime
    %     pause(0.2);
    recordblocking(micRecorder,micTimeSample);%录制音频
    micData=getaudiodata(micRecorder);%获取数组
    micData=micData((end-micPointsSample-1):end);%截去音频信号前不稳定的部分
    subplot(2,1,1);
    plot(micData);
    axis([0,length(micData),-0.5,0.5]);
    grid on
    
    %     subplot(2,1,2);
    %     fftA=abs(fft(data));%进行傅里叶变换
    %     fftA=fftA(1:floor(end/2));%取一半
    %     plot(fftA);
    %     axis([860-33,860+33,0,200]);
    %     grid on
    
    subplot(2,1,2);
    [fftFre,fftAmp]=zfft(micData', waveFreAv-micFreRange,waveFreAv+micFreRange, micFreSample);
    plot(fftFre,fftAmp);
    axis([waveFreAv-micFreRange,waveFreAv+micFreRange,0,0.1]);
end

function vectors=dopplerGet(allTime,doPlot)
%麦克风
micTimeSample=0.1;%采样时间
micFreSample=44100;%采样率
micFreRange=1000;
micPointsSample=2048;
micRecorder = audiorecorder( micFreSample, 16 ,1 );%设置采样率、数据类型uint16、单声道

%喇叭
waveFreSample=44100; %采样频率
waveFreAv=18500;
waveFreOffset=200;
waveFreLeft=18500-waveFreOffset;%输出声波频率
waveFreRight=18500+waveFreOffset;%输出声波频率

waveTimePoint=0: 1/waveFreSample: allTime;
waveAmpPoint=sin(2*pi*waveFreLeft*waveTimePoint);
waveAmpPoint(2,:)=sin(2*pi*waveFreRight*waveTimePoint);
sound(waveAmpPoint, waveFreSample);

tic;
while toc<allTime
%     pause(0.2);
    recordblocking(micRecorder,micTimeSample);%录制音频
    micData=getaudiodata(micRecorder);%获取数组
    micData=micData((end-micPointsSample-1):end);%截去音频信号前不稳定的部分
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