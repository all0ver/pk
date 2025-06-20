

# This file was *autogenerated* from the file 7.sage
from sage.all_cmdline import *   # import sage library

_sage_const_2 = Integer(2); _sage_const_8 = Integer(8); _sage_const_1 = Integer(1); _sage_const_4 = Integer(4); _sage_const_0 = Integer(0)# dowody o wiedzy

import random

p = next_prime(_sage_const_2 **_sage_const_8 )
F = GF(p)
x = random.randint(_sage_const_2 ,p-_sage_const_1 )
a = F.random_element()
while a.multiplicative_order() != p-_sage_const_1 :
    a = F.random_element()

b = pow(a, x, p)

print("a = ", a)
print("b = ", b)
print("p = ", p)
print("x = ", x)

for i in range(_sage_const_1 ,_sage_const_4 ):
    print()
    print()
    print()
    print("iteracja: ", i)
    print("Krok 1. uzytkownik A wybiera liczbe losowa r taka, ze r jest mniejsze od p-1, oblicza h=a^r")
    r = random.randint(_sage_const_2 , p-_sage_const_1 )

    # h = a^r
    h = pow(a, r, p)

    print("h = ", h)
    print("A wysyla B h")

    print()
    print("Krok 2. uzytkownik B przesyla uzytkownikowi A losowy bit k")
    # k = random.randint(2, p-1)
    k = random.randint(_sage_const_0 , _sage_const_1 )
    print("k = ", k)

    print()
    print("Krok 3. uzytkownik A oblicza: s = r+kx (mod p-1)")

    s = (r+k*x)%(p-_sage_const_1 )
    print("s = ", s)
    print("s zostaje przeslane do B")

    print("Krok 4. uzytkownik B potwierdza ze: a^s = hb^k (mod p)")
    asmodp = pow(a, s, p)
    hbk = (h*pow(b, k, p))%p
    if asmodp == hbk:
        print("wartosc potwierdzona")
    print("as = ", asmodp)
    print("bh^k = ", hbk)


