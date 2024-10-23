CREATE OR REPLACE FUNCTION Eliminazione_Tupla_Militanza()
RETURNS TRIGGER AS $$
BEGIN
    DECLARE
        checks RECORD;
    BEGIN
        SELECT * INTO checks
        FROM partecipazione AS p
        WHERE p.id_giocatore = OLD.id_giocatore AND p.nome_squadra = OLD.nome_squadra;

        IF checks.id_giocatore IS NOT NULL THEN
            DELETE FROM partecipazione
            WHERE id_giocatore = OLD.id_giocatore AND nome_squadra = OLD.nome_squadra;
        END IF;

    END;
    RETURN OLD;
END;
$$ LANGUAGE plpgsql;


CREATE TRIGGER Eliminazione_Tupla_Militanza
AFTER DELETE ON Militanza
FOR EACH ROW
EXECUTE FUNCTION Eliminazione_Tupla_Militanza();
