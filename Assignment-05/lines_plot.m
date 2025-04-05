clear;
close all;
clc;

time = 2050;
px = [1 2 2 4];
py = [1 2 4 4];

% Create figure once
figure(1), clf
hold on
colors = lines(4);  % Use different colors for 4 configurations
legendEntries = cell(1,4);  % Preallocate legend entries

for m = 1:4
    tid2 = linspace(0, px(m)*py(m)-1, px(m)*py(m));
    nRanks = length(tid2);
    tid1 = time * ones(1, nRanks);

    Tmid_all = [];

    for i = 1:length(tid1)
        all_variables = [];

        for j = 1:nRanks
            filename = sprintf('T_x_y_%06d_%04d_%d*%d.dat', tid1(i), tid2(j), px(m), py(m));
            dataset = dlmread(filename);
            all_variables = [all_variables; dataset];
        end

       [x_grid,y_grid,T_grid] = reconstructMesh(all_variables);

        mid_index = round(length(x_grid) / 2);
        Tmid_all(i, :) = T_grid(mid_index, :);
    end

    % Plot for this px x py
    h = plot(x_grid, Tmid_all(end, :), '-', 'LineWidth', 2, 'Color', colors(m,:));
    grid on
    legendEntries{m} = sprintf('%dx%d', px(m), py(m));  % e.g., '2x4'
end

xlabel('x'), ylabel('T')
title(['Profile along mid-y at t = ', sprintf('%06d', time)])
legend(legendEntries, 'Location', 'best')
xlim([-0.05 1.05])
set(gca, 'FontSize', 14)

% Save figure
screen2jpeg('comparison_of_line_midy_T_all_between_serial_parallel_t_2050.png')
