-- Consulta 1 

SELECT e.nombre, e.sueldo,
    CASE WHEN pc.es_jefe THEN 'Sí' ELSE 'No' END AS es_jefe,
    CASE WHEN pc.es_jefe THEN COUNT(ac.rut_alumno) ELSE 0 END AS num_alumnos
FROM profesor p
INNER JOIN empleado e ON e.rut_empleado = p.rut_empleado
LEFT JOIN profesor_curso pc ON pc.id_profesor = p.id_profesor
LEFT JOIN curso cu ON cu.id_curso = pc.id_curso
LEFT JOIN alumno_curso ac ON ac.id_curso = cu.id_curso
GROUP BY e.nombre, e.sueldo, pc.es_jefe
ORDER BY e.nombre ASC;

-- Consulta 2

SELECT a.rut_alumno, a.nombre, ac.id_curso, extract(month from asi.fecha) AS mes, COUNT(*) AS inasistencias
FROM alumno a
INNER JOIN asistencia asi ON a.rut_alumno = asi.rut_alumno
INNER JOIN alumno_curso ac ON a.rut_alumno = ac.rut_alumno
WHERE asi.fecha >= '2019/01/01' AND asi.fecha <= '2019/12/31' AND asi.asistencia = 'False'
GROUP BY a.rut_alumno, ac.id_curso, extract(month from asi.fecha)
ORDER BY ac.id_curso, extract(month from asi.fecha), inasistencias DESC;

-- Consulta 3 

SELECT e.nombre AS nombre_empleado, e.cargo, e.sueldo, c.nombre AS nombre_comuna
FROM public.empleado e
INNER JOIN public.comuna c ON e.id_comuna = c.id_comuna
ORDER BY c.nombre, e.sueldo;

-- Consulta 4

SELECT DISTINCT ON (c.anio)
    c.anio,
    c.letra,
    COALESCE(COUNT(ac.id_alumno_curso), 0) AS num_alumnos
FROM public.curso c
         LEFT JOIN public.alumno_curso ac ON c.id_curso = ac.id_curso
GROUP BY c.id_curso, c.anio
ORDER BY c.anio, num_alumnos;

-- Consulta 5

SELECT a.rut_alumno, a.nombre, a.apellido
FROM public.alumno a
WHERE NOT EXISTS (
        SELECT 1 FROM public.asistencia asi
        WHERE asi.rut_alumno = a.rut_alumno
          AND asi.asistencia = false
    )
  AND NOT EXISTS (
        SELECT 1 FROM public.asistencia asi2
        WHERE asi2.rut_alumno = a.rut_alumno
          AND asi2.fecha NOT IN (
            SELECT asi3.fecha FROM public.asistencia asi3
            WHERE asi3.asistencia = true
              AND asi3.rut_alumno = a.rut_alumno
        )
    )
GROUP BY a.rut_alumno, a.nombre, a.apellido

-- Consulta 6

-- No se puede realizar por la manera en que construimos la base de datos.

-- Consulta 7

-- No se puede realizar por la forma en que construimos la base de datos.

-- Consulta 8

SELECT c.id_curso, ac.rut_alumno, a.apellido, a.nombre
FROM public.curso c
         JOIN public.alumno_curso ac ON ac.id_curso = c.id_curso
         JOIN public.alumno a ON a.rut_alumno = ac.rut_alumno
WHERE NOT EXISTS (
        SELECT 1
        FROM public.alumno a2
        WHERE a2.rut_alumno = ac.rut_alumno
          AND a2.rut_apoderado = a.rut_alumno
          AND a2.padre_apoderado = true
    )
ORDER BY c.id_curso, a.apellido, a.nombre;

-- Consulta 9

SELECT c.nombre AS colegio, com.nombre AS comuna, AVG(a.asistencia::int) AS promedio_asistencia
FROM public.asistencia a
JOIN public.alumno al ON a.rut_alumno = al.rut_alumno
JOIN public.alumno_curso ac ON al.rut_alumno = ac.rut_alumno
JOIN public.curso cr ON ac.id_curso = cr.id_curso
JOIN public.colegio c ON cr.id_colegio = c.id_colegio
JOIN public.comuna com ON c.id_comuna = com.id_comuna
WHERE cr.anio = 2019
GROUP BY c.nombre, com.nombre
ORDER BY promedio_asistencia DESC
LIMIT 1;

-- Consulta 10

SELECT c.nombre, cr.anio, COUNT(ac.rut_alumno) as num_alumnos
FROM public.colegio c
         JOIN public.curso cr ON c.id_colegio = cr.id_colegio
         JOIN public.alumno_curso ac ON cr.id_curso = ac.id_curso
GROUP BY c.nombre, cr.anio
ORDER BY cr.anio DESC, num_alumnos DESC;