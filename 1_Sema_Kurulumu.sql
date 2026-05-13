-- =========================================================================
-- 1. GÜN: VERÝTABANI ÞEMASI VE TABLO YAPILARININ OLUÞTURULMASI (DDL)
-- =========================================================================

-- Veritabaný oluþturuluyor 
CREATE DATABASE YemekSiparisPlatformu;
GO
USE YemekSiparisPlatformu;
GO

-- 1. TABLO: Kullanicilar (Müþteri, Baðýþçý ve Ýhtiyaç Sahipleri) [cite: 5, 7]
CREATE TABLE Kullanicilar (
    KullaniciID INT PRIMARY KEY IDENTITY(1,1),
    AdSoyad NVARCHAR(100) NOT NULL,
    Eposta NVARCHAR(100) UNIQUE NOT NULL, -- 
    Telefon CHAR(11) UNIQUE, -- 
    Sifre NVARCHAR(255) NOT NULL,
    IsVerified BIT DEFAULT 0, -- Ýhtiyaç sahibi doðrulamasý [cite: 7]
    IsActive BIT DEFAULT 1 -- Soft Delete [cite: 20]
);

-- 2. TABLO: Restoranlar [cite: 5]
CREATE TABLE Restoranlar (
    RestoranID INT PRIMARY KEY IDENTITY(1,1),
    RestoranAdi NVARCHAR(100) NOT NULL,
    Kategori NVARCHAR(50),
    RestoranPuani DECIMAL(2,1) DEFAULT 0,
    IsActive BIT DEFAULT 1, -- [cite: 20]
    CONSTRAINT CHK_RestoranPuani CHECK (RestoranPuani BETWEEN 0 AND 5) -- [cite: 14, 15]
);

-- 3. TABLO: Kuryeler [cite: 5]
CREATE TABLE Kuryeler (
    KuryeID INT PRIMARY KEY IDENTITY(1,1),
    AdSoyad NVARCHAR(100) NOT NULL,
    Telefon CHAR(11) UNIQUE NOT NULL,
    AracTipi NVARCHAR(30),
    IsActive BIT DEFAULT 1 -- [cite: 20]
);

-- 4. TABLO: Kategoriler
CREATE TABLE Kategoriler (
    KategoriID INT PRIMARY KEY IDENTITY(1,1),
    KategoriAd NVARCHAR(50) NOT NULL
);

-- 5. TABLO: Urunler (Menü) [cite: 5]
CREATE TABLE Urunler (
    UrunID INT PRIMARY KEY IDENTITY(1,1),
    RestoranID INT,
    KategoriID INT,
    UrunAdi NVARCHAR(100) NOT NULL,
    Fiyat DECIMAL(10,2) NOT NULL,
    IsActive BIT DEFAULT 1, -- [cite: 20]
    FOREIGN KEY (RestoranID) REFERENCES Restoranlar(RestoranID), -- [cite: 13]
    FOREIGN KEY (KategoriID) REFERENCES Kategoriler(KategoriID),
    CONSTRAINT CHK_Fiyat CHECK (Fiyat > 0) -- [cite: 14]
);

-- 6. TABLO: Adresler
CREATE TABLE Adresler (
    AdresID INT PRIMARY KEY IDENTITY(1,1),
    KullaniciID INT,
    AdresBasligi NVARCHAR(50),
    AdresDetay NVARCHAR(255) NOT NULL,
    FOREIGN KEY (KullaniciID) REFERENCES Kullanicilar(KullaniciID) -- [cite: 13]
);

-- 7. TABLO: Siparisler [cite: 5]
CREATE TABLE Siparisler (
    SiparisID INT PRIMARY KEY IDENTITY(1,1),
    KullaniciID INT,
    RestoranID INT,
    KuryeID INT,
    SiparisTarihi DATETIME DEFAULT GETDATE(),
    ToplamTutar DECIMAL(10,2),
    SiparisDurumu NVARCHAR(50) DEFAULT 'Hazýrlanýyor',
    FOREIGN KEY (KullaniciID) REFERENCES Kullanicilar(KullaniciID), -- [cite: 13]
    FOREIGN KEY (RestoranID) REFERENCES Restoranlar(RestoranID),
    FOREIGN KEY (KuryeID) REFERENCES Kuryeler(KuryeID)
);

-- 8. TABLO: SiparisDetay [cite: 5]
CREATE TABLE SiparisDetay (
    SiparisDetayID INT PRIMARY KEY IDENTITY(1,1),
    SiparisID INT,
    UrunID INT,
    Adet INT NOT NULL,
    BirimFiyat DECIMAL(10,2),
    FOREIGN KEY (SiparisID) REFERENCES Siparisler(SiparisID), -- [cite: 13]
    FOREIGN KEY (UrunID) REFERENCES Urunler(UrunID)
);

-- 9. TABLO: AskidaHavuz (Özel Modül) 
CREATE TABLE AskidaHavuz (
    HavuzID INT PRIMARY KEY IDENTITY(1,1),
    UrunID INT,
    MevcutAdet INT DEFAULT 0,
    SonGuncelleme DATETIME DEFAULT GETDATE(),
    FOREIGN KEY (UrunID) REFERENCES Urunler(UrunID) -- [cite: 13]
);

-- 10. TABLO: Bagislar (Hayýrsever Ýþlemleri) [cite: 7]
CREATE TABLE Bagislar (
    BagisID INT PRIMARY KEY IDENTITY(1,1),
    KullaniciID INT, -- Anonim baðýþ için NULL olabilir
    UrunID INT,
    BagisTarihi DATETIME DEFAULT GETDATE(),
    FOREIGN KEY (KullaniciID) REFERENCES Kullanicilar(KullaniciID),
    FOREIGN KEY (UrunID) REFERENCES Urunler(UrunID)
);

-- 11. TABLO: AskidaKullanimlar (Ýhtiyaç Sahibi Ýþlemleri) [cite: 7]
CREATE TABLE AskidaKullanimlar (
    KullanimID INT PRIMARY KEY IDENTITY(1,1),
    KullaniciID INT,
    UrunID INT,
    KullanimTarihi DATETIME DEFAULT GETDATE(),
    FOREIGN KEY (KullaniciID) REFERENCES Kullanicilar(KullaniciID),
    FOREIGN KEY (UrunID) REFERENCES Urunler(UrunID)
);

-- 12. TABLO: Yorumlar
CREATE TABLE Yorumlar (
    YorumID INT PRIMARY KEY IDENTITY(1,1),
    KullaniciID INT,
    RestoranID INT,
    Puan INT,
    YorumMetni NVARCHAR(500),
    FOREIGN KEY (KullaniciID) REFERENCES Kullanicilar(KullaniciID),
    FOREIGN KEY (RestoranID) REFERENCES Restoranlar(RestoranID),
    CONSTRAINT CHK_YorumPuan CHECK (Puan BETWEEN 1 AND 5) -- [cite: 14]
);