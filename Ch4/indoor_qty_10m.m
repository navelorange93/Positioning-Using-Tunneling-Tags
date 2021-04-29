clc
%clear all
close all
% Frequency sweep from 5820MHz to 5870MHz, each frequency step is 1MHz
data_15m_qto1=read_complex_binary ("10m_qty_110mv_121_1.bin", 1000000,31467);
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
RSSI_10m_qt=mean(RSSI_15m_qt_f(1:500));
figure(5)
plot(angle_15m_qt_f)


%%

%%Data cleaning and range estimation
% %Clean Data and calculate the distance for the quantum tunneling tag at 15m
for k=3500:4000
    if angle_15m_qt_f(k)<=-80
        angle_15m_qt_f(k)=angle_15m_qt_f(k)+180;
    end
end
for k=7000:7500
    if angle_15m_qt_f(k)<=-80
        angle_15m_qt_f(k)=angle_15m_qt_f(k)+180;
    end
end
for k=14000:14500
    if angle_15m_qt_f(k)<=-80
        angle_15m_qt_f(k)=angle_15m_qt_f(k)+180;
    end
end
for k=17500:18000
    if angle_15m_qt_f(k)<=-80
        angle_15m_qt_f(k)=angle_15m_qt_f(k)+180;
    end
end
for k=21000:21500
    if angle_15m_qt_f(k)<=-80
        angle_15m_qt_f(k)=angle_15m_qt_f(k)+180;
    end
end
for k=37500:38000
    if angle_15m_qt_f(k)<=-80
        angle_15m_qt_f(k)=angle_15m_qt_f(k)+180;
    end
end
for k=41000:41500
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
for n=1:50
    diff_angel_15m_qt(n)=mean_angel_15m_qt(n+1)-mean_angel_15m_qt(n);
    if diff_angel_15m_qt(n)<=0
        diff_angel_15m_qt(n)=diff_angel_15m_qt(n)+180;
    end
    if diff_angel_15m_qt(n)>=170
        diff_angel_15m_qt(n)=diff_angel_15m_qt(n)-180;
    end
end
figure(7)
plot(diff_angel_15m_qt)
distance_10m_qt=mean(diff_angel_15m_qt)/720*300; % Distance Estimation 0.0613
error_10m_qt=distance_10m_qt/10-1; %Estimation error is 0.0613
for j=1:120
    mean_mag_15m_qt(j)=20*log10(mean(abs(data_15m_qt_0((j-1)*500+1:j*500))));
end
t=0;
for i=1:101
    
    angles(i)=mean_angel_15m_qt(i)-180*t;
    if mean_angel_15m_qt(i+1)<mean_angel_15m_qt(i)
       t=t+1;
    end
end
d= 3e8/101e6/2*linspace(1, 101, 101);
x=10.^(mean_mag_15m_qt(1:101)/10).*cos(-angles(1:101)/180*pi)+1i*10.^(mean_mag_15m_qt(1:101)/10).*sin(-angles(1:101)/180*pi)
plot(d,abs(ifft(x)))
hold on
d2= 3e8/101e6/4*linspace(1, 101, 101);
x=10.^(mean_mag_15m_qt(1:101)/10).*cos(-2*angles(1:101)/180*pi)+1i*10.^(mean_mag_15m_qt(1:101)/10).*sin(-2*angles(1:101)/180*pi)
plot(d2,abs(ifft(x)))
hold on
d2= 3e8/101e6/4*linspace(1, 101, 101);
x=10.^(mean_mag_15m_qt(1:101)/10).*cos(-2*mean_angel_15m_qt(1:101)/180*pi)+1i*10.^(mean_mag_15m_qt(1:101)/10).*sin(-2*mean_angel_15m_qt(1:101)/180*pi)
plot(d2,abs(ifft(x)))