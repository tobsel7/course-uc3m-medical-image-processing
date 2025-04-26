% Calculates the otsu threshold value based on an a histogram (counts
% for each bin)
function histogram_threshold_index = otsu_threshold(histogram)
    bin_probability = histogram / sum(histogram);
    
    cum_prob = cumsum(bin_probability);
    cumulative_bin_mean = cumsum(bin_probability .* (1:size(histogram, 2)));

    % Calculate the variance between the groups for each possible bin
    % Epsilon is added to avoid division by zero
    between_class_variance = (cumulative_bin_mean(end) * cum_prob - cumulative_bin_mean).^2 ./ (cum_prob .* (1 - cum_prob + eps)); 
    
    [~, histogram_threshold_index] = max(between_class_variance);
end