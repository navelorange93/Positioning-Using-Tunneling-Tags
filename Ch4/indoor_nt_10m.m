clc
%clear all
close all
% Frequency sweep from 5820MHz to 5870MHz, each frequency step is 1MHz
data_15m_qto1=read_complex_binary ("10m_nt_3v_121_1.bin", 1000000,24440+2367);
scatterplot(data_15m_qto1)
plot(angle(data_15m_qto1))
%%
figure(1)
%Clean the transition between frequency steps and plot the IQ constellation
for i=1:120
    data_15m_qto((i-1)*1000+1:i*1000)=data_15m_qto1((i-1)*5082+1001:(i-1)*5082+2000);
end

scatterplot(data_15m_qto)
figure(2)

% Plot the phase of 0s
data_15m_qt_0=data_15m_qto(angle(data_15m_qto)<0)/2/pi*360;
figure(3)
plot(angle(data_15m_qt_0))
%%
angle_15m_qt_f=angle(data_15m_qt_0)/2/pi*360;
%calculate the received signal strength of each measurements
magnitude_10m_qt_f=20*log10(mean(abs(data_15m_qto)))-10*log10(50);
RSSI_15m_qt_f=20*log10(abs(data_15m_qt_0));
RSSI_10m_nt=mean(RSSI_15m_qt_f(1:500));
figure(5)
plot(angle_15m_qt_f)


%%

%%Data cleaning and range estimation
% %Clean Data and calculate the distance for the quantum tunneling tag at 15m
for k=28000:28500
    if angle_15m_qt_f(k)<=-80
        angle_15m_qt_f(k)=angle_15m_qt_f(k)+180;
    end
end
for k=21000:21500
    if angle_15m_qt_f(k)<=-80
        angle_15m_qt_f(k)=angle_15m_qt_f(k)+180;
    end
end
for k=2500:3000
    if angle_15m_qt_f(k)<=-80
        angle_15m_qt_f(k)=angle_15m_qt_f(k)+180;
    end
end
for k=10000:10500
    if angle_15m_qt_f(k)<=-80
        angle_15m_qt_f(k)=angle_15m_qt_f(k)+180;
    end
end
% for k=6500:7000
%     if angle_15m_qt_f(k)<=-80
%         angle_15m_qt_f(k)=angle_15m_qt_f(k)+180;
%     end
% end
% for k=14500:15000
%     if angle_15m_qt_f(k)<=-80
%         angle_15m_qt_f(k)=angle_15m_qt_f(k)+180;
%     end
% end

% for k=7500:8000
%     if angle_15m_qt_f(k)<=-80
%         angle_15m_qt_f(k)=angle_15m_qt_f(k)+180;
%     end
% end

% % plot(angle_15m_qt_f)
% for k=16000:16500
%     if angle_15m_qt_f(k)<=-80
%         angle_15m_qt_f(k)=angle_15m_qt_f(k)+180;
%     end
% end
% for k=21500:22000
%     if angle_15m_qt_f(k)<=-80
%         angle_15m_qt_f(k)=angle_15m_qt_f(k)+180;
%     end
% end
% for k=23000:23500
%     if angle_15m_qt_f(k)<=-80
%         angle_15m_qt_f(k)=angle_15m_qt_f(k)+180;
%     end
% end
% for k=14000:14500
%     if angle_15m_qt_f(k)<=-80
%         angle_15m_qt_f(k)=angle_15m_qt_f(k)+180;
%     end
% end
% for k=12000:12500
%     if angle_15m_qt_f(k)<=-80
%         angle_15m_qt_f(k)=angle_15m_qt_f(k)+180;
%     end
% end
% for k=25500:26000
%     if angle_15m_qt_f(k)<=-80
%         angle_15m_qt_f(k)=angle_15m_qt_f(k)+180;
%     end
% end
for k=38000:38500
    if angle_15m_qt_f(k)<=-80
        angle_15m_qt_f(k)=angle_15m_qt_f(k)+180;
    end
end
for k=49000:49500
    if angle_15m_qt_f(k)<=-80
        angle_15m_qt_f(k)=angle_15m_qt_f(k)+180;
    end
end
plot(angle_15m_qt_f)
mean_angel_15m_qt=zeros(1,120);

for j=1:120
    mean_angel_15m_qt(j)=mean(angle_15m_qt_f((j-1)*500+1:j*500));
end
figure(6)
stem(mean_angel_15m_qt+180)
diff_angel_15m_qt=zeros(1,50);
k=0;
for n=1:50
    diff_angel_15m_qt(n)=mean_angel_15m_qt(n+1+k)-mean_angel_15m_qt(n+k);
    if diff_angel_15m_qt(n)<=0
        diff_angel_15m_qt(n)=diff_angel_15m_qt(n)+180;
    end
end
figure(7)
plot(diff_angel_15m_qt)
distance_10m_nt=mean(diff_angel_15m_qt)/720*300; % Distance Estimation 0.0613
error_10m_nt=distance_10m_nt/10-1; %Estimation error is 0.0613
