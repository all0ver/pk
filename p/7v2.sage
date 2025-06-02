# dowody o wiedzy

import random

p = next_prime(2^16)
F = GF(p)

a = F.random_element()

while a.multiplicative_order() != (p-1):
    a = F.random_element()

x = F.random_element()
while gcd(x, p-1) != 1:
    x = F.random_element()

b = pow(a, x, p)

print("p = ", p)
print("a = ", a)
print("b = ", b)
print("x = ", x)

for i in range(1, 5):
    print()
    print()
    print()
    print("iteraja: ", i)
    print("krok 1. a wybiera liczbe losowa r i oblicza: h = a^r")
    r = F.random_element()
    h = a^r
    print("h = ", h)

    print("h jest przyslane do B")

    print()
    print("krok 2. b przysla uzytkownikowi A losowy bit k")
    # k = F.random_element()
    k = random.randint(0, 1)
    print("k = ", k)

    print()
    print("krok 3. uzytkownik a oblicza s = r+kx (mod p-1)")

    s = (int(r)+int(k)*int(x))%(p-1)

    print("s = ", s)

    print("s jest przeslane d oB")

    print("krok 4. b potwierdza ze a^s = hb^k (mod p)")
    asmodp = a^s
    hbk = (h*b^k)%p

    if (asmodp == hbk):
        print("potwierdzone")
    else:
        print("!!!NIE!!!")