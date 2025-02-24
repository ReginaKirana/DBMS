-- DELIMITER
-- DELIMITER membantu MySQL memahami blok kode dengan lebih baik, terutama dalam Stored Procedure, Function, dan Trigger.
-- Tanpa DELIMITER, MySQL bisa salah mengira bahwa titik koma (;) di dalam blok prosedur adalah akhir dari keseluruhan perintah.


-- -----------------------------------------------------------------------------------------------------------------
-- PARAMETER IN 
-- Parameter IN dalam Stored Procedure digunakan untuk mengirimkan nilai dari program utama ke prosedur, 
-- tetapi nilai tersebut tidak bisa diubah di dalam prosedur. 

DELIMITER $$
DROP PROCEDURE getAllPorjectsByLocation;
DELIMITER ;

-- Stored Procedure getAllPorjectsByLocation : untuk mendapatkan daftar proyek berdasarkan lokasi.
DELIMITER $$
CREATE PROCEDURE getAllProjectsByLocation(IN location varchar(15))
BEGIN
	SELECT * FROM PROJECT
    WHERE Plocation = location;
END $$
DELIMITER ;

select * from project;
CALL getAllProjectsByLocation ('Stafford');
CALL getAllProjectsByLocation ('Houston');


-- --------------------------------------------------------------------------------------------------------------
-- PARAMETER OUT
-- Dalam stored procedure, parameter OUT digunakan untuk mengembalikan hasil dari prosedur ke program utama
-- Nilainya bisa diubah dalam prosedur sebelum dikembalikan.
-- Prosedur yang memanggilnya bisa mengambil hasilnya menggunakan variabel SQL (@variabel).

DELIMITER $$
DROP PROCEDURE getPorjectsCountByLocation;
DELIMITER ;

DELIMITER $$
CREATE PROCEDURE getProjectsCountByLocation(IN location varchar(15), OUT amount INT)
BEGIN
	SELECT COUNT(Pnumber) INTO amount
		FROM Project
		WHERE Plocation = location;
END$$
DELIMITER ;

Select * from project;

CALL getProjectsCountByLocation('Bellaire', @sum);
SELECT @sum as BSum;

CALL getProjectsCountByLocation('Stafford', @jumlah);
SELECT @jumlah AS jumlah_project; 

--  Contoh Modifikasi Nilai OUT (Dapat Diubah)
-- DELIMITER $$  
-- CREATE PROCEDURE getModifiedProjectsCount(IN location VARCHAR(15), OUT amount INT)  
-- BEGIN  
--     SELECT COUNT(Pnumber) INTO amount FROM project WHERE Plocation = location;  
--     SET amount = amount + 2;  -- Tambahkan 2 sebagai bonus proyek tambahan (INI BAGIAN DIUBAHNYA)
-- END$$  
-- DELIMITER ;


-- -----------------------------------------------------------------------------------------------------------
-- Parameter INOUT
-- INOUT memungkinkan perubahan nilai dalam prosedur dan hasil akhirnya dikembalikan ke pemanggil

DELIMITER $$
DROP PROCEDURE ubahEmployeeSalary;
DELIMITER ;

DELIMITER $$
CREATE PROCEDURE ubahEmployeeSalary(INOUT Salary decimal(5,0))
BEGIN
	IF Salary < 26000 THEN
		SET Salary = 27000; -- Ini bagian ubah (out nya)
        END IF;
END$$
DELIMITER ;
 
SELECT Salary into @newSalary
	FROM employee
	WHERE Ssn = 999887777;
    
-- SELECT Salary from Employee
-- 	WHERE Ssn = 999887777; Awalnya 25000
    
SELECT @newSalary;
CALL ubahEmployeeSalary(@newSalary);
SELECT @newSalary; 


-- ---------------------------------------------------------------------------------------------------------------
-- FUNCTION
-- Stored Function digunakan untuk mengembalikan satu nilai tunggal, seperti status, perhitungan, atau validasi data.
-- Stored Function lebih cocok untuk perhitungan atau konversi data daripada untuk mengubah database.

DELIMITER $$
DROP FUNCTION getSalaryStatus;
DELIMITER ;

DELIMITER $$
CREATE FUNCTION getSalaryStatus(Salary decimal(5,0))
RETURNS VARCHAR(10)
DETERMINISTIC
BEGIN
	DECLARE statusSalary VARCHAR(10);
    IF Salary<30000 THEN
		SET statusSalary = 'rendah';
	ELSEIF Salary >= 30000 AND Salary <= 50000 THEN
		SET statusSalary = 'sedang';
	ELSE 
		SET statusSalary = 'tinggi';
	END IF;
		RETURN(statusSalary);
END $$
DELIMITER ;

SELECT getSalaryStatus(7000);
SELECT getSalaryStatus(35000);
SELECT getSalaryStatus(80000);