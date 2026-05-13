-- =========================================================================
-- 4. GÜN: PROGRAMLANABÝLÝR NESNELER (VIEW & TRIGGER)
-- =========================================================================
USE YemekSiparisPlatformu;
GO

-- 1. GÖRÜNÜM (VIEW): Askýda Yemek Havuz Durumu
-- Hocan sorduðunda: "Karmaþýk join iþlemlerini basitleþtirmek için kullandým" dersin.
IF OBJECT_ID('vw_AskidaYemekHavuzDurumu', 'V') IS NOT NULL DROP VIEW vw_AskidaYemekHavuzDurumu;
GO

CREATE VIEW vw_AskidaYemekHavuzDurumu AS
SELECT 
    U.UrunAdi,
    R.RestoranAdi,
    H.MevcutAdet,
    H.SonGuncelleme
FROM AskidaHavuz H
JOIN Urunler U ON H.UrunID = U.UrunID
JOIN Restoranlar R ON U.RestoranID = R.RestoranID
WHERE U.IsActive = 1;
GO

-- 2. TETÝKLEYÝCÝ (TRIGGER): Havuz Stok Azaltma
-- Bir ihtiyaç sahibi yemek kullandýðýnda havuzdaki sayý otomatik düþer.
IF OBJECT_ID('trg_AskidaStokDusur', 'TR') IS NOT NULL DROP TRIGGER trg_AskidaStokDusur;
GO

CREATE TRIGGER trg_AskidaStokDusur
ON AskidaKullanimlar
AFTER INSERT
AS
BEGIN
    DECLARE @UrunID INT;
    SELECT @UrunID = UrunID FROM inserted;

    UPDATE AskidaHavuz
    SET MevcutAdet = MevcutAdet - 1,
        SonGuncelleme = GETDATE()
    WHERE UrunID = @UrunID;
END;
GO

-- 3. TETÝKLEYÝCÝ (TRIGGER): Sipariþ Tamamlanýnca Ciro Güncelleme
-- Restoranlar tablosuna ciro takibi için kolon ekliyoruz.
IF NOT EXISTS (SELECT * FROM sys.columns WHERE object_id = OBJECT_ID('Restoranlar') AND name = 'ToplamCiro')
BEGIN
    ALTER TABLE Restoranlar ADD ToplamCiro DECIMAL(18,2) DEFAULT 0;
END
GO

IF OBJECT_ID('trg_SiparisCiroGuncelle', 'TR') IS NOT NULL DROP TRIGGER trg_SiparisCiroGuncelle;
GO

CREATE TRIGGER trg_SiparisCiroGuncelle
ON Siparisler
AFTER UPDATE
AS
BEGIN
    -- Sadece SiparisDurumu deðiþtiðinde çalýþýr
    IF UPDATE(SiparisDurumu)
    BEGIN
        DECLARE @RestoranID INT, @Tutar DECIMAL(10,2), @YeniDurum NVARCHAR(50);
        SELECT @RestoranID = RestoranID, @Tutar = ToplamTutar, @YeniDurum = SiparisDurumu FROM inserted;

        IF @YeniDurum = 'Teslim Edildi'
        BEGIN
            UPDATE Restoranlar
            SET ToplamCiro = ToplamCiro + ISNULL(@Tutar, 0)
            WHERE RestoranID = @RestoranID;
        END
    END
END;
GO