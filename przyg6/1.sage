# Mateusz Karpiński
# WCY23KY1S1
# ślepe podpisy cyfrowe
# bazujacy na schemacie nyberg-rueppel

import random

print("Zalozenia:")
print("Wylosowanie liczby pierwszej p, duzego pierwszego dzielnika q liczby p-1 oraz generatora g, nalezacego do F_p rzedu q")

q = random_prime(2^16, 2^32)


while True:
    p = 2*q+1
    if is_prime(p):
        break
    q = next_prime(p)

F = GF(p)

while True:
    g = F.random_element()
    if g.multiplicative_order() == q:
        break

print("q = ", q)
print("p = ", p)
print("g = ", g)
print()
print()
print()
print("Wygenerowanie klucza publicznego i prywanego uzytkownika B")

x = randint(1, q-1)
y = power_mod(g, x, p)

print("Klucza uzytkownika B:")
print("Klucz prywatny x: ", x)
print("Klucz publiczny y: ", y)

print("Generacja podpisu")
m = random.randint(1, q-1)
print("Wiadomosc m: ", m)
print()
print("Krok 1. Podpisujacy B wybera losowo k i oblicza R = g^k mod p. Jezeli NWD(R, q) = 1, to wysyła R do A")
k = random.randint(1, q-1)
R = power_mod(g, k, p)
if gcd(R, q) == 1:
    print("Wartosc R jest wysylana przez B do A")
print()
print("Krok 2. A sprawdza czy NWD(R, q) == 1")
if gcd(R, q) == 1:
    print("A sprawdzilo i NWD(R, q) == 1 to prawda")
while True:
    print()
    print("Krok 3.1 A losuje liczby a nalezy do Z_q i b nalezy do Z_q^*")
    a = randint(0, q - 1)
    b = randint(1, q - 1)  
    print("a =", a)
    print("b =", b)

    print()
    print("Krok 3.2 A oblicza r = m * g^a * R^b (mod p)")
    r = (m * power_mod(g, a, p) * power_mod(R, b, p)) % p
    print("r =", r)

    print()
    print("Krok 4. A oblicza m' = r * b^(-1) mod q i sprawdza czy m' nalezy do  {1, ..., q-1}")
    b_inv = inverse_mod(b, q)  # mod q, nie mod p!
    m1 = (int(r) * b_inv) % q

    if 1 <= m1 <= q - 1:
        print("Warunek spelniony, A wysyla m' do B")
        break
    else:
        print("m' nie nalezy do {1,...,q-1}, wracamy do Kroku 3")

print()
print("Krok 5. B wyznacza podpis: s' = m'*x+k (mod p)")
s1 = (m1*x+k)%q
print("s' = ", s1)
print()
print("Krok 6. A usuwa zaciemnienie: (s'*b+a) (mod q)")
s = (s1*b+a)%q
print("s = ", s)

print(f"Podpis: (r, s) = ({r}, {s})")

print()
print()
print()
print("Weryfikacja podpisu")
print()
print("Krok W1. C oblicza m'' = g^(-s)*y^r*r (mod p)")
m2 = (power_mod(int(g), int(-s), p)*power_mod(int(y), int(r), p)*int(r))%p
print("m'' = ", m2)

print()
print("Krok W2. C sprawdza czy m'' = m (mod p) (kongruencja)")

if (m2%p == m):
    print("Weryfikacja poprawna m'' = m (mod p) - podpis jest poprawny")
else:
    print("m = ", m2%p)