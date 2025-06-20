# Mateusz Karpiński 
# WCY23KY1S1
# Uczciwe rzucanie moneta

import random

# parametry wejsciowe
# b1, b2 w bitach
b1 = 30
b2 = 32
print("b1 = ", b1)
print("b2 = ", b2)

print("Wygenerowanie liczb p i q")
p = next_prime(random.getrandbits(b1))
while p % 4 != 3:
    p = next_prime(p)
    
q = next_prime(random.getrandbits(b2))
while q % 4 != 3:
    q = next_prime(q)

print("p = ", p)
print("q = ", q)

# 1. uzytkownik A generiuje liczbe calkowita Bluma n, losowe x wzglednie pierwsze z n
print()
print("1.1 Uzytkownik A generuje liczbe calkowita Bluma")
n = p * q
print("Liczba calkowita Bluma: n = p*q")
print("n = ", n)

print("1.2 Uzytkownik A generuje losowe x wzglednie pierwsze z n")
while True:
    x = random.randint(2, n-1)
    if gcd(x, n) == 1:
        break
print("x = ", x)

# 2.uzytkownik A oblicza:
print()
print()
print()
print("2.1 Uzytkownik A oblicza: ")
print("x0 = x^2 (mod n)")
x0 = pow(x, 2, n)
# x_0 = x^2 (mod n)
print("x1 = x0^2 (mod n)")
# x_1 = x_0^2 (mod n)
x1 = pow(x0, 2, n)
print("x0 = ", x0)
print("x1 = ", x1)
# i przesyla n i x_1 do uzytkownika B
print("n i x1 sa przeslane do uzytkownika B")


# 3. uzytkownik B odgaduje czy x_0 jest przyste, czy nieparzyste
print()
print("3.1 Uzytkownik B odgaduje czy x0 jest parzyste czy nie")
guess = random.randint(0, 1)  # 0 - parzyste, 1 - nieparzyste
if guess == 0:
    print("B odgaduje, ze x0 jest parzyste")
else:
    print("B odgaduje, ze x0 jest nieparzyste")


# 4. uzytkownik A przesyla do B x i x_0
print()
print("4.1 Uzytkownik A przesyla do B x i x0")

# 5. uzytkownik B sprawdza, czy n jest liczba calkowita Bluma (uzytkownik A powinien przekazac do B czynniki liczby n lub zrealizowac protokol o wiedzy 'zerowej' w celu przekonania go, ze jest rzeczywiscie liczba calkowita Bluma) i czy x_0 = x^2 (mod n) oraz x_1 = x_0^2 (mod n), jezeli wszystko sie zgadza, to wynikiem rzutu moneta jest: orzel jezeli uzytkownik B odgadl poprawnie parzystosc/nieparzystosc x0; reszka w przeciwnym wypadku

# sposob 1: przekazanie czynnikow liczby n
print()
print("5.1 A przesyla czynniki n do B")
print("5.2 B sprawdza czy rzeczywiscie jest to liczba calkowita Bluma i czy sie wszystko zgadza")

x0b = pow(x, 2, n)
x1b = pow(x0, 2, n)
if int(x0)%2 == 0:
    result = 0
else:
    result = 1
print()
print()
print()
print("Wariant I")
if p%4==3 and q%4==3 and x0b == x0 and x1b == x1:
    print("Wszystko sie zgadza")
    if guess == result:
        print("Wynik: Orzeł")
    else:
        print("Wynik: Reszka")
else:
    print("Cos sie nie zgadza - koniec programu")


print()
print()
print()
print("Wariant II")
print("Wariant gdzie n nie jest liczba Bluma")

oldq = q
q = q+1
while (q%4) == 3:
    q = random.randint(2, q-1)
print("p = ", p)
print("q = ", q)

n = p * q
print("n = ", n)

while True:
    x = random.randint(2, n-1)
    if gcd(x, n) == 1:
        break
print("x = ", x)

# 2.uzytkownik A oblicza:
x0 = pow(x, 2, n)
# x_0 = x^2 (mod n)
# x_1 = x_0^2 (mod n)
x1 = pow(x0, 2, n)
print("x0 = ", x0)
print("x1 = ", x1)
# i przesyla n i x_1 do uzytkownika B


# 3. uzytkownik B odgaduje czy x_0 jest przyste, czy nieparzyste
guess = random.randint(0, 1)  # 0 - parzyste, 1 - nieparzyste

# sposob 1: przekazanie czynnikow liczby n
print("5.2 B sprawdza czy rzeczywiscie jest to liczba calkowita Bluma i czy sie wszystko zgadza")

x0b = pow(x, 2, n)
x1b = pow(x0, 2, n)
if int(x0)%2 == 0:
    result = 0
else:
    result = 1
print("Wariant II")
if p%4==3 and q%4==3 and x0b == x0 and x1b == x1:
    print("Wszystko sie zgadza")
    if guess == result:
        print("Wynik: Orzeł")
    else:
        print("Wynik: Reszka")
else:
    print("Cos sie nie zgadza - koniec programu")
    if (q%4!=3):
        print("liczba q nie spelnia: q = 3 (mod 4), wiec n nie jest liczba Bluma")
    elif (p%4!=3):
        print("liczba p nie spelnia: p = 3 (mod 4), wiec n nie jest liczba Bluma")
    elif (x0b != x0):
        print("x0 obliczone przez B nie jest rowne x0 przeslanemu przez A")
    elif (x1b != x1):
        print("x1 obliczone przez B nie jest rowne x1 przeslanemu przez A")






print()
print()
print()
print("Wariant III")
print("Wariant gdzie zmieniana jest wartosc x0 podczas gdy jest obliczny przez A")
q = oldq
print("p = ", p)
print("q = ", q)

n = p * q
print("n = ", n)

while True:
    x = random.randint(2, n-1)
    if gcd(x, n) == 1:
        break
print("x = ", x)

# 2.uzytkownik A oblicza:
print("Gdy A obblicza x0 to aby zmienic jego wartosc na nie poprawna dodawana jest do x0 wartosc 1")
x0 = pow(x, 2, n)+1
x1 = pow(x0, 2, n)
print("x0 = ", x0)
print("x1 = ", x1)


# 3. uzytkownik B odgaduje czy x_0 jest przyste, czy nieparzyste
guess = random.randint(0, 1)  # 0 - parzyste, 1 - nieparzyste

# sposob 1: przekazanie czynnikow liczby n
print("5.2 B sprawdza czy rzeczywiscie jest to liczba calkowita Bluma i czy sie wszystko zgadza")

x0b = pow(x, 2, n)
x1b = pow(x0, 2, n)
if int(x0)%2 == 0:
    result = 0
else:
    result = 1
print("Wariant III")
if p%4==3 and q%4==3 and x0b == x0 and x1b == x1:
    print("Wszystko sie zgadza")
    if guess == result:
        print("Wynik: Orzeł")
    else:
        print("Wynik: Reszka")
else:
    print("Cos sie nie zgadza - koniec programu")
    if (q%4!=3):
        print("liczba q nie spelnia: q = 3 (mod 4)")
    elif (p%4!=3):
        print("liczba p nie spelnia: p = 3 (mod 4)")
    elif (x0b != x0):
        print("x0 obliczone przez B nie jest rowne x0 przeslanemu przez A")
    elif (x1b != x1):
        print("x1 obliczone przez B nie jest rowne x1 przeslanemu przez A")

