-- =========================================================================
-- 3. GÜN: ASKIDA YEMEK MODÜLÜ VE SÝPARÝÞ AKIÞI (DML)
-- =========================================================================
USE YemekSiparisPlatformu;
GO

-- 1. ADIM: HAVUZA BAÞLANGIÇ ÜRÜNLERÝNÝN EKLENMESÝ 
-- (Hangi üründen kaç adet askýda bekliyor?)
INSERT INTO AskidaHavuz (UrunID, MevcutAdet) VALUES 
(1, 10), -- Adana Kebap
(5, 20), -- Lahmacun
(11, 5), -- Margarita Pizza
(12, 8);  -- Karýþýk Pizza

-- 2. ADIM: BAÐIÞ HAREKETLERÝNÝN OLUÞTURULMASI 
-- (Hayýrseverlerin sisteme yaptýðý baðýþlar)
INSERT INTO Bagislar (KullaniciID, UrunID) VALUES 
(1, 1), -- Veysel Baþkan 1 Adana Kebap baðýþladý
(3, 5), -- Ýsa Acar 5 Lahmacun baðýþladý
(5, 11), -- Arafat Çoban 2 Pizza baðýþladý
(NULL, 1); -- Anonim bir baðýþ yapýldý

-- 3. ADIM: KLASÝK SÝPARÝÞ HAREKETLERÝ [cite: 5, 19]
-- (Normal nakit/kart ile verilen sipariþler)
INSERT INTO Siparisler (KullaniciID, RestoranID, KuryeID, ToplamTutar, SiparisDurumu) VALUES 
(6, 1, 1, 330.00, 'Teslim Edildi'), -- Sefa Oðuz sipariþi
(1, 2, 2, 245.00, 'Yolda');

-- 4. ADIM: ASKIDAN YEMEK KULLANIMI 
-- (Ýhtiyaç sahiplerinin havuzdan ücretsiz sipariþ vermesi)
-- Önce kullaným kaydý atýlýr:
INSERT INTO AskidaKullanimlar (KullaniciID, UrunID) VALUES 
(2, 1), -- Harun Al (Ýhtiyaç sahibi) 1 Adana Kebap kullandý 
(4, 5); -- Diyar Biçen 1 Lahmacun kullandý 

-- 5. ADIM: SÝPARÝÞ DETAYLARININ GÝRÝLMESÝ 
-- (Sipariþlerin içeriði)
INSERT INTO SiparisDetay (SiparisID, UrunID, Adet, BirimFiyat) VALUES 
(1, 1, 1, 250.00), -- 1 Adana
(1, 5, 1, 80.00);  -- 1 Lahmacun