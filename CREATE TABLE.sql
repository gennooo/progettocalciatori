CREATE TABLE Nazioni (
    nome VARCHAR(50) NOT NULL,
    PRIMARY KEY (nome));

CREATE TABLE Giocatori (
    nome VARCHAR(50) NOT NULL,
    cognome VARCHAR(50) NOT NULL,
    id_giocatore id_valido NOT NULL,
    data_nascita DATE NOT NULL,
    piede CHARACTER(2) NOT NULL,
    ruolo ruolo_position NOT NULL,
    abilita skills NOT NULL,
    ritiro BOOLEAN NOT NULL DEFAULT FALSE,
    data_ritiro DATE NOT NULL
  
    PRIMARY KEY (id_giocatore),
  
    CONSTRAINT checkpiede CHECK (piede = 'D' or piede = 'S' or piede = 'DS')
    CONSTRAINT checkdata CHECK (data_nascita < data_ritiro)
);


CREATE TABLE Squadra (
    nome_squadra VARCHAR(50) NOT NULL,
    nazionalita VARCHAR(50) REFERENCES Nazioni(Nome) NOT NULL

    PRIMARY KEY (nome_squadra)
);

Create table Militanza (
    nome_squadra VARCHAR(50) REFERENCES Squadra(nome_squadra) NOT NULL,
    ruolomilitanza VARCHAR(1) NOT NULL,
    id_militanza NOT NULL
    id_giocatore id_valido NOT NULL,
    data_inizio NOT NULL,
    data_termine NOT NULL,
    partite_giocate NOT NULL,
    goal_segnati NOT NULL,
    assist NOT NULL,
    goal_subiti NOT NULL
  
    PRIMARY KEY (id_militanza),
  
    CONSTRAINT checkdate CHECK (data_inizio < data_termine)
    CONSTRAINT checkruolomilitanza CHECK (ruolomilitanza = 'M' OR ruolomilitanza = 'P')
    CONSTRAINT checkgoalsubiti CHECK ((goal_subiti = 0 AND ruolomilitanza = 'M') OR (goal_subiti >= 0 AND ruolomilitanza = 'P')
  );

CREATE TABLE Trofeo (
    nome_trofeo VARCHAR(50) NOT NULL,
    anno DATE NOT NULL,
    trofeo_individuale BOOLEAN NOT NULL DEFAULT FALSE
    
    PRIMARY KEY (nome_trofeo, anno)
);

CREATE TABLE vincere_individuale (
    id_giocatore id_valido REFERENCES Giocatori(id_giocatore) NOT NULL,
    nome_trofeo VARCHAR(30) NOT NULL,
    anno DATE NOT NULL,

    PRIMARY KEY (nome_trofeo, anno)

    CONSTRAINT TrofeoFK FOREIGN KEY (nome_trofeo, anno) REFERENCES Trofeo(nome_trofeo, anno));

CREATE TABLE vincere_squadra (
nome_squadra VARCHAR(50) REFERENCES Squadra(nome_squadra) NOT NULL,
nome_trofeo VARCHAR(30) NOT NULL,
    anno DATE NOT NULL,

    PRIMARY KEY (nome_trofeo, anno)

    CONSTRAINT TrofeoFK FOREIGN KEY (nome_trofeo, anno) REFERENCES Trofeo(nome_trofeo, anno));

CREATE TABLE partecipazione(
id_giocatore id_valido REFERENCES Giocatore(id_giocatore) NOT NULL,
nomesquadra VARCHAR(50) REFERENCES Squadra(nome_squadra) NOT NULL);

CREATE TABLE Utenti (
    username VARCHAR(20) UNIQUE NOT NULL,
    password VARCHAR(20) NOT NULL
);

