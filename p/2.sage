# zadanie 2
# lamport
import random
import hashlib

n = 10
t = 4

print("Krok 1")
x = 1234567890
dane = []
dane.append(x)
print('x = ', x)
print("generowanie hasel")

d = hashlib.sha3_512()
d.update(x.str().encode())
hash = d.hexdigest()
dane.append(hash)

for i in range(8):
    x = hash
    d.update(x.encode())
    hash = d.hexdigest()
    dane.append(hash)

print()
print(dane)




print()
print("Krok 2")
print("System sprawdza")
for i in range(t):
    if t[i] in dane:
        print("uzytkownik istnieje, zapytanie o haslo")
        
print("Krok 3")
print("Krok 4")