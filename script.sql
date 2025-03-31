CREATE TABLE jesuita(
	idJesuita tinyint   identity NOT NULL PRIMARY KEY,
	codigo char(5) NULL, 
	nombre varchar(50) NOT NULL UNIQUE,
	nombreAlumno varchar(100)NOT NULL UNIQUE,
	firma varchar(300) NOT NULL,
	firmaIngles varchar(300) NOT NULL
);

CREATE TABLE lugar(
	ip char(15) NOT NULL PRIMARY KEY,
	nombre_maquina char(12) NOT NULL,
	lugar varchar(30) NOT NULL
);

CREATE TABLE visita(
    idVisita  smallint  NOT NULL identity PRIMARY KEY,
	idJesuita tinyint  NOT NULL,
	ip char(15) NOT NULL,
	fechaHora datetime NOT NULL default SYSDATETIMEOFFSET(), --  buscado en la web de microsoft transact sql
	CONSTRAINT Lugar_Visita FOREIGN KEY (ip) REFERENCES lugar(ip),
	CONSTRAINT Jesuita_Visita FOREIGN KEY (idJesuita) REFERENCES jesuita(idJesuita)
);


	-- insercion de datos 
INSERT INTO jesuita(codigo,nombre,nombreAlumno,firma,firmaIngles) values
('11111','jesuita1','alumno1','hola','hello'),
('22222','jesuita2','alumno2','hola','hello'),
('33333','jesuita3','alumno3','hola','hello'),
('44444','jesuita4','alumno4','hola','hello'),
('55555','jesuita5','alumno5','hola','hello'),
('66666','jesuita6','alumno6','hola','hello');


INSERT INTO lugar  VALUES
('192.168.10.1', 'win-1', 'Madrid'),
('192.168.10.2', 'win-2', 'Barcelona'),
('192.168.10.3', 'win-3', 'Cadiz'),
('192.168.10.4', 'win-4', 'Malaga'),
('192.168.10.5', 'win-5', 'Valencia');

 -- la fecha hora la coge de forma automatica
INSERT INTO visita ( idJesuita, ip) VALUES
(1, '192.168.10.2'),
(1, '192.168.10.4'),
(1, '192.168.10.3'),
(1, '192.168.10.4');



	-- consultas de la tarea 
	
-- 1 
select idVisita,nombre
FROM visita INNER JOIN jesuita
			ON visita.idJesuita=jesuita.idJesuita;

-- 2
select idVisita,nombre,lugar
FROM visita INNER JOIN jesuita
			ON visita.idJesuita=jesuita.idJesuita
				INNER JOIN lugar
					ON visita.ip=lugar.ip;
					
-- 3
INSERT INTO jesuita(codigo,nombre,nombreAlumno,firma,firmaIngles) values('77777','jesuita7','alumno7','hola','hello');

-- 4
INSERT INTO lugar  VALUES
('192.168.10.22', 'win-30', 'japon'),
('192.168.10.24', 'win-20', 'Italia');

-- 5
select idVisita,nombre,lugar
from visita LEFT JOIN lugar   	-- no comprendo el funcionamiento de LEFT JOIN y RIGHT JOIN
			ON visita.ip=lugar.ip
			RIGHT JOIN jesuita
			ON jesuita.idJesuita=visita.idJesuita;
			
-- 6
select idVisita,nombre,lugar
from visita LEFT JOIN jesuita
			ON jesuita.idJesuita=visita.idJesuita
			RIGHT JOIN lugar
			ON visita.ip=lugar.ip;
			
-- 7
select idVisita,nombre,lugar
from visita LEFT JOIN jesuita
			ON jesuita.idJesuita=visita.idJesuita
			RIGHT JOIN lugar
			ON visita.ip=lugar.ip
			WHERE visita.idVisita is NULL;

-- 8
select idVisita,nombre,lugar
from visita LEFT JOIN lugar   
			ON visita.ip=lugar.ip
			RIGHT JOIN jesuita
			ON jesuita.idJesuita=visita.idJesuita
UNION	 -- utilizo UNION para poder sacar las dos consultas a  la vez y obtener los resultados de ambas
select idVisita,nombre,lugar
from visita LEFT JOIN jesuita
			ON jesuita.idJesuita=visita.idJesuita
			RIGHT JOIN lugar
			ON visita.ip=lugar.ip;
-- 9
select DISTINCT nombre  -- solo me muestra el jesuita 1 porque no hice visitas con más
from visita INNER JOIN jesuita
			 ON jesuita.idJesuita=visita.idJesuita;
			 
-- 10
	-- con esta consulta saco todos los lugares que han sido visitados sin repetirlos
select DISTINCT lugar
	from visita INNER JOIN lugar
				ON visita.ip=lugar.ip;
				
--------------------------------------------------------------------------------------------------------
-- consultas con operadores 
	-- operador = 
select *
	from visita INNER JOIN lugar	
				on visita.ip=lugar.ip
	WHERE lugar='Barcelona';
	
	-- operador !=
select *
	from visita INNER JOIN lugar	
				on visita.ip=lugar.ip
	WHERE lugar!='Barcelona';
	
	-- operador IN
select *
	from visita INNER JOIN lugar	
				on visita.ip=lugar.ip
	WHERE lugar IN('Barcelona','Madrid');
	--operador BETWEEN
select * 
	from visita INNER JOIN jesuita	
				on visita.idJesuita=jesuita.idJesuita
	WHERE jesuita.idJesuita BETWEEN 1 AND 3; -- solo me sacará los jesuitas entre id 1 e id 3

--operador NOT BETWEEN
select * 	
from visita INNER JOIN jesuita	
				on visita.idJesuita=jesuita.idJesuita
	WHERE jesuita.idJesuita NOT BETWEEN 1 AND 3; -- solo me sacará los jesuitas  que no esten entre id 1 e id 3
	
	

	


