# CHEATSHEET: Formatowanie Danych MySQL dla Wyświetlenia na Stronach Internetowych
## PHP & JavaScript - Projekt Sklepu Internetowego

---

## 📋 SPIS TREŚCI
1. [Bezpieczeństwo Danych](#bezpieczeństwo-danych)
2. [Formatowanie Tekstu w PHP](#formatowanie-tekstu-w-php)
3. [Formatowanie Liczb i Walut w PHP](#formatowanie-liczb-i-walut-w-php)
4. [Formatowanie Dat i Czasów w PHP](#formatowanie-dat-i-czasów-w-php)
5. [Operacje na Tablicach w PHP](#operacje-na-tablicach-w-php)
6. [Kodowanie i Dekodowanie w PHP](#kodowanie-i-dekodowanie-w-php)
7. [Formatowanie Danych w JavaScript](#formatowanie-danych-w-javascript)
8. [Operacje na Stringach w JavaScript](#operacje-na-stringach-w-javascript)
9. [Operacje na Tablicach w JavaScript](#operacje-na-tablicach-w-javascript)
10. [Konwersja Formatów PHP ↔ JavaScript](#konwersja-formatów-php--javascript)

---

## 🔒 BEZPIECZEŃSTWO DANYCH

### Prepared Statements (Zabezpieczenie przed SQL Injection)

**PHP - PDO Prepared Statements:**
```php
// Sposób POPRAWNY
$stmt = $pdo->prepare("SELECT * FROM products WHERE id = :id");
$stmt->bindParam(':id', $id, PDO::PARAM_INT);
$stmt->execute();

// Alternatywa z ?
$stmt = $pdo->prepare("SELECT * FROM products WHERE name LIKE ?");
$stmt->execute(["%".$searchTerm."%"]);

// Lub z execute()
$stmt = $pdo->prepare("INSERT INTO products (name, price) VALUES (:name, :price)");
$stmt->execute([':name' => $name, ':price' => $price]);
```

### Sanitizacja Tekstu

**htmlspecialchars() - Konwersja do HTML entities:**
```php
// Zabezpiecza przed XSS
$safe_text = htmlspecialchars($user_input, ENT_QUOTES, 'UTF-8');
// & → &amp;
// " → &quot;
// ' → &#039;
// < → &lt;
// > → &gt;

echo htmlspecialchars("<script>alert('XSS')</script>");
// Wyświetla: &lt;script&gt;alert(&#039;XSS&#039;)&lt;/script&gt;
```

**stripslashes() - Usuwanie backslashów:**
```php
// Usuwa backslashe z danych z bazy
$clean_data = stripslashes($data_from_db);

// Przydatne jeśli baza przechowuje escapeowane znaki
$string = "It\\'s a test"; // z bazy
$clean = stripslashes($string); // It's a test
```

**strip_tags() - Usuwanie tagów HTML:**
```php
// Usuwa wszystkie tagi HTML
$text = "<p>Hello</p><script>alert('test')</script>";
$safe = strip_tags($text); // Hello

// Dozwolone tagi
$safe = strip_tags($text, '<p><b><i>');
```

---

## 📝 FORMATOWANIE TEKSTU W PHP

### Podstawowe Funkcje

**strlen() - Długość stringa:**
```php
$text = "Ołówek";
echo strlen($text); // 7 (liczy bajty w UTF-8)

// Dla znaków wielobajtowych używaj mb_strlen()
echo mb_strlen($text, 'UTF-8'); // 6
```

**strtoupper() / strtolower() - Zmiana wielkości liter:**
```php
$product = "Laptop Dell XPS";
echo strtoupper($product); // LAPTOP DELL XPS
echo strtolower($product); // laptop dell xps

// Dla UTF-8
echo mb_strtoupper($product, 'UTF-8');
```

**ucfirst() / ucwords() - Wielkie litery:**
```php
$product = "laptop dell xps";
echo ucfirst($product);  // Laptop dell xps
echo ucwords($product);  // Laptop Dell Xps
```

**trim() / ltrim() / rtrim() - Usuwanie spacji:**
```php
$text = "  Ołówek  ";
echo trim($text);   // "Ołówek" (obie strony)
echo ltrim($text);  // "Ołówek  " (lewa strona)
echo rtrim($text);  // "  Ołówek" (prawa strona)

// Usuwanie konkretnych znaków
echo trim($text, " \t\n"); // Usuwa spacje, taby, nowe linie
```

**substr() - Wycinanie tekstu:**
```php
$product = "Apple iPhone 14 Pro";
echo substr($product, 0, 5);    // "Apple" (od 0, 5 znaków)
echo substr($product, 6);       // "iPhone 14 Pro" (od pozycji 6)
echo substr($product, -3);      // "Pro" (ostatnie 3 znaki)
echo substr($product, 0, -4);   // "Apple iPhone 14"
```

**strpos() / strrpos() - Wyszukiwanie pozycji:**
```php
$text = "MacBook Pro M1 Pro";
echo strpos($text, "Pro");      // 9 (pierwsza pozycja)
echo strrpos($text, "Pro");     // 15 (ostatnia pozycja)

if (strpos($text, "Apple") !== false) {
    // "Apple" nie znaleziono (strpos zwraca false, nie 0!)
}
```

**str_replace() - Zamiana tekstu:**
```php
$text = "Cena produktu to 100 PLN";
echo str_replace("100", "150", $text);
// Cena produktu to 150 PLN

// Wielokrotne zamiany
$find = ["100", "PLN"];
$replace = ["150", "EUR"];
echo str_replace($find, $replace, $text);

// Case-insensitive
echo str_ireplace("PLN", "EUR", $text);
```

**str_pad() - Dopełnianie tekstu:**
```php
$id = "123";
echo str_pad($id, 6, "0", STR_PAD_LEFT);
// "000123" (0 z lewej)

echo str_pad($id, 6, "-", STR_PAD_RIGHT);
// "123---" (- z prawej)

// Dla cen
echo str_pad("99", 5, "0", STR_PAD_LEFT); // "00099"
```

**mb_strimwidth() - Obcinanie tekstu z ellipsis:**
```php
$desc = "To jest bardzo długi opis produktu";
echo mb_strimwidth($desc, 0, 20, "...");
// "To jest bardzo długi..."
```

**preg_replace() - Zamiana z regex:**
```php
// Usuwanie spacji
$text = "To jest   test";
echo preg_replace('/ +/', ' ', $text);
// "To jest test" (zastępuje 1+ spacje jedną)

// Usuwanie znaków specjalnych
echo preg_replace('/[^a-zA-Z0-9]/', '', "Hello@World!"); // HelloWorld

// Zamiana znaku na słowo
echo preg_replace('/\s/', '_', "Hello World"); // Hello_World
```

---

## 💰 FORMATOWANIE LICZB I WALUT W PHP

### number_format() - Formatowanie Liczb

**Podstawowe użycie:**
```php
$price = 1234567.89;

// Bez miejsc dziesiętnych
echo number_format($price);
// 1,234,568 (zaokrąglone w górę)

// Z miejscami dziesiętnymi
echo number_format($price, 2);
// 1,234,567.89

// Custom separator dla tysięcy i dziesiętnych
echo number_format($price, 2, ',', ' ');
// 1 234 567,89 (europejski format)

// Format niemiecki
echo number_format($price, 2, ',', '.');
// 1.234.567,89
```

**Formatowanie Walut:**
```php
$price = 99.5;

// USD
echo '$' . number_format($price, 2);
// $99.50

// EUR (europejski)
echo number_format($price, 2, ',', ' ') . ' €';
// 99,50 €

// GBP
echo '£' . number_format($price, 2);
// £99.50

// PLN
echo number_format($price, 2) . ' zł';
// 99.50 zł
```

### NumberFormatter (Intl Extension) - Zaawansowane

**Formatowanie przez Intl:**
```php
$price = 1234.56;
$locale = 'pl_PL'; // Polska

// Tworzenie formatera
$fmt = new NumberFormatter($locale, NumberFormatter::CURRENCY);

// Formatowanie waluty
echo $fmt->formatCurrency($price, 'PLN');
// 1 234,56 zł

// USD
echo $fmt->formatCurrency($price, 'USD');
// 1 234,56 USD

// Bez waluty
$fmt = new NumberFormatter($locale, NumberFormatter::DECIMAL);
echo $fmt->format($price); // 1 234,56
```

---

## 📅 FORMATOWANIE DAT I CZASÓW W PHP

### date() i strtotime()

**Podstawowe formatowanie dat:**
```php
$timestamp = time(); // Current timestamp

echo date('Y-m-d', $timestamp);
// 2025-11-04

echo date('d.m.Y', $timestamp);
// 04.11.2025

echo date('Y-m-d H:i:s', $timestamp);
// 2025-11-04 09:21:35

// Pełny format
echo date('l, j F Y', $timestamp);
// Tuesday, 4 November 2025
```

**Formatowanie z bazy MySQL:**
```php
// MySQL timestamp format: 2025-11-04 09:21:35
$db_date = '2025-11-04 09:21:35';

// Konwersja do timestamp
$timestamp = strtotime($db_date);

// Formatowanie
echo date('d.m.Y', $timestamp);
// 04.11.2025

echo date('Y-m-d H:i', $timestamp);
// 2025-11-04 09:21

// Wyznaczanie interwałów
echo date('Y-m-d', strtotime('+7 days', $timestamp));
// 2025-11-11

echo date('Y-m-d', strtotime('-1 month', $timestamp));
// 2025-10-04
```

### DateTime Class (OOP)

**Zaawansowane formatowanie:**
```php
$db_date = '2025-11-04 09:21:35';

// Tworzenie obiektu DateTime
$dateTime = new DateTime($db_date);

// Formatowanie
echo $dateTime->format('d.m.Y');     // 04.11.2025
echo $dateTime->format('Y-m-d H:i'); // 2025-11-04 09:21

// Modyfikacja
$dateTime->modify('+7 days');
$dateTime->modify('-2 hours');

// Roznica czasu
$now = new DateTime();
$interval = $now->diff($dateTime);
echo $interval->days . ' dni';
```

### Konwersja Strefy Czasowej

**Zmiana strefy czasowej:**
```php
date_default_timezone_set('Europe/Warsaw');

$db_date = '2025-11-04 09:21:35 UTC'; // Z bazy

$dateTime = new DateTime($db_date, new DateTimeZone('UTC'));
$dateTime->setTimezone(new DateTimeZone('Europe/Warsaw'));

echo $dateTime->format('Y-m-d H:i:s');
// Formatowana w warszawskiej strefie czasowej

// Format do MySQL INSERT/UPDATE
$formatted = date('Y-m-d H:i:s'); // 2025-11-04 09:21:35
```

### MySQL DATE_FORMAT w SQL Query

**Formatowanie na poziomie bazy danych:**
```php
$stmt = $pdo->prepare("
    SELECT id, name, DATE_FORMAT(created_at, '%d.%m.%Y') as data
    FROM products
");
$stmt->execute();
// Zwraca już sformatowaną datę: 04.11.2025
```

---

## 🎯 OPERACJE NA TABLICACH W PHP

### array_filter() - Filtrowanie

**Filtrowanie tablicy:**
```php
$products = [
    ['id' => 1, 'name' => 'Laptop', 'price' => 2000, 'stock' => 5],
    ['id' => 2, 'name' => 'Mouse', 'price' => 50, 'stock' => 0],
    ['id' => 3, 'name' => 'Keyboard', 'price' => 150, 'stock' => 10],
];

// Produkty z ceną > 100
$expensive = array_filter($products, function($p) {
    return $p['price'] > 100;
});

// Tylko dostępne produkty (stock > 0)
$available = array_filter($products, function($p) {
    return $p['stock'] > 0;
});

// Bez callback - usuwa wartości falsy
$data = [1, 0, 2, '', 3, false];
$filtered = array_filter($data); // [1, 2, 3]
```

### array_map() - Transformacja

**Transformacja każdego elementu:**
```php
$products = [
    ['id' => 1, 'name' => 'Laptop', 'price' => 2000],
    ['id' => 2, 'name' => 'Mouse', 'price' => 50],
];

// Wyciągnięcie tylko nazw
$names = array_map(function($p) {
    return $p['name'];
}, $products);
// ['Laptop', 'Mouse']

// Formatowanie cen
$formatted_prices = array_map(function($p) {
    return '$' . number_format($p['price'], 2);
}, $products);
// ['$2,000.00', '$50.00']

// Dodanie pola
$with_currency = array_map(function($p) {
    $p['currency'] = 'USD';
    return $p;
}, $products);
```

### array_reduce() - Agregacja

**Łączenie danych w jedną wartość:**
```php
$products = [
    ['price' => 100, 'qty' => 2],
    ['price' => 50, 'qty' => 3],
    ['price' => 200, 'qty' => 1],
];

// Suma kwot
$total = array_reduce($products, function($sum, $item) {
    return $sum + ($item['price'] * $item['qty']);
}, 0);
// 550

// Grupowanie
$grouped = array_reduce($products, function($acc, $item) {
    $key = $item['price'] > 100 ? 'expensive' : 'cheap';
    $acc[$key][] = $item;
    return $acc;
}, []);
```

### array_slice() / array_splice()

**Wycinanie fragmentu tablicy:**
```php
$items = ['A', 'B', 'C', 'D', 'E'];

// slice - nie zmienia oryginału
echo array_slice($items, 2);       // ['C', 'D', 'E']
echo array_slice($items, 1, 2);    // ['B', 'C']
echo array_slice($items, -2);      // ['D', 'E']

// splice - modyfikuje oryginał
$copy = $items;
array_splice($copy, 1, 2, ['X', 'Y']);
// ['A', 'X', 'Y', 'D', 'E']
```

### array_column() - Wyciąganie kolumny

**Ekstrakcja określonej kolumny:**
```php
$products = [
    ['id' => 1, 'name' => 'Laptop', 'category_id' => 1],
    ['id' => 2, 'name' => 'Mouse', 'category_id' => 2],
    ['id' => 3, 'name' => 'Keyboard', 'category_id' => 2],
];

// Wszystkie nazwy
$names = array_column($products, 'name');
// ['Laptop', 'Mouse', 'Keyboard']

// Z kluczem
$by_id = array_column($products, 'name', 'id');
// [1 => 'Laptop', 2 => 'Mouse', 3 => 'Keyboard']

// Z kategoriami
$by_category = array_column($products, 'name', 'category_id');
// [1 => 'Laptop', 2 => 'Keyboard'] (ostatni dla kategorii 2)
```

### implode() / explode()

**Konwersja tablica ↔ string:**
```php
// implode - tablica na string
$tags = ['elektronika', 'sprzedaż', 'nowe'];
$tag_string = implode(', ', $tags);
// "elektronika, sprzedaż, nowe"

// W bazie
INSERT INTO products (tags) VALUES ('elektronika, sprzedaż, nowe');

// explode - string na tablicę
$db_tags = 'elektronika, sprzedaż, nowe';
$tag_array = explode(', ', $db_tags);
// ['elektronika', 'sprzedaż', 'nowe']

// Czyszczenie
$tags = array_map('trim', explode(',', $tag_string));
```

---

## 🔐 KODOWANIE I DEKODOWANIE W PHP

### json_encode() / json_decode()

**Konwersja JSON:**
```php
$product = [
    'id' => 1,
    'name' => 'Laptop',
    'price' => 2000.50,
    'tags' => ['elektronika', 'sprzedaż']
];

// Do JSON string
$json = json_encode($product);
// {"id":1,"name":"Laptop","price":2000.5,"tags":["elektronika","sprzedaż"]}

// Z sformatowaniem
$json_pretty = json_encode($product, JSON_PRETTY_PRINT);

// Z wariantami
$json = json_encode($product, JSON_UNESCAPED_UNICODE); // Zachowuje znaki Unicode

// Z powrotem na PHP
$decoded = json_decode($json, true); // true = tablica
$object = json_decode($json);        // false = stdClass object

// Sprawdzenie błędu
if (json_last_error() !== JSON_ERROR_NONE) {
    echo 'JSON Error: ' . json_last_error_msg();
}
```

### base64_encode() / base64_decode()

**Kodowanie binarne:**
```php
// Kodowanie
$image_data = file_get_contents('image.jpg');
$base64 = base64_encode($image_data);

// Dla URL (Data URL)
$data_url = 'data:image/jpeg;base64,' . $base64;

// Dekodowanie
$decoded = base64_decode($base64);
file_put_contents('output.jpg', $decoded);

// Do bazy
INSERT INTO products (image) VALUES ('$base64');

// Z bazy
$image_base64 = $row['image'];
echo '<img src="data:image/jpeg;base64,' . $image_base64 . '">';
```

### htmlentities() / html_entity_decode()

**Konwersja HTML entities:**
```php
$text = 'Cena: 100 zł & 50 €';

// htmlentities
$encoded = htmlentities($text);
// Cena: 100 zł &amp; 50 €

// html_entity_decode
$decoded = html_entity_decode($encoded);
// Cena: 100 zł & 50 €

// W atrybutach
$title = 'Produkt "Premium" & "Exclusive"';
$safe = htmlentities($title, ENT_QUOTES, 'UTF-8');
echo '<div title="' . $safe . '"></div>';
```

---

## 🟡 FORMATOWANIE DANYCH W JAVASCRIPT

### Formatowanie Liczb

**toLocaleString() - Formatowanie lokalne:**
```javascript
const price = 1234567.89;

// Domyślny format
console.log(price.toLocaleString());
// "1,234,567.89" (USA)

// Z waluty
console.log(price.toLocaleString('en-US', {
    style: 'currency',
    currency: 'USD'
}));
// "$1,234,567.89"

// EUR
console.log(price.toLocaleString('pl-PL', {
    style: 'currency',
    currency: 'EUR'
}));
// "1 234 567,89 €"

// PLN
console.log(price.toLocaleString('pl-PL', {
    style: 'currency',
    currency: 'PLN'
}));
// "1 234 567,89 zł"
```

**Intl.NumberFormat - Zaawansowane formatowanie:**
```javascript
const price = 2000.5;

// Formatter
const formatter = new Intl.NumberFormat('pl-PL', {
    style: 'currency',
    currency: 'PLN',
    minimumFractionDigits: 2,
    maximumFractionDigits: 2
});

console.log(formatter.format(price));
// "2 000,50 zł"

// Bez waluty
const numFormatter = new Intl.NumberFormat('de-DE');
console.log(numFormatter.format(1234567.89));
// "1.234.567,89"
```

---

## 📜 OPERACJE NA STRINGACH W JAVASCRIPT

### Podstawowe Metody

**toUpperCase() / toLowerCase():**
```javascript
const product = "Laptop Dell XPS";
console.log(product.toUpperCase());  // "LAPTOP DELL XPS"
console.log(product.toLowerCase());  // "laptop dell xps"
```

**trim() / trimStart() / trimEnd():**
```javascript
const text = "  Ołówek  ";
console.log(text.trim());      // "Ołówek"
console.log(text.trimStart()); // "Ołówek  "
console.log(text.trimEnd());   // "  Ołówek"
```

**substring() / substr() / slice():**
```javascript
const product = "Apple iPhone 14 Pro";

console.log(product.substring(0, 5));  // "Apple"
console.log(product.slice(6));         // "iPhone 14 Pro"
console.log(product.slice(-3));        // "Pro"
console.log(product.slice(0, -4));     // "Apple iPhone 14"

// substring nie obsługuje ujemnych indeksów
console.log(product.substring(-3));    // "Apple iPhone 14 Pro"
```

**indexOf() / lastIndexOf() / includes():**
```javascript
const text = "MacBook Pro M1 Pro";

console.log(text.indexOf("Pro"));      // 8
console.log(text.lastIndexOf("Pro"));  // 15
console.log(text.includes("Apple"));   // false
console.log(text.startsWith("Mac"));   // true
console.log(text.endsWith("Pro"));     // true
```

**replace() / replaceAll():**
```javascript
const text = "Cena to 100 PLN";

console.log(text.replace("100", "150"));
// "Cena to 150 PLN" (tylko pierwszy)

console.log(text.replaceAll("0", "X"));
// "Cena to 1XX PLN"

// Regex
console.log(text.replace(/\d+/g, "150"));
// "Cena to 150 PLN"
```

**padStart() / padEnd():**
```javascript
const id = "123";

console.log(id.padStart(6, "0"));
// "000123"

console.log(id.padEnd(6, "-"));
// "123---"

// ID transakcji
const txId = "ABC";
console.log(txId.padStart(8, "#"));
// "#####ABC"
```

**split() - Dzielenie stringa:**
```javascript
const tags = "elektronika, sprzedaż, nowe";
const tagArray = tags.split(", ");
// ["elektronika", "sprzedaż", "nowe"]

const csv = "1,2,3,4,5";
const numbers = csv.split(",");
// ["1", "2", "3", "4", "5"]

// Z limitem
const parts = tags.split(",", 2);
// ["elektronika", " sprzedaż"]

// Na znaki
const chars = "Hello".split("");
// ["H", "e", "l", "l", "o"]
```

---

## 📊 OPERACJE NA TABLICACH W JAVASCRIPT

### Podstawowe Metody

**map() - Transformacja:**
```javascript
const products = [
    {id: 1, name: 'Laptop', price: 2000},
    {id: 2, name: 'Mouse', price: 50}
];

// Wyciągnięcie nazw
const names = products.map(p => p.name);
// ['Laptop', 'Mouse']

// Formatowanie cen
const prices = products.map(p => '$' + p.price);
// ['$2000', '$50']

// Dodanie pola
const withTax = products.map(p => ({
    ...p,
    priceWithTax: p.price * 1.23
}));
```

**filter() - Filtrowanie:**
```javascript
const products = [
    {id: 1, name: 'Laptop', price: 2000, stock: 5},
    {id: 2, name: 'Mouse', price: 50, stock: 0},
    {id: 3, name: 'Keyboard', price: 150, stock: 10}
];

// Drogi produkty
const expensive = products.filter(p => p.price > 100);
// [{id: 1, ...}, {id: 3, ...}]

// Dostępne produkty
const available = products.filter(p => p.stock > 0);
// [{id: 1, ...}, {id: 3, ...}]

// Łączenie warunków
const filtered = products.filter(p => 
    p.price > 100 && p.stock > 0
);
```

**reduce() - Agregacja:**
```javascript
const products = [
    {price: 100, qty: 2},
    {price: 50, qty: 3},
    {price: 200, qty: 1}
];

// Suma
const total = products.reduce((sum, item) => {
    return sum + (item.price * item.qty);
}, 0);
// 550

// Grupowanie
const grouped = products.reduce((acc, item) => {
    const key = item.price > 100 ? 'expensive' : 'cheap';
    if (!acc[key]) acc[key] = [];
    acc[key].push(item);
    return acc;
}, {});
```

**find() / findIndex():**
```javascript
const products = [
    {id: 1, name: 'Laptop'},
    {id: 2, name: 'Mouse'},
    {id: 3, name: 'Keyboard'}
];

// Znalezienie produktu
const product = products.find(p => p.id === 2);
// {id: 2, name: 'Mouse'}

// Index
const index = products.findIndex(p => p.id === 2);
// 1
```

**some() / every():**
```javascript
const products = [
    {price: 100, available: true},
    {price: 50, available: false},
    {price: 200, available: true}
];

// Czy któregoś produktu brak
const hasUnavailable = products.some(p => !p.available);
// true

// Czy wszystkie są dostępne
const allAvailable = products.every(p => p.available);
// false
```

**join():**
```javascript
const tags = ['elektronika', 'sprzedaż', 'nowe'];

console.log(tags.join(', '));
// "elektronika, sprzedaż, nowe"

console.log(tags.join(' | '));
// "elektronika | sprzedaż | nowe"

// Wysyłanie do bazy
const tagString = tags.join(',');
```

**sort():**
```javascript
const products = [
    {name: 'Laptop', price: 2000},
    {name: 'Mouse', price: 50},
    {name: 'Keyboard', price: 150}
];

// Sortowanie po cenie rosnąco
products.sort((a, b) => a.price - b.price);

// Sortowanie po cenie malejąco
products.sort((a, b) => b.price - a.price);

// Sortowanie alfabetycznie
products.sort((a, b) => a.name.localeCompare(b.name));
```

---

## 📅 FORMATOWANIE DAT W JAVASCRIPT

### Podstawowe Formatowanie

**toLocaleDateString():**
```javascript
const date = new Date('2025-11-04');

// Domyślnie
console.log(date.toLocaleDateString());
// "11/4/2025" (USA)

// Polski format
console.log(date.toLocaleDateString('pl-PL'));
// "4.11.2025"

// Pełny format
console.log(date.toLocaleDateString('pl-PL', {
    weekday: 'long',
    year: 'numeric',
    month: 'long',
    day: 'numeric'
}));
// "wtorek, 4 listopada 2025"
```

**Konwersja z MySQL DATETIME:**
```javascript
// Z bazy: "2025-11-04 09:21:35"
const mysqlDate = "2025-11-04 09:21:35";

// Metoda 1: replace - separator
const dateObj = new Date(mysqlDate.replace(' ', 'T'));

// Metoda 2: parse ze strefy czasowej
const [date, time] = mysqlDate.split(' ');
const [year, month, day] = date.split('-');
const dateObj2 = new Date(year, month - 1, day);

// Formatowanie
console.log(dateObj.toLocaleDateString('pl-PL'));
// "4.11.2025"

console.log(dateObj.toLocaleTimeString('pl-PL'));
// "09:21:35"
```

**Intl.DateTimeFormat:**
```javascript
const date = new Date('2025-11-04T09:21:35');

const formatter = new Intl.DateTimeFormat('pl-PL', {
    year: 'numeric',
    month: '2-digit',
    day: '2-digit',
    hour: '2-digit',
    minute: '2-digit'
});

console.log(formatter.format(date));
// "04.11.2025, 09:21"
```

---

## 🔄 KONWERSJA FORMATÓW PHP ↔ JAVASCRIPT

### JSON API - Wymiana Danych

**PHP wysyła JSON:**
```php
// backend.php
$products = [
    ['id' => 1, 'name' => 'Laptop', 'price' => 2000],
    ['id' => 2, 'name' => 'Mouse', 'price' => 50]
];

header('Content-Type: application/json; charset=utf-8');
echo json_encode($products);
```

**JavaScript odbiera:**
```javascript
// frontend.js
fetch('backend.php')
    .then(response => response.json())
    .then(products => {
        products.forEach(p => {
            console.log(`${p.name}: $${p.price}`);
        });
    });
```

### Synchronizacja Daty

**PHP wysyła datę UTC:**
```php
// backend.php
$date = new DateTime('now', new DateTimeZone('UTC'));
echo json_encode([
    'created_at' => $date->format('Y-m-d H:i:s'),
    'timestamp' => $date->getTimestamp()
]);
```

**JavaScript konwertuje na lokalne:**
```javascript
// frontend.js
fetch('backend.php')
    .then(r => r.json())
    .then(data => {
        // Opcja 1: Z timestamp
        const date = new Date(data.timestamp * 1000);
        
        // Opcja 2: Z string (UTC)
        const date2 = new Date(data.created_at + 'Z');
        
        console.log(date.toLocaleDateString('pl-PL'));
    });
```

### Formatowanie Listy do Wysyłki

**JavaScript przygotowuje dane:**
```javascript
const products = [
    {id: 1, name: 'Laptop', price: 2000},
    {id: 2, name: 'Mouse', price: 50}
];

const dataToSend = {
    items: products,
    total: products.reduce((sum, p) => sum + p.price, 0),
    timestamp: new Date().toISOString()
};

fetch('process.php', {
    method: 'POST',
    headers: {'Content-Type': 'application/json'},
    body: JSON.stringify(dataToSend)
});
```

**PHP odbiera i przetwarza:**
```php
// process.php
$input = json_decode(file_get_contents('php://input'), true);

if ($input) {
    $items = $input['items'];
    $total = $input['total'];
    $created = new DateTime($input['timestamp']);
    
    // Przetwarzanie...
    
    echo json_encode(['status' => 'success', 'order_id' => 123]);
}
```

---

## 💡 PRAKTYCZNE PRZYKŁADY - SKLEPIK INTERNETOWY

### Wyświetlanie Listy Produktów

**PHP - Pobieranie i formatowanie:**
```php
$stmt = $pdo->prepare("SELECT id, name, price, created_at FROM products ORDER BY id");
$stmt->execute();
$products = $stmt->fetchAll(PDO::FETCH_ASSOC);

$formatted = array_map(function($p) {
    return [
        'id' => (int)$p['id'],
        'name' => htmlspecialchars($p['name']),
        'price' => number_format($p['price'], 2),
        'price_formatted' => '$' . number_format($p['price'], 2),
        'created' => date('d.m.Y', strtotime($p['created_at']))
    ];
}, $products);

header('Content-Type: application/json');
echo json_encode($formatted);
```

**JavaScript - Wyświetlanie:**
```javascript
fetch('api/products.php')
    .then(r => r.json())
    .then(products => {
        const html = products.map(p => `
            <div class="product">
                <h3>${p.name}</h3>
                <p class="price">${p.price_formatted}</p>
                <p class="date">Dodano: ${p.created}</p>
            </div>
        `).join('');
        
        document.getElementById('products').innerHTML = html;
    });
```

### Koszyk Zakupów

**PHP - Kalkulacja:**
```php
$cart = $_SESSION['cart'] ?? []; // Tablica [id => qty]

$ids = array_keys($cart);
$placeholders = implode(',', array_fill(0, count($ids), '?'));

$stmt = $pdo->prepare(
    "SELECT id, name, price FROM products WHERE id IN ($placeholders)"
);
$stmt->execute($ids);
$products = $stmt->fetchAll(PDO::FETCH_ASSOC);

$items = array_map(function($p) use ($cart) {
    $qty = $cart[$p['id']];
    $subtotal = $p['price'] * $qty;
    
    return [
        'id' => $p['id'],
        'name' => $p['name'],
        'price' => number_format($p['price'], 2),
        'qty' => $qty,
        'subtotal' => number_format($subtotal, 2)
    ];
}, $products);

$total = array_reduce($items, function($sum, $item) {
    return $sum + ($item['price'] * $item['qty']);
}, 0);

echo json_encode([
    'items' => $items,
    'total' => number_format($total, 2),
    'total_formatted' => '$' . number_format($total, 2)
]);
```

**JavaScript - Rendering koszyka:**
```javascript
fetch('api/cart.php')
    .then(r => r.json())
    .then(cart => {
        let html = '<table>';
        
        cart.items.forEach(item => {
            html += `
                <tr>
                    <td>${item.name}</td>
                    <td>${item.price}</td>
                    <td>${item.qty}</td>
                    <td>${item.subtotal}</td>
                </tr>
            `;
        });
        
        html += `
            <tr class="total">
                <td colspan="3">RAZEM:</td>
                <td>${cart.total_formatted}</td>
            </tr>
        </table>`;
        
        document.getElementById('cart').innerHTML = html;
    });
```

---

## ⚡ SZYBKA LISTA - NAJCZĘŚCIEJ UŻYWANE

| Operacja | PHP | JavaScript |
|----------|-----|-----------|
| Trimowanie | `trim($text)` | `text.trim()` |
| Wielkie litery | `strtoupper($text)` | `text.toUpperCase()` |
| Małe litery | `strtolower($text)` | `text.toLowerCase()` |
| Długość | `strlen($text)` | `text.length` |
| Wycinanie | `substr($text, 0, 5)` | `text.slice(0, 5)` |
| Zamiana | `str_replace($a, $b, $text)` | `text.replace($a, $b)` |
| Dzielenie | `explode(', ', $text)` | `text.split(', ')` |
| Łączenie | `implode(', ', $arr)` | `arr.join(', ')` |
| Liczba | `number_format(123.45, 2)` | `(123.45).toLocaleString()` |
| Waluta | `'$' . number_format($p, 2)` | `price.toLocaleString('en-US', {style: 'currency', currency: 'USD'})` |
| Data | `date('d.m.Y', strtotime($d))` | `new Date(date).toLocaleDateString('pl-PL')` |
| JSON | `json_encode($arr)` | `JSON.stringify(obj)` |
| JSON | `json_decode($json, true)` | `JSON.parse(jsonStr)` |
| Filter | `array_filter($arr, fn)` | `arr.filter(fn)` |
| Map | `array_map($fn, $arr)` | `arr.map(fn)` |
| Reduce | `array_reduce($arr, fn, 0)` | `arr.reduce(fn, 0)` |

---

## 📌 WSKAZÓWKI BEZPIECZEŃSTWA

✅ **ZAWSZE RÓB:**
- Używaj `prepared statements` z PDO
- Sanitizuj tekst `htmlspecialchars()` przed wyświetleniem
- Waliduj i filtruj dane użytkownika po stronie serwera
- Używaj `json_encode()` do API
- Testuj formatowanie z różnymi zestawami znaków

❌ **NIGDY NIE RÓB:**
- Nie łączaj zmiennych bezpośrednio w SQL: `"SELECT * FROM t WHERE id = $id"`
- Nie uufaj danym z `$_GET`, `$_POST`, `$_COOKIE`
- Nie wyświetlaj surowych danych użytkownika bez `htmlspecialchars()`
- Nie przesyłaj niesformatowanych danych do API

---

**Ostatnia aktualizacja: November 2025**
