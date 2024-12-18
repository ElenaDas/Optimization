% clear;

% define function using symbolic toolbox
syms f(x, y);
f(x, y) = (x^5) * exp(- x^2 - y^2);
gradf = gradient(f);

% plot function
figure("Name", "Function plot");
fsurf(f);
xlabel("x");
ylabel("y");
zlabel("f(x, y)");

colormap(spring);

% epsilon for all runs
epsilon = 0.01;

% constant step
step = 0.005;

% start from (0, 0)
f_point = [0 0];
points_zero_const = zeros([1 2]);
points_zero_const(1, :) = f_point;
k = 1;

function [minArg,minValue] = minimize_1d_function(f, starting_point, gradf_value)
    % use bicection with derivative method to minimize f and return both
    % its min value and the argument that holds it
    
    % parameters to be changed
    upper = 1;
    lower = 0;
    l = 0.1;

    syms g(x);
    g(x) = f(starting_point(1) + x * gradf_value(1), starting_point(2) + x * gradf_value(2));
    dg = diff(g);

     while upper - lower >= l
        midpoint = (upper + lower) / 2;
        der_g = dg(midpoint);
        if der_g > 0
            upper = midpoint;
        elseif der_g < 0
            lower = midpoint;
        else
           % break the loop
           upper = midpoint;
           lower = midpoint;
        end
     end

     minArg = upper; % = lower
     minValue = g(minArg);
end


gradf_value = double(gradf(f_point(1), f_point(2)))';

while norm(gradf_value) >= epsilon
    f_point = f_point - step * gradf_value;
    points_zero_const(end + 1, :) = f_point;
    gradf_value = double(gradf(f_point(1), f_point(2)))';
    k = k + 1;
end

% start from (-1, 1)
f_point = [-1 1];
points_one_const = zeros([1 2]);
points_one_const(1, :) = f_point;
k = 1;

gradf_value = double(gradf(f_point(1), f_point(2)))';

while norm(gradf_value) >= epsilon
    f_point = f_point - step * gradf_value;
    points_one_const(end + 1, :) = f_point;
    gradf_value = double(gradf(f_point(1), f_point(2)))';
    k = k + 1;
end

% start from (1, -1)
f_point = [1 -1];
points_two_const = zeros([1 2]);
points_two_const(1, :) = f_point;
k = 1;

gradf_value = double(gradf(f_point(1), f_point(2)))';

while norm(gradf_value) >= epsilon
    f_point = f_point - step * gradf_value;
    points_two_const(end + 1, :) = f_point;
    gradf_value = double(gradf(f_point(1), f_point(2)))';
    k = k + 1;
end

% step that minimizes condition

% start from (0, 0)
f_point = [0 0];
points_zero_min = zeros([1 2]);
points_zero_min(1, :) = f_point;
k = 1;

gradf_value = double(gradf(f_point(1), f_point(2)))';
[step, ~] = minimize_1d_function(f, f_point, gradf_value);

while norm(gradf_value) >= epsilon
    f_point = f_point - step * gradf_value;
    points_zero_min(end + 1, :) = f_point;
    gradf_value = double(gradf(f_point(1), f_point(2)))';
    [step, ~] = minimize_1d_function(f, f_point, gradf_value);
    k = k + 1;
end

% start from (-1, 1)
f_point = [-1 1];
points_one_min = zeros([1 2]);
points_one_min(1, :) = f_point;
k = 1;

gradf_value = double(gradf(f_point(1), f_point(2)))';
[step, ~] = minimize_1d_function(f, f_point, gradf_value);

while norm(gradf_value) >= epsilon
    f_point = f_point - step * gradf_value;
    points_one_min(end + 1, :) = f_point;
    gradf_value = double(gradf(f_point(1), f_point(2)))';
    [step, ~] = minimize_1d_function(f, f_point, gradf_value);
    k = k + 1;
end

% start from (1, -1)
f_point = [1 -1];
points_two_min = zeros([1 2]);
points_two_min(1, :) = f_point;
k = 1;

gradf_value = double(gradf(f_point(1), f_point(2)))';
[step, ~] = minimize_1d_function(f, f_point, gradf_value);

while norm(gradf_value) >= epsilon
    f_point = f_point - step * gradf_value;
    points_two_min(end + 1, :) = f_point;
    gradf_value = double(gradf(f_point(1), f_point(2)))';
    [step, ~] = minimize_1d_function(f, f_point, gradf_value);
    k = k + 1;
end


% armijo rule

% arbitrary constant selection
a = 0.001;
b = 0.2;
s = 1;

% start from (0, 0)
f_point = [0 0];
points_zero_arm = zeros([1 2]);
points_zero_arm(1, :) = f_point;
k = 1;
step = 1; % initial step

gradf_value = double(gradf(f_point(1), f_point(2)))';

while norm(gradf_value) >= epsilon
    f_point_old = f_point;
    f_point = f_point - step * gradf_value;
    % recompute step
    mk = 1;
    while f(f_point_old(1), f_point_old(2)) - f(f_point(1), f_point(2)) < ...
            - a * b^mk * s * (step * gradf_value * (gradf_value'))
        mk = mk + 1;
    end
    step = s * b^mk;
    points_zero_arm(end + 1, :) = f_point;
    gradf_value = double(gradf(f_point(1), f_point(2)))';
    k = k + 1;
end

% start from (-1, 1)
f_point = [-1 1];
points_one_arm = zeros([1 2]);
points_one_arm(1, :) = f_point;
k = 1;
step = 1; % initial step

gradf_value = double(gradf(f_point(1), f_point(2)))';

while norm(gradf_value) >= epsilon
    f_point_old = f_point;
    f_point = f_point - step * gradf_value;
    % recompute step
    mk = 1;
    while f(f_point_old(1), f_point_old(2)) - f(f_point(1), f_point(2)) < ...
            - a * b^mk * s * (step * gradf_value * (gradf_value'))
        mk = mk + 1;
    end
    step = s * b^mk;
    points_one_arm(end + 1, :) = f_point;
    gradf_value = double(gradf(f_point(1), f_point(2)))';
    k = k + 1;
end

% start from (1, -1)
f_point = [1 -1];
points_two_arm = zeros([1 2]);
points_two_arm(1, :) = f_point;
k = 1;
step = 1; % initial step

gradf_value = double(gradf(f_point(1), f_point(2)))';

while norm(gradf_value) >= epsilon
    f_point_old = f_point;
    f_point = f_point - step * gradf_value;
    % recompute step
    mk = 1;
    while f(f_point_old(1), f_point_old(2)) - f(f_point(1), f_point(2)) < ...
            - a * b^mk * s * (step * gradf_value * (gradf_value'))
        mk = mk + 1;
    end
    step = s * b^mk;
    points_two_arm(end + 1, :) = f_point;
    gradf_value = double(gradf(f_point(1), f_point(2)))';
    k = k + 1;
end

% visualise results
% constant step
figure("Name", "Constant step = 0.005, Starting point = (0, 0)");
fsurf(f);
hold on;
xlabel("x");
ylabel("y");
zlabel("f(x, y)");
plot3(points_zero_const(:, 1), points_zero_const(:, 2), f(points_zero_const(:, 1), points_zero_const(:, 2)), "r*");
colormap(spring);

figure("Name", "f value at each iteration, constant step = 0.005, starting point = (0, 0)");
size_zr = size(points_zero_const);
plot(1:size_zr(1), f(points_zero_const(:, 1), points_zero_const(:, 2)));
xlabel("iteration no");
ylabel("function value");
colormap(spring);
sd_const_step_zero_iter = size_zr;

figure("Name", "Constant step = 0.005, Starting point = (-1, 1)");
fsurf(f);
hold on;
xlabel("x");
ylabel("y");
zlabel("f(x, y)");
plot3(points_one_const(:, 1), points_one_const(:, 2), f(points_one_const(:, 1), points_one_const(:, 2)), "r*");
colormap(spring);


figure("Name", "f value at each iteration, constant step = 0.005, starting point = (-1, 1)");
size_zr = size(points_one_const);
plot(1:size_zr(1), f(points_one_const(:, 1), points_one_const(:, 2)));
xlabel("iteration no");
ylabel("function value");


colormap(spring);
sd_const_step_one_iter = size_zr;

figure("Name", "Constant step = 0.005, Starting point = (1, -1)");
fsurf(f);
hold on;
xlabel("x");
ylabel("y");
zlabel("f(x, y)");
plot3(points_two_const(:, 1), points_two_const(:, 2), f(points_two_const(:, 1), points_two_const(:, 2)), "r*");
colormap(spring);


figure("Name", "f value at each iteration, constant step = 0.005, starting point = (1, -1)");
size_zr = size(points_two_const);
plot(1:size_zr(1), f(points_two_const(:, 1), points_two_const(:, 2)));
xlabel("iteration no");
ylabel("function value");
colormap(spring);


sd_const_step_two_iter = size_zr;

% minimal step
figure("Name", "Minimizing step, Starting point = (0, 0)");
fsurf(f);
hold on;
xlabel("x");
ylabel("y");
zlabel("f(x, y)");
plot3(points_zero_min(:, 1), points_zero_min(:, 2), f(points_zero_min(:, 1), points_zero_min(:, 2)), "r*");
colormap(spring);

figure("Name", "f value at each iteration, minimizing step, starting point = (0, 0)");
size_zr = size(points_zero_min);
plot(1:size_zr(1), f(points_zero_min(:, 1), points_zero_min(:, 2)));
xlabel("iteration no");
ylabel("function value");
colormap(spring);
sd_min_step_zero_iter = size_zr;



figure("Name", "Minimizing step, Starting point = (-1, 1)");
fsurf(f);
hold on;
xlabel("x");
ylabel("y");
zlabel("f(x, y)");
plot3(points_one_min(:, 1), points_one_min(:, 2), f(points_one_min(:, 1), points_one_min(:, 2)), "r*");
colormap(spring);


figure("Name", "f value at each iteration, minimizing step, starting point = (-1, 1)");
size_zr = size(points_one_min);
plot(1:size_zr(1), f(points_one_min(:, 1), points_one_min(:, 2)));
xlabel("iteration no");
ylabel("function value");
colormap(spring);
sd_min_step_one_iter = size_zr;

figure("Name", "Minimizing, Starting point = (1, -1)");
fsurf(f);
hold on;
xlabel("x");
ylabel("y");
zlabel("f(x, y)");
plot3(points_two_min(:, 1), points_two_min(:, 2), f(points_two_min(:, 1), points_two_min(:, 2)), "r*");
colormap(spring);

figure("Name", "f value at each iteration, minimizing step, starting point = (1, -1)");
size_zr = size(points_two_min);
plot(1:size_zr(1), f(points_two_min(:, 1), points_two_min(:, 2)));
xlabel("iteration no");
ylabel("function value");
colormap(spring);
sd_min_step_two_iter = size_zr;

% armijo's rule
figure("Name", "Armijo's rule step, Starting point = (0, 0)");
fsurf(f);
hold on;
xlabel("x");
ylabel("y");
zlabel("f(x, y)");
plot3(points_zero_arm(:, 1), points_zero_arm(:, 2), f(points_zero_arm(:, 1), points_zero_arm(:, 2)), "r*");
colormap(spring);

figure("Name", "f value at each iteration, armijo's rule step, starting point = (0, 0)");
size_zr = size(points_zero_arm);
plot(1:size_zr(1), f(points_zero_arm(:, 1), points_zero_arm(:, 2)));
xlabel("iteration no");
ylabel("function value");
colormap(spring);
sd_arm_step_zero_iter = size_zr;

figure("Name", "Armijo's rule step, Starting point = (-1, 1)");
fsurf(f);
hold on;
xlabel("x");
ylabel("y");
zlabel("f(x, y)");
plot3(points_one_arm(:, 1), points_one_arm(:, 2), f(points_one_arm(:, 1), points_one_arm(:, 2)), "r*");
colormap(spring);

figure("Name", "f value at each iteration, armijo's rule step, starting point = (-1, 1)");
size_zr = size(points_one_arm);
plot(1:size_zr(1), f(points_one_arm(:, 1), points_one_arm(:, 2)));
xlabel("iteration no");
ylabel("function value");
colormap(spring);
sd_arm_step_one_iter = size_zr;

figure("Name", "Armijo's rule step, Starting point = (1, -1)");
fsurf(f);
hold on;
xlabel("x");
ylabel("y");
zlabel("f(x, y)");
plot3(points_two_arm(:, 1), points_two_arm(:, 2), f(points_two_arm(:, 1), points_two_arm(:, 2)), "r*");
colormap(spring);


figure("Name", "f value at each iteration, armijo's rule step, starting point = (1, -1)");
size_zr = size(points_two_arm);
plot(1:size_zr(1), f(points_two_arm(:, 1), points_two_arm(:, 2)));
xlabel("iteration no");
ylabel("function value");
colormap(spring);
sd_arm_step_two_iter = size_zr;