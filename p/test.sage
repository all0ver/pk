# Dowód o wiedzy logarytmu dyskretnego — SageMath
# Imię i nazwisko: [TWOJE DANE]
# Grupa: [TWOJA GRUPA]

from random import randint

# --- Krok 1: Generacja parametrów ---
def generuj_parametry(bit_length=10):
    # Znajdź losową liczbę pierwszą p
    p = random_prime(2^bit_length, lbound=2^(bit_length-1))
    
    # Ciało F_p
    F = GF(p)
    
    # Znajdź generator grupy multiplikatywnej
    a = F.multiplicative_generator()
    
    # Losowe x < p-1, x względnie pierwsze z p-1
    while True:
        x = randint(2, p-2)
        if gcd(x, p-1) == 1:
            break
    
    b = a^x  # b = a^x mod p

    return p, a, b, x

# --- Krok 2: Jedna runda protokołu ---
def wykonaj_runde(p, a, b, x):
    F = GF(p)

    # A wybiera losowe r
    r = randint(1, p - 2)
    h = a^r
    print("Krok 1 (A): r =", r, ", h = a^r =", h)
    
    # B wybiera losowy bit k
    k = randint(0, 1)
    print("Krok 2 (B): k =", k)
    
    # A oblicza s = r + kx mod (p-1)
    s = (r + k * x) % (p - 1)
    print("Krok 3 (A): s =", s)
    
    # B sprawdza warunek: a^s == h * b^k mod p
    lewa = a^s
    prawa = h * b^k
    print("Krok 4 (B): Sprawdzenie: a^s =", lewa, ", h * b^k =", prawa)
    print(">>> Wynik:", "OK" if lewa == prawa else "NIEPOWODZENIE")

# --- Wykonanie całego protokołu ---
def protokol(t=5, bit_length=10):
    p, a, b, x = generuj_parametry(bit_length)
    print("Parametry: p =", p)
    print("a =", a)
    print("b = a^x =", b)
    print("x (tajne) =", x)
    print("----------\n")

    for i in range(1, t+1):
        print("=== RUNDA", i, "===")
        wykonaj_runde(p, a, b, x)
        print("")

# Uruchomienie protokołu z 5 rundami
protokol(t=5, bit_length=10)
