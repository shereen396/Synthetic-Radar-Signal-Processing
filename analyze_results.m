% Compute signal to Noise [SNR] , mean squared error [MSE], and peak signal to Noise [PSNR]
%  for different denoising methods and visualize the results

fs = 10e3;
T = 1;
snr_input = 0;

%% generate signal
[clean_signal, noisy_signal, t] = SAR_signal(fs, T, [], snr_input);

%% denoising 
denoised_signal = signal_refinement_wavelet(noisy_signal);
kalman_filtered_signal = signal_refinement_kalman(noisy_signal);

%% metric functions 
compute_snr = @(x, x_hat) 10 * log10(sum(x.^2) / sum((x - x_hat).^2));
compute_mse = @(x, x_hat) mean((x - x_hat).^2);
compute_psnr = @(x, x_hat) 10 * log10(max(x).^2 / compute_mse(x, x_hat));

%% compute Metrics

% SNR
snr_noisy = compute_snr(clean_signal, noisy_signal);
snr_wavelet = compute_snr(clean_signal, denoised_signal);
snr_kalman = compute_snr(clean_signal, kalman_filtered_signal);

% MSE
mse_noisy = compute_mse(clean_signal, noisy_signal);
mse_wavelet = compute_mse(clean_signal, denoised_signal);
mse_kalman = compute_mse(clean_signal, kalman_filtered_signal);

% PSNR
psnr_noisy = compute_psnr(clean_signal, noisy_signal);
psnr_wavelet = compute_psnr(clean_signal, denoised_signal);
psnr_kalman = compute_psnr(clean_signal, kalman_filtered_signal);

%% display
fprintf('\n=== SNR ===\n');
fprintf('Noisy    : %.2f dB\n', snr_noisy);
fprintf('Wavelet  : %.2f dB\n', snr_wavelet);
fprintf('Kalman   : %.2f dB\n', snr_kalman);

fprintf('\n=== MSE ===\n');
fprintf('Noisy    : %.4f\n', mse_noisy);
fprintf('Wavelet  : %.4f\n', mse_wavelet);
fprintf('Kalman   : %.4f\n', mse_kalman);

fprintf('\n=== PSNR ===\n');
fprintf('Noisy    : %.2f dB\n', psnr_noisy);
fprintf('Wavelet  : %.2f dB\n', psnr_wavelet);
fprintf('Kalman   : %.2f dB\n', psnr_kalman);

%% Plot SNR Comparison
figure;
bar([snr_noisy, snr_wavelet, snr_kalman]);
set(gca, 'XTickLabel', {'Noisy', 'Wavelet', 'Kalman'});
ylabel('SNR (dB)');
title('SNR Comparison: Noisy & Wavelet & Kalman');
grid on;
