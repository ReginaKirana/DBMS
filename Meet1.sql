-- PERTEMUAN 1 {KELAS} --
-- Soal UAS {Sintaks APEX} --

-- 1. Tampilkan data events berupa bulan dan jumlah biaya dalam bulan tersebut yang dilaksanakan mulai
-- januari 2004 hingga juni 2004 yang dikelompokkan berdasarkan bulannya diurutkan berdasarkan bulan!
-- Cek: Tabel d_events
SELECT * FROM D_EVENTS
-- Ketentuan: {Data bulan, jumlah biaya} ; {Mulai Januari 2004 - Juni 2004} ; {Dikelompokan dan diurutkan berdasarkan bulan}
SELECT 
    TO_CHAR(EVENT_DATE, 'YYYY-MM') AS BULAN, 
    SUM(COST) AS TOTAL_BIAYA
FROM D_EVENTS
WHERE TO_DATE(EVENT_DATE, 'DD-Mon-YYYY') 
      BETWEEN DATE '2004-01-01' AND DATE '2004-06-30'
GROUP BY TO_CHAR(EVENT_DATE, 'YYYY-MM')
ORDER BY TO_CHAR(EVENT_DATE, 'YYYY-MM');


-- 2. Tampilkan data clients yang terdiri dari nomor clients, nama lengkap (gabungan nama depan dan belakang), phone, dan email. 
-- Data yang tampil hanya data yang memiliki phone = 5335 pada bagian tengah, bukan diawal maupun diakhir!
-- Cek: Tabel d_clients
SELECT * FROM D_CLIENTS
-- Ketentuan: {Data nomor client, nama lengkap (FN + LN), Phone, Email} ; {Data phone 5335 di bagian tengah, bukan awal atau akhir}
SELECT 
    CLIENT_NUMBER AS NOMOR_KLIEN, 
    FIRST_NAME || ' ' || LAST_NAME AS NAMA_LENGKAP, 
    PHONE as NO_TELP, 
    EMAIL
FROM d_clients
WHERE PHONE LIKE '%5335%'
AND PHONE NOT LIKE '5335%' 
AND PHONE NOT LIKE '%5335';


-- 3. Ubahlah data venues untuk rental_feenya menjadi $500/night untuk hotel di kota Los Angeles 
-- yang memiliki Gazebo! berikan informasi jumlah data yang berubah karena query yang anda buat!
-- Cek: Tabel d_venues
SELECT * FROM D_VENUES
-- Ketentuan: {Ubah data venue, rental_fee = $500/night untuk hotel di Los Angeles yang memiliki Gazebo} 
            --{Beri info jumlah data yang berubah}
UPDATE D_VENUES
SET RENTAL_FEE = '500/night'
WHERE LOC_TYPE = 'Hotel'
AND ADDRESS LIKE '%Los Angeles%'
AND COMMENTS LIKE '%GAZEBO%';
-- Data yang berubah: 0 row(s) updated 
-- {Tidak ada hotel di LA, hotel tidak memiliki Gazebo}


-- 4. Tampilkan seluruh pakages yang memiliki code ganjil dan 
-- diurutkan berdasarkan digit ke 2 code dari besar ke kecil!
-- Cek: Tabel d_packages
SELECT * FROM D_PACKAGES
-- Ketentuan: {Tampilkan seluruh packages} {Kode Ganjil dan diurutkan berdasar digit ke-2 code dari besar ke kecil (Descending)}
SELECT * 
FROM D_PACKAGES
WHERE MOD(CODE, 2) = 1
ORDER BY SUBSTR((CODE), 2) DESC;