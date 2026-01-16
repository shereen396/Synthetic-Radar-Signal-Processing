% SAR radar function that return signal with noise [Pn]
function [clean_signal, noisy_signal, t] = SAR_signal(fs, T, target_params, snr_input);

fs = 10e3;      % frequency [Hz]
T = 1;          % duration in seconds
t = 0:1/fs:T-1/fs;  % time vector

%  targets with delayed gaussian pulses
target1 = gauspuls(t - 0.2, 500, 0.5);
target2 = gauspuls(t - 0.5, 800, 0.5);
target3 = gauspuls(t - 0.7, 1000, 0.5);


clean_signal = target1 + target2 + target3;

% add white gaussian noise [wt]
snr_input = 0; % SNR in dB

noisy_signal = awgn(clean_signal, snr_input, 'measured');

%% Plot
figure;
subplot(2,1,1);
plot(t, clean_signal);
title('Clean SAR-Like Signal'); 
xlabel('Time (s)'); 
ylabel('Amplitude');

subplot(2,1,2);
plot(t, noisy_signal);
title(['Noisy Signal (SNR = ' num2str(snr_input) ' dB)']);
xlabel('Time (s)'); 
ylabel('Amplitude');

end
