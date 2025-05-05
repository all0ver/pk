# Mateusz Karpiński
# WCY23KY1S1
# Laboratoria 2 - protokol Lamporta z wieloma użytkownikami (łącznie t logowań)

import hashlib as h
import random

# funkcja skrotu
def f(x):
    d = h.sha3_512()
    d.update(str(x).encode())
    return d.hexdigest()

# pobranie n oraz wylosowanie
n = 10
t = random.randint(2, n+1)
l = random.randint(2,4)
print("Wylosowanie n oraz t:")
print("n: ", n)
print("t: ", t)
print("l: ", l)

# utworzenie listy uzytkownikow
users = {}         
# tablica identyfikatorow
x_k_saved = {}     
# ile razy dany uzytkownik sie zalogowa
login_index = {}

for u in range(1, l + 1):
    # wygenerowanie x0
    x0 = str(random.randint(1, 999)) 
    # dodanie pierwszego elementu do listy
    x = [x0] 
    for i in range(1, n+1):           
        # wygenerowanie n iteracji funkcji f (sha3_512)
        x.append(f(x[i-1]))
    # utworzenie nazwy nowego uzytkownika
    user = f"u{u}"
    # utworzenie tablicy z podtablicami uzytkownikow
    users[user] = x
    # zapisane pierwszych identyfikatorow (x_n) uzytkownikow
    x_k_saved[user] = x[-1]
    # na poczatku uzytkownik nie logowal sie
    login_index[user] = 0      

    # wypisanie calej listy
    print(f"\nTablica x dla {user}:")
    for i in range(0, n+1):
        print(f"{i+1}. {x[i]}")

# calkowita liczba logowan
logowanie = 0

# petala logowan
while logowanie < t:
    print(f"\nLiczba pozostalych logowan: {t - logowanie}")
    print("Lista użytkownikow:")
    for user in users:
        print("-", user)

    wybrany = random.choice(list(users.keys()))
    print("Wybrany uzytkownik: ", wybrany)

    print("\n\nStart: ")
    # 1. użytkownik przesyła aktualny identyfikator x_k
    i = login_index[wybrany]
    x_k = users[wybrany][n - i]
    print("K1: Uzytkownik: przesyla x_k do systemu: ", x_k)

    # 2. system sprawdza istnienie użytkownika o otrzymanym identyfikatorze, po czym żąda podania hasła x_k-1
    print("K2: System: sprawdzenie czy istnieje identyfikator taki jaki otrzymany")
    if x_k == x_k_saved[wybrany]:
        print("K2: System: Istnieje taki identyfikator wyslanie zapytania do uzytkownika o haslo - x_k-1")
        # 3. użytkownik przesyła hasło x_k-1
        x_k1 = users[wybrany][n - i - 1]
        x_test = f(x_k1)
        print("K3: Uzytkownik: wysyla haslo: x_k-1: ", x_k1)

        # 4. system weryfikuje poprawność hasła, sprawdzając czy f(x_k-1) = x_k
        if x_test == x_k:
            print("K4: System: Podane x_k: ", x_k)
            print("K4: System: Podane x_k-1: ", x_k1)
            print("K4: System: Obliczne x_k z podanego x_k1: ", x_test)
            print("K4: System: Logowanie powiodlo sie, haslo oraz identyfikator zgadzaja sie")
            print("\nK4: System: zapamietanie x_k-1, jako nowego identyfikatora")
            x_k_saved[wybrany] = x_k1
            logowanie += 1
            login_index[wybrany] += 1
        else:
            print("System: identyfikator i haslo nie zgadzaja sie")
    else:
        print("System: Blad brak podanego identyfikatora")

    print("Koniec krokow\n")

