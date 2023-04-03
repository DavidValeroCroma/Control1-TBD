DROP TABLE IF EXISTS comuna;

CREATE SEQUENCE comuna_seq;

CREATE TABLE comuna (
  id_comuna int NOT NULL DEFAULT NEXTVAL ('comuna_seq'),
  nombre varchar(100) NOT NULL,
  PRIMARY KEY (id_comuna)
) ;

DROP TABLE IF EXISTS colegio;

CREATE SEQUENCE colegio_seq;

CREATE TABLE colegio (
  id_colegio int NOT NULL DEFAULT NEXTVAL ('colegio_seq'),
  nombre varchar(100) NOT NULL,
  direccion varchar(200) NOT NULL,
  id_comuna int NOT NULL,
  PRIMARY KEY (id_colegio)
,
  CONSTRAINT colegio_FK FOREIGN KEY (id_comuna) REFERENCES comuna (id_comuna)
) ;

CREATE INDEX colegio_FK ON colegio (id_comuna);

DROP TABLE IF EXISTS empleado;

CREATE SEQUENCE empleado_seq;

CREATE TABLE empleado (
  id_empleado int NOT NULL DEFAULT NEXTVAL ('empleado_seq'),
  nombre varchar(100) NOT NULL,
  tipo varchar(100) NOT NULL,
  rut int NOT NULL,
  id_colegio int NOT NULL,
  CONSTRAINT id_empleado UNIQUE  (id_empleado)
,
  CONSTRAINT empleado_FK FOREIGN KEY (id_colegio) REFERENCES colegio (id_colegio)
) ;

DROP TABLE IF EXISTS alumno;

CREATE SEQUENCE alumno_seq;

CREATE TABLE alumno (
  id_alumno int NOT NULL DEFAULT NEXTVAL ('alumno_seq'),
  nombre varchar(100) NOT NULL,
  rut int NOT NULL,
  sexo varchar(1) NOT NULL,
  id_comuna int NOT NULL,
  PRIMARY KEY (id_alumno)
,
  CONSTRAINT alumno_FK FOREIGN KEY (id_comuna) REFERENCES comuna (id_comuna)
) ;

CREATE INDEX alumno_FK ON alumno (id_comuna);

DROP TABLE IF EXISTS apoderado;

CREATE SEQUENCE apoderado_seq;

CREATE TABLE apoderado (
  id_apod int NOT NULL DEFAULT NEXTVAL ('apoderado_seq'),
  nombre varchar(100) NOT NULL,
  rut int NOT NULL,
  parentesco varchar(100) NOT NULL,
  id_comuna int NOT NULL,
  PRIMARY KEY (id_apod)
,
  CONSTRAINT apoderado_FK FOREIGN KEY (id_comuna) REFERENCES comuna (id_comuna)
) ;

CREATE INDEX apoderado_FK ON apoderado (id_comuna);

DROP TABLE IF EXISTS profesor;

CREATE SEQUENCE profesor_seq;

CREATE TABLE profesor (
  id_prof int NOT NULL DEFAULT NEXTVAL ('profesor_seq'),
  asignatura varchar(100) NOT NULL,
  id_empleado int NOT NULL,
  PRIMARY KEY (id_prof),
  CONSTRAINT id_prof UNIQUE  (id_prof)
,
  CONSTRAINT profesor_FK FOREIGN KEY (id_empleado) REFERENCES empleado (id_empleado)
) ;

CREATE INDEX profesor_FK ON profesor (id_empleado);

DROP TABLE IF EXISTS plantilla_curso;

CREATE SEQUENCE plantilla_curso_seq;

CREATE TABLE plantilla_curso (
  id_plant int NOT NULL DEFAULT NEXTVAL ('plantilla_curso_seq'),
  cant_alumnos int NOT NULL DEFAULT '35',
  planificacion varchar(300) DEFAULT NULL,
  PRIMARY KEY (id_plant)
) ;

DROP TABLE IF EXISTS curso;

CREATE SEQUENCE curso_seq;

CREATE TABLE curso (
  id_curso int NOT NULL DEFAULT NEXTVAL ('curso_seq'),
  nivel int NOT NULL,
  id_plant int NOT NULL,
  id_profesor_jefe int NOT NULL,
  año int NOT NULL,
  PRIMARY KEY (id_curso)
,
  CONSTRAINT curso_FK FOREIGN KEY (id_profesor_jefe) REFERENCES profesor (id_prof),
  CONSTRAINT curso_FK_1 FOREIGN KEY (id_plant) REFERENCES plantilla_curso (id_plant)
) ;

CREATE INDEX curso_FK ON curso (id_profesor_jefe);
CREATE INDEX curso_FK_1 ON curso (id_plant);

DROP TABLE IF EXISTS sueldo;

CREATE SEQUENCE sueldo_seq;

CREATE TABLE sueldo (
  id_sueldo int NOT NULL DEFAULT NEXTVAL ('sueldo_seq'),
  monto int NOT NULL,
  id_empleado int NOT NULL,
  PRIMARY KEY (id_sueldo)
,
  CONSTRAINT sueldo_FK FOREIGN KEY (id_empleado) REFERENCES empleado (id_empleado)
) ;

CREATE INDEX sueldo_FK ON sueldo (id_empleado);

DROP TABLE IF EXISTS horario;

CREATE SEQUENCE horario_seq;

CREATE TABLE horario (
  id_horario int NOT NULL DEFAULT NEXTVAL ('horario_seq'),
  dia varchar(30) NOT NULL,
  bloque int NOT NULL,
  id_prof int NOT NULL,
  PRIMARY KEY (id_horario),
  CONSTRAINT horario_un UNIQUE  (id_horario,dia,bloque,id_prof)
,
  CONSTRAINT horario_FK FOREIGN KEY (id_prof) REFERENCES profesor (id_prof)
) ;

CREATE INDEX horario_FK ON horario (id_prof);

DROP TABLE IF EXISTS alumno_apoderado;

CREATE TABLE alumno_apoderado (
  id_alumno int NOT NULL,
  id_apod int NOT NULL,
  PRIMARY KEY (id_alumno,id_apod)
,
  CONSTRAINT alumno_apoderado_FK FOREIGN KEY (id_alumno) REFERENCES alumno (id_alumno),
  CONSTRAINT alumno_apoderado_FK_1 FOREIGN KEY (id_apod) REFERENCES apoderado (id_apod)
) ;

CREATE INDEX alumno_apoderado_FK_1 ON alumno_apoderado (id_apod);

DROP TABLE IF EXISTS alumno_curso;

CREATE TABLE alumno_curso (
  id_alumno int NOT NULL,
  id_curso int NOT NULL,
  PRIMARY KEY (id_alumno,id_curso)
,
  CONSTRAINT alumno_curso_FK FOREIGN KEY (id_alumno) REFERENCES alumno (id_alumno),
  CONSTRAINT alumno_curso_FK_1 FOREIGN KEY (id_curso) REFERENCES curso (id_curso)
) ;

CREATE INDEX alumno_curso_FK_1 ON alumno_curso (id_curso);

DROP TABLE IF EXISTS asistencia;

CREATE SEQUENCE asistencia_seq;

CREATE TABLE asistencia (
  id_asistencia int NOT NULL DEFAULT NEXTVAL ('asistencia_seq'),
  fecha date NOT NULL,
  asistio smallint NOT NULL DEFAULT '0',
  id_alumno int NOT NULL,
  id_horario int NOT NULL,
  PRIMARY KEY (id_asistencia)
,
  CONSTRAINT asistencia_FK FOREIGN KEY (id_alumno) REFERENCES alumno (id_alumno),
  CONSTRAINT asistencia_FK_1 FOREIGN KEY (id_horario) REFERENCES horario (id_horario)
) ;

CREATE INDEX asistencia_FK ON asistencia (id_alumno);
CREATE INDEX asistencia_FK_1 ON asistencia (id_horario);