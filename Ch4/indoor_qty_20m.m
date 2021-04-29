clc
%clear all
close all
% Frequency sweep from 5820MHz to 5870MHz, each frequency step is 1MHz
data_15m_qto1=read_complex_binary ("20m_qty_110mv_121_1.bin", 1000000,11557);
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
RSSI_15m_qt_f=20*log10(abs(data_15m_qt_0));
RSSI_20m_qt=mean(RSSI_15m_qt_f(1:500));
%calculate the received signal strength of each measurements
magnitude_10m_qt_f=20*log10(mean(abs(data_15m_qto)))-10*log10(50);

figure(5)
plot(angle_15m_qt_f)


%%

%%Data cleaning and range estimation
% %Clean Data and calculate the distance for the quantum tunneling tag at 15m
for k=500:1000
    if angle_15m_qt_f(k)<=-80
        angle_15m_qt_f(k)=angle_15m_qt_f(k)+180;
    end
end
% for k=4000:4500
%     if angle_15m_qt_f(k)>=80
%         angle_15m_qt_f(k)=angle_15m_qt_f(k)-180;
%     end
% end
% for k=4500:5000
%     if angle_15m_qt_f(k)<=-80
%         angle_15m_qt_f(k)=angle_15m_qt_f(k)+180;
%     end
% end
for k=7000:7500
    if angle_15m_qt_f(k)<=-80
        angle_15m_qt_f(k)=angle_15m_qt_f(k)+180;
    end
end
% for k=13000:13500
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
% for k=24000:24500
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
% for k=27500:28000
%     if angle_15m_qt_f(k)<=-80
%         angle_15m_qt_f(k)=angle_15m_qt_f(k)+180;
%     end
% end
plot(angle_15m_qt_f)
mean_angel_15m_qt=zeros(1,120);

for j=1:120
    mean_angel_15m_qt(j)=mean(angle_15m_qt_f((j-1)*500+1:j*500));
end
figure(6)
stem(mean_angel_15m_qt+180)
diff_angel_15m_qt=zeros(1,50);
for n=1:50
    diff_angel_15m_qt(n)=mean_angel_15m_qt(n+1)-mean_angel_15m_qt(n);
    if diff_angel_15m_qt(n)<=-50
        diff_angel_15m_qt(n)=diff_angel_15m_qt(n)+180;
    end
    
end
figure(7)
plot(diff_angel_15m_qt)
distance_20m_qt=mean(diff_angel_15m_qt)/720*300; % Distance Estimation 0.0613
error_20m_qt=distance_20m_qt/20-1; %Estimation error is 0.0613
for j=1:120
    mean_mag_15m_qt(j)=20*log10(mean(abs(data_15m_qt_0((j-1)*500+1:j*500))));
end
x=10.^(mean_mag_15m_qt(1:101)/10).*cos(-2*mean_angel_15m_qt(1:101)/180*pi)+1i*10.^(mean_mag_15m_qt(1:101)/10).*sin(-2*mean_angel_15m_qt(1:101)/180*pi)
plot(abs(ifft(x)))