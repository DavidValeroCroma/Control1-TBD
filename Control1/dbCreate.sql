-- Database: control1

-- DROP DATABASE IF EXISTS control1;


create table if not exists public.alumno
(
    rut_alumno      varchar(255) not null,
    apellido        varchar(255) not null,
    nombre          varchar(255) not null,
    padre_apoderado boolean      not null,
    rut_apoderado   varchar(255) not null,
    id_comuna       bigint       not null
);

alter table public.alumno
    add constraint alumno_pkey
        primary key (rut_alumno);

create table if not exists public.alumno_curso
(
    id_alumno_curso     bigint       not null,
    rut_alumno 		varchar(255) not null,
    id_curso   		bigint       not null
);

alter table public.alumno_curso
    add constraint alumno_curso_pkey
        primary key (id_alumno_curso);

alter table public.alumno_curso
    add constraint alumno_curso_fkey
        foreign key (rut_alumno) references public.alumno;

create table if not exists public.apoderado
(
    rut_apoderado  varchar(255) not null,
    apellido  varchar(255) not null,
    email     varchar(255) not null,
    nombre    varchar(255) not null,
    telefono  varchar(255) not null,
    id_comuna bigint       not null
);

alter table public.apoderado
    add constraint apoderado_pkey
        primary key (rut_apoderado);

alter table public.alumno
    add constraint rut_apoderado
        foreign key (rut_apoderado) references public.apoderado;

create table if not exists public.asistencia
(
    id_asistencia     bigint       not null,
    asistencia        boolean,
    fecha             date,
    rut_alumno         varchar(255) not null,
    id_franja_horaria bigint       not null
);

alter table public.asistencia
    add constraint asistencia_pkey
        primary key (id_asistencia);

alter table public.asistencia
    add constraint rut_alumno
        foreign key (rut_alumno) references public.alumno;


create table if not exists public.colegio
(
    id_colegio	bigint not null,
    nombre    	varchar(255),
    id_comuna 	bigint not null
);

alter table public.colegio
    add constraint colegio_pkey
        primary key (id_colegio);

create table if not exists public.comuna
(
    id_comuna     bigint not null,
    ciudad varchar(255),
    nombre varchar(255),
    region varchar(255)
);

alter table public.comuna
    add constraint comuna_pkey
        primary key (id_comuna);

alter table public.alumno
    add constraint id_comuna
        foreign key (id_comuna) references public.comuna;

alter table public.apoderado
    add constraint id_comuna
        foreign key (id_comuna) references public.comuna;

alter table public.colegio
    add constraint id_comuna
        foreign key (id_comuna) references public.comuna;

CREATE TABLE IF NOT EXISTS public.curso
(
    id_curso bigint NOT NULL,
    anio integer NOT NULL,
    letra character varying(255) COLLATE pg_catalog."default" NOT NULL,
    id_colegio bigint, -- Agregamos la columna id_colegio
    CONSTRAINT curso_pkey PRIMARY KEY (id_curso),
    CONSTRAINT fk_curso_colegio -- Agregamos la restricción de llave foránea
        FOREIGN KEY (id_colegio)
            REFERENCES public.colegio (id_colegio)
);

alter table public.alumno_curso
    add constraint id_curso
        foreign key (id_curso) references public.curso;

create table if not exists public.empleado
(
    rut_empleado   	varchar(20)  not null,
    apellido   		varchar(255) not null,
    cargo      		varchar(255) not null,
    nombre     		varchar(255) not null,
    sueldo     		bigint       not null,
    id_colegio 		bigint       not null,
    id_comuna  		bigint       not null
);

alter table public.empleado
    add constraint empleado_pkey
        primary key (rut_empleado);

alter table public.empleado
    add constraint id_colegio
        foreign key (id_colegio) references public.colegio;

alter table public.empleado
    add constraint id_comuna
        foreign key (id_comuna) references public.comuna;

create table if not exists public.franja_horaria
(
    id_franja_horaria           bigint       not null,
    hora_inicio  varchar(255) not null,
    hora_termino varchar(255) not null
);

alter table public.franja_horaria
    add constraint franja_horaria_pkey
        primary key (id_franja_horaria);

alter table public.asistencia
    add constraint id_franja_horaria
        foreign key (id_franja_horaria) references public.franja_horaria;

create table if not exists public.plantilla_curso
(
    id_plantilla_curso         	bigint not null,
    id_curso          		bigint not null,
    fecha_inicio      		date,
    fecha_termino     		date,
    cupos             		integer
);

alter table public.plantilla_curso
    add constraint plantilla_curso_pkey
        primary key (id_plantilla_curso);

alter table public.plantilla_curso
    add constraint id_curso
        foreign key (id_curso) references public.curso;

create table if not exists public.profesor
(
    id_profesor          bigint      not null,
    rut_empleado varchar(20) not null
);

alter table public.profesor
    add constraint profesor_pkey
        primary key (id_profesor);

alter table public.profesor
    add constraint rut_empleado
        foreign key (rut_empleado) references public.empleado;

create table if not exists public.profesor_curso
(
    id_profesor_curso  bigint not null,
    id_curso           bigint not null,
    es_jefe	       bool not null,
    id_profesor        bigint not null
);

alter table public.profesor_curso
    add constraint profesor_curso_pkey
        primary key (id_profesor_curso);

alter table public.profesor_curso
    add constraint id_curso
        foreign key (id_curso) references public.curso;


alter table public.profesor_curso
    add constraint id_profesor
        foreign key (id_profesor) references public.profesor;


