CREATE OR REPLACE FUNCTION Check_and_Insert_Militanza()
RETURNS TRIGGER AS $$
DECLARE
    giocatore Giocatori%ROWTYPE;
    militanza_attiva Militanza%ROWTYPE;
BEGIN
    -- 1. Verifica se il giocatore è ritirato
    SELECT *
    INTO giocatore
    FROM Giocatori
    WHERE id_giocatore = NEW.id_giocatore;
    
    IF giocatore.ritiro = TRUE THEN
        RAISE EXCEPTION 'Impossibile inserire militanza: il giocatore è ritirato.';
    END IF;

    -- 2. Controlla se esiste una militanza con data_fine NULL
    SELECT *
    INTO militanza_attiva
    FROM Militanza
    WHERE id_giocatore = NEW.id_giocatore AND data_termine IS NULL
    LIMIT 1;

    IF FOUND THEN
        RAISE EXCEPTION 'Impossibile inserire militanza: esiste già una militanza attiva per questo giocatore.';
    END IF;

    -- 3. Se tutte le condizioni sono rispettate, l'inserimento della militanza è permesso
    -- Ora aggiorniamo anche la tabella partecipazione
    INSERT INTO partecipazione(id_giocatore, nome_squadra)
    VALUES (NEW.id_giocatore, NEW.nome_squadra);

    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER Check_and_Insert_Militanza
BEFORE INSERT ON Militanza
FOR EACH ROW
EXECUTE FUNCTION Check_and_Insert_Militanza();
