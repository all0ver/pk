# Mateusz Karpiński
# WCY23KY1S1
# Laboratoria 3: Podzial Wiadomosci Pofunych

import random


print("Krok 1: Wylosowanie M, n oraz k, oraz znalezienie liczby pierwszej p > max(M, n)")
M = random.randint(1, 100000000)
n = random.randint(4, 10)
k = random.randint(3, n-1)
p = next_prime(max(M, n))

# M - wiadomosc
print("M: ", M)
# n - liczba cieni
print("n: ", n)
# k - liczba potrzebna do odtworzenia wiadomości M
print("k: ", k)
# p - liczba pierwsza > n, > M
print("p: ", p)


print();
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
l = zero_matrix(F, n, 2)

print("Krok 3: Wyznaczenie cieni poprzez wyznaczenie wartosci wielomianu w n roznych punkach")
print("Krok 4: Wyslanie do poszczegolnych uzytkownikow systemu x_i oraz odpowiadajaca jej wartosci l_i, oraz liczbe pierwsza p")
# wygenerowanie cieni
for i in range(n):
    x_i = i+1
    l[i, 0] = x_i
    l[i, 1] = f(x_i)

print("Cienie l (uzytkownik, cień):")
print(l)

print("Krok 5: Wyznaczenie M, przez zebranie dowolnego podzbioru k osob posiadajacych cienie. (Poprzez rozwiazanie ukladu kongruencji z k niewiadomymi)")

print("Krok 5.1 Wybranie k losowych osob")

KM = random.sample(range(n), k)

print("Losowo wybrane osoby: ", KM)
for i in KM:
    print(f"KM indeks: {i}, x_i = l[{i}, 0] = {l[i,0]}")


print("Aby odtworzyc f nalezy rozwiazac uklad kongruencji: A * a = B, gdzie:")
print("A - macierz z x do potegi")
print("a - wektor wspolczynnikow wielomianu - szukana")
print("B - wektor wartosci wielomianu (f(x_i))")

A = zero_matrix(F, k, k)
a = zero_vector(F, k)
B = zero_vector(F, k)

# zapelnienie A oraz B

for i in range(k):
    x_i = l[KM[i], 0]
    B[i] = l[KM[i], 1]
    for j in range(k):
        A[i, j] = x_i^j

print("Rownanie A * a = B: ")
print(A," * ", a, " = ", B)

# rozwiazanie rownania
a = A.solve_right(B)

print("Otrzymane a: ", a)
print("Wiadomo, ze a_0 = M, stad M = ", a[0])

