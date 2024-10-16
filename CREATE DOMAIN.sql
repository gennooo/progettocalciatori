CREATE DOMAIN ruolo_position AS VARCHAR(15) CHECK (VALUE IN ('Portiere', 'Difensore', 'Centrocampista', 'Attaccante'));

CREATE DOMAIN id_valido AS VARCHAR(9) CHECK (VALUE SIMILAR TO '[0-9]{4}-[0-9]{4}');
