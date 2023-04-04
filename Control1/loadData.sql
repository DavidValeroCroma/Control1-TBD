INSERT INTO public.comuna (id_comuna, ciudad, nombre, region) VALUES
                                                           (1, 'Santiago', 'Santiago', 'Región Metropolitana'),
                                                           (2, 'Santiago', 'Puente Alto', 'Región Metropolitana'),
                                                           (3, 'Santiago', 'Maipú', 'Región Metropolitana'),
                                                           (4, 'Santiago', 'La Florida', 'Región Metropolitana'),
                                                           (5, 'Santiago', 'Las Condes', 'Región Metropolitana'),
                                                           (6, 'Santiago', 'Providencia', 'Región Metropolitana'),
                                                           (7, 'Santiago', 'Ñuñoa', 'Región Metropolitana'),
                                                           (8, 'Valparaíso', 'Valparaíso', 'Región de Valparaíso'),
                                                           (9, 'Valparaíso', 'Viña del Mar', 'Región de Valparaíso'),
                                                           (10, 'Valparaíso', 'Quilpué', 'Región de Valparaíso');



INSERT INTO public.colegio (id_colegio, nombre, id_comuna) VALUES
                                                       (1, 'Colegio A', 1),
                                                       (2, 'Colegio B', 2),
                                                       (3, 'Colegio C', 3),
                                                       (4, 'Colegio D', 4),
                                                       (5, 'Colegio E', 5),
                                                       (6, 'Colegio F', 1),
                                                       (7, 'Colegio G', 2),
                                                       (8, 'Colegio H', 3),
                                                       (9, 'Colegio I', 4),
                                                       (10, 'Colegio J', 5);
-- Carga de datos para la tabla curso
INSERT INTO public.curso (id_curso, anio, letra,id_colegio) VALUES
                                                          (1, 2019, 'A', 1),
                                                          (2, 2019, 'B', 1),
                                                          (3, 2020, 'A', 2),
                                                          (4, 2020, 'B', 2),
                                                          (5, 2021, 'A', 1),
                                                          (6, 2021, 'B', 1),
                                                          (7, 2022, 'A', 2),
                                                          (8, 2022, 'B', 2),
                                                          (9, 2023, 'A', 1),
                                                          (10, 2023, 'B', 1);

-- Carga de datos para la tabla plantilla_curso
INSERT INTO public.plantilla_curso (id_plantilla_curso, id_curso, fecha_inicio, fecha_termino, cupos) VALUES
                                                                                          (1, 1, '2021-03-01', '2021-12-15', 20),
                                                                                          (2, 1, '2022-03-01', '2022-12-15', 25),
                                                                                          (3, 2, '2021-03-01', '2021-12-15', 22),
                                                                                          (4, 2, '2022-03-01', '2022-12-15', 24),
                                                                                          (5, 3, '2022-03-01', '2022-12-15', 20),
                                                                                          (6, 3, '2023-03-01', '2023-12-15', 25),
                                                                                          (7, 4, '2022-03-01', '2022-12-15', 22),
                                                                                          (8, 4, '2023-03-01', '2023-12-15', 24),
                                                                                          (9, 5, '2023-03-01', '2023-12-15', 20),
                                                                                          (10, 5, '2024-03-01', '2024-12-15', 25);
INSERT INTO public.apoderado(rut_apoderado, apellido, email, nombre, telefono, id_comuna) VALUES
                                                                                    ('11111111-1', 'Perez', 'juan.perez@gmail.com', 'Juan', '987654321', 1),
                                                                                    ('22222222-2', 'Gonzalez', 'maria.gonzalez@gmail.com', 'Maria', '987654322', 2),
                                                                                    ('33333333-3', 'Lopez', 'pedro.lopez@gmail.com', 'Pedro', '987654323', 3),
                                                                                    ('44444444-4', 'Diaz', 'carla.diaz@gmail.com', 'Carla', '987654324', 1),
                                                                                    ('55555555-5', 'Ruiz', 'camila.ruiz@gmail.com', 'Camila', '987654325', 2);

INSERT INTO public.alumno(rut_alumno, apellido, nombre, padre_apoderado, rut_apoderado, id_comuna) VALUES
                                                                                                ('11111111-1', 'Perez', 'Juan', false, '22222222-2', 1),
                                                                                                ('22222222-2', 'Gonzalez', 'Maria', true, '33333333-3', 2),
                                                                                                ('33333333-3', 'Lopez', 'Pedro', false, '44444444-4', 3),
                                                                                                ('44444444-4', 'Diaz', 'Carla', true, '11111111-1', 1),
                                                                                                ('55555555-5', 'Ruiz', 'Camila', false, '22222222-2', 2),
                                                                                                ('66666666-6', 'Sanchez', 'Luis', false, '33333333-3', 3),
                                                                                                ('77777777-7', 'Martinez', 'Ana', true, '44444444-4', 4),
                                                                                                ('88888888-8', 'Flores', 'Diego', false, '11111111-1', 5),
                                                                                                ('99999999-9', 'Gomez', 'Sofia', true, '22222222-2', 4),
                                                                                                ('10101010-1', 'Hernandez', 'Javier', false, '33333333-3', 5);

INSERT INTO public.alumno_curso(id_alumno_curso, rut_alumno, id_curso) VALUES
                                                              (1, '11111111-1', 1),
                                                              (2, '22222222-2', 2),
                                                              (3, '33333333-3', 1),
                                                              (4, '44444444-4', 2),
                                                              (5, '55555555-5', 3),
                                                              (6, '66666666-6', 1),
                                                              (7, '77777777-7', 2),
                                                              (8, '88888888-8', 3),
                                                              (9, '99999999-9', 1),
                                                              (10, '10101010-1', 2);
INSERT INTO public.empleado (rut_empleado, apellido, cargo, nombre, sueldo, id_colegio, id_comuna) VALUES
                                                                                              ('11111111-1', 'González', 'Profesor', 'María', 1200000, 1, 1),
                                                                                              ('22222222-2', 'Rodríguez', 'Profesor', 'Juan', 1250000, 1, 1),
                                                                                              ('33333333-3', 'García', 'Profesor', 'Pedro', 1300000, 1, 1),
                                                                                              ('44444444-4', 'Fernández', 'Profesor', 'Carla', 1250000, 1, 1),
                                                                                              ('55555555-5', 'López', 'Profesor', 'Cristina', 1300000, 1, 1),
                                                                                              ('66666666-6', 'Martínez', 'Profesor', 'Miguel', 1200000, 1, 1),
                                                                                              ('77777777-7', 'Sánchez', 'Profesor', 'Andrea', 1250000, 1, 1),
                                                                                              ('88888888-8', 'Pérez', 'Administrativo', 'Carlos', 800000, 1, 1),
                                                                                              ('99999999-9', 'Gómez', 'Administrativo', 'Fernanda', 850000, 1, 1),
                                                                                              ('10101010-0', 'Muñoz', 'Administrativo', 'Camila', 900000, 1, 1);
INSERT INTO public.profesor (rut_empleado, id_profesor)
VALUES
    ('11111111-1', 1),
    ('22222222-2', 2),
    ('33333333-3', 3),
    ('44444444-4', 4),
    ('55555555-5', 5),
    ('66666666-6', 6),
    ('77777777-7', 7);

-- Insertar datos de franjas horarias desde las 8:00 am hasta las 6:30 pm
INSERT INTO public.franja_horaria (id_franja_horaria, hora_inicio, hora_termino)
VALUES
    (1, '08:00:00', '09:30:00'),
    (2, '09:45:00', '11:15:00'),
    (3, '11:25:00', '12:55:00'),
    (4, '14:00:00', '15:30:00'),
    (5, '15:35:00', '17:05:00'),
    (6, '17:10:00', '18:40:00');

-- Generar datos para la tabla profesor_curso
INSERT INTO public.profesor_curso (id_profesor_curso, id_profesor, id_curso, es_jefe)
SELECT row_number() OVER (ORDER BY p.id_profesor, c.id_curso), p.id_profesor, c.id_curso, (row_number() OVER (PARTITION BY p.id_profesor ORDER BY c.id_curso) = 1)
FROM public.profesor p
         CROSS JOIN public.curso c
ORDER BY p.id_profesor, c.id_curso;

-- Carga de datos para la tabla asistencia
INSERT INTO public.asistencia (id_asistencia, asistencia, fecha, rut_alumno, id_franja_horaria)
SELECT
            ROW_NUMBER() OVER() AS id_asistencia,
            CASE WHEN random() < 0.8 THEN true ELSE false END AS asistencia,
            to_date('2019-' || lpad(CAST(trunc(random() * 9 + 3) AS INTEGER)::text, 2, '0') || '-' || lpad(CAST(trunc(random() * 30 + 1) AS INTEGER)::text, 2, '0'), 'YYYY-MM-DD') AS fecha,
            CASE WHEN random() < 0.1 THEN '11111111-1'
                 WHEN random() < 0.2 THEN '22222222-2'
                 WHEN random() < 0.3 THEN '33333333-3'
                 WHEN random() < 0.4 THEN '44444444-4'
                 WHEN random() < 0.5 THEN '55555555-5'
                 WHEN random() < 0.6 THEN '66666666-6'
                 WHEN random() < 0.7 THEN '77777777-7'
                 WHEN random() < 0.8 THEN '88888888-8'
                 ELSE '99999999-9' END AS rut_alumno,
            CASE WHEN random() < 0.1667 THEN 1
                 WHEN random() < 0.3333 THEN 2
                 WHEN random() < 0.5 THEN 3
                 WHEN random() < 0.6667 THEN 4
                 WHEN random() < 0.8333 THEN 5
                 ELSE 6 END AS id_franja_horaria
FROM generate_series('2019-03-01'::date, '2019-12-31'::date, '1 day'::interval) AS g
WHERE NOT (EXTRACT(MONTH FROM g) = 7 AND EXTRACT(DAY FROM g) BETWEEN 12 AND 15);
