%% Read the image
A = dicomread('BrainImage.dcm')
whos A; %  check data type of image
% Display the original image
figure, imagesc(A), title('Original Image'), colorbar

figure, imagesc(A), title('Original Image'), axis image, axis off, colormap(gray), colorbar

%% Convert to double format
Img = double(A)
figure, imagesc(Img), title('Original Image of Double'), colorbar

figure, imagesc(A), title('Original Image of Double'), axis image, axis off, colormap(gray), colorbar

%% Pre-processing step: |remove the background by thresholding|
%the background intensity values equal to zero by using a threshold value
threshold = 100; % adjust this value as needed
Img(Img < threshold) = 0

% Display the Pre-processed image
figure, imagesc(Img), title('Pre-processed Image'), colorbar

figure, imagesc(Img), title('Pre-processed Image'), axis image, axis off, colormap(gray), colorbar

%% Gamma correction
% S = Cr^gamma
C = 1; % Define a constant C
gamma_values = [0.03, 0.1, 1] % three different values of gamma.
S_gamma = zeros(size(Img,1), size(Img,2), length(gamma_values)) %Output image intensity
for i = 1:length(gamma_values)
    gamma = gamma_values(i)

    % Apply the gamma correction formula
    S_gamma(:,:,i) = C * power(Img, gamma)
    
    % Display the enhanced image
    figure
    imagesc(S_gamma(:,:,i))
    title(['Gamma Correction = ' num2str(gamma)])
    colorbar

    figure
    imagesc(S_gamma(:,:,i))
    title(['Gamma Correction = ' num2str(gamma)])
    axis image
    axis off
    colormap(gray)
    colorbar

    % Plot the Input intensity vs Output intensity
    figure
    plot(Img, S_gamma(:,:,i), '.');
    title(['Gamma Correction = ' num2str(gamma)]);
    xlabel('Input Intensity (r)');
    ylabel('Output Intensity(S)');

    % Compute and display histogram
    figure
    imhist(S_gamma(:,:,i), 256)
    title(['Histogram (Gamma) = ' num2str(gamma)])

    % Compute the difference image
    gamma_diff_image = abs(Img - S_gamma(:,:,i))

    % Display the difference image
    figure
    imagesc(gamma_diff_image)
    title(['Difference (Gamma = ', num2str(gamma), ')'])
    
    % Compute absolute mean residual error
    gamma_error = mean(gamma_diff_image(:));

    % Display absolute mean residual error
    disp(['Absolute Mean Residual Error (Gamma = ', num2str(gamma), '): ', num2str(gamma_error)])

end

%% Logarithmic Transformation
C = 1; % Define a constant C
% Apply the logarithmic transformation formula
S_log = C * log(1 + Img)

% Display the enhanced image
figure
imagesc(S_log)
title('Logarithmic transformation')
colorbar

figure
imagesc(S_log)
title('Logarithmic transformation')
axis image
axis off
colormap(gray)
colorbar

% Plot the Input intensity vs Output intensity
figure
plot(Img, S_log, '.');
title(['Logarithmic transformation  = ' num2str(gamma)]);
xlabel('Input Intensity (r)');
ylabel('Output Intensity(S)');

% Compute and display histogram
figure
imhist(S_log, 256)
title('Histogram (Logarithmic Transformation)')

% Compute the difference image
log_diff_image = abs(Img - S_log)

% Display the difference image
figure
imagesc(log_diff_image)
title('Difference (Logarithmic Transformation)')

% Compute and display absolute mean residual error
log_error = mean(log_diff_image(:));
disp(['Absolute Mean Residual Error (Logarithmic Transformation): ', num2str(log_error)])

%% Histogram Equalization
% Apply the histogram equalization formula
S_hist = histeq(Img)

% Display enhanced image
figure
imagesc(S_hist)
title('Histogram Equalization')
colorbar

figure
imagesc(S_hist)
title('Histogram Equalization')
axis image
axis off
colormap(gray)
colorbar

% Plot the Input intensity vs Output intensity
figure
plot(Img, S_hist, '.');
title(['Histogram Equalization  = ' num2str(gamma)]);
xlabel('Input Intensity (r)');
ylabel('Output Intensity(S)');

% Compute and display histogram
figure
imhist(S_hist, 256);
title('Histogram (Histogram Equalization)');

% Compute the difference image
hist_diff_image = abs(Img - S_hist)

% Display the difference image
figure
imagesc(hist_diff_image)
title('Difference (Histogram Equalization)')

% Compute absolute mean residual error
hist_error = mean(hist_diff_image(:));

% Display absolute mean residual error
disp(['Absolute mean residual error (Histogram Equalization): ' num2str(hist_error)])

%% Display the results
fprintf('\n...Absolute Mean Residual Error...\n');
fprintf('Gamma Correction: %.2f\n', gamma_error);
fprintf('Logarithmic Transformation: %.2f\n', log_error);
fprintf('Histogram Equalization: %.2f\n', hist_error);