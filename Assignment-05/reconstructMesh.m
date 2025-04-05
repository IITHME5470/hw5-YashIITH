function [x_grid,y_grid,T_grid] = reconstructMesh(all_variables)

    x_all = all_variables(:,1);
    y_all = all_variables(:,2);
    T_all = all_variables(:,3);

    x_grid = unique(x_all);
    y_grid = unique(y_all);
    nx = length(x_grid);
    ny = length(y_grid);

    T_grid = nan(ny, nx);

    for k = 1:length(T_all)
        xi = x_grid == x_all(k);
        yi = y_grid == y_all(k);
        T_grid(yi, xi) = T_all(k);
    end

end