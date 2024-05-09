%% Q1. Load DICOM Image, Scale Image to 0-255, Convert to uint8
dicom_image = dicomread('Q3.dcm');
scaled_image = mat2gray(dicom_image) * 255;
scaled_image_uint8 = uint8(scaled_image);

%% Q2. (i) Add Salt and Pepper Noise with Noise Density of 0.01, 0.05, and 0.08
noisy_images_sp = cell(3, 1);
noise_densities_sp = [0.01, 0.05, 0.08];
for i = 1:numel(noise_densities_sp)
    noisy_images_sp{i} = imnoise(scaled_image_uint8, 'salt & pepper', noise_densities_sp(i));
end

% (ii) Denoise the three saved noisy image with Mean Filter of size 3X3, 9X9, and 15X15.
% (iii) Denoise the three saved noisy image with Median Filter of size 3X3, 9X9, and 15X15.
% (iv) Denoise the three saved noisy image with Gaussian Filter of size 3X3, 9X9, and 15X15.
filter_sizes = [3, 9, 15];
denoised_images_sp_mean = cell(3, 3);
denoised_images_sp_median = cell(3, 3);
denoised_images_sp_gaussian = cell(3, 3);
for i = 1:numel(noise_densities_sp)
    for j = 1:numel(filter_sizes)
        denoised_images_sp_mean{i, j} = uint8(conv2(double(noisy_images_sp{i}), ones(filter_sizes(j))/filter_sizes(j)^2, 'same'));
        denoised_images_sp_median{i, j} = medfilt2(noisy_images_sp{i}, [filter_sizes(j), filter_sizes(j)]);
        denoised_images_sp_gaussian{i, j} = uint8(imgaussfilt(double(noisy_images_sp{i}), filter_sizes(j)/6));
    end
end

%% Q3. (i) Add Gaussian Noise with Mean : 0 and Variance: 0.01, 0.025, and 0.05
noisy_images_gaussian = cell(3, 1);
variances = [0.01, 0.025, 0.05];
for i = 1:numel(variances)
    noisy_images_gaussian{i} = imnoise(scaled_image_uint8, 'gaussian', 0, variances(i));
end

% (ii) Denoise the three saved noisy image with Mean Filter of size 3X3, 9X9, and 15X15.
% (iii) Denoise the three saved noisy image with Median Filter of size 3X3, 9X9, and 15X15.
% (iv) Denoise the three saved noisy image with Gaussian Filter of size 3X3, 9X9, and 15X15.
denoised_images_gaussian_mean = cell(3, 3);
denoised_images_gaussian_median = cell(3, 3);
denoised_images_gaussian_gaussian = cell(3, 3);
for i = 1:numel(variances)
    for j = 1:numel(filter_sizes)
        denoised_images_gaussian_mean{i, j} = uint8(conv2(double(noisy_images_gaussian{i}), ones(filter_sizes(j))/filter_sizes(j)^2, 'same'));
        denoised_images_gaussian_median{i, j} = medfilt2(noisy_images_gaussian{i}, [filter_sizes(j), filter_sizes(j)]);
        denoised_images_gaussian_gaussian{i, j} = uint8(imgaussfilt(double(noisy_images_gaussian{i}), filter_sizes(j)/6));
    end
end

%% Display or save noisy images with salt and pepper noise
for i = 1:numel(noise_densities_sp)
    figure;
    imshow(noisy_images_sp{i});
    title(['Salt & Pepper Noise, Density: ', num2str(noise_densities_sp(i))]);
    % Uncomment the line below to save the image
    % imwrite(noisy_images_sp{i}, ['noisy_sp_density_', num2str(noise_densities_sp(i)), '.png']);
end

%% Display or save denoised images with mean filter for salt and pepper noise
for i = 1:numel(noise_densities_sp)
    for j = 1:numel(filter_sizes)
        figure;
        imshow(denoised_images_sp_mean{i, j});
        title(['Denoised (Mean Filter) - Salt & Pepper Noise, Density: ', num2str(noise_densities_sp(i)), ', Filter Size: ', num2str(filter_sizes(j))]);
        % Uncomment the line below to save the image
        % imwrite(denoised_images_sp_mean{i, j}, ['denoised_sp_mean_density_', num2str(noise_densities_sp(i)), '_filter_', num2str(filter_sizes(j)), '.png']);
    end
end

%% Display or save denoised images with median filter for salt and pepper noise
for i = 1:numel(noise_densities_sp)
    for j = 1:numel(filter_sizes)
        figure;
        imshow(denoised_images_sp_median{i, j});
        title(['Denoised (Median Filter) - Salt & Pepper Noise, Density: ', num2str(noise_densities_sp(i)), ', Filter Size: ', num2str(filter_sizes(j))]);
        % Uncomment the line below to save the image
        % imwrite(denoised_images_sp_median{i, j}, ['denoised_sp_median_density_', num2str(noise_densities_sp(i)), '_filter_', num2str(filter_sizes(j)), '.png']);
    end
end

%% Display or save denoised images with Gaussian filter for salt and pepper noise
for i = 1:numel(noise_densities_sp)
    for j = 1:numel(filter_sizes)
        figure;
        imshow(denoised_images_sp_gaussian{i, j});
        title(['Denoised (Gaussian Filter) - Salt & Pepper Noise, Density: ', num2str(noise_densities_sp(i)), ', Filter Size: ', num2str(filter_sizes(j))]);
        % Uncomment the line below to save the image
        % imwrite(denoised_images_sp_gaussian{i, j}, ['denoised_sp_gaussian_density_', num2str(noise_densities_sp(i)), '_filter_', num2str(filter_sizes(j)), '.png']);
    end
end

%% Display or save noisy images with gaussian noise
for i = 1:numel(variances)
    figure;
    imshow(noisy_images_gaussian{i});
    title(['Gaussian Noise, Variance: ', num2str(variances(i))]);
    % Uncomment the line below to save the image
    % imwrite(noisy_images_gaussian{i}, ['noisy_gaussian_variance_', num2str(variances(i)), '.png']);
end

%% Display or save denoised images with mean filter for gaussian noise
for i = 1:numel(variances)
    for j = 1:numel(filter_sizes)
        figure;
        imshow(denoised_images_gaussian_mean{i, j});
        title(['Denoised (Mean Filter) - Gaussian Noise, Variance: ', num2str(variances(i)), ', Filter Size: ', num2str(filter_sizes(j))]);
        % Uncomment the line below to save the image
        % imwrite(denoised_images_gaussian_mean{i, j}, ['denoised_gaussian_mean_variance_', num2str(variances(i)), '_filter_', num2str(filter_sizes(j)), '.png']);
    end
end

%% Display or save denoised images with median filter for gaussian noise
for i = 1:numel(variances)
    for j = 1:numel(filter_sizes)
        figure;
        imshow(denoised_images_gaussian_median{i, j});
        title(['Denoised (Median Filter) - Gaussian Noise, Variance: ', num2str(variances(i)), ', Filter Size: ', num2str(filter_sizes(j))]);
        % Uncomment the line below to save the image
        % imwrite(denoised_images_gaussian_median{i, j}, ['denoised_gaussian_median_variance_', num2str(variances(i)), '_filter_', num2str(filter_sizes(j)), '.png']);
    end
end

%% Display or save denoised images with Gaussian filter for gaussian noise
for i = 1:numel(variances)
    for j = 1:numel(filter_sizes)
        figure;
        imshow(denoised_images_gaussian_gaussian{i, j});
        title(['Denoised (Gaussian Filter) - Gaussian Noise, Variance: ', num2str(variances(i)), ', Filter Size: ', num2str(filter_sizes(j))]);
        % Uncomment the line below to save the image
        % imwrite(denoised_images_gaussian_gaussian{i, j}, ['denoised_gaussian_gaussian_variance_', num2str(variances(i)), '_filter_', num2str(filter_sizes(j)), '.png']);
    end
end

%% Q4. How does the Mean filter affect the image quality, discussing the effect of filter size?
Answer: The mean filter blurs the image, and larger filter sizes result in stronger blurring.

% Effort of filter size:
Smaller filter sizes (i.e, 3x3) lead to more localized averaging, resulting in less smoothing and preservation of finer details. They may not effectively remove noise or larger artifacts.
Larger filter sizes (i.e, 15x15) result in more extensive averaging, leading to greater smoothing and loss of detail. They are more effective at removing noise and larger artifacts but can also blur important features.

%% Q5. How does the Median filter affect the image quality, discussing the effect of filter size?
Answer: The median filter is effective in removing salt-and-pepper noise. Larger filter sizes preserve edges better.

%Effort of filter size:
Similar to the Mean filter, smaller filter sizes (i.e, 3x3) preserve more detail but may not effectively remove all noise.
Larger filter sizes (i.e, 15x15) are more effective at noise removal but can blur edges and details.

%% Q6. How does the Gaussian filter affect the image quality, discussing the effect of filter size and standard deviation?
Answer: The gaussian filter blurs the image and larger standard deviations result in stronger blurring.

%Effect of Filter Size:
Larger filter sizes result in more extensive blurring and smoothing, similar to the Mean filter.

%Effect of Standard Deviation:
A smaller standard deviation results in a sharper filter response, preserving more detail but potentially less effective noise reduction.
A larger standard deviation results in a broader filter response, leading to more effective noise reduction but potentially more loss of detail.

%% Q7. Which filter is best for Salt and Pepper Noise and Why?
Answer: Median filter is typically better for salt and pepper noise as it can effectively remove outliers without blurring the image.

%% Q8. Which filter is best for Gaussian Noise and Why?
Answer: Gaussian filter is generally suitable for Gaussian noise as it provides a smoothing effect and reduces high-frequency noise.

%% Q9. Homework Assignment: Implement 3x3 and 9x9 Mean filters by yourself.

function output_image = mean_filter(input_image, filter_size)
    [rows, cols] = size(input_image);
    pad_size = floor(filter_size / 2);
    padded_image = padarray(input_image, [pad_size, pad_size], 'replicate');
    output_image = zeros(rows, cols);

    for i = 1:rows
        for j = 1:cols
            % Extract the region of interest
            region = padded_image(i:i+filter_size-1, j:j+filter_size-1);
            % Compute the mean and assign it to the corresponding pixel
            output_image(i, j) = mean(region(:));
        end
    end
end

% Example usage:
% blurred_image_3x3 = mean_filter(input_image, 3);
% blurred_image_9x9 = mean_filter(input_image, 9);
