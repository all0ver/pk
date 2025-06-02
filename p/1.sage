# zadanie 1

b = 128
n = next_prime(2^(b-2))
p = 2*n+1
while not is_prime(p):
    n = next_prime(n)
    p = 2*n+1

F = GF(p)

g = F.random_element()
while not g.multiplicative_order() == n:
    g = F.random_element()

print("p = ", p)
print("n = ", n)
print("g = ", g)


print()
print("Krok1")
xa = F.random_element()
ka = g^xa
print("xa = ", xa)
print("ka = ", ka)

print()
print("Krok2")
xb = F.random_element()
kb = g^xb
print("xb = ", xa)
print("kb = ", ka)
print()
print("Krok3")
print("A oblicza klucz sesyjny")
KBA = kb^xa

print("Otrzymany klucz sesyjny KBA: ", KBA)
print()
print("Krok4")
print("B oblicza klucz sesyjny")
KAB = ka^xb

print("Otrzymany klucz sesyjny KAB: ", KAB)