% Kalman filter to the noisy signal
function kalman_filtered_signal = signal_refinement_kalman(noisy_signal)

fs = 10e3; % frequency [Hz]
T = 1; % duration in seconds
snr_input = 0;

t = 0:1/fs:T-1/fs; % time vector
[clean_signal, noisy_signal, t] = SAR_signal(fs, T, [], snr_input);

% initialize kalman filter variables
n = length(noisy_signal);
x_est = zeros(1, n);  % estimated signal
P = zeros(1, n); % error covariance

% Kalman filter parameters
Q = 0.01; 
R = 0.5;      
A = 1;                   
H = 1;                   

% initial guesses
x_est(1) = noisy_signal(1);
P(1) = 1;

% apply Kalman filter
for k = 2:n
    % prediction
    x_pred = A * x_est(k-1);
    P_pred = A * P(k-1) * A' + Q;

    % update
    K = P_pred * H' / (H * P_pred * H' + R);
    x_est(k) = x_pred + K * (noisy_signal(k) - H * x_pred);
    P(k) = (1 - K * H) * P_pred;
end
kalman_filtered_signal = x_est;
%% plot
figure;
subplot(3,1,1); plot(t, clean_signal); title('Clean Signal');
subplot(3,1,2); plot(t, noisy_signal); title('Noisy Signal');
subplot(3,1,3); plot(t, x_est); title('Kalman Filtered Signal');

end
