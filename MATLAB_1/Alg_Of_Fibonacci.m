 clear; % Καθαρισμός του workspace
clc; % Εκκαθάριση της κονσόλας

% Ορισμός συναρτήσεων με χρήση του συμβολικού toolbox
syms f1(x);
syms f2(x);
syms f3(x);
f1(x) = (x - 2)^2 + x * log(x + 3); % Ορισμός της f1
f2(x) = exp(-2*x) + (x-2)^2; % Ορισμός της f2
f3(x) = exp(x) * (x^3 - 1) + (x - 1) * sin(x); % Ορισμός της f3

% Ορισμός κάτω και άνω ορίων αναζήτησης
lower = -1; % Κάτω όριο
upper = 3; % Άνω όριο

% Καθορισμός παραμέτρων για την αλλαγή του l
n_l = 100; % Αριθμός τιμών του l
start_l = 0.001; % Αρχική τιμή του l
end_l = 0.1; % Τελική τιμή του l

% Δημιουργία διανύσματος με τις τιμές του l
ls = linspace(start_l, end_l, n_l);

% Αρχικοποίηση πινάκων για τις επαναλήψεις και τους υπολογισμούς
iterations = zeros([n_l 3]);
calculations = zeros([n_l 3]);
lower_limits = zeros([n_l 1 3]);
upper_limits = zeros([n_l 1 3]);

% Βρόχος για κάθε τιμή του l
for i = 1:n_l
    % Λήψη της τρέχουσας τιμής του l
    l = ls(i);
    epsilon = 0.0001; % Μικρή τιμή για την τελική σύγκριση

    % Υπολογισμός του αριθμού επαναλήψεων με βάση τη σειρά Fibonacci
    compared = (upper - lower) / l;
    n_iterations = 1;
    while fibonacci(n_iterations) <= compared
        n_iterations = n_iterations + 1;
    end

    % Ορισμός αρχικών ορίων για τις συναρτήσεις
    lower_1 = lower;
    upper_1 = upper;
    lower_2 = lower;
    upper_2 = upper;
    lower_3 = lower;
    upper_3 = upper;

    % Αποθήκευση αρχικών ορίων
    lower_limits(i, 1, :) = [lower_1 lower_2 lower_3];
    upper_limits(i, 1, :) = [upper_3 upper_3 upper_3];

    % Υλοποίηση της μεθόδου Fibonacci για τη f1
    x_k_1 = lower_1 + (fibonacci(n_iterations - 2) / fibonacci(n_iterations)) * (upper_1 - lower_1);
    x_k_2 = lower_1 + (fibonacci(n_iterations - 1) / fibonacci(n_iterations)) * (upper_1 - lower_1);
    lower_value_1 = f1(x_k_1);
    upper_value_1 = f1(x_k_2);
    iterations_1 = 1;
    while iterations_1 < n_iterations - 2
        if lower_value_1 > upper_value_1
            lower_1 = x_k_1;
            x_k_1 = x_k_2;
            lower_value_1 = upper_value_1;
            x_k_2 = lower_1 + (fibonacci(n_iterations - iterations_1 - 1) / fibonacci(n_iterations - iterations_1)) * (upper_1 - lower_1);
            upper_value_1 = f1(x_k_2);
        else
            upper_1 = x_k_2;
            x_k_2 = x_k_1;
            upper_value_1 = lower_value_1;
            x_k_1 = lower_1 + (fibonacci(n_iterations - iterations_1 - 2) / fibonacci(n_iterations - iterations_1)) * (upper_1 - lower_1);
            lower_value_1 = f1(x_k_1);
        end
        iterations_1 = iterations_1 + 1;
        lower_limits(i, iterations_1, 1) = lower_1;
        upper_limits(i, iterations_1, 1) = upper_1;
    end
    % Τελική σύγκριση για τη f1
    if f1(x_k_1) > f1(x_k_1 + epsilon)
        lower_1 = x_k_1;
    else
        upper_1 = x_k_1 + epsilon;
    end
    lower_limits(i, iterations_1 + 2, 1) = lower_1;
    upper_limits(i, iterations_1 + 2, 1) = upper_1;

    % Υλοποίηση της μεθόδου Fibonacci για τη f2
    % (Ακολουθεί η ίδια διαδικασία με τη f1)
    x_k_1 = lower_2 + (fibonacci(n_iterations - 2) / fibonacci(n_iterations)) * (upper_2 - lower_2);
    x_k_2 = lower_2 + (fibonacci(n_iterations - 1) / fibonacci(n_iterations)) * (upper_2 - lower_2);
    lower_value_2 = f2(x_k_1);
    upper_value_2 = f2(x_k_2);
    iterations_2 = 1;
    while iterations_2 < n_iterations - 2
        if lower_value_2 > upper_value_2
            lower_2 = x_k_1;
            x_k_1 = x_k_2;
            lower_value_2 = upper_value_2;
            x_k_2 = lower_2 + (fibonacci(n_iterations - iterations_2 - 1) / fibonacci(n_iterations - iterations_2)) * (upper_2 - lower_2);
            upper_value_2 = f2(x_k_2);
        else
            upper_2 = x_k_2;
            x_k_2 = x_k_1;
            upper_value_2 = lower_value_2;
            x_k_1 = lower_2 + (fibonacci(n_iterations - iterations_2 - 2) / fibonacci(n_iterations - iterations_2)) * (upper_2 - lower_2);
            lower_value_2 = f2(x_k_1);
        end
        iterations_2 = iterations_2 + 1;
        lower_limits(i, iterations_2, 2) = lower_2;
        upper_limits(i, iterations_2, 2) = upper_2;
    end
    % Τελική σύγκριση για τη f2
    if f2(x_k_1) > f2(x_k_1 + epsilon)
        lower_2 = x_k_1;
    else
        upper_2 = x_k_1 + epsilon;
    end
    lower_limits(i, iterations_2 + 2, 2) = lower_2;
    upper_limits(i, iterations_2 + 2, 2) = upper_2;

    % Υλοποίηση της μεθόδου Fibonacci για τη f3
    % (Ακολουθεί η ίδια διαδικασία με τη f1)
    x_k_1 = lower_3 + (fibonacci(n_iterations - 2) / fibonacci(n_iterations)) * (upper_3 - lower_3);
    x_k_2 = lower_3 + (fibonacci(n_iterations - 1) / fibonacci(n_iterations)) * (upper_3 - lower_3);
    lower_value_3 = f3(x_k_1);
    upper_value_3 = f3(x_k_2);
    iterations_3 = 1;
    while iterations_3 < n_iterations - 2
        if lower_value_3 > upper_value_3
            lower_3 = x_k_1;
            x_k_1 = x_k_2;
            lower_value_3 = upper_value_3;
            x_k_2 = lower_3 + (fibonacci(n_iterations - iterations_3 - 1) / fibonacci(n_iterations - iterations_3)) * (upper_3 - lower_3);
            upper_value_3 = f3(x_k_2);
        else
            upper_3 = x_k_2;
            x_k_2 = x_k_1;
            upper_value_3 = lower_value_3;
            x_k_1 = lower_3 + (fibonacci(n_iterations - iterations_3 - 2) / fibonacci(n_iterations - iterations_3)) * (upper_3 - lower_3);
            lower_value_3 = f3(x_k_1);
        end
        iterations_3 = iterations_3 + 1;
        lower_limits(i, iterations_3, 3) = lower_3;
        upper_limits(i, iterations_3, 3) = upper_3;
    end
    % Τελική σύγκριση για τη f3
    if f3(x_k_1) > f3(x_k_1 + epsilon)
        lower_3 = x_k_1;
    else
        upper_3 = x_k_1 + epsilon;
    end
    lower_limits(i, iterations_3 + 2, 3) = lower_3;
    upper_limits(i, iterations_3 + 2, 3) = upper_3;

    % Αποθήκευση αποτελεσμάτων
    iterations(i, :) = [n_iterations n_iterations n_iterations];
    calculations(i, :) = [n_iterations n_iterations n_iterations];
end

% Σχεδίαση γραφημάτων για τον αριθμό επαναλήψεων
figure("Name", "Number of iterations")
plot(ls, iterations(:, 1), ls, iterations(:, 2), ls, iterations(:, 3));
xlabel("l");
ylabel("Number of iterations");
legend("f1", "f2", "f3");

% Σχεδίαση γραφημάτων για τον αριθμό υπολογισμών
figure("Name", "Number of calculations")
plot(ls, calculations(:, 1), ls, calculations(:, 2), ls, calculations(:, 3));
xlabel("l");
ylabel("Number of calculations");
legend("f1", "f2", "f3");

% Σχεδίαση γραφημάτων για τα όρια αναζήτησης
plot_l_idx = 1;
figure("Name", sprintf("f1, Lower and Upper search limit, l = %f", ls(plot_l_idx)))
plot(1:iterations(plot_l_idx, 1), lower_limits(plot_l_idx, 1:iterations(plot_l_idx, 1), 1), ...
    1:iterations(plot_l_idx, 1), upper_limits(plot_l_idx, 1:iterations(plot_l_idx, 1), 1));
xlabel("Number of iterations");
ylabel("Interval");
legend("l(f1)", "u(f1)");

% Ανάλογη διαδικασία για f2 και f3
plot_l_idx = 1;
figure("Name", sprintf("f2, Lower and Upper search limit, l = %f", ls(plot_l_idx)))
plot(1:iterations(plot_l_idx, 2), lower_limits(plot_l_idx, 1:iterations(plot_l_idx, 2), 2), ...
    1:iterations(plot_l_idx, 2), upper_limits(plot_l_idx, 1:iterations(plot_l_idx, 2), 2) ...
    );
xlabel("Number of iterations");
ylabel("Interval");
legend("l(f2)", "u(f2)");


figure("Name", sprintf("f3, Lower and Upper search limit, l = %f", ls(plot_l_idx)))
plot(1:iterations(plot_l_idx, 3), lower_limits(plot_l_idx, 1:iterations(plot_l_idx, 3), 3), ...
    1:iterations(plot_l_idx, 3), upper_limits(plot_l_idx, 1:iterations(plot_l_idx, 3), 3) ...
    );
xlabel("Number of iterations");
ylabel("Interval");
legend("l(f3)", "u(f3)");


plot_l_idx = n_l / 2;
figure("Name", sprintf("f1, Lower and Upper search limit, l = %f", ls(plot_l_idx)))
plot(1:iterations(plot_l_idx, 1), lower_limits(plot_l_idx, 1:iterations(plot_l_idx, 1), 1), ...
    1:iterations(plot_l_idx, 1), upper_limits(plot_l_idx, 1:iterations(plot_l_idx, 1), 1) ...
    );
xlabel("Number of iterations");
ylabel("Interval");
legend("l(f1)", "u(f1)");


plot_l_idx = n_l / 2;
figure("Name", sprintf("f2, Lower and Upper search limit, l = %f", ls(plot_l_idx)))
plot(1:iterations(plot_l_idx, 2), lower_limits(plot_l_idx, 1:iterations(plot_l_idx, 2), 2), ...
    1:iterations(plot_l_idx, 2), upper_limits(plot_l_idx, 1:iterations(plot_l_idx, 2), 2) ...
    );
xlabel("Number of iterations");
ylabel("Interval");
legend("l(f2)", "u(f2)");


plot_l_idx = n_l / 2;
figure("Name", sprintf("f3, Lower and Upper search limit, l = %f", ls(plot_l_idx)))
plot(1:iterations(plot_l_idx, 3), lower_limits(plot_l_idx, 1:iterations(plot_l_idx, 3), 3), ...
    1:iterations(plot_l_idx, 3), upper_limits(plot_l_idx, 1:iterations(plot_l_idx, 3), 3) ...
    );
xlabel("Number of iterations");
ylabel("Interval");
legend("l(f3)", "u(f3)");


plot_l_idx = n_l;
figure("Name", sprintf("f1, Lower and Upper search limit, l = %f", ls(plot_l_idx)))
plot(1:iterations(plot_l_idx, 1), lower_limits(plot_l_idx, 1:iterations(plot_l_idx, 1), 1), ...
    1:iterations(plot_l_idx, 1), upper_limits(plot_l_idx, 1:iterations(plot_l_idx, 1), 1) ...
    );
xlabel("Number of iterations");
ylabel("Interval");
legend("l(f1)", "u(f1)");


plot_l_idx = n_l;
figure("Name", sprintf("f2, Lower and Upper search limit, l = %f", ls(plot_l_idx)))
plot(1:iterations(plot_l_idx, 2), lower_limits(plot_l_idx, 1:iterations(plot_l_idx, 2), 2), ...
    1:iterations(plot_l_idx, 2), upper_limits(plot_l_idx, 1:iterations(plot_l_idx, 2), 2) ...
    );
xlabel("Number of iterations");
ylabel("Interval");
legend("l(f2)", "u(f2)");


plot_l_idx = n_l;
figure("Name", sprintf("f3, Lower and Upper search limit, l = %f", ls(plot_l_idx)))
plot(1:iterations(plot_l_idx, 3), lower_limits(plot_l_idx, 1:iterations(plot_l_idx, 3), 3), ...
    1:iterations(plot_l_idx, 3), upper_limits(plot_l_idx, 1:iterations(plot_l_idx, 3), 3) ...
    );
xlabel("Number of iterations");
ylabel("Interval");
legend("l(f3)", "u(f3)");


close all;