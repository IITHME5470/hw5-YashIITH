clear;
close all;
clc;

time=1142;
px=4; py=4;
tid2 = linspace(0, px*py-1, px*py);
nRanks = length(tid2);
tid1=time*ones(1,nRanks);


for i = 1:length(tid1)
    all_variables = [];

    for j = 1:nRanks
        filename = sprintf('T_x_y_%06d_%04d_%d*%d.dat', tid1(i), tid2(j), px, py);
        dataset = dlmread(filename);
        all_variables = [all_variables; dataset];
    end

   [x_grid,y_grid,T_grid] = reconstructMesh(all_variables);


    if i == length(tid1)
        figure(1)
        contourf(x_grid, y_grid, T_grid, 'LineColor', 'none')
        xlabel('x'), ylabel('y')
        title(['Contour plot at t = ', sprintf('%06d', tid1(i))])
        xlim([-0.05 1.05]), ylim([-0.05 1.05])
        caxis([-0.05 1.05]), colorbar
        colormap('jet')
        set(gca, 'FontSize', 14)
    end
    save_filename = sprintf('cont_T_combined_%dx%d_t_%d.png', px, py, time);
    screen2jpeg(save_filename);
end
