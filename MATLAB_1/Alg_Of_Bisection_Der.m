 clear; % Καθαρισμός του workspace
clc; % Εκκαθάριση της κονσόλας

% Ορισμός συναρτήσεων με χρήση του συμβολικού toolbox
syms f1(x);
syms f2(x);
syms f3(x);
f1(x) = (x - 2)^2 + x * log(x + 3); % Ορισμός της συνάρτησης f1
f2(x) = exp(-2*x) + (x-2)^2; % Ορισμός της συνάρτησης f2
f3(x) = exp(x) * (x^3 - 1) + (x - 1) * sin(x); % Ορισμός της συνάρτησης f3

% Υπολογισμός της πρώτης παραγώγου των συναρτήσεων
df1 = diff(f1);
df2 = diff(f2);
df3 = diff(f3);

% Ορισμός των κάτω και άνω ορίων αναζήτησης
lower = -1; % Κάτω όριο
upper = 3; % Άνω όριο

% Καθορισμός παραμέτρων για το l
n_l = 100; % Αριθμός διαφορετικών τιμών για το l
start_l = 0.001; % Αρχική τιμή του l
end_l = 0.1; % Τελική τιμή του l

% Δημιουργία διανύσματος για τις τιμές του l
ls = linspace(start_l, end_l, n_l);

% Αρχικοποίηση πινάκων για την αποθήκευση επαναλήψεων, υπολογισμών και ορίων
iterations = zeros([n_l 3]);
calculations = zeros([n_l 3]);
lower_limits = zeros([n_l 1 3]);
upper_limits = zeros([n_l 1 3]);

% Βρόχος για κάθε τιμή του l
for i = 1:n_l
    % Λήψη της τρέχουσας τιμής του l
    l = ls(i);

    % Αρχικοποίηση του αριθμού επαναλήψεων για κάθε συνάρτηση
    iterations_1 = 1;
    iterations_2 = 1;
    iterations_3 = 1;

    % Αρχικοποίηση του αριθμού υπολογισμών για κάθε συνάρτηση
    calculations_1 = 0;
    calculations_2 = 0;
    calculations_3 = 0;

    % Ορισμός αρχικών ορίων αναζήτησης για κάθε συνάρτηση
    lower_1 = lower;
    upper_1 = upper;
    lower_2 = lower;
    upper_2 = upper;
    lower_3 = lower;
    upper_3 = upper;

    % Αποθήκευση των αρχικών ορίων
    lower_limits(i, 1, :) = [lower_1 lower_2 lower_3];
    upper_limits(i, 1, :) = [upper_3 upper_3 upper_3];

    % Υλοποίηση της μεθόδου διχοτόμησης για τη συνάρτηση f1
    while upper_1 - lower_1 >= l
        midpoint = (upper_1 + lower_1) / 2; % Υπολογισμός του μέσου σημείου
        der_f1 = df1(midpoint); % Υπολογισμός της παραγώγου στο μέσο σημείο
        if der_f1 > 0
            upper_1 = midpoint; % Ενημέρωση του άνω ορίου αν η παράγωγος είναι θετική
        elseif der_f1 < 0
            lower_1 = midpoint; % Ενημέρωση του κάτω ορίου αν η παράγωγος είναι αρνητική
        else
           % Διακοπή του βρόχου αν η παράγωγος είναι μηδέν (το μέσο σημείο είναι τοπικό ελάχιστο)
           upper_1 = midpoint;
           lower_1 = midpoint;
        end

        iterations_1 = iterations_1 + 1; % Αύξηση του αριθμού επαναλήψεων
        calculations_1 = calculations_1 + 1; % Αύξηση του αριθμού υπολογισμών

        % Αποθήκευση των ορίων αναζήτησης
        lower_limits(i, iterations_1, 1) = lower_1;
        upper_limits(i, iterations_1, 1) = upper_1;
    end

    % Ανάλογη διαδικασία για τη συνάρτηση f2
    while upper_2 - lower_2 >= l
        midpoint = (upper_2 + lower_2) / 2;
        der_f2 = df2(midpoint);
        if der_f2 > 0
           upper_2 = midpoint;
        elseif der_f2 < 0
           lower_2 = midpoint;
        else
            upper_2 = midpoint;
            lower_2 = midpoint;
        end

        iterations_2 = iterations_2 + 1;
        calculations_2 = calculations_2 + 1;

        lower_limits(i, iterations_2, 2) = lower_2;
        upper_limits(i, iterations_2, 2) = upper_2;
    end

    % Ανάλογη διαδικασία για τη συνάρτηση f3
    while upper_3 - lower_3 >= l
        midpoint = (upper_3 + lower_3) / 2;
        der_f3 = df3(midpoint);
        if der_f3 > 0
           upper_3 = midpoint;
        elseif der_f3 < 0
           lower_3 = midpoint;
        else
            upper_3 = midpoint;
            lower_3 = midpoint;
        end

        iterations_3 = iterations_3 + 1;
        calculations_3 = calculations_3 + 1;

        lower_limits(i, iterations_3, 3) = lower_3;
        upper_limits(i, iterations_3, 3) = upper_3;
    end

    % Αποθήκευση του αριθμού επαναλήψεων και υπολογισμών
    iterations(i, :) = [iterations_1 iterations_2 iterations_3];
    calculations(i, :) = [calculations_1 calculations_2 calculations_3];
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

% Σχεδίαση γραφημάτων για τα όρια αναζήτησης για διάφορες τιμές του l
plot_l_idx = 1;
figure("Name", sprintf("f1, Lower and Upper search limit, l = %f", ls(plot_l_idx)))
plot(1:iterations(plot_l_idx, 1), lower_limits(plot_l_idx, 1:iterations(plot_l_idx, 1), 1), ...
    1:iterations(plot_l_idx, 1), upper_limits(plot_l_idx, 1:iterations(plot_l_idx, 1), 1));
xlabel("Number of iterations");
ylabel("Interval");
legend("l(f1)", "u(f1)");

% Ανάλογη διαδικασία για τις συναρτήσεις f2 και f3
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