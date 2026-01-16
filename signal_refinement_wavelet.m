% get [pn] signal from SAR and apply wavelet denoising
function denoised_signal = signal_refinement_wavelet(noisy_signal)

fs = 10e3;  % frequency [Hz]
T = 1;   % duration in seconds
snr_input = 0;  % SNR in dB

[clean_signal, noisy_signal, t] = SAR_signal(fs, T, [], snr_input);

% apply wavelet denoising
wname = 'db4';  % daubechies wavelet
level = 5; % decomposition level
denoised_signal = wdenoise(noisy_signal, level, 'Wavelet', wname);

%% Plot original & denoised
figure;
subplot(3,1,1);
plot(t, clean_signal); title('Clean Signal'); ylabel('Amplitude');

subplot(3,1,2);
plot(t, noisy_signal); title('Noisy Signal'); ylabel('Amplitude');

subplot(3,1,3);
plot(t, denoised_signal); title('Denoised Signal [Wavelet]'); xlabel('Time (s)'); ylabel('Amplitude');

end 