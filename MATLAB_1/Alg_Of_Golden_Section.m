 clear; % Καθαρισμός του workspace
clc; % Εκκαθάριση της κονσόλας

% Ορισμός συναρτήσεων με χρήση του συμβολικού εργαλείου
syms f1(x);
syms f2(x);
syms f3(x);
f1(x) = (x - 2)^2 + x * log(x + 3); % Ορισμός της f1
f2(x) = exp(-2*x) + (x-2)^2; % Ορισμός της f2
f3(x) = exp(x) * (x^3 - 1) + (x - 1) * sin(x); % Ορισμός της f3

% Ορισμός των αρχικών ορίων αναζήτησης
lower = -1; % Κάτω όριο
upper = 3; % Άνω όριο

% Καθορισμός του πλήθους των τιμών του l
n_l = 100; % Αριθμός τιμών για το l
start_l = 0.001; % Αρχική τιμή του l
end_l = 0.1; % Τελική τιμή του l

% Δημιουργία διανύσματος τιμών για το l
ls = linspace(start_l, end_l, n_l);

% Αρχικοποίηση πινάκων για αποθήκευση επαναλήψεων και υπολογισμών
iterations = zeros([n_l 3]);
calculations = zeros([n_l 3]);
lower_limits = zeros([n_l 1 3]);
upper_limits = zeros([n_l 1 3]);

% Επανάληψη για κάθε τιμή του l
for i = 1:n_l
    % Απόκτηση της τρέχουσας τιμής του l
    l = ls(i);

    % Αρχικοποίηση μετρητών επαναλήψεων και υπολογισμών
    iterations_1 = 1;
    iterations_2 = 1;
    iterations_3 = 1;
    calculations_1 = 0; % Υπολογισμοί για f1
    calculations_2 = 0; % Υπολογισμοί για f2
    calculations_3 = 0; % Υπολογισμοί για f3

    % Ορισμός σταθεράς γ για τη μέθοδο του Χρυσού Τομέα
    gamma = 0.618;

    % Αρχικοποίηση ορίων αναζήτησης
    lower_1 = lower;
    upper_1 = upper;
    lower_2 = lower;
    upper_2 = upper;
    lower_3 = lower;
    upper_3 = upper;

    % Αποθήκευση των αρχικών ορίων
    lower_limits(i, 1, :) = [lower_1 lower_2 lower_3];
    upper_limits(i, 1, :) = [upper_3 upper_3 upper_3];

    % Υλοποίηση της μεθόδου για τη συνάρτηση f1
    lower_value_1 = f1(lower_1 + (1 - gamma) * (upper_1 - lower_1));
    upper_value_1 = f1(lower_1 + gamma * (upper_1 - lower_1));
    while upper_1 - lower_1 >= l
        if lower_value_1 > upper_value_1
            lower_1 = lower_1 + (1 - gamma) * (upper_1 - lower_1);
            lower_value_1 = upper_value_1;
            upper_value_1 = f1(lower_1 + gamma * (upper_1 - lower_1));
        else
            upper_1 = lower_1 + gamma * (upper_1 - lower_1);
            upper_value_1 = lower_value_1;
            lower_value_1 = f1(lower_1 + (1 - gamma) * (upper_1 - lower_1));
        end

        % Ενημέρωση μετρητών επαναλήψεων και υπολογισμών
        iterations_1 = iterations_1 + 1;
        calculations_1 = calculations_1 + 1;

        % Αποθήκευση των νέων ορίων
        lower_limits(i, iterations_1, 1) = lower_1;
        upper_limits(i, iterations_1, 1) = upper_1;
    end

    % Υλοποίηση της μεθόδου για τη συνάρτηση f2
    lower_value_2 = f2(lower_2 + (1 - gamma) * (upper_2 - lower_2));
    upper_value_2 = f2(lower_2 + gamma * (upper_2 - lower_2));
    while upper_2 - lower_2 >= l
        if lower_value_2 > upper_value_2
            lower_2 = lower_2 + (1 - gamma) * (upper_2 - lower_2);
            lower_value_2 = upper_value_2;
            upper_value_2 = f2(lower_2 + gamma * (upper_2 - lower_2));
        else
            upper_2 = lower_2 + gamma * (upper_2 - lower_2);
            upper_value_2 = lower_value_2;
            lower_value_2 = f2(lower_2 + (1 - gamma) * (upper_2 - lower_2));
        end

        % Ενημέρωση μετρητών επαναλήψεων και υπολογισμών
        iterations_2 = iterations_2 + 1;
        calculations_2 = calculations_2 + 1;

        % Αποθήκευση των νέων ορίων
        lower_limits(i, iterations_2, 2) = lower_2;
        upper_limits(i, iterations_2, 2) = upper_2;
    end

    % Υλοποίηση της μεθόδου για τη συνάρτηση f3
    lower_value_3 = f3(lower_3 + (1 - gamma) * (upper_3 - lower_3));
    upper_value_3 = f3(lower_3 + gamma * (upper_3 - lower_3));
    while upper_3 - lower_3 >= l
        if lower_value_3 > upper_value_3
            lower_3 = lower_3 + (1 - gamma) * (upper_3 - lower_3);
            lower_value_3 = upper_value_3;
            upper_value_3 = f3(lower_3 + gamma * (upper_3 - lower_3));
        else
            upper_3 = lower_3 + gamma * (upper_3 - lower_3);
            upper_value_3 = lower_value_3;
            lower_value_3 = f3(lower_3 + (1 - gamma) * (upper_3 - lower_3));
        end

        % Ενημέρωση μετρητών επαναλήψεων και υπολογισμών
        iterations_3 = iterations_3 + 1;
        calculations_3 = calculations_3 + 1;

        % Αποθήκευση των νέων ορίων
        lower_limits(i, iterations_3, 3) = lower_3;
        upper_limits(i, iterations_3, 3) = upper_3;
    end

    % Αποθήκευση αποτελεσμάτων επαναλήψεων και υπολογισμών
    iterations(i, :) = [iterations_1 iterations_2 iterations_3];
    calculations(i, :) = [calculations_1 calculations_2 calculations_3];
end

% Σχεδίαση γραφημάτων για τον αριθμό των επαναλήψεων
figure("Name", "Number of iterations")
plot(ls, iterations(:, 1), ls, iterations(:, 2), ls, iterations(:, 3));
xlabel("l");
ylabel("Number of iterations");
legend("f1", "f2", "f3");

% Σχεδίαση γραφημάτων για τον αριθμό των υπολογισμών
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


plot_l_idx = 1;
figure("Name", sprintf("f2, Lower and Upper search limit, l = %f", ls(plot_l_idx)))
plot(1:iterations(plot_l_idx, 2), lower_limits(plot_l_idx, 1:iterations(plot_l_idx, 2), 2), ...
    1:iterations(plot_l_idx, 2), upper_limits(plot_l_idx, 1:iterations(plot_l_idx, 2), 2) ...
    );
xlabel("Number of iterations");
ylabel("Interval");
legend("l(f2)", "u(f2)");


plot_l_idx = 1;
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