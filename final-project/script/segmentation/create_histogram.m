% Calculates the histogram bin counts and bin edges for an input image
function [bin_counts, bin_edges] = create_histogram(image, n_bins)
    image = double(image(:));

    bin_edges = linspace(min(image), max(image), n_bins + 1);
    bin_counts = histcounts(image, bin_edges);
end