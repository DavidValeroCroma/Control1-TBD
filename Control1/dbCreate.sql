DROP TABLE IF EXISTS `comuna`;
CREATE TABLE `comuna` (
  `id_comuna` int NOT NULL AUTO_INCREMENT,
  `nombre` varchar(100) NOT NULL,
  PRIMARY KEY (`id_comuna`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

DROP TABLE IF EXISTS `empleado`;
CREATE TABLE `empleado` (
  `id_empleado` int NOT NULL AUTO_INCREMENT,
  `nombre` varchar(100) NOT NULL,
  `tipo` varchar(100) NOT NULL,
  `rut` int NOT NULL,
  UNIQUE KEY `id_empleado` (`id_empleado`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

DROP TABLE IF EXISTS `alumno`;
CREATE TABLE `alumno` (
  `id_alumno` int NOT NULL AUTO_INCREMENT,
  `nombre` varchar(100) NOT NULL,
  `rut` int NOT NULL,
  `sexo` enum('M','F') NOT NULL,
  `id_comuna` int NOT NULL,
  PRIMARY KEY (`id_alumno`),
  KEY `alumno_FK` (`id_comuna`),
  CONSTRAINT `alumno_FK` FOREIGN KEY (`id_comuna`) REFERENCES `comuna` (`id_comuna`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

DROP TABLE IF EXISTS `apoderado`;
CREATE TABLE `apoderado` (
  `id_apod` int NOT NULL AUTO_INCREMENT,
  `nombre` varchar(100) NOT NULL,
  `rut` int NOT NULL,
  `parentesco` varchar(100) NOT NULL,
  `id_comuna` int NOT NULL,
  PRIMARY KEY (`id_apod`),
  KEY `apoderado_FK` (`id_comuna`),
  CONSTRAINT `apoderado_FK` FOREIGN KEY (`id_comuna`) REFERENCES `comuna` (`id_comuna`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

DROP TABLE IF EXISTS `colegio`;
CREATE TABLE `colegio` (
  `id_colegio` int NOT NULL AUTO_INCREMENT,
  `nombre` varchar(100) NOT NULL,
  `direccion` varchar(200) NOT NULL,
  `id_comuna` int NOT NULL,
  PRIMARY KEY (`id_colegio`),
  KEY `colegio_FK` (`id_comuna`),
  CONSTRAINT `colegio_FK` FOREIGN KEY (`id_comuna`) REFERENCES `comuna` (`id_comuna`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

DROP TABLE IF EXISTS `profesor`;
CREATE TABLE `profesor` (
  `id_prof` int NOT NULL AUTO_INCREMENT,
  `asignatura` varchar(100) NOT NULL,
  `id_empleado` int NOT NULL,
  PRIMARY KEY (`id_prof`),
  UNIQUE KEY `id_prof` (`id_prof`),
  KEY `profesor_FK` (`id_empleado`),
  CONSTRAINT `profesor_FK` FOREIGN KEY (`id_empleado`) REFERENCES `empleado` (`id_empleado`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

DROP TABLE IF EXISTS `plantilla_curso`;
CREATE TABLE `plantilla_curso` (
  `id_plant` int NOT NULL AUTO_INCREMENT,
  `cant_alumnos` int NOT NULL DEFAULT '35',
  `planificacion` varchar(300) DEFAULT NULL,
  PRIMARY KEY (`id_plant`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

DROP TABLE IF EXISTS `curso`;
CREATE TABLE `curso` (
  `id_curso` int NOT NULL AUTO_INCREMENT,
  `nivel` int NOT NULL,
  `id_plant` int NOT NULL,
  `id_profesor_jefe` int NOT NULL,
  `año` int NOT NULL,
  PRIMARY KEY (`id_curso`),
  KEY `curso_FK` (`id_profesor_jefe`),
  KEY `curso_FK_1` (`id_plant`),
  CONSTRAINT `curso_FK` FOREIGN KEY (`id_profesor_jefe`) REFERENCES `profesor` (`id_prof`),
  CONSTRAINT `curso_FK_1` FOREIGN KEY (`id_plant`) REFERENCES `plantilla_curso` (`id_plant`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

DROP TABLE IF EXISTS `sueldo`;
CREATE TABLE `sueldo` (
  `id_sueldo` int NOT NULL AUTO_INCREMENT,
  `monto` int NOT NULL,
  `id_empleado` int NOT NULL,
  PRIMARY KEY (`id_sueldo`),
  KEY `sueldo_FK` (`id_empleado`),
  CONSTRAINT `sueldo_FK` FOREIGN KEY (`id_empleado`) REFERENCES `empleado` (`id_empleado`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

DROP TABLE IF EXISTS `horario`;
CREATE TABLE `horario` (
  `id_horario` int NOT NULL AUTO_INCREMENT,
  `dia` enum('lunes','martes','miercoles','jueves','viernes') NOT NULL,
  `bloque` int NOT NULL,
  `id_prof` int NOT NULL,
  PRIMARY KEY (`id_horario`),
  UNIQUE KEY `horario_un` (`id_horario`,`dia`,`bloque`,`id_prof`),
  KEY `horario_FK` (`id_prof`),
  CONSTRAINT `horario_FK` FOREIGN KEY (`id_prof`) REFERENCES `profesor` (`id_prof`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

DROP TABLE IF EXISTS `alumno_apoderado`;
CREATE TABLE `alumno_apoderado` (
  `id_alumno` int NOT NULL,
  `id_apod` int NOT NULL,
  PRIMARY KEY (`id_alumno`,`id_apod`),
  KEY `alumno_apoderado_FK_1` (`id_apod`),
  CONSTRAINT `alumno_apoderado_FK` FOREIGN KEY (`id_alumno`) REFERENCES `alumno` (`id_alumno`),
  CONSTRAINT `alumno_apoderado_FK_1` FOREIGN KEY (`id_apod`) REFERENCES `apoderado` (`id_apod`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

DROP TABLE IF EXISTS `alumno_curso`;
CREATE TABLE `alumno_curso` (
  `id_alumno` int NOT NULL,
  `id_curso` int NOT NULL,
  PRIMARY KEY (`id_alumno`,`id_curso`),
  KEY `alumno_curso_FK_1` (`id_curso`),
  CONSTRAINT `alumno_curso_FK` FOREIGN KEY (`id_alumno`) REFERENCES `alumno` (`id_alumno`),
  CONSTRAINT `alumno_curso_FK_1` FOREIGN KEY (`id_curso`) REFERENCES `curso` (`id_curso`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

DROP TABLE IF EXISTS `asistencia`;
CREATE TABLE `asistencia` (
  `id_asistencia` int NOT NULL AUTO_INCREMENT,
  `fecha` date NOT NULL,
  `asistio` tinyint(1) NOT NULL DEFAULT '0',
  `id_alumno` int NOT NULL,
  `id_horario` int NOT NULL,
  PRIMARY KEY (`id_asistencia`),
  KEY `asistencia_FK` (`id_alumno`),
  KEY `asistencia_FK_1` (`id_horario`),
  CONSTRAINT `asistencia_FK` FOREIGN KEY (`id_alumno`) REFERENCES `alumno` (`id_alumno`),
  CONSTRAINT `asistencia_FK_1` FOREIGN KEY (`id_horario`) REFERENCES `horario` (`id_horario`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

DROP TABLE IF EXISTS `colegio_empleado`;
CREATE TABLE `colegio_empleado` (
  `id_colegio` int NOT NULL,
  `id_empleado` int NOT NULL,
  PRIMARY KEY (`id_colegio`,`id_empleado`),
  KEY `colegio_empleado_FK_1` (`id_empleado`),
  CONSTRAINT `colegio_empleado_FK` FOREIGN KEY (`id_colegio`) REFERENCES `colegio` (`id_colegio`),
  CONSTRAINT `colegio_empleado_FK_1` FOREIGN KEY (`id_empleado`) REFERENCES `empleado` (`id_empleado`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;