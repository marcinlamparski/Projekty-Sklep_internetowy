# INSTRUKCJA DLA UCZNIA – Samodzielny projekt
## Sklep Internetowy – Pisz kod samodzielnie!

---

## ⚠️ WAŻNE!

Ta instrukcja zawiera **podpowiedzi, a nie gotowy kod**. Będziesz musiał **sam napisać** każdy plik. Na egzaminie będziesz musiał to robić samodzielnie, więc zacznij od teraz!

**Czegoś nie rozumiesz?** Szukaj w Google, dokumentacji PHP, MDN lub pytaj nauczyciela – nie szukaj gotowych rozwiązań.

---

## 🎯 CEL PROJEKTU

Stworzysz aplikację internetową, która:
- ✅ Połączy się z bazą MySQL
- ✅ Wyświetli produkty w tabeli
- ✅ Wyświetli zamówienia z danymi klientów (JOIN)
- ✅ Umożliwi filtrowanie produktów na żywo

---

## 📁 STRUKTURA PROJEKTU

```
C:\xampp\htdocs\sklep\
├── config.php
├── index.php
├── zamowienia.php
├── css/styl.css
├── js/skrypt.js
├── img/ (katalog na zrzuty wykonanych kwarend sql)
├── kwerendy.txt
└── przegladarka.txt
```

---

## ⚙️ Dzień 1: BAZA DANYCH

### Zadanie: Import bazy danych

Otrzymasz od nauczyciela plik `sklep_internetowy.sql`.

**Kroki:**
1. Uruchom XAMPP (Apache + MySQL)
2. Otwórz phpMyAdmin
3. Zaimportuj plik (SQL → wklej → Wykonaj)

**Co sprawdzić:**
- Czy baza `sklep_internetowy` się stworzyła?
- Ile tabel jest w bazie? (Powinna być 4)
- Ile produktów? (SELECT COUNT(*) FROM produkt)
- Ile zamówień? (SELECT COUNT(*) FROM zamowienie)

**Zadanie:** Uruchom w phpMyAdmin zapytania i zobacz jakie dane są w każdej tabeli. Zapamiętaj nazwy kolumn.

---

## ⚙️ Dzień 2: PLIK KONFIGURACYJNY (config.php)

### Co musisz zrobić?

Utwórz plik, który **połączy się z bazą MySQL**.

### Jakie funkcje będziesz potrzebować?

- `mysqli_connect()` – łączenie z bazą
- `mysqli_set_charset()` – ustawienie kodowania
  Przykład użycia: mysqli_set_charset($conn, "utf8");  - po ustanowieniu połączenia z bazą w pliku config.php

### Wskazówka na strukturę:

```
<?php
// Zmienne z danymi dostępu
// Połączenie z bazą
// Sprawdzenie błędu (if !$connect)
// Ustawienie kodowania
?>
```

### Gdzie szukać informacji?

- Google: "php mysqli_connect"
- PHP.net: https://www.php.net/manual/pl/function.mysqli-connect
- Pytaj nauczyciela

### Test:

Po napisaniu pliku – jeśli go dołączysz do innego pliku i będziesz mieć dostęp do `$connect`, to działa.

---

## ⚙️ Dzień 3-4: STRONA GŁÓWNA (index.php)

### Co musisz zrobić?

Utwórz stronę, która:
1. Dołączy config.php
2. Pobierze produkty z bazy
3. Wyświetli je w tabeli HTML
4. Umożliwi wyszukiwanie

### Struktura pliku:

```
<?php
// 1. Dołączenie config.php

// 2. Zapytanie SELECT do bazy
// 3. Pętla przez wyniki
?>

<!DOCTYPE html>
// HTML

<?php
// Koniec pętli
// Zamknięcie połączenia
?>
```

### Kluczowe funkcje PHP:

- `mysqli_query()` – wykonanie zapytania
- `mysqli_fetch_assoc()` – pobranie wiersza
- `mysqli_num_rows()` – liczba wierszy
- `while` – pętla
- `number_format()` – formatowanie ceny - skorzystaj z google lub dokumentacji, sprawdź jak działa
- `substr()` – skrócenie tekstu
- `htmlspecialchars()` – bezpieczeństwo - opcjonalnie, sprawdć jak działa, po co ją stosować?

### Wskazówki:

**Zapytanie SELECT:**
- Napisz: `SELECT * FROM produkt ORDER BY nazwa ASC`
- Myśl: Jakie kolumny chcę? Z której tabeli? W jakiej kolejności?

**Formatowanie ceny:**
- Cena 2499.99 powinna wyglądać: `2 499,99 PLN`
- Google: "php number_format"

**Skrócenie opisu:**
- Opis może być długi
- Możesz pokazać tylko pierwsze 50 znaków + `...`
- Google: "php substr"

**Tabela HTML:**
- `<table>` <tr> <th> dla nagłówka
- `<tbody>` z pętlą while dla wierszy
- Umieść w `<td>` wartości z bazy

**Pole wyszukiwania:**
- `<input type="text" id="searchInput">`
- jakis_input.addEventListener(input, function() { };
lub
- `onkeyup="filterTable()"` – wywoła JavaScript przy każdej literze

### Test:

Otwórz http://localhost/sklep/

- ✅ Tabela z produktami
- ✅ 15 produktów
- ✅ Ceny sformatowane
- ✅ Opisy skrócone

Jeśli błąd – otwórz F12 → Console → czytaj komunikat błędu

---

## ⚙️ Dzień 5: STRONA ZAMÓWIEŃ (zamowienia.php)

### Co musisz zrobić?

Stwórz nową stronę z tabelą zamówień i danymi klientów.

### Różnica od index.php?

- **Tutaj będziesz używać JOIN** – połączenie dwóch tabel
- Zamiast jednej tabeli `FROM`, będziesz miał `FROM` + `JOIN`

### Kluczowe pojęcie: JOIN

**Myśl tak:**
- Mam zamówienia w tabeli `zamowienie`
- Chcę wiedzieć imię i nazwisko klienta
- Dane klienta są w tabeli `klient`
- Dlatego muszę połączyć obie tabele

**Struktura zapytania:**
```
SELECT kolumny_z_obu_tabel
FROM tabela1 alias1
JOIN tabela2 alias2 ON warunek_połączenia
```

### Wskazówki:

**Alias tabel:**
- Alias nie musi być zadeklarowany wcześniej
- Deklarujesz go w `FROM` lub `JOIN`
- Przykład: `FROM zamowienie z` – "z" to alias
- Potem używasz: `z.id_zamowienia`, `z.data_zamowienia`

**Warunek JOIN:**
- `ON z.id_klienta = k.id_klienta`
- Myśl: Gdzie kolumny się zgadzają?

**Formatowanie daty:**
- Data z bazy: `2024-10-05 10:30:00`
- Powinna wyglądać: `05.10.2024 10:30`
- Google: "php date formatting"
- Funkcja: `date()` + `strtotime()`

**Status kolory:**
- Jeśli status = "Dostarczone" → kolor zielony
- Jeśli status = "W realizacji" → kolor pomarańczowy
- Jeśli status = "Nowe" → kolor niebieski
- W PHP: `if ($row['status'] == "...") { ... }`
- W HTML: `<td class="...">` – klasa CSS dla koloru

### Test:

Otwórz http://localhost/sklep/zamowienia.php

- ✅ Tabela z zamówieniami
- ✅ 30 zamówień
- ✅ Imiona i nazwiska klientów
- ✅ Statusy w różnych kolorach
- ✅ Daty sformatowane

---

## ⚙️ Dzień 6: STYLOWANIE (styl.css)

### Co musisz zrobić?

Ostyluj stronę tak, by:
- Wyglądała profesjonalnie
- Była responsywna na telefonie
- Miała naprzemienne kolory wierszy
- Miała efekt hover

### Struktura CSS:

```css
/* 1. Reset */
* { margin: 0; padding: 0; }

/* 2. Zmienne */
:root { --primary-color: #2563eb; ... }

/* 3. Body i tekst */
body { ... }

/* 4. Header */
header { ... }

/* 5. Tabela */
table { ... }
table thead { ... }
table tbody tr { ... }
table tbody tr:nth-child(even) { ... }

/* 6. Responsywność */
@media (max-width: 768px) { ... }
```

### Kluczowe CSS:

- `background-color` – kolor tła
- `padding` – odstęp wewnętrzny
- `border` – obramowanie
- `:hover` – efekt przy najechaniu
- `:nth-child(even)` – parzyste wiersze
- `@media` – responsywność

### Wskazówki:

**Nagłówek:**
- Powinien być niebieski (#2563eb lub inny)
- Tekst biały
- Duży padding

**Tabela:**
- Header z innym kolorem niż wiersze
- Wiersze z obramowaniem
- Naprzemienne kolory (białe + jasne szare)
- Przy hover – zmiana koloru

**Responsywność:**
- Na dużych ekranach (1200px+) – pełna szerokość
- Na średnich ekranach (768px-1200px) – zmniejsz padding
- Na małych ekranach (<768px) – zmniejsz font, zmień layout

### Test:

- Otwórz obie strony w przeglądarce
- Ctrl+F5 (hard refresh)
- ✅ Header jest niebieski
- ✅ Tabela ma kolory
- ✅ Przy hover wiersz się zmienia
- ✅ Zmień rozmiar okna – zmienia się layout

---

## ⚙️ Dzień 7: INTERAKTYWNOŚĆ (skrypt.js)

### Co musisz zrobić?

Napisz funkcję, która **filtruje tabelę produktów na żywo**.

### Logika:

```
1. Pobierz wartość z pola input
2. Pobierz wszystkie wiersze tabeli
3. Dla każdego wiersza:
   - Sprawdź czy zawiera szukany tekst
   - Jeśli tak → pokaż wiersz
   - Jeśli nie → ukryj wiersz
```

### Kluczowe metody JavaScript:

- `document.getElementById()` – pobierz element po ID
- `getElementsByTagName()` – pobierz elementy po nazwie tagu
- `textContent` – tekst elementu
- `style.display` – pokazanie/ukrycie ('' lub 'none')
- `.toUpperCase()` – wielkie litery
- `.includes()` – sprawdzenie czy zawiera tekst
- `for` – pętla przez elementy

### Wskazówki:

**Pobieranie elementów:**
```javascript
// Pole input: id="searchInput"
// Tabela: id="produktyTable"
```

**Pętla przez wiersze:**
- Wiersze zaczynają się od indexu 1 (0 to nagłówek)
- Dla każdego wiersza pobierz komórki `<td>`

**Ukrywanie wiersza:**
- `rows[i].style.display = 'none'` – ukryj
- `rows[i].style.display = ''` – pokaż

**Case-insensitive:**
- `input.value.toUpperCase()` – zamień na wielkie litery
- `cellText.toUpperCase()` – zamień na wielkie litery
- Potem porównuj

### Struktura kodu:

```javascript
function filterTable() {
    // 1. Pobierz pole input
    // 2. Pobierz wartość (wielkie litery)
    // 3. Pobierz tabelę
    // 4. Pobierz wszystkie wiersze
    
    // 5. Pętla for przez wiersze (od 1)
    //    - Pobierz komórki wiersza
    //    - Pętla for przez komórki
    //      - Sprawdź czy zawiera tekst
    //      - Jeśli tak, ustaw found = true
    //    - Pokaż/ukryj wiersz
}
```

### Test:

- Strona produktów
- Wpisz w pole: "laptop"
- ✅ Tabela pokazuje tylko laptopy
- Wymaż – ✅ Tabela pokazuje wszystkie produkty
- Wpisz: "100" – ✅ Filtruje po cenie
- Wpisz: "5" – ✅ Filtruje po ID

---

## ⚙️ Dzień 8: DOKUMENTACJA

### Zadanie 1: SQL Queries

W phpMyAdmin wykonaj 8 różnych zapytań:

**Wskazówki do zapytań:**
- Wszystkie produkty posortowane
- Produkty droższe niż 100 PLN
- Produkty o małej ilości np <5
- Zamówienia z danymi klientów (JOIN)
- Liczba zamówień na klienta (GROUP BY)
- Średnia cena produktu (AVG)
- Produkty z konkretnego zakresu cen (WHERE)
- Zamówienia z konkretnym statusem (WHERE)

**Zapisz je w `kwerendy.txt`**

### Zadanie 2: Zrzuty ekranów

Dla 4 zapytań SQL:
1. Wykonaj w phpMyAdmin
2. PrintScreen
3. Otwórz Paint
4. Wklej i zapisz jako JPG: `kwerenda1.jpg`, itd.
5. Umieść w `sklep/img/`

### Zadanie 3: przegladarka.txt

Utwórz plik z nazwą przeglądarki, której używałeś.

---

## ❓ NAJCZĘSTSZE PROBLEMY

### Problem: "Błąd połączenia z bazą"

**Co sprawdzić:**
- Czy MySQL jest uruchomiony?
- Czy dane w config.php są poprawne?
- Czy baza o tej nazwie istnieje?

**Jak debugować:**
- F12 → Console → szukaj błędu
- `mysqli_error($connect)` – wypisz błąd

### Problem: "Polskie znaki się źle wyświetlają"

**Przyczyna:**
- Kodowanie UTF-8 nie jest ustawione

**Rozwiązanie:**
- W config.php: `mysqli_set_charset()`
- Plik PHP: Zapisz jako UTF-8

### Problem: "Tabela jest pusta"

**Co sprawdzić:**
- W phpMyAdmin: `SELECT * FROM produkt` – czy są dane?
- Czy zapytanie w PHP jest poprawne?
- Czy pętla while działa?

### Problem: "Filtrowanie nie działa"

**Co sprawdzić:**
- F12 → Console → czy są błędy?
- Czy ID w HTML są poprawne?
- Czy plik `skrypt.js` się wczytuje?
- Czy w input jest `onkeyup="filterTable()"`?

### Problem: "CSS się nie wczytuje"

**Rozwiązanie:**
- Ctrl+F5 (hard refresh)
- Sprawdź ścieżkę w `<link>`
- Folder `css` musi istnieć

---

## 📚 GDZIE SZUKAĆ POMOCY

### Dokumentacja:
- **PHP:** https://www.php.net/manual/pl/
- **JavaScript:** https://developer.mozilla.org/pl/
- **CSS:** https://www.w3schools.com/css/

### Wyszukiwanie:
- Google: "php mysqli_query example"
- Google: "javascript filter array"
- Google: "css responsive table"

### Nauczyciel:
- Pytaj kiedy nie rozumiesz koncepcji
- Pytaj o błędy w konsoli
- Pytaj o składnię

### YouTube:
- Szukaj: "PHP MySQL tutorial"
- Szukaj: "JavaScript DOM manipulation"
- Szukaj: "CSS responsive design"

---

## 🎓 PYTANIA SPRAWDZAJĄCE ZROZUMIENIE

Zanim oddasz projekt, odpowiedz na pytania:

1. **Jakie funkcje MySQL/PHP były ci potrzebne?** (Wymień co najmniej 5)
2. **Co robi JOIN i kiedy go używasz?**
3. **Jak filtrować tabelę w JavaScript?**
4. **Co to jest responsywny design?**
5. **Jak formatować cenę w PHP?**
6. **Co to jest alias tabeli w SQL?**
7. **Gdzie ukryć elementy w CSS/JavaScript?**
8. **Jak się łączy z bazą MySQL?**

---

## ✅ CHECKLIST PRZED ODDANIEM

```
TYDZIEŃ 1-2:
- [ ] Baza zaimportowana
- [ ] config.php napisany

TYDZIEŃ 3-4:
- [ ] index.php wyświetla produkty
- [ ] Formatowanie cen OK
- [ ] Pole wyszukiwania jest

TYDZIEŃ 5:
- [ ] zamowienia.php napisany
- [ ] JOIN działa
- [ ] Statusy mają kolory

TYDZIEŃ 6:
- [ ] styl.css napisany
- [ ] Responsywny na telefonie
- [ ] Header niebieski

TYDZIEŃ 7:
- [ ] skrypt.js filtruje
- [ ] Bez błędów w F12

TYDZIEŃ 8:
- [ ] 4 zrzuty ekranów
- [ ] kwerendy.txt wypełniony
- [ ] przegladarka.txt utworzony
- [ ] Struktura folderów OK
```

---

## 🎯 KRYTERIA OCENY

| Element | Punkty | Sprawdzam |
|---------|--------|-----------|
| config.php | 10 | Kod sam napisany, działa |
| index.php | 20 | SELECT, pętla, formatowanie |
| zamowienia.php | 20 | JOIN, kolory, formatowanie |
| styl.css | 20 | Stylowanie, media queries |
| skrypt.js | 15 | Filtrowanie działa |
| Dokumentacja | 15 | Zrzuty, kwerendy, struktura |
| Prezentacja | 50 | Aplikacja działa na wybranym komputerze, umiem odpowiedzieć na pytania dotyczące projektu |

| 46-50pkt - 5 |
| 40-45pkt - 4 |
| 34-39pkt - 3 |
| 26-33pkt - 2 |
| 0-25pkt - 1 | 

| Oceny z PHP, to ocena z przemiotu >> Tworzenie stron i aplikacji internetowych |
| Ocena z CSS, JS, Dokumentacja, to ocena z przedmiotu >> Aplikacje desktopowe i mobilne |
| Ocena z prezentacji, to ocena z przedmiotu >> Witryny i aplikacje internetowe |

- Całość dokumentację (strukturę plików i katalogów) wrzucacie po skompresowaniu na serwer:
- klasa V TIe --- https://tiny.pl/59ym1y5r
- klasa IV TIe --- https://tiny.pl/m954pryb

---

## 💡 ZŁOTA ZASADA

**Nie kopiuj gotowego kodu! Pisz sam.**

**Na egzaminie nikt ci nie da gotowego kodu. Zacznij się uczyć pisać teraz. Błędy są naturalną konsekwencją kodowania**

---

**Powodzenia! Pamiętaj – każdy błąd to nauka. Używaj F12, czytaj dokumentację, pytaj nauczyciela!** 🚀
