# Βελτιστοποίηση και Αλγόριθμοι Αναζήτησης

Αυτό το repository περιέχει δύο εργασίες που εκπονήθηκαν στο πλαίσιο του μαθήματος **Τεχνικές Βελτιστοποίησης**, με πλήρεις υλοποιήσεις και προσομοιώσεις σε MATLAB καθώς και αναφορές σε LaTeX.

## Περιεχόμενα

### 1. Εργασία 1: Ελαχιστοποίηση Κυρτής Συνάρτησης Μίας Μεταβλητής
**Περιγραφή:**  
Η εργασία επικεντρώνεται στην ελαχιστοποίηση κυρτών συναρτήσεων μίας μεταβλητής σε συγκεκριμένο διάστημα με τη χρήση διαφόρων αλγορίθμων, με ή χωρίς παραγώγους.

**Αλγόριθμοι που υλοποιούνται:**
- Μέθοδοι χωρίς χρήση παραγώγων:
  - Διχοτόμου
  - Χρυσού Τομέα
  - Fibonacci
- Μέθοδος με χρήση παραγώγων:
  - Διχοτόμου με χρήση παραγώγου

**Δεδομένα και Αποτελέσματα:**
- Ελαχιστοποίηση τριών κυρτών συναρτήσεων:
  1. \( f_1(x) = (x - 2)^2 + x \cdot \ln(x + 3) \)
  2. \( f_2(x) = e^x + (x - 2)^2 \)
  3. \( f_3(x) = e^x \cdot (x - 1) + (x - 1)^2 \cdot \sin(x) \)
- Γραφικές παραστάσεις:
  - Μεταβολές της αντικειμενικής συνάρτησης ανά αλγόριθμο.
  - Εξέλιξη των ορίων του διαστήματος αναζήτησης.

**Περιεχόμενα φακέλου:**
- Κώδικες MATLAB για κάθε αλγόριθμο.
- Αναφορά σε LaTeX που περιλαμβάνει τα αποτελέσματα, διαγράμματα και συγκριτική ανάλυση.

---

### 2. Εργασία 2: Ελαχιστοποίηση Συναρτήσεων Πολλών Μεταβλητών Χωρίς Περιορισμούς
**Περιγραφή:**  
Η εργασία αφορά την ελαχιστοποίηση συναρτήσεων πολλών μεταβλητών με χρήση παραγώγων και επαναληπτικών μεθόδων καθόδου.

**Αλγόριθμοι που υλοποιούνται:**
- Μέγιστης Καθόδου (Steepest Descent)
- Newton
- Levenberg-Marquardt

**Δεδομένα και Αποτελέσματα:**
- Στόχος: Ελαχιστοποίηση της συνάρτησης \( f(x, y) = x^2 \cdot e^y \).
- Ανάλυση:
  - Σύγκριση αποτελεσμάτων ανάλογα με το αρχικό σημείο εκκίνησης και την επιλογή βήματος (\(\gamma\)).
  - Επιλογές βήματος:
    - Σταθερό
    - Ελαχιστοποίηση της \( f(x + \gamma \cdot d) \)
    - Βάσει του κανόνα Armijo

**Περιεχόμενα φακέλου:**
- Κώδικες MATLAB για κάθε αλγόριθμο.
- Αναφορά σε LaTeX που περιλαμβάνει τις προσομοιώσεις, γραφήματα σύγκλισης και ανάλυση απόδοσης.

---


## Οδηγίες Χρήσης

1. **MATLAB**:
   - Εισάγετε τους φακέλους `MATLAB_1` και `MATLAB_2` στο MATLAB workspace.
   - Εκτελέστε τα αντίστοιχα scripts για να παραχθούν οι γραφικές παραστάσεις και τα αποτελέσματα.

2. **Αναφορές**:
   - Τα αρχεία PDF παρέχουν λεπτομερή περιγραφή, γραφικά και ανάλυση των αποτελεσμάτων.

3. **Επεκτάσεις**:
   - Οι κώδικες είναι σχεδιασμένοι για εύκολη προσαρμογή σε νέες συναρτήσεις ή άλλες μεθόδους βελτιστοποίησης.

