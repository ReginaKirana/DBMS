-- MANAJEMEN BASIS DATA
-- PERTEMUAN 3 
-- 24 FEB 2025
-- ----------------------------------------------------------

-- -------------------- TANPA PARAMETER --------------------
-- ----------------------- SOAL 1 -------------------------- 
-- Buatlah sebuah stored procedure untuk menampilkan semua proyek yang berlokasi di 'Houston'
DELIMITER $$
CREATE PROCEDURE ProjectByLocation()
BEGIN
	SELECT * from project
    Where Plocation = 'Houston';
END $$
DELIMITER ;
CALL ProjectByLocation;


-- ----------------------- SOAL 2 -------------------------- 
-- Buatlah sebuah stored procedure untuk menampilkan semua proyek yang berlokasi di 'Sugarland'
DELIMITER $$
DROP PROCEDURE ProjectByLocation;
DELIMITER ;

DELIMITER $$
CREATE PROCEDURE ProjectByLocation()
BEGIN
	SELECT * from project
    Where Plocation = 'Sugarland';
END $$
DELIMITER ;
CALL ProjectByLocation;


-- ----------------------- SOAL 3 -------------------------- 
-- Buatlah Procedure untuk menampilkan semua data dari tabel DEPARTMENT "Headquarters" 
SELECT * FROM DEPARTMENT;
DELIMITER $$
CREATE PROCEDURE Dept_Name()
BEGIN
	SELECT * FROM DEPARTMENT
    WHERE Dname = 'Headquarters';
END $$
DELIMITER ;
CALL Dept_Name;


-- ----------------------- SOAL 4 -------------------------- 
-- Buatlah Procedure untuk menampilkan semua data karyawan yang bekerja di departemen nomor 5 
DELIMITER $$
CREATE PROCEDURE Emp_5()
BEGIN
	SELECT * FROM EMPLOYEE
    WHERE Dno = 5;
END $$
DELIMITER ;
CALL Emp_5;


-- ----------------------- SOAL 5 -------------------------- 
-- Buatlah Procedure untuk menampilkan semua data karyawan yang bekerja di departemen "Research" (Pakai JOIN)
DELIMITER $$
CREATE PROCEDURE Emp_Research()
BEGIN
	SELECT * 
    FROM EMPLOYEE E
    JOIN DEPARTMENT D ON E.Dno = D.Dnumber
    WHERE D.Dname = 'Research';
END $$
DELIMITER ;
Call Emp_Research;
select * from department;

-- ----------------------- SOAL 6 -------------------------- 
-- Buatlah Procedure untuk menampilkan semua data proyek yang berada di bawah departemen "Research" (Pakai JOIN)
select * from project;
select * from department;
DELIMITER $$
CREATE PROCEDURE Proj_Research()
BEGIN
	SELECT * 
    FROM project P
    JOIN department D ON p.Dnum = D.Dnumber
    WHERE D.Dname = 'Research';
END $$
DELIMITER ;
Call Proj_Research();
select * from department;

-- Buatlah Procedure untuk menampilkan semua data proyek yang berada di bawah departemen "Research" (Tidak Pakai JOIN)
select * from project;
DELIMITER $$
CREATE PROCEDURE Proj_Lima()
BEGIN
	SELECT * 
    FROM project P
    WHERE Dnum = 5;
END $$
DELIMITER ;
Call Proj_Lima;


-- --------------------- PARAMETER IN ----------------------
-- ----------------------- SOAL 7 -------------------------- 
-- Buatlah stored procedure untuk menampilkan karyawan dengan gaji sebesar 30.000.
SELECT * FROM EMPLOYEE;
DELIMITER $$
CREATE PROCEDURE Emp_tiga(IN Gaji Decimal(5,0))
BEGIN
	SELECT * 
    FROM EMPLOYEE E
    WHERE Salary = Gaji;
END $$
DELIMITER ;
CALL Emp_tiga(30000);


-- ----------------------- SOAL 8 -------------------------- 
-- Buatlah procedure unyuk menampilkan Essn dari tabel dependent berdasarkan nama = 'Alice'
select * from dependent;
select * from employee;
DESCRIBE dependent;
DELIMITER $$
CREATE PROCEDURE E_Alice(IN nama VARCHAR(15))
BEGIN
	SELECT Essn
    FROM dependent
    WHERE Dependent_name = nama;
END $$
DELIMITER ;
CALL E_Alice('Alice');


-- -------------------- PARAMETER OUT ----------------------
-- ----------------------- SOAL 9 -------------------------- 
-- Buatlah Procedure bernama untuk menghitung jumlah proyek di Stafford. 
select * from project; 
DELIMITER $$ 
CREATE PROCEDURE GetStaford(IN location varchar(15), OUT jum INT)
BEGIN
	SELECT COUNT(Pnumber) into jum
    from project
    Where Plocation = location;
END $$ 
DELIMITER ;
CALL getStaford('Stafford', @jumlah);
select @jum as Jumlah_Stafford;


-- ----------------------- SOAL 10 -------------------------- 
-- Buatlah Procedure untuk menghitung jumlah proyek di Houston
DELIMITER $$ 
CREATE PROCEDURE GetHouston(IN location varchar(15), OUT suma INT)
BEGIN
	SELECT COUNT(Pnumber) into suma
    from project
    Where Plocation = location;
END $$ 
DELIMITER ;
CALL getHouston('Houston', @jumlah);
select @jumlah as Jumlah_Houston;


-- ----------------------- SOAL 11 -------------------------- 
-- Buatlah Procedure Emp_lima untuk menghitung jumlah karyawan dalam suatu departemen, nomor departemen = 5
select * from employee;
describe employee;
DELIMITER $$ 
CREATE PROCEDURE Emp_lima(IN denum int, OUT jml INT)
BEGIN
	SELECT COUNT(Ssn) into jml
    from employee
    Where Dno = denum;
END $$ 
DELIMITER ;
call Emp_lima(5, @jmlh);
select @jmlh as Jumlah_dept5;


-- ------------------ PARAMETER INOUT ---------------------
-- ----------------------- SOAL 12 -------------------------- 
-- Ubah salary, ke employee yang < 30000 ke 320000
DELIMITER $$
CREATE PROCEDURE CEmpSala(INOUT gaji decimal(5,0))
BEGIN
	IF gaji <=30000 THEN
    SET gaji = 32000;
    END IF;
END $$
DELIMITER ;

select * from employee;
SELECT Salary into @newSala
	FROM employee
	WHERE Ssn = '987987987';
    
Call CEmpSala(@newSala);
select @newSala;

-- ----------------------------------------------------------
-- ---------------------  MERCI  ----------------------------
-- ----------------------------------------------------------