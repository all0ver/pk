# Mateusz Karpiński WCY23KY1S1
# na 4 punkty do 8 kwietnia 

import random


b = 128
n = next_prime(1*10^15)
p = 2*n+1
while not is_prime(p):
    n = next_prime(n)
    p = 2*n+1

print("\nWyznaczenie liczby pierwszej n oraz liczby pierwszej p = 2n+1:\n")
print("\nOtrzymana liczban: ", n)
print("\nOtrzymana liczba p: ", p)

# inicjacja ciała F
print("\nInicjalizacja ciala F(p)\n")
F = GF(p)

# znalezeinie takeigo g (generatora), że #<g> = n
while True:
    g = F.random_element()
    if g.multiplicative_order() == n:
        break

print("\nZnalezienie generatora g, dla ktorego #<g> = n: ", g)
# print("\ng:")
# print(g.multiplicative_order())

# generowanie kluczy prywatnych A, B, C

xa = random.randint(1, n-1)
xb = random.randint(1, n-1)
xc = random.randint(1, n-1)
print("\nGenerowanie kluczy prytwatnych A, B, C: xa: ", xa, " xb: ", xb, " xc: ", xc)

# generowanie kluczy publicznych A, B, C

KA = (g^xa)
KB = (g^xb)
KC = (g^xc)
print("\nGenerowanie kluczy publicznych: \nKA: ", KA, "\nKB: ", KB, "\nKC: ", KC)

# pierwsza wymiana kluczy publicznych

print("\nPierwsza wymiana kluczy publicznych:\n")
# a oblicza KCA
KCA = (KC^xa)
# b oblicza KAB
KAB = (KA^xb)
# c oblicza KBC
KBC = (KB^xc)
print("\nObliczone klucze po pierwszej wymianie:")
print("\nKlucz obliczony przez A: (KC^xa): ", KCA)
print("\nKlucz obliczony przez B: (KA^xc): ", KAB)
print("\nKlucz obliczony przez C: (KB^xc): ", KBC)

# druga wymiana kluczy publicznych
# obliczenie kluczy sesji

# a oblicza K_BC^xa
K_BCA = (KBC^xa)
# b oblicza K_CA^xb
K_CAB = (KCA^xb)
# c oblicza K_AB^xc
K_ABC = (KAB^xc)

print("\nObliczone klucze po drugiej wymianie:")
print("\nKlucz obliczony przez A: (KBC^xa): ", K_BCA)
print("\nKlucz obliczony przez B: (KCA^xb): ", K_CAB)   
print("\nKlucz obliczony przez C: (KAB^xc): ", K_ABC)

print("\nKlucze sesyjne:\n")
print("\nKlucz obliczny przez A: ", K_BCA)
print("\nKlucz obliczny przez B: ", K_CAB)
print("\nKlucz obliczny przez C: ", K_ABC)

if K_BCA == K_CAB and K_CAB == K_ABC:
    print("\nKlucze sesji są takie same")

