# Mateusz Karpiński WCY23KY1S1
# na 4 punkty do 8 kwietnia 

import random


b = 128
n = next_prime(1*10^15)
p = 2*n+1
while not is_prime(p):
    n = next_prime(n)
    p = 2*n+1

print(n)
print(p)

# inicjacja ciała F
F = GF(p)

g = F.random_element()

print(g.multiplicative_order())

xa = random.randint(1, n-1)