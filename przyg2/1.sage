# Mateusz Karpiński
# WCY23KY1S1
# Laboratoria 2 - protokol Lamporta
import hashlib as h
import hmac 
import binascii
import random

# wytyczne:
# 1. funkcja jednokierunkowa -> sha3_512
# 2. parametrem wejściowym jest liczba iteracji n (np 10). Protokół powinien być wykonany t razy gdzie t <= n (np t = 4)

# funkcja skrotu
def f(x):
    d = h.sha3_512()
    d.update(str(x).encode())
    return d.hexdigest()

# pobranie n oraz wylosowanie t
# n = int(input("Podaj liczbe iteracji n: "))
n = random.randint(5,11)
t = random.randint(2, n+1)
print("Wylosowanie n oraz t:")
print("n: ", n)
print("t: ", t)

# utworzenie listy z n hasłami/identyfikatorami, oraz stworznie x0 i dodanie do niego pierwszego elementu: Mateusz Karpinski
x0 = str(random.randint(1, 999))
x = [x0]

# wygenerowanie n iteracji funkcji f (sha3_512)
for i in range(1, n+1):
    x.append(f(x[i-1]))

print("Tablica x:")
for i in range (0, n+1):
    print("\n", i+1, ". ", x[i])

# podanie wartosci x_n systemowi
x_n = x[-1]
x_k_saved = x_n
print("Uzytkownik: przesyla x_n systemowi (pierwsze x_k)")
print("\nx_n: ", x_n, "\n\n")

# kroki:


for i in range(1, t+1):
    print("\n\nStart: ")
    # 1. użytkownik przesyła aktualny identyfikator x_k
    print("K1: Uzytkownik: przesyla x_k do systemu")
    x_k = x[-i]
    # 2. system sprawdza istnienie użytkownika o otrzymanym identyfikatorze, po czym żąda podania hasła x_k-1
    print("K2: System: sprawdzenie czy istnieje identyfikator taki jaki otrzymany")
    if x_k == x_k_saved:
        print("K2: System: Istnieje taki identyfikator wyslanie zapytania do uzytkownika o haslo - x_k-1")
        # 3. użytkownik przesyła hasło x_k-1
        print("K3: Uzytkownik: wysyla haslo")
        x_k1 = x[-i-1]
        x_test = f(x_k1)
        # 4. system weryfikuje poprawność hasła, sprawdając czy f(x_k-1) = x_k, jeśli tak, to zapamiętuje x_k-1 jako identyfikator przy następnym logowaniu
        if x_test == x_k:
            print("K4: System: Podane x_k: ", x_k)
            print("K4: System: Podane x_k-1: ", x_k1)
            print("K4: System: Obliczne x_k z podanego x_k1: ", x_test)
            print("K4: System: Logowanie powiodlo sie, haslo oraz identyfkiator zgadzaja sie")
            print("\nK4: System: zapamietanie x_k-1, jako nowego identyfikatora")
            x_k_saved = x_k1
        else:
            print("System: identyfkiator i haslo nie zgadzaja sie")
            break
    else:
        print("System: Blad brak podanego identyfikatora")
        break
    print("Koniec")