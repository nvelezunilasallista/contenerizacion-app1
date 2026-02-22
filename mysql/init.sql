CREATE DATABASE IF NOT EXISTS politecnico_db CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE politecnico_db;

SET NAMES utf8mb4;
SET CHARACTER SET utf8mb4;

CREATE TABLE IF NOT EXISTS docentes (
    id              INT AUTO_INCREMENT PRIMARY KEY,
    nombres         VARCHAR(100) NOT NULL,
    apellidos       VARCHAR(100) NOT NULL,
    cedula          VARCHAR(20)  NOT NULL UNIQUE,
    correo          VARCHAR(150) NOT NULL UNIQUE,
    telefono        VARCHAR(15),
    fecha_ingreso   DATE         NOT NULL,
    activo          BOOLEAN      NOT NULL DEFAULT TRUE,
    tipo_contrato   CHAR(1)      NOT NULL COMMENT 'P=Planta, C=Catedra, T=Temporal'
) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS asignaturas (
    id              INT AUTO_INCREMENT PRIMARY KEY,
    codigo          VARCHAR(10)  NOT NULL UNIQUE,
    nombre          VARCHAR(150) NOT NULL,
    creditos        INT          NOT NULL,
    horas_semana    INT          NOT NULL,
    descripcion     VARCHAR(500),
    fecha_creacion  DATE         NOT NULL,
    obligatoria     BOOLEAN      NOT NULL DEFAULT TRUE,
    docente_id      INT          NOT NULL,
    CONSTRAINT fk_docente FOREIGN KEY (docente_id) REFERENCES docentes(id)
        ON DELETE RESTRICT ON UPDATE CASCADE
) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- =============================================
-- 22 DOCENTES
-- =============================================
INSERT INTO docentes (nombres, apellidos, cedula, correo, telefono, fecha_ingreso, activo, tipo_contrato) VALUES
('Carlos Andrés',    'Ramírez Mora',       '79123456',   'cramirez@poligran.edu.co',     '3001112233', '2018-02-01', TRUE,  'P'),
('Laura Milena',     'Torres Vargas',      '52654321',   'ltorres@poligran.edu.co',      '3119988776', '2020-07-15', TRUE,  'C'),
('Andrés Felipe',    'Ospina Ríos',        '1020304050', 'aospina@poligran.edu.co',      '3205566778', '2015-01-10', TRUE,  'P'),
('María Fernanda',   'Gutiérrez Peña',     '43210987',   'mgutierrez@poligran.edu.co',   '3142233445', '2022-03-01', FALSE, 'T'),
('Jorge Iván',       'Salcedo Nieto',      '80456123',   'jsalcedo@poligran.edu.co',     '3167890123', '2019-08-05', TRUE,  'C'),
('Sandra Milena',    'Castillo Herrera',   '52987654',   'scastillo@poligran.edu.co',    '3012345678', '2017-03-12', TRUE,  'P'),
('Diego Alejandro',  'Mendoza Quiroga',    '1010234567', 'dmendoza@poligran.edu.co',     '3134567890', '2016-06-20', TRUE,  'P'),
('Claudia Patricia', 'Rojas Cifuentes',    '46789012',   'crojas@poligran.edu.co',       '3156789012', '2021-01-08', TRUE,  'C'),
('Héctor Fabio',     'Valencia Cardona',   '71234567',   'hvalencia@poligran.edu.co',    '3178901234', '2014-09-15', TRUE,  'P'),
('Adriana Lucía',    'Moreno Betancur',    '55678901',   'amoreno@poligran.edu.co',      '3190123456', '2023-02-20', TRUE,  'T'),
('Ricardo Ernesto',  'Patiño Lozano',      '82345678',   'rpatino@poligran.edu.co',      '3001234567', '2013-07-01', TRUE,  'P'),
('Pilar Esperanza',  'Vargas Quintero',    '41234567',   'pvargas@poligran.edu.co',      '3023456789', '2020-11-10', FALSE, 'C'),
('Mauricio Alberto', 'Agudelo Sánchez',    '98765432',   'magudelo@poligran.edu.co',     '3045678901', '2018-05-22', TRUE,  'P'),
('Natalia Andrea',   'Cárdenas Ruiz',      '53456789',   'ncardenas@poligran.edu.co',    '3067890123', '2022-08-15', TRUE,  'C'),
('Felipe Antonio',   'Jiménez Ossa',       '1032456789', 'fjimenez@poligran.edu.co',     '3089012345', '2019-04-03', TRUE,  'P'),
('Gloria Inés',      'Sepúlveda Arango',   '44567890',   'gsepulveda@poligran.edu.co',   '3101234567', '2015-10-18', TRUE,  'P'),
('Camilo Augusto',   'Londoño Mejía',      '1045678901', 'clondono@poligran.edu.co',     '3123456789', '2021-06-07', TRUE,  'C'),
('Beatriz Elena',    'Holguín Castaño',    '36789012',   'bholguin@poligran.edu.co',     '3145678901', '2017-12-01', FALSE, 'T'),
('Juan Pablo',       'Arbeláez Giraldo',   '1058901234', 'jarbelaez@poligran.edu.co',    '3167891234', '2023-09-04', TRUE,  'C'),
('Marcela Sofía',    'Restrepo Álvarez',   '47890123',   'mrestrepo@poligran.edu.co',    '3189012345', '2016-03-25', TRUE,  'P'),
('Hernán Darío',     'Quintero Zapata',    '75678901',   'hquintero@poligran.edu.co',    '3001357900', '2012-08-14', TRUE,  'P'),
('Viviana Paola',    'Echeverri Montoya',  '51234567',   'vecheverri@poligran.edu.co',   '3024680135', '2024-01-15', TRUE,  'T');

-- =============================================
-- 22 ASIGNATURAS
-- =============================================
INSERT INTO asignaturas (codigo, nombre, creditos, horas_semana, descripcion, fecha_creacion, obligatoria, docente_id) VALUES
('INF101', 'Fundamentos de Programación',        3, 4, 'Introducción a la lógica y programación estructurada con Python.',          '2018-06-01', TRUE,  1),
('MAT201', 'Cálculo Diferencial',                 4, 5, 'Límites, derivadas y aplicaciones en ingeniería y tecnología.',             '2015-06-01', TRUE,  3),
('RED301', 'Redes y Comunicaciones',              3, 4, 'Topologías, protocolos y modelos OSI/TCP-IP aplicados.',                    '2020-07-20', TRUE,  2),
('BD401',  'Bases de Datos Relacionales',         3, 4, 'Modelado entidad-relación, SQL avanzado y normalización.',                  '2015-06-01', TRUE,  3),
('WEB501', 'Desarrollo Web Frontend',             2, 3, 'HTML5, CSS3, JavaScript moderno y frameworks como React.',                  '2022-03-10', FALSE, 4),
('SIS601', 'Sistemas Operativos',                 3, 4, 'Gestión de procesos, memoria, archivos y seguridad del sistema.',           '2019-09-01', TRUE,  5),
('ALG201', 'Álgebra Lineal',                      3, 4, 'Matrices, vectores, transformaciones lineales y aplicaciones.',             '2015-06-01', TRUE,  3),
('POO301', 'Programación Orientada a Objetos',    3, 4, 'Paradigma OOP con Java: clases, herencia, polimorfismo e interfaces.',      '2016-08-01', TRUE,  6),
('EST401', 'Estadística y Probabilidad',          3, 4, 'Distribuciones de probabilidad, inferencia y análisis de datos.',           '2017-02-10', TRUE,  7),
('ARQ501', 'Arquitectura de Software',            3, 4, 'Patrones de diseño, microservicios y arquitecturas escalables.',            '2021-03-15', TRUE,  9),
('MOV601', 'Desarrollo de Aplicaciones Móviles', 2, 3, 'Creación de apps Android e iOS con Flutter y React Native.',                '2022-06-01', FALSE, 8),
('SEG701', 'Seguridad Informática',               3, 4, 'Criptografía, ethical hacking, OWASP y gestión de vulnerabilidades.',       '2019-01-20', TRUE,  11),
('NUB801', 'Computación en la Nube',              2, 3, 'AWS, Azure y GCP: despliegue, escalabilidad y costos en cloud.',            '2023-01-10', FALSE, 13),
('INT901', 'Inteligencia Artificial',             3, 4, 'Machine learning, redes neuronales y procesamiento de lenguaje natural.',   '2021-08-01', TRUE,  9),
('CAL202', 'Cálculo Integral',                    4, 5, 'Integrales definidas e indefinidas, series y aplicaciones físicas.',        '2015-06-01', TRUE,  3),
('GES101', 'Gestión de Proyectos TI',             2, 3, 'PMBOK, Scrum, Kanban y herramientas de gestión ágil de proyectos.',        '2018-09-01', FALSE, 16),
('DAT501', 'Ciencia de Datos',                    3, 4, 'Análisis exploratorio, visualización y modelos predictivos con Python.',    '2022-02-14', TRUE,  7),
('DEV601', 'DevOps y CI/CD',                      2, 3, 'Docker, Kubernetes, Jenkins y pipelines de integración continua.',          '2023-03-01', FALSE, 5),
('MAT301', 'Matemáticas Discretas',               3, 4, 'Lógica proposicional, grafos, combinatoria y teoría de conjuntos.',        '2016-01-15', TRUE,  21),
('ING101', 'Inglés Técnico para TI',              2, 3, 'Lectura y escritura técnica en inglés orientada a documentación de TI.',   '2019-05-01', FALSE, 20),
('EMP201', 'Emprendimiento e Innovación',         2, 2, 'Design thinking, lean startup y creación de modelos de negocio digitales.', '2020-10-01', FALSE, 14),
('AUD701', 'Auditoría de Sistemas',               3, 4, 'Controles internos, normas ISO 27001 y auditoría de infraestructura TI.',  '2018-11-12', TRUE,  11);