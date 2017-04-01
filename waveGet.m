%% 录音指定时间，并在指定频率附近进行zoomFFT变换，返回频谱
function vector=waveGet(micTimeSample,waveFreAv,doPlot)
%麦克风
micFreSample=44100;%采样率
micFreRange=600;
micPointsSample=1024;
micRecorder = audiorecorder( micFreSample, 16 ,1 );%设置采样率、数据类型uint16、单声道

recordblocking(micRecorder,micTimeSample);%录制音频
micData=getaudiodata(micRecorder);%获取数组
micData=micData((end-micPointsSample-1):end);%截去音频信号前不稳定的部分
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