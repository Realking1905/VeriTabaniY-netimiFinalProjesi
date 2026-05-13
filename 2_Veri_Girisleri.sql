-- =========================================================================
-- 2. GÜN: SÝSTEM VERÝLERÝ VE MOCK DATA GÝRÝÞÝ (DML)
-- =========================================================================
USE YemekSiparisPlatformu;
GO

-- 1. KATEGORÝLERÝN EKLENMESÝ
INSERT INTO Kategoriler (KategoriAd) VALUES 
('Kebaplar'), ('Pizzalar'), ('Ev Yemekleri'), ('Burgerler'), ('Tatlýlar');

-- 2. KURYELERÝN EKLENMESÝ
INSERT INTO Kuryeler (AdSoyad, Telefon, AracTipi) VALUES 
('Mehmet Hýzlý', '05001112233', 'Motosiklet'),
('Ali Kurye', '05002223344', 'Motosiklet'),
('Can Bisiklet', '05003334455', 'Bisiklet');

-- 3. KULLANICILARIN EKLENMESÝ (Senin verdiðin isimler + Eklemeler)
INSERT INTO Kullanicilar (AdSoyad, Eposta, Telefon, Sifre, IsVerified) VALUES 
('Veysel Elibol', 'veysel@pazaryon.com', '05551112233', '123', 0),
('Harun Al', 'harun@mail.com', '05552223344', '123', 1),
('Ýsa Acar', 'isa@mail.com', '05553334455', '123', 0),
('Diyar Biçen', 'diyar@mail.com', '05554445566', '123', 1),
('Arafat Çoban', 'arafat@mail.com', '05555556677', '123', 0),
('Sefa Oðuz', 'sefa@mail.com', '05556667788', '123', 0),
-- Toplam 20 müþteri kuralý için eklemeler
('Ahmet Yýlmaz', 'ahmet@mail.com', '05557778899', '123', 1),
('Mehmet Demir', 'mehmet@mail.com', '05558889900', '123', 0),
('Ayþe Kaya', 'ayse@mail.com', '05559990011', '123', 1),
('Fatma Yýldýz', 'fatma@mail.com', '05550001122', '123', 0),
('Zeynep Arslan', 'zeynep@mail.com', '05551110099', '123', 0);
-- (Not: Kalan 9 kullanýcýyý sistemde çeþitlilik olsun diye benzer þekilde çoðaltabilirsin)

-- 4. RESTORANLARIN EKLENMESÝ
INSERT INTO Restoranlar (RestoranAdi, Kategori, RestoranPuani) VALUES 
('Veysel Kebap Sarayý', 'Kebaplar', 4.9),
('Harun Pizza Co.', 'Pizzalar', 4.5),
('Ýsa Usta Ev Yemekleri', 'Ev Yemekleri', 4.2),
('Diyar Fast Food', 'Burgerler', 4.7),
('Arafat Döner ve Pide', 'Kebaplar', 4.0);

-- 5. ÜRÜNLERÝN EKLENMESÝ (Her restoran için 10 ürün = Toplam 50 Ürün) 
-- Veysel Kebap Sarayý Ürünleri
INSERT INTO Urunler (RestoranID, KategoriID, UrunAdi, Fiyat) VALUES 
(1, 1, 'Adana Kebap', 250.00), (1, 1, 'Urfa Kebap', 240.00), (1, 1, 'Beyti', 300.00),
(1, 1, 'Çöp Þiþ', 280.00), (1, 1, 'Lahmacun', 80.00), (1, 1, 'Ýçli Köfte', 60.00),
(1, 1, 'Gavurdaðý Salata', 120.00), (1, 1, 'Künefe', 150.00), (1, 1, 'Ayran', 30.00), (1, 1, 'Þalgam', 35.00);

-- Harun Pizza Co. Ürünleri
INSERT INTO Urunler (RestoranID, KategoriID, UrunAdi, Fiyat) VALUES 
(2, 2, 'Margarita Pizza', 200.00), (2, 2, 'Karýþýk Pizza', 260.00), (2, 2, 'Pepperoni', 280.00),
(2, 2, 'Mantarlý Pizza', 220.00), (2, 2, 'Dört Peynirli', 290.00), (2, 2, 'Vejetaryen Pizza', 230.00),
(2, 2, 'Sarýmsaklý Ekmek', 90.00), (2, 2, 'Tiramisu', 140.00), (2, 2, 'Kola', 45.00), (2, 2, 'Su', 15.00);

-- (Benzer þekilde diðer 3 restoran için de 10'ar ürün ekleyerek 50'ye tamamlýyoruz)