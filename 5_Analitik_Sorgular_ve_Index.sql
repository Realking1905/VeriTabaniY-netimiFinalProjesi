-- =========================================================================
-- 5. GÜN: ANALÝTÝK SORGULAR VE PERFORMANS (DQL & INDEXING)
-- =========================================================================
USE YemekSiparisPlatformu;
GO

-- 1. ADIM: PERFORMANS ÝYÝLEÞTÝRMELERÝ (INDEXING) 
-- Sýk aranan alanlara (E-posta ve Sipariþ Durumu gibi) index ekliyoruz.
CREATE INDEX IDX_Kullanici_Eposta ON Kullanicilar(Eposta);
CREATE INDEX IDX_Siparis_Durum ON Siparisler(SiparisDurumu);
GO

-- 2. ADIM: GELÝÞMÝÞ JOIN SORGUSU (DETAYLI SÝPARÝÞ FÝÞÝ) 
-- En az 3 tabloyu baðlayan, müþteri-restoran-ürün dökümü.
SELECT 
    S.SiparisID,
    K.AdSoyad AS Musteri,
    R.RestoranAdi,
    U.UrunAdi,
    SD.Adet,
    SD.BirimFiyat,
    S.SiparisTarihi
FROM Siparisler S
INNER JOIN Kullanicilar K ON S.KullaniciID = K.KullaniciID
INNER JOIN Restoranlar R ON S.RestoranID = R.RestoranID
INNER JOIN SiparisDetay SD ON S.SiparisID = SD.SiparisID
INNER JOIN Urunler U ON SD.UrunID = U.UrunID;
GO

-- 3. ADIM: GRUPLAMA VE ANALÝZ (GRUP BY & HAVING) 
-- Toplam sipariþ tutarý 500 TL'den fazla olan restoranlarýn listesi.
SELECT 
    R.RestoranAdi, 
    COUNT(S.SiparisID) AS ToplamSiparisSayisi,
    SUM(S.ToplamTutar) AS ToplamCiro
FROM Siparisler S
JOIN Restoranlar R ON S.RestoranID = R.RestoranID
GROUP BY R.RestoranAdi
HAVING SUM(S.ToplamTutar) > 500;
GO

-- 4. ADIM: ALT SORGU (SUBQUERY) 
-- Hiç baðýþ yapmamýþ ama sistemde kayýtlý olan kullanýcýlarý listele.
SELECT AdSoyad, Eposta 
FROM Kullanicilar 
WHERE KullaniciID NOT IN (SELECT DISTINCT KullaniciID FROM Bagislar WHERE KullaniciID IS NOT NULL);
GO