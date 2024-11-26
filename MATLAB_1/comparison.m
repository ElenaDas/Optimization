% Εκτέλεση της μεθόδου διχοτόμησης
Alg_Of_Bisection;

% Αποθήκευση των υπολογισμών για τη μέθοδο διχοτόμησης
calculations_Alg_Of_Bisection = (iterations_variable_l_const_e(:, 1) - 1) * 2;

% Εκτέλεση της μεθόδου χρυσής τομής
Alg_Of_Golden_Section;

% Αποθήκευση των υπολογισμών για τη μέθοδο χρυσής τομής
calculations_Alg_Of_Golden_Section = calculations(:, 1);

% Εκτέλεση της μεθόδου Fibonacci
Alg_Of_Fibonacci;

% Αποθήκευση των υπολογισμών για τη μέθοδο Fibonacci
calculations_Alg_Of_Fibonacci = calculations(:, 1);

% Εκτέλεση της μεθόδου διχοτόμησης με χρήση παραγώγων
Alg_Of_Bisection_Der;

% Αποθήκευση των υπολογισμών για τη μέθοδο διχοτόμησης με χρήση παραγώγων
calculations_Alg_Of_Bisection_Der = calculations(:, 1);

% Δημιουργία του τελικού γραφήματος που συγκρίνει τον αριθμό υπολογισμών
figure("Name", "Number of calculations")
plot(ls, calculations_Alg_Of_Bisection, ... % Γραμμή για τη μέθοδο διχοτόμησης
    ls, calculations_Alg_Of_Golden_Section, ... % Γραμμή για τη μέθοδο χρυσής τομής
    ls, calculations_Alg_Of_Fibonacci, ... % Γραμμή για τη μέθοδο Fibonacci
    ls, calculations_Alg_Of_Bisection_Der... % Γραμμή για τη μέθοδο διχοτόμησης με παράγωγο
    );
xlabel("l"); % Ετικέτα του άξονα x
ylabel("Number of calculations"); % Ετικέτα του άξονα y
legend("Bicection", "Golden Section", "Fibonacci", "Bicection with Derivative"); % Υπόμνημα γραφήματος

% Κλείσιμο όλων των ανοιχτών παραθύρων γραφημάτων
close all;
