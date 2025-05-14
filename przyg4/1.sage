# Mateusz Karpiński
# WCY23KY1S1
# Laboratoria 4

# generacja podpisu

import random 

print("Zalozenia")

print("Wylosowanie liczby pierwszej p i q")
while True:
    q = random_prime(2^16, 2^32)
    p = 2*q+1
    if (is_prime(p) == 1):
        break

print("p: ", p)
print("q: ", q)
print("Zdefiniowanie ciala F_p")
F = GF(p)

print("Znalezienie generatora g podgrupy cyklicznej rzedu q")
# while True:
#     a = F.primitive_element()
#     g = a^2%p
#     if pow(g, q, p) == 1 and g != 1:
#         break
while True:
    h = random.randint(2, p-1)
    g = (h^((p-1)/q))%p
    if (g != 1):
        break

print("g: ", g)

print("Generowanie kluczy prywatnych x,z z przedzialu  <1, ..., q-1>")
x = random.randint(1, q)
z = random.randint(1, q)

print("Generowanie kluczy publicznych y = g^x oraz u = g^z")
y = (g^x)%p
u = (g^z)%p
print("Pierwsza para kluczy")
print("x = ", x)
print("y = ", y)
print("Druga para kluczy")
print("z = ", z)
print("u = ", u)

m = random.randint(2^20, 2^30)
print("Wiadomosc m: ", m)


print()
print()
print()
print("Generacja podpisu")
print("K1. A wybiera losowe t z przedzialu <1, ..., q-1>")
t = random.randint(1, q-1)
print("t = ", t)

print("A oblicza T = g^t (mod p) i m' = Ttzm (mod q)")

T = (g^t)%p
ma = (Integer(T) * t * z * m) % q

print("T = ", T)
print("m' = ", ma)

print()
print("K2. A wybiera losowe R z przedzialu: <1, ..., p-2>, gdzie NWD(R, p-1) = 1")
while True:
    R = random.randint(1, p-2)
    if gcd(R, p-1) == 1:
        break
print("R = ", R)

print("K2. A oblicza r = g^R (mod p)")
r = (g^R)%p
print("r = ", r)

print()
print("K3. A oblicza s, ktore spelnia: m' = rx+Rs (mod q)")

R1 = pow(R, -1, q)
# s = ((ma-(Integer(r)*x)%q)%q) * R1%q
s = ((ma-(Integer(r)*x))/R)%q

print("s = ", s)

# Sprawdzenie poprawności obliczenia s
lewa_strona = ma
prawa_strona = (Integer(r) * x + R * s) % q
if lewa_strona == prawa_strona:
    print("Rownanie m' = rx + Rs (mod q) jest spelnione.")
else:
    print("blad l != p")
    print("m' =", ma)
    print("rx + Rs =", prawa_strona)

print("Podpis A = <(r, s), T>:")
print(f"<({r}, {s}), {T}")


# weryfikacja podpisu
print()
print()
print()
print("Weryfikacja podpisu")

print()
print("K1. Uzytkownik B wytwarza dwie liczby losowe a i b. Oblicza: c = T^(T*m*a)*g^b (mod p) i przesyla c do A")
a = random.randint(1, 2^20)
b = random.randint(1, 2^20)
# c = (T^(T*m*a)*g^b)%p
c = (pow(T, T*m*a, p) * pow(g, b, p)) % p

print("a = ", a)
print("b = ", b)
print("c = ", c)

print()
print("K2. Uzytkownik A wytwarza liczbe losowa k i oblicza:")
k = random.randint(1, 2^20)
print("h1 = c*g^k (mod p)")
print("h2 = h1^z (mod p)")

print("k = ", k)
h1 = (c*(g^k))%p
h2 = (h1^z)%p

print("h1 = ", h1)
print("h2 = ", h2)
print("Nastepuje przeslanie h1 i h2 do B")

print()
print("K3. Uzytkownik B przesyla do A wartosci a i b")
print("a = ", a)
print("b = ", b)

print()
print("K4. uzytkownik A sprawdza czy: c = T^(T*m*a)*g^b (mod p), jezeli tak to przsyla k do uzytkownika B, jezeli nie to koniec")

# ca = (T^(T*m*a)*g^b)%p
ca = (pow(T, T*m*a, p) * pow(g, b, p)) % p
if ca != c:
    print("Weryfikacja c nie powiodła się")
    # Przerwij protokół
else:
    print("Weryfikacja c poprawna, A wysyła k do B")
    # Kontynuuj z krokiem 5
print()
print("K5. Uzytkownik B oblicza: ")
print("h1^ = T^(T*m*a)*g^(b+k) (mod p)")
print("h2^ = y^(r*a)*r^(s*a)*u(b+k) (mod p)")

# h1b = (T**(T*m*a)*g**(b+k))%p
# h2b = (y**(r*a) * r**(s*a) * u**(b+k)) % p
# h2b = (y^(r*a)*r^(s*a)*u^(b+k))%p
h1b = (pow(T, T*m*a, p) * pow(g, b+k, p)) % p
h2b = (pow(y, r*a, p) * pow(r, s*a, p) * pow(u, b+k, p)) % p
print()
print()
print()
print("Obliczone wartosci:")
print("h1^ = ", h1b)
print("h1 = ", h1)
print("h2^ = ", h2b)
print("h2 = ", h2)


if h1 == h1b:
    print("h1 sie zgadza")

if h2 == h2b:
    print("h2 sie zgadza")

if h2 == h2b and h1 == h1b:
    print("Podpis zostal potwierdzony")