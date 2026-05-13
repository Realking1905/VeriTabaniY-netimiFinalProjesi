# 🍲 Çevrimiçi Yemek Sipariş & "Askıda Yemek" Sosyal Sorumluluk Modülü

Bu çalışma, klasik bir yemek sipariş platformunu modern veritabanı teknikleriyle (3NF) kurgulayan ve toplumsal dayanışmayı hedefleyen bir dönem projesidir.

## 🧠 Projenin Temel Mantığı ve İş Kuralları
Sistemi tasarlarken sadece "sipariş ver-gönder" akışını değil, verinin güvenliğini ve sürdürülebilirliğini de ön planda tuttum:

* **Soft Delete Uygulaması:** Sistemdeki hiçbir restoran veya ürün fiziksel olarak silinmez. `IsActive` kolonu üzerinden pasife çekilerek veri geçmişi korunur.
* **Referans Bütünlüğü:** Tüm tablolar PK (Primary Key) ve FK (Foreign Key) kısıtlamalarıyla birbirine sıkı sıkıya bağlanmıştır; bu sayede sistemsel hataların veya rastgele veri silinmelerinin önüne geçilmiştir.
* **Otomasyon (Triggerlar):** Sipariş tamamlandığında restoran cirosunun güncellenmesi veya havuzdan yemek çekildiğinde stoğun düşmesi gibi kritik işlemler, insan hatasını sıfıra indirmek için tamamen veritabanı seviyesinde otomatikleştirilmiştir.

## 🤝 "Askıda Yemek" Nasıl Çalışıyor? (Özel Modül)
Hocamızın belirttiği sosyal sorumluluk kuralı çerçevesinde şu mühendislik yaklaşımını benimsedim:
1. **Bağış Süreci:** Hayırsever kullanıcılar sisteme bağış yapar ve bu bilgiler `Bagislar` tablosuna kaydedilir.
2. **Merkezi Havuz:** Tüm bağışlar `AskidaHavuz` tablosunda anlık olarak stoklanır.
3. **Kullanım:** İhtiyaç sahibi olarak sisteme tanımlanmış (`IsVerified = 1`) kullanıcılar bu havuzdan sipariş geçebilir. Kullanım gerçekleştiği anda `trg_AskidaStokDusur` tetikleyicisi (trigger) stoğu otomatik olarak günceller.

## 📊 Raporlama ve Analiz Yetenekleri
Sistem üzerinde geliştirilen `JOIN`, `GROUP BY` ve `Subquery` yapıları sayesinde şu analizler yapılabilmektedir:
- En çok sipariş alan restoranların ciro ve performans analizi.
- Sosyal dayanışma kapsamında hiç bağış yapmamış aktif kullanıcıların tespiti.
- Askıda yemek havuzunun anlık doluluk ve stok durumu raporları.

## 🛠️ Kullanılan Teknolojiler ve AI Beyanı
- **Veritabanı:** MS SQL Server
- **Tasarım:** SQL Server Management Studio (SSMS) Diagram Tool
- **Yapay Zeka Kullanımı:** Bu projenin geliştirilme sürecinde kod bloklarının optimizasyonu ve yüksek hacimli test verilerinin (Mock Data) üretilmesi aşamasında **Google Gemini** asistan olarak kullanılmıştır. Üretilen tüm çıktılar projenin iş kurallarına göre tarafımdan analiz edilmiş ve gerekli manuel düzeltmeler yapılarak doğrulanmıştır.

---
**Hazırlayan:** Veysel Elibol  
**Bölüm:** Bilgisayar Mühendisliği 3. Sınıf
