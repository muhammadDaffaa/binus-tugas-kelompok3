-- --------------------------------------------------------
-- Host:                         127.0.0.1
-- Server version:               8.0.17 - MySQL Community Server - GPL
-- Server OS:                    Win64
-- HeidiSQL Version:             12.4.0.6659
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;


-- Dumping database structure for employee_db
CREATE DATABASE IF NOT EXISTS `employee_db` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `employee_db`;

-- Dumping structure for table employee_db.covid_test
CREATE TABLE IF NOT EXISTS `covid_test` (
  `id_test` int(11) NOT NULL AUTO_INCREMENT,
  `status_test` varchar(255) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id_test`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Dumping data for table employee_db.covid_test: ~2 rows (approximately)
DELETE FROM `covid_test`;
INSERT INTO `covid_test` (`id_test`, `status_test`) VALUES
	(1, 'negatif'),
	(2, 'positif');

-- Dumping structure for table employee_db.divisi
CREATE TABLE IF NOT EXISTS `divisi` (
  `id_divisi` int(11) NOT NULL AUTO_INCREMENT,
  `nama_divisi` varchar(50) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id_divisi`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Dumping data for table employee_db.divisi: ~2 rows (approximately)
DELETE FROM `divisi`;
INSERT INTO `divisi` (`id_divisi`, `nama_divisi`) VALUES
	(1, 'Engineer'),
	(2, 'Sales');

-- Dumping structure for table employee_db.karyawan
CREATE TABLE IF NOT EXISTS `karyawan` (
  `id_karyawan` int(255) NOT NULL AUTO_INCREMENT,
  `nama_karyawan` varchar(255) NOT NULL,
  `alamat_karyawan` varchar(255) NOT NULL,
  `kelamin_karyawan` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `no_telpon_karyawan` int(255) NOT NULL,
  `username_karyawan` varchar(50) NOT NULL DEFAULT '',
  `password_karyawan` varchar(50) NOT NULL DEFAULT '',
  `id_divisi` int(255) NOT NULL,
  `id_role` int(255) NOT NULL,
  PRIMARY KEY (`id_karyawan`),
  KEY `id_divisi` (`id_divisi`),
  KEY `id_role` (`id_role`),
  CONSTRAINT `FK_karyawan_divisi` FOREIGN KEY (`id_divisi`) REFERENCES `divisi` (`id_divisi`),
  CONSTRAINT `FK_karyawan_role` FOREIGN KEY (`id_role`) REFERENCES `role` (`id_role`)
) ENGINE=InnoDB AUTO_INCREMENT=18 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Dumping data for table employee_db.karyawan: ~2 rows (approximately)
DELETE FROM `karyawan`;
INSERT INTO `karyawan` (`id_karyawan`, `nama_karyawan`, `alamat_karyawan`, `kelamin_karyawan`, `no_telpon_karyawan`, `username_karyawan`, `password_karyawan`, `id_divisi`, `id_role`) VALUES
	(16, '23123', 'kebantenan', 'sdasdasdasd', 90838730, 'asdasd', 'pbkdf2:sha256:600000$4mzqjoacYJm74jDP$78aa150023f2', 1, 1),
	(17, '23123', 'kebantenan', 'sdasdasdasd', 90838730, 'asdasd', 'asd', 1, 1);

-- Dumping structure for table employee_db.laporan
CREATE TABLE IF NOT EXISTS `laporan` (
  `id_laporan` int(11) NOT NULL AUTO_INCREMENT,
  `id_laporan_kinerja` int(11) NOT NULL DEFAULT '0',
  `id_laporan_pencapaian` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id_laporan`),
  KEY `id_laporan_kinerja` (`id_laporan_kinerja`),
  KEY `id_laporan_pencapaian` (`id_laporan_pencapaian`),
  CONSTRAINT `FK_laporan_laporan_kinerja` FOREIGN KEY (`id_laporan_kinerja`) REFERENCES `laporan_kinerja` (`id_laporan_kinerja`),
  CONSTRAINT `FK_laporan_laporan_pencapaian` FOREIGN KEY (`id_laporan_pencapaian`) REFERENCES `laporan_pencapaian` (`id_laporan_pencapaian`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Dumping data for table employee_db.laporan: ~1 rows (approximately)
DELETE FROM `laporan`;
INSERT INTO `laporan` (`id_laporan`, `id_laporan_kinerja`, `id_laporan_pencapaian`) VALUES
	(1, 1, 1);

-- Dumping structure for table employee_db.laporan_kinerja
CREATE TABLE IF NOT EXISTS `laporan_kinerja` (
  `id_laporan_kinerja` int(11) NOT NULL AUTO_INCREMENT,
  `keterangan_kinerja` varchar(50) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id_laporan_kinerja`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Dumping data for table employee_db.laporan_kinerja: ~3 rows (approximately)
DELETE FROM `laporan_kinerja`;
INSERT INTO `laporan_kinerja` (`id_laporan_kinerja`, `keterangan_kinerja`) VALUES
	(1, 'Sangat Baik'),
	(2, 'Baik'),
	(3, 'Cukup');

-- Dumping structure for table employee_db.laporan_pencapaian
CREATE TABLE IF NOT EXISTS `laporan_pencapaian` (
  `id_laporan_pencapaian` int(11) NOT NULL AUTO_INCREMENT,
  `keterangan_pencapaian` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id_laporan_pencapaian`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Dumping data for table employee_db.laporan_pencapaian: ~1 rows (approximately)
DELETE FROM `laporan_pencapaian`;
INSERT INTO `laporan_pencapaian` (`id_laporan_pencapaian`, `keterangan_pencapaian`) VALUES
	(1, 'Berhasil Memecahkan Masalah yang sulit');

-- Dumping structure for table employee_db.role
CREATE TABLE IF NOT EXISTS `role` (
  `id_role` int(11) NOT NULL AUTO_INCREMENT,
  `nama_role` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT '0',
  PRIMARY KEY (`id_role`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci ROW_FORMAT=DYNAMIC;

-- Dumping data for table employee_db.role: ~2 rows (approximately)
DELETE FROM `role`;
INSERT INTO `role` (`id_role`, `nama_role`) VALUES
	(1, 'Admin'),
	(2, 'User');

/*!40103 SET TIME_ZONE=IFNULL(@OLD_TIME_ZONE, 'system') */;
/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IFNULL(@OLD_FOREIGN_KEY_CHECKS, 1) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40111 SET SQL_NOTES=IFNULL(@OLD_SQL_NOTES, 1) */;
