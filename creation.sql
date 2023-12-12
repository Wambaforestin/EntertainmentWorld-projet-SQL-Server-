--creation de la base de données  et les tables
CREATE DATABASE EntertainmentWorld;

GO
    -- Use the EntertainmentWorld database 
    USE EntertainmentWorld;

GO
    ---creating series
    CREATE TABLE series (
        id_serie INT IDENTITY(1001, 1) PRIMARY KEY,
        titre VARCHAR(50) NOT NULL,
        date_de_creation DATE NOT NULL,
        pays VARCHAR(50),
        langues VARCHAR(50) NOT NULL,
        CONSTRAINT UQ_Titre UNIQUE (titre)
    );

-- --creating the utilisateurs
CREATE TABLE utilisateurs (
    id_utilisateur INT IDENTITY(2001, 1) PRIMARY KEY,
    nom_u VARCHAR(50) NOT NULL,
    prenom_u VARCHAR(50) NOT NULL,
    mdp VARCHAR(200) NOT NULL,
    age SMALLINT NOT NULL,
    pseudo VARCHAR(50) NOT NULL,
    sexe VARCHAR(1) NOT NULL
);

-- Genres Table 
CREATE TABLE genres (
    id_genre INT IDENTITY(3001, 1) PRIMARY KEY,
    nom_gen VARCHAR(50) NOT NULL,
    CONSTRAINT UQ_NomGen UNIQUE (nom_gen)
);

-- Sa--creating the saisons 
CREATE TABLE saisons (
    id_saison INT IDENTITY(4001, 1) PRIMARY KEY,
    date_de_debut DATE NOT NULL,
    date_de_fin DATE NOT NULL,
    numero_de_saison INT NOT NULL,
    id_serie INT,
    FOREIGN KEY(id_serie) REFERENCES series(id_serie) ON DELETE
    SET
        NULL
);

--creating the acteurs
CREATE TABLE acteurs (
    id_acteur INT IDENTITY(5001, 1) PRIMARY KEY,
    nom_act VARCHAR(50) NOT NULL,
    prenom_act VARCHAR(50) NOT NULL,
    sexe VARCHAR(10) NOT NULL,
    age INT NOT NULL CHECK (age >= 18)
    AND (age <= 65)
);
--table producteurs
CREATE TABLE producteurs (
    id_prod INT IDENTITY(6001, 1) PRIMARY KEY,
    nom VARCHAR(50) NOT NULL,
    prenom VARCHAR(50) NOT NULL,
    sexe VARCHAR(2) NOT NULL
);

-- Categories Table
CREATE TABLE categories (
    id_categorie INT IDENTITY(7001, 1) PRIMARY KEY,
    nom_cat VARCHAR(255) NOT NULL,
    CONSTRAINT UQ_NomCat UNIQUE (nom_cat)
);

-- Episodes Table
CREATE TABLE episodes (
    id_episode INT IDENTITY(8001, 1) PRIMARY KEY,
    titre_ep VARCHAR(50) NOT NULL,
    duree TIME NOT NULL,
    date_de_diffusion DATE NOT NULL,
    id_saison INT,
    FOREIGN KEY(id_saison_) REFERENCES saisons(id_saison_) ON DELETE
    SET
        NULL
);

-- Notes Table
CREATE TABLE notes (
    id_note INT IDENTITY(9001, 1) PRIMARY KEY,
    commentaire VARCHAR(255) NOT NULL,
    date_note DATE NOT NULL,
    evaluation SMALLINT NOT NULL,
    id_serie INT,
    id_utilisateur INT,
    id_episode INT,
    FOREIGN KEY(id_serie) REFERENCES series(id_serie) ON DELETE
    SET
        NULL,
        FOREIGN KEY(id_utilisateur) REFERENCES utilisateurs(id_utilisateur) ON DELETE
    SET
        NULL,
        FOREIGN KEY(id_episode) REFERENCES episodes(id_episode) ON DELETE
    SET
        NULL
);

-- Createurs Table
CREATE TABLE createurs (
    id_create INT IDENTITY(10001, 1) PRIMARY KEY,
    nom VARCHAR(50) NOT NULL,
    prenom VARCHAR(50) NOT NULL,
    sex VARCHAR(2) NOT NULL,
    id_prod INT,
    FOREIGN KEY(id_prod) REFERENCES producteurs(id_prod) ON DELETE
    SET
        NULL
);

-- Questions Table
CREATE TABLE questions (
    id_question INT IDENTITY(11001, 1) PRIMARY KEY,
    question TEXT NOT NULL,
    titre_question VARCHAR(100) NOT NULL,
    date_question DATE NOT NULL,
    id_categorie INT,
    id_utilisateur INT,
    id_serie INT,
    FOREIGN KEY (id_serie) REFERENCES series(id_serie) ON DELETE SET NULL,
    FOREIGN KEY(id_categorie) REFERENCES categories(id_categorie) ON DELETE
    SET
        NULL,
        FOREIGN KEY(id_utilisateur) REFERENCES utilisateurs(id_utilisateur) ON DELETE
    SET
        NULL
);

-- Reponses Table 
CREATE TABLE reponses (
    id_answer INT IDENTITY(12001, 1) PRIMARY KEY,
    reponse VARCHAR(255) NOT NULL,
    date_reponse DATE NOT NULL,
    id_question INT,
    id_utilisateur INT,
    FOREIGN KEY(id_question) REFERENCES questions(id_question) ON DELETE
    SET
        NULL,
        FOREIGN KEY(id_utilisateur) REFERENCES utilisateurs(id_utilisateur) ON DELETE
    SET
        NULL
);

CREATE TABLE acteurs_episodes(
    id_episode INT,
    id_acteur INT,
    PRIMARY KEY(id_episode, id_acteur),
    FOREIGN KEY(id_episode) REFERENCES episodes(id_episode) ON DELETE CASCADE,
    FOREIGN KEY(id_acteur) REFERENCES acteurs_(id_acteur) ON DELETE CASCADE
);

-- Createur_Producteur_Series Table
CREATE TABLE createur_producteur_series (
    id_serie INT,
    id_create INT,
    PRIMARY KEY(id_serie, id_create),
    FOREIGN KEY(id_serie) REFERENCES series(id_serie) ON DELETE CASCADE,
    FOREIGN KEY(id_create) REFERENCES createurs(id_create) ON DELETE CASCADE
);

-- Series_Genres Table
CREATE TABLE series_genres (
    id_serie INT,
    id_genre INT,
    PRIMARY KEY(id_serie, id_genre),
    FOREIGN KEY(id_serie) REFERENCES series(id_serie) ON DELETE CASCADE,
    FOREIGN KEY(id_genre) REFERENCES genres(id_genre) ON DELETE CASCADE
);
