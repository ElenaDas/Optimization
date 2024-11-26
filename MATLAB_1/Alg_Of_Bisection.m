% Clear workspace and command window
clear;
clc;

% Define symbolic functions using the symbolic toolbox
syms f1(x);
syms f2(x);
syms f3(x);
f1(x) = (x - 2)^2 + x * log(x + 3); % Συνάρτηση f1
f2(x) = exp(-2*x) + (x-2)^2;        % Συνάρτηση f2
f3(x) = exp(x) * (x^3 - 1) + (x - 1) * sin(x); % Συνάρτηση f3

% Ορισμός των κάτω και άνω ορίων αναζήτησης
lower = -1;
upper = 3;

% Σχεδίαση γραφικών για τις συναρτήσεις στα ορισμένα όρια
figure("Name", "f1(x) = (x-2)^2 + x*ln(x+3)");
fplot(f1, [lower, upper]);
xlabel("x");
ylabel("y");

figure("Name", "f2(x) = exp(-2*x) + (x-2)^2");
fplot(f2, [lower, upper]);
xlabel("x");
ylabel("y");

figure("Name", "f3(x) = exp(x) * (x^3 - 1) + (x - 1) * sin(x)");
fplot(f3, [lower, upper]);
xlabel("x");
ylabel("y");

% Ορισμός σταθερού εύρους αναζήτησης l και πλήθους τιμών για το epsilon
l_const = 0.01;
n_e = 50;
start_e = 0.00001;
end_e = (l_const / 2) - start_e;

% Δημιουργία διαστήματος τιμών epsilon
epsilons = linspace(start_e, end_e, n_e);

% Πίνακας για αποθήκευση αριθμού επαναλήψεων για διαφορετικά epsilon
iterations_const_l_variable_e = zeros([n_e 3]);

% Επανάληψη για κάθε τιμή του epsilon
for i = 1:n_e
    epsilon = epsilons(i); % Τρέχουσα τιμή του epsilon

    % Αρχικοποίηση αριθμού επαναλήψεων για τις τρεις συναρτήσεις
    iterations_1 = 1;
    iterations_2 = 1;
    iterations_3 = 1;

    % Αρχικοποίηση κάτω και άνω ορίων για τις τρεις συναρτήσεις
    lower_1 = lower;
    upper_1 = upper;

    lower_2 = lower;
    upper_2 = upper;

    lower_3 = lower;
    upper_3 = upper;

    % Εφαρμογή του αλγορίθμου για την f1 έως ότου το εύρος γίνει μικρότερο του l_const
    while upper_1 - lower_1 >= l_const
        x_1_k = (lower_1 + upper_1) / 2 - epsilon;
        x_2_k = (lower_1 + upper_1) / 2 + epsilon;

        % Ενημέρωση των ορίων ανάλογα με τις τιμές της συνάρτησης
        if f1(x_1_k) < f1(x_2_k) 
            upper_1 = x_2_k;
        else
            lower_1 = x_1_k;
        end

        iterations_1 = iterations_1 + 1; % Αύξηση του μετρητή επαναλήψεων
    end

    % Εφαρμογή του αλγορίθμου για την f2
    while upper_2 - lower_2 >= l_const
        x_1_k = (lower_2 + upper_2) / 2 - epsilon;
        x_2_k = (lower_2 + upper_2) / 2 + epsilon;

        if f2(x_1_k) < f2(x_2_k) 
            upper_2 = x_2_k;
        else
            lower_2 = x_1_k;
        end

        iterations_2 = iterations_2 + 1;
    end

    % Εφαρμογή του αλγορίθμου για την f3
    while upper_3 - lower_3 >= l_const
        x_1_k = (lower_3 + upper_3) / 2 - epsilon;
        x_2_k = (lower_3 + upper_3) / 2 + epsilon;

        if f3(x_1_k) < f3(x_2_k) 
            upper_3 = x_2_k;
        else
            lower_3 = x_1_k;
        end

        iterations_3 = iterations_3 + 1;
    end

    % Αποθήκευση του αριθμού επαναλήψεων για τις τρεις συναρτήσεις
    iterations_const_l_variable_e(i, :) = [iterations_1 iterations_2 iterations_3];
end

% Σχεδίαση του αριθμού επαναλήψεων για διαφορετικές τιμές του epsilon
figure("Name", "Number of iterations, l = 0.01, variable e");
plot(epsilons, iterations_const_l_variable_e(:, 1), ...
    epsilons, iterations_const_l_variable_e(:, 2), ...
    epsilons, iterations_const_l_variable_e(:, 3));
xlabel("e");
ylabel("Number of iterations");
legend("f1", "f2", "f3");

% Σχεδίαση του αριθμού υπολογισμών για διαφορετικές τιμές του epsilon
figure("Name", "Number of calculations, l = 0.01, variable e");
plot(epsilons, (iterations_const_l_variable_e(:, 1) - 1) * 2, ...
    epsilons, (iterations_const_l_variable_e(:, 2) - 1) * 2, ...
    epsilons, (iterations_const_l_variable_e(:, 3) - 1) * 2);
xlabel("e");
ylabel("Number of calculations");
legend("f1", "f2", "f3");

% Ορισμός τιμών του l για επαναλήψεις με σταθερό epsilon
n_l = 100;
start_l = 0.005;
end_l = 0.1;

e_const = 0.001;
ls = linspace(start_l, end_l, n_l);

iterations_variable_l_const_e = zeros([n_l 3]);
lower_limits = zeros([n_l 1 3]);
upper_limits = zeros([n_l 1 3]);

% Επανάληψη για κάθε τιμή του l
for i = 1:n_l
    l = ls(i); % Τρέχουσα τιμή του l

    % Αρχικοποίηση αριθμού επαναλήψεων για τις τρεις συναρτήσεις
    iterations_1 = 1;
    iterations_2 = 1;
    iterations_3 = 1;

    % Αρχικοποίηση ορίων για τις τρεις συναρτήσεις
    lower_1 = lower;
    upper_1 = upper;

    lower_2 = lower;
    upper_2 = upper;

    lower_3 = lower;
    upper_3 = upper;

    % Αποθήκευση αρχικών ορίων
    lower_limits(i, 1, :) = [lower_1 lower_2 lower_3];
    upper_limits(i, 1, :) = [upper_3 upper_3 upper_3];

    % Εφαρμογή του αλγορίθμου για την f1 με μεταβαλλόμενο l
    while upper_1 - lower_1 >= l
        x_1_k = (lower_1 + upper_1) / 2 - e_const;
        x_2_k = (lower_1 + upper_1) / 2 + e_const;

        if f1(x_1_k) < f1(x_2_k) 
            upper_1 = x_2_k;
        else
            lower_1 = x_1_k;
        end

        iterations_1 = iterations_1 + 1;
        lower_limits(i, iterations_1, 1) = lower_1;
        upper_limits(i, iterations_1, 1) = upper_1;
    end

    % Εφαρμογή του αλγορίθμου για την f2 με μεταβαλλόμενο l
    while upper_2 - lower_2 >= l
        x_1_k = (lower_2 + upper_2) / 2 - e_const;
        x_2_k = (lower_2 + upper_2) / 2 + e_const;

        if f2(x_1_k) < f2(x_2_k) 
            upper_2 = x_2_k;
        else
            lower_2 = x_1_k;
        end

        iterations_2 = iterations_2 + 1;
        lower_limits(i, iterations_2, 2) = lower_2;
        upper_limits(i, iterations_2, 2) = upper_2;
    end

    % Εφαρμογή του αλγορίθμου για την f3 με μεταβαλλόμενο l
    while upper_3 - lower_3 >= l
        x_1_k = (lower_3 + upper_3) / 2 - e_const;
        x_2_k = (lower_3 + upper_3) / 2 + e_const;

        if f3(x_1_k) < f3(x_2_k) 
            upper_3 = x_2_k;
        else
            lower_3 = x_1_k;
        end

        iterations_3 = iterations_3 + 1;
        lower_limits(i, iterations_3, 3) = lower_3;
        upper_limits(i, iterations_3, 3) = upper_3;
    end

    % Αποθήκευση του αριθμού επαναλήψεων για τις τρεις συναρτήσεις
    iterations_variable_l_const_e(i, :) = [iterations_1 iterations_2 iterations_3];
end

% Σχεδίαση του αριθμού επαναλήψεων για διαφορετικές τιμές του l και σταθερό epsilon
figure("Name", "Number of iterations, variable l, e = 0.001");
plot(ls, iterations_variable_l_const_e(:, 1), ...
    ls, iterations_variable_l_const_e(:, 2), ...
    ls, iterations_variable_l_const_e(:, 3) ...
    );
xlabel("l");
ylabel("Number of iterations");
legend("f1", "f2", "f3");

% Σχεδίαση του αριθμού υπολογισμών για διαφορετικές τιμές του l και σταθερό epsilon
figure("Name", "Number of calculations, variable l, e = 0.001");
plot(ls, (iterations_variable_l_const_e(:, 1) - 1) * 2, ...
    ls, (iterations_variable_l_const_e(:, 2) - 1) * 2, ...
    ls, (iterations_variable_l_const_e(:, 3) - 1) * 2 ...
    );
xlabel("l");
ylabel("Number of calculations");
legend("f1", "f2", "f3");

% Σχεδίαση των ορίων αναζήτησης για τρεις διαφορετικές τιμές του l: μικρή, μέση και μεγάλη
plot_l_idx = 1; % Χαμηλή τιμή του l
figure("Name", sprintf("f1, Lower and Upper search limit, l = %f, e = 0.001", ls(plot_l_idx)));
plot(1:iterations_variable_l_const_e(plot_l_idx, 1), lower_limits(plot_l_idx, 1:iterations_variable_l_const_e(plot_l_idx, 1), 1), ...
    1:iterations_variable_l_const_e(plot_l_idx, 1), upper_limits(plot_l_idx, 1:iterations_variable_l_const_e(plot_l_idx, 1), 1) ...
    );
xlabel("Number of iterations");
ylabel("Interval");
legend("l(f1)", "u(f1)");

plot_l_idx = n_l / 2; % Μέση τιμή του l
figure("Name", sprintf("f1, Lower and Upper search limit, l = %f, e = 0.001", ls(plot_l_idx)));
plot(1:iterations_variable_l_const_e(plot_l_idx, 1), lower_limits(plot_l_idx, 1:iterations_variable_l_const_e(plot_l_idx, 1), 1), ...
    1:iterations_variable_l_const_e(plot_l_idx, 1), upper_limits(plot_l_idx, 1:iterations_variable_l_const_e(plot_l_idx, 1), 1) ...
    );
xlabel("Number of iterations");
ylabel("Interval");
legend("l(f1)", "u(f1)");

plot_l_idx = n_l; % Υψηλή τιμή του l
figure("Name", sprintf("f1, Lower and Upper search limit, l = %f, e = 0.001", ls(plot_l_idx)));
plot(1:iterations_variable_l_const_e(plot_l_idx, 1), lower_limits(plot_l_idx, 1:iterations_variable_l_const_e(plot_l_idx, 1), 1), ...
    1:iterations_variable_l_const_e(plot_l_idx, 1), upper_limits(plot_l_idx, 1:iterations_variable_l_const_e(plot_l_idx, 1), 1) ...
    );
xlabel("Number of iterations");
ylabel("Interval");
legend("l(f1)", "u(f1)");

% Το ίδιο γίνεται για τις συναρτήσεις f2 και f3
% Συνέχεια για τις f2 και f3
plot_l_idx = 1; % Χαμηλή τιμή του l
figure("Name", sprintf("f2, Lower and Upper search limit, l = %f, e = 0.001", ls(plot_l_idx)));
plot(1:iterations_variable_l_const_e(plot_l_idx, 2), lower_limits(plot_l_idx, 1:iterations_variable_l_const_e(plot_l_idx, 2), 2), ...
    1:iterations_variable_l_const_e(plot_l_idx, 2), upper_limits(plot_l_idx, 1:iterations_variable_l_const_e(plot_l_idx, 2), 2) ...
    );
xlabel("Number of iterations");
ylabel("Interval");
legend("l(f2)", "u(f2)");

% Μέση και υψηλή τιμή του l για την f2
plot_l_idx = n_l / 2;
figure("Name", sprintf("f2, Lower and Upper search limit, l = %f, e = 0.001", ls(plot_l_idx)));
plot(1:iterations_variable_l_const_e(plot_l_idx, 2), lower_limits(plot_l_idx, 1:iterations_variable_l_const_e(plot_l_idx, 2), 2), ...
    1:iterations_variable_l_const_e(plot_l_idx, 2), upper_limits(plot_l_idx, 1:iterations_variable_l_const_e(plot_l_idx, 2), 2) ...
    );
xlabel("Number of iterations");
ylabel("Interval");
legend("l(f2)", "u(f2)");

plot_l_idx = n_l;
figure("Name", sprintf("f2, Lower and Upper search limit, l = %f, e = 0.001", ls(plot_l_idx)));
plot(1:iterations_variable_l_const_e(plot_l_idx, 2), lower_limits(plot_l_idx, 1:iterations_variable_l_const_e(plot_l_idx, 2), 2), ...
    1:iterations_variable_l_const_e(plot_l_idx, 2), upper_limits(plot_l_idx, 1:iterations_variable_l_const_e(plot_l_idx, 2), 2) ...
    );
xlabel("Number of iterations");
ylabel("Interval");
legend("l(f2)", "u(f2)");

% Συνέχεια για την f3
plot_l_idx = 1; % Χαμηλή τιμή του l
figure("Name", sprintf("f3, Lower and Upper search limit, l = %f, e = 0.001", ls(plot_l_idx)));
plot(1:iterations_variable_l_const_e(plot_l_idx, 3), lower_limits(plot_l_idx, 1:iterations_variable_l_const_e(plot_l_idx, 3), 3), ...
    1:iterations_variable_l_const_e(plot_l_idx, 3), upper_limits(plot_l_idx, 1:iterations_variable_l_const_e(plot_l_idx, 3), 3) ...
    );
xlabel("Number of iterations");
ylabel("Interval");
legend("l(f3)", "u(f3)");

% Μέση και υψηλή τιμή του l για την f3
plot_l_idx = n_l / 2;
figure("Name", sprintf("f3, Lower and Upper search limit, l = %f, e = 0.001", ls(plot_l_idx)));
plot(1:iterations_variable_l_const_e(plot_l_idx, 3), lower_limits(plot_l_idx, 1:iterations_variable_l_const_e(plot_l_idx, 3), 3), ...
    1:iterations_variable_l_const_e(plot_l_idx, 3), upper_limits(plot_l_idx, 1:iterations_variable_l_const_e(plot_l_idx, 3), 3) ...
    );
xlabel("Number of iterations");
ylabel("Interval");
legend("l(f3)", "u(f3)");

plot_l_idx = n_l;
figure("Name", sprintf("f3, Lower and Upper search limit, l = %f, e = 0.001", ls(plot_l_idx)));
plot(1:iterations_variable_l_const_e(plot_l_idx, 3), lower_limits(plot_l_idx, 1:iterations_variable_l_const_e(plot_l_idx, 3), 3), ...
    1:iterations_variable_l_const_e(plot_l_idx, 3), upper_limits(plot_l_idx, 1:iterations_variable_l_const_e(plot_l_idx, 3), 3) ...
    );
xlabel("Number of iterations");
ylabel("Interval");
legend("l(f3)", "u(f3)");

% Τέλος του κώδικα


