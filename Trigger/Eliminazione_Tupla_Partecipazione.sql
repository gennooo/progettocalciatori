-- Se sto eliminando da partecipazione, allora la militanza sta terminando.

CREATE OR REPLACE FUNCTION Eliminazione_Tupla_Partecipazione()
RETURNS TRIGGER AS $$
DECLARE
    tmp Militanza%ROWTYPE;
BEGIN
    -- Utilizzare direttamente la variabile tmp senza aprire il cursore
    SELECT *
    INTO tmp
    FROM Militanza
    WHERE nome_squadra = OLD.nome_squadra AND id_giocatore = OLD.id_giocatore
    ORDER BY data_inizio DESC
    LIMIT 1;

    IF tmp.data_termine IS NULL THEN
        UPDATE Militanza
        SET data_termine = CURRENT_DATE
        WHERE id_militanza = tmp.id_militanza;
    END IF;

    RETURN OLD;
END;
$$ LANGUAGE plpgsql;


-- Creazione del trigger separatamente dalla definizione della funzione
CREATE TRIGGER Eliminazione_Tupla_Partecipazione
BEFORE DELETE ON partecipazione
EXECUTE FUNCTION Eliminazione_Tupla_Partecipazione();
