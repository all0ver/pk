# dowody o wiedzy

import random

p = next_prime(2^8)
F = GF(p)
x = random.randint(2,p-1)
a = F.random_element()
while a.multiplicative_order() != p-1:
    a = F.random_element()

b = pow(a, x, p)

print("a = ", a)
print("b = ", b)
print("p = ", p)
print("x = ", x)

for i in range(1,4):
    print()
    print()
    print()
    print("iteracja: ", i)
    print("Krok 1. uzytkownik A wybiera liczbe losowa r taka, ze r jest mniejsze od p-1, oblicza h=a^r")
    r = random.randint(2, p-1)

    # h = a^r
    h = pow(a, r, p)

    print("h = ", h)
    print("A wysyla B h")

    print()
    print("Krok 2. uzytkownik B przesyla uzytkownikowi A losowy bit k")
    # k = random.randint(2, p-1)
    k = random.randint(0, 1)
    print("k = ", k)

    print()
    print("Krok 3. uzytkownik A oblicza: s = r+kx (mod p-1)")

    s = (r+k*x)%(p-1)
    print("s = ", s)
    print("s zostaje przeslane do B")

    print("Krok 4. uzytkownik B potwierdza ze: a^s = hb^k (mod p)")
    asmodp = pow(a, s, p)
    hbk = (h*pow(b, k, p))%p
    if asmodp == hbk:
        print("wartosc potwierdzona")
    print("as = ", asmodp)
    print("bh^k = ", hbk)

