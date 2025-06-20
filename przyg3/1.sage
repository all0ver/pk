# Mateusz Karpiński
# WCY23KY1S1
# Laboratoria 3: Podzial Wiadomosci Pofunych

import random


print("Krok 1: Znalezienie p, wylosowanie M oraz ustawienia n = 10 i k = 5")
u = 2^24
p = next_prime(u)
M = random.randint(1, p)
n = 10
k = 5

# M - wiadomosc
print("M: ", M)
# n - liczba cieni
print("n: ", n)
# k - liczba potrzebna do odtworzenia wiadomości M
print("k: ", k)
# p - liczba pierwsza > n, > M
print("p: ", p)



print()
print()
print()

print("Krok 2: Wygenerowanie wielomianu stopnia k-1 (wylosowanie wspolczynnikow a_i)")

F = GF(p)

a = []

# dodanie elementu wolengo w wielomianie
a.append(M)

for i in range(0, k-1):
    a.append(F.random_element())


print("Tablica wspolczynnikow (oraz M jako element wolny): ", a)

P.<x>=F[]
f = sum([a[i] * x^i for i in range(len(a))])
print("f: ", f)


# wygenerowanie pierscienia wielomianu i wielomianu

# tablica uzytkownikow i cieni
# l = zero_matrix(F, n, 2)
l = zero_matrix(n, 3)


print()
print()
print()

print("Krok 3: Wyznaczenie cieni poprzez wyznaczenie wartosci wielomianu w n roznych punkach")
print("Krok 4: Wyslanie do poszczegolnych uzytkownikow systemu x_i oraz odpowiadajaca jej wartosci l_i, oraz liczbe pierwsza p")
# wygenerowanie cieni
used = []
for i in range(n):
    x_i = i+1
    r = random.randint(1, p)
    while r in used:
        r = random.randint(1, p)

    used.append(r)
    l[i, 0] = r
    l[i, 1] = f(r)
    l[i, 2] = p

print()
print()

print("Cienie l (x_i, l_i, p):")
print(l)

print()
print()
print()

print("Krok 5: Wyznaczenie M, przez zebranie dowolnego podzbioru k osob posiadajacych cienie. (Poprzez rozwiazanie ukladu kongruencji z k niewiadomymi)")

print("Krok 5.1 Wybranie k losowych osob")

KM = random.sample(range(n), k)

print("Losowo wybrane osoby: ", KM)
for i in KM:
    print(f"KM indeks: {i}, x_i = l[{i}, 0] = {l[i,0]}, l_i = {l[i,1]}")


print("Aby odtworzyc f nalezy rozwiazac uklad kongruencji: A * c = B, gdzie:")
print("A - macierz z x do potegi")
print("c - wektor wspolczynnikow wielomianu - szukana")
print("B - wektor wartosci wielomianu (f(x_i))")

A = zero_matrix(F, k, k)
c = zero_vector(F, k)
B = zero_vector(F, k)

# zapelnienie A oraz B

for i in range(k):
    x_i = l[KM[i], 0]
    B[i] = l[KM[i], 1]
    for j in range(k):
        A[i, j] = x_i^j


print()
print()
print()

print("Rownanie A * c = B: ")
print(A," * (w_1, w_2, w_3, w_4, w_5)^T = ", B, "^T")
print()
print()
print("Gdzie w_i to szukane wspolczynniki wielomianu")

# rozwiazanie rownania
c = A.solve_right(B)


print()
print()
print()

print("Otrzymane a (wspolczynniki): ", c)
print("Wiadomo, ze c_0 = M, stad M = ", c[0])
print("M z poczatku zadnia: ", M)

if (M == c[0]):
    print("Wiadomosci sa takie same")
else:
    print("Wiadomosci nie sa takie same")

print()
print()
print()
print("Sprawdzenie wszystkich cieni z otrzymanym wielomianem:")

f_odtworzony = sum([c[i] * x^i for i in range(k)])

print("Odtworzony wielomian: ", f_odtworzony)

for i in range(n):
    x_i = l[i, 0]
    oryginalny = l[i, 1]
    odtworzony = f_odtworzony(x_i)
    print(f"x = {x_i}, oryginalny: {oryginalny}, odtworzony: {odtworzony}")