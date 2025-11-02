-- ============================================
-- BAZA DANYCH: sklep_internetowy
-- Tworzenie struktury i dane testowe
-- ============================================

-- Tworzenie bazy danych
CREATE DATABASE IF NOT EXISTS sklep_internetowy CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;
USE sklep_internetowy;

-- ============================================
-- TABELA: klient
-- ============================================

CREATE TABLE klient (
  id_klienta INT AUTO_INCREMENT PRIMARY KEY,
  imie VARCHAR(50) NOT NULL,
  nazwisko VARCHAR(50) NOT NULL,
  email VARCHAR(100) NOT NULL UNIQUE,
  telefon VARCHAR(20) NOT NULL,
  miasto VARCHAR(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

INSERT INTO klient (imie, nazwisko, email, telefon, miasto) VALUES
('Jan', 'Kowalski', 'jan.kowalski@email.com', '501234567', 'Warszawa'),
('Maria', 'Nowak', 'maria.nowak@email.com', '502345678', 'Kraków'),
('Piotr', 'Lewandowski', 'piotr.lewandowski@email.com', '503456789', 'Wrocław'),
('Anna', 'Wiśniewski', 'anna.wisniewski@email.com', '504567890', 'Poznań'),
('Tomasz', 'Dabrowski', 'tomasz.dabrowski@email.com', '505678901', 'Gdańsk'),
('Katarzyna', 'Grabowska', 'katarzyna.grabowska@email.com', '506789012', 'Szczecin'),
('Łukasz', 'Szymczyk', 'lukasz.szymczyk@email.com', '507890123', 'Łódź'),
('Barbara', 'Michalski', 'barbara.michalski@email.com', '508901234', 'Zakopane'),
('Krzysztof', 'Wolski', 'krzysztof.wolski@email.com', '509012345', 'Gdynia'),
('Ewa', 'Kucharska', 'ewa.kucharska@email.com', '510123456', 'Toruń');

-- ============================================
-- TABELA: produkt
-- ============================================

CREATE TABLE produkt (
  id_produktu INT AUTO_INCREMENT PRIMARY KEY,
  nazwa VARCHAR(100) NOT NULL,
  opis TEXT NOT NULL,
  cena DECIMAL(10,2) NOT NULL,
  ilosc_na_stanie INT NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

INSERT INTO produkt (nazwa, opis, cena, ilosc_na_stanie) VALUES
('Laptop Dell Inspiron 15', 'Laptop z procesorem Intel i5, 8GB RAM, 256GB SSD', 2499.99, 5),
('Mysz bezprzewodowa Logitech', 'Ergonomiczna mysz z Bluetooth, zasięg do 10m', 49.99, 20),
('Klawiatura mechaniczna RGB', 'Klawiatura RGB z przełącznikami Cherry MX, USB-C', 299.99, 8),
('Monitor ASUS 24 cale 144Hz', 'Monitor IPS Full HD, tempo odświeżania 144Hz', 799.99, 3),
('Headset HyperX Cloud Stinger', 'Słuchawki dla graczy z mikrofonem, 7.1 surround', 149.99, 12),
('Pad podkładka pod mysz XXL', 'Duża podkładka 80x40cm z krawędzią zszytą', 39.99, 30),
('Kabel USB-C 2m', 'Kabel USB-C 3.0 do transferu i ładowania', 19.99, 50),
('Stojak na monitor regulowany', 'Stojak pozwalający na regulację wysokości monitora', 89.99, 15),
('Webcam Logitech C920', 'Kamera internetowa Full HD 1080p z autofokusem', 199.99, 7),
('SSD Samsung 970 1TB', 'Dysk SSD NVMe, prędkość do 3500MB/s', 349.99, 10),
('RAM Kingston 16GB DDR4', 'Pamięć RAM DDR4 16GB 3200MHz', 199.99, 18),
('Obudowa PC Corsair Carbide', 'Obudowa ATX z wentylacją, szklana ściana', 449.99, 4),
('Zasilacz 750W 80+ Bronze', 'Zasilacz modułowy 750W, sertyfikacja 80+ Bronze', 299.99, 6),
('Chłodzenie CPU Noctua', 'Chłodzenie powietrzne z wentylatorami 120mm', 129.99, 11),
('Router WiFi 6 ASUS', 'Router AX6000 z WiFi 6, MU-MIMO, 4 anteny', 399.99, 2);

-- ============================================
-- TABELA: zamowienie
-- ============================================

CREATE TABLE zamowienie (
  id_zamowienia INT AUTO_INCREMENT PRIMARY KEY,
  id_klienta INT NOT NULL,
  data_zamowienia DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  status VARCHAR(50) NOT NULL DEFAULT 'Nowe',
  kwota_calkowita DECIMAL(10,2) NOT NULL,
  FOREIGN KEY (id_klienta) REFERENCES klient(id_klienta) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

INSERT INTO zamowienie (id_klienta, data_zamowienia, status, kwota_calkowita) VALUES
(1, '2024-10-05 10:30:00', 'Dostarczone', 2549.98),
(1, '2024-10-15 14:20:00', 'Wysłane', 149.99),
(2, '2024-10-10 09:15:00', 'W realizacji', 899.98),
(2, '2024-10-20 16:45:00', 'Nowe', 99.98),
(3, '2024-10-08 11:00:00', 'Dostarczone', 899.98),
(3, '2024-10-22 13:30:00', 'W realizacji', 599.97),
(4, '2024-10-12 10:00:00', 'Dostarczone', 249.98),
(4, '2024-10-18 15:20:00', 'Wysłane', 999.98),
(5, '2024-10-06 08:45:00', 'Dostarczone', 799.99),
(5, '2024-10-19 12:10:00', 'W realizacji', 189.98),
(6, '2024-10-11 14:30:00', 'Dostarczone', 649.98),
(6, '2024-10-23 10:00:00', 'Nowe', 349.99),
(7, '2024-10-09 09:30:00', 'Wysłane', 499.99),
(7, '2024-10-21 16:00:00', 'Dostarczone', 99.98),
(8, '2024-10-14 11:15:00', 'W realizacji', 799.99),
(8, '2024-10-24 13:45:00', 'Nowe', 199.99),
(9, '2024-10-07 10:20:00', 'Dostarczone', 849.98),
(9, '2024-10-17 14:50:00', 'Wysłane', 299.99),
(10, '2024-10-13 15:30:00', 'Dostarczone', 2499.99),
(10, '2024-10-25 09:00:00', 'W realizacji', 449.99),
(1, '2024-10-26 10:00:00', 'Nowe', 349.99),
(2, '2024-10-27 11:30:00', 'W realizacji', 599.98),
(3, '2024-10-28 13:00:00', 'Wysłane', 549.98),
(4, '2024-10-29 14:20:00', 'Dostarczone', 799.99),
(5, '2024-10-30 15:45:00', 'Nowe', 349.99),
(6, '2024-10-31 16:10:00', 'W realizacji', 899.98),
(7, '2024-11-01 09:30:00', 'Wysłane', 449.99),
(8, '2024-11-02 10:50:00', 'Dostarczone', 649.98),
(9, '2024-11-02 12:15:00', 'Nowe', 199.99),
(10, '2024-11-02 14:00:00', 'W realizacji', 899.98);

-- ============================================
-- TABELA: zamowienie_produkt
-- ============================================

CREATE TABLE zamowienie_produkt (
  id_zamowienia INT NOT NULL,
  id_produktu INT NOT NULL,
  ilosc INT NOT NULL,
  cena_jednostkowa DECIMAL(10,2) NOT NULL,
  PRIMARY KEY (id_zamowienia, id_produktu),
  FOREIGN KEY (id_zamowienia) REFERENCES zamowienie(id_zamowienia) ON DELETE CASCADE,
  FOREIGN KEY (id_produktu) REFERENCES produkt(id_produktu)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

INSERT INTO zamowienie_produkt (id_zamowienia, id_produktu, ilosc, cena_jednostkowa) VALUES
(1, 1, 1, 2499.99), (1, 2, 1, 49.99),
(2, 5, 1, 149.99),
(3, 4, 1, 799.99), (3, 2, 2, 49.99),
(4, 6, 1, 39.99), (4, 7, 3, 19.99),
(5, 4, 1, 799.99), (5, 2, 2, 49.99),
(6, 3, 1, 299.99), (6, 6, 1, 39.99), (6, 7, 13, 19.99),
(7, 2, 1, 49.99), (7, 8, 5, 89.99),
(8, 1, 1, 2499.99), (8, 5, 1, 149.99), (8, 10, 1, 349.99),
(9, 4, 1, 799.99),
(10, 9, 1, 199.99), (10, 7, 1, 19.99),
(11, 3, 1, 299.99), (11, 8, 1, 89.99), (11, 6, 1, 39.99),
(12, 10, 1, 349.99),
(13, 12, 1, 449.99), (13, 2, 1, 49.99),
(14, 6, 1, 39.99), (14, 7, 3, 19.99),
(15, 4, 1, 799.99),
(16, 9, 1, 199.99),
(17, 4, 1, 799.99), (17, 2, 1, 49.99),
(18, 3, 1, 299.99),
(19, 1, 1, 2499.99),
(20, 12, 1, 449.99),
(21, 10, 1, 349.99),
(22, 3, 1, 299.99), (22, 6, 1, 39.99), (22, 7, 13, 19.99),
(23, 2, 1, 49.99), (23, 8, 1, 89.99), (23, 11, 2, 199.99),
(24, 4, 1, 799.99),
(25, 10, 1, 349.99),
(26, 4, 1, 799.99), (26, 2, 2, 49.99),
(27, 12, 1, 449.99),
(28, 3, 1, 299.99), (28, 10, 1, 349.99),
(29, 9, 1, 199.99),
(30, 4, 1, 799.99), (30, 2, 2, 49.99);

-- ============================================
-- KONIEC SKRYPTU
-- ============================================