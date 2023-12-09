-- SQL SERVER queries for the transversal project Remark: Database used [SQL Server].
--Gestion des utilisateurs et rôles de le base de données
-- Notez que pour chaque utilisateur, nous devont d’abord créer un LOGIN correspondant : 
CREATE LOGIN AdminLogin1 WITH PASSWORD = 'AdminLogin1Password123';

CREATE LOGIN AdminLogin2 WITH PASSWORD = 'AdminLogin1Password123';

CREATE LOGIN DataEngLogin1 WITH PASSWORD = 'DataEngLogin1Password123';

CREATE LOGIN DataEngLogin2 WITH PASSWORD = 'DataEngLogin1Password123';

CREATE LOGIN DataAnalystLogin1 WITH PASSWORD = 'DataAnalystLogin1Password123';

CREATE LOGIN DataAnalystLogin2 WITH PASSWORD = 'DataAnalystLogin1Password123';

CREATE LOGIN DataSciLogin1 WITH PASSWORD = 'DataSciLogin1Password123';

CREATE LOGIN DataSciLogin2 WITH PASSWORD = 'DataSciLogin1Password123';

CREATE LOGIN MetierLogin1 WITH PASSWORD = 'MetierLogin1Password123';

CREATE LOGIN MetierLogin2 WITH PASSWORD = 'MetierLogin1Password123';

--Assosier les utilisateurs aux logins
-- Association de deux utilisateurs pour le rôle Administrateur
CREATE USER AdminUser1 FOR LOGIN AdminLogin1;

CREATE USER AdminUser2 FOR LOGIN AdminLogin2;

-- Association de deux utilisateurs pour le rôle Data Engineer
CREATE USER DataEngUser1 FOR LOGIN DataEngLogin1;

CREATE USER DataEngUser2 FOR LOGIN DataEngLogin2;

-- Association de deux utilisateurs pour le rôle Data Analyst
CREATE USER DataAnalystUser1 FOR LOGIN DataAnalystLogin1;

CREATE USER DataAnalystUser2 FOR LOGIN DataAnalystLogin2;

-- Association de deux utilisateurs pour le rôle Data Scientist
CREATE USER DataSciUser1 FOR LOGIN DataSciLogin1;

CREATE USER DataSciUser2 FOR LOGIN DataSciLogin2;

-- Association de deux utilisateurs pour le rôle Métier
CREATE USER MetierUser1 FOR LOGIN MetierLogin1;

CREATE USER MetierUser2 FOR LOGIN MetierLogin2;

--creation des rôles
-- Création du rôle Administrateur
CREATE ROLE Administrateur;

-- Création du rôle Data Engineer
CREATE ROLE DataEngineer;

-- Création du rôle Data Analyst
CREATE ROLE DataAnalyst;

-- Création du rôle Data Scientist
CREATE ROLE DataScientist;

-- Création du rôle Métier
CREATE ROLE Metier;
-- Attribution des permissions au rôle Administrateur

--creation de la base de données  et les tables
CREATE DATABASE EntertainmentWorld;

GO
    -- Use the EntertainmentWorld database this is a comment in sqlsql server
    USE EntertainmentWorld;

GO
    ---creating series- Series Table//this is a comment in sqlthis is a comment in sql s
    CREATE TABLE series (
        id_serie INT IDENTITY(1001, 1) PRIMARY KEY,
        titre VARCHAR(50) NOT NULL,
        date_de_creation DATE NOT NULL,
        pays VARCHAR(50),
        langues VARCHAR(50) NOT NULL,
        CONSTRAINT UQ_Titre UNIQUE (titre)
    );

-- --creating the utilisateurs Utilisateurs Table//this is a comment in SQL
CREATE TABLE utilisateurs (
    id_utilisateur INT IDENTITY(2001, 1) PRIMARY KEY,
    nom_u VARCHAR(50) NOT NULL,
    prenom_u VARCHAR(50) NOT NULL,
    mdp VARCHAR(200) NOT NULL,
    age SMALLINT NOT NULL,
    pseudo VARCHAR(50) NOT NULL,
    sexe VARCHAR(1) NOT NULL
);

-- Genre--creating the genress Table//this is a comment in SQL this 
CREATE TABLE genres (
    id_genre INT IDENTITY(3001, 1) PRIMARY KEY,
    nom_gen VARCHAR(50) NOT NULL,
    CONSTRAINT UQ_NomGen UNIQUE (nom_gen)
);

-- Sa--creating the saisonsisons Table//this is a comment in SQL  is this is a comment in sql server 
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

--creating the acteurseurs Table//this is a comment in SQL
CREATE TABLE acteurs (
    id_acteur INT IDENTITY(5001, 1) PRIMARY KEY,
    nom_act VARCHAR(50) NOT NULL,
    prenom_act VARCHAR(50) NOT NULL,
    sexe VARCHAR(10) NOT NULL,
    age INT NOT NULL CHECK (age >= 18)
    AND (age <= 65)
);

CREATE TABLE producteurs (
    id_prod INT IDENTITY(6001, 1) PRIMARY KEY,
    nom VARCHAR(50) NOT NULL,
    prenom VARCHAR(50) NOT NULL,
    sexe VARCHAR(2) NOT NULL
);

-- Categories Table//this is a comment in SQL omment in sql server
CREATE TABLE categories (
    id_categorie INT IDENTITY(7001, 1) PRIMARY KEY,
    nom_cat VARCHAR(255) NOT NULL,
    CONSTRAINT UQ_NomCat UNIQUE (nom_cat)
);

-- Episodes Table//this is a comment in SQL //this is a comment in sql server
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

-- Notes Table//this is a comment in SQL //this is a comment in sql server 
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

-- Createurs Table//this is a comment in SQL //this is a comment in sql server
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

-- Questions Table//this is a comment in SQL his is a comment in sql server
CREATE TABLE questions (
    id_question INT IDENTITY(11001, 1) PRIMARY KEY,
    question TEXT NOT NULL,
    titre_question VARCHAR(100) NOT NULL,
    date_question DATE NOT NULL,
    id_categorie INT,
    id_utilisateur INT,
    FOREIGN KEY(id_categorie) REFERENCES categories(id_categorie) ON DELETE
    SET
        NULL,
        FOREIGN KEY(id_utilisateur) REFERENCES utilisateurs(id_utilisateur) ON DELETE
    SET
        NULL
);

-- Reponses Table//this is a comment in SQL 
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

-- Createur_Producteur_Series Table//this is a comment in SQL /
CREATE TABLE createur_producteur_series (
    id_serie INT,
    id_create INT,
    PRIMARY KEY(id_serie, id_create),
    FOREIGN KEY(id_serie) REFERENCES series(id_serie) ON DELETE CASCADE,
    FOREIGN KEY(id_create) REFERENCES createurs(id_create) ON DELETE CASCADE
);

-- Series_Genres Table//this is a comment in SQL //this is a comment 
CREATE TABLE series_genres (
    id_serie INT,
    id_genre INT,
    PRIMARY KEY(id_serie, id_genre),
    FOREIGN KEY(id_serie) REFERENCES series(id_serie) ON DELETE CASCADE,
    FOREIGN KEY(id_genre) REFERENCES genres(id_genre) ON DELETE CASCADE
);

--Inserting data into the corresponding tables:
-- Insert data into Series Table
INSERT INTO
    series (titre, date_de_creation, pays, langues)
VALUES
    (
        'Breaking Bad',
        '2020-01-05',
        'France',
        'Français '
    ),
    (
        'Death Rate',
        '2021-02-01',
        'Etats-Unis',
        'Anglais'
    ),
    (
        'Episodes',
        '2011-09-25',
        'Etats-Unis',
        'Anglais'
    ),
    ('Bleach', '2004-05-10', 'Japon', 'Japonais'),
    (
        'Outlander',
        '2014-09-14',
        'Etats-Unis',
        'Anglais'
    ),
    ('One Piece', '1999-10-20', 'Japon', 'Japanais'),
    (
        'Game of Thrones',
        '2011-04-17',
        'Etats-Unis',
        'Anglais'
    ),
    (
        'Stranger Things',
        '2016-08-15',
        'Etats-Unis',
        'Anglais'
    ),
    ('Dark', '2017-12-31', 'Allemange', 'Allemand'),
    ('The Crown', '2016-11-04', 'UK', 'Anglais');

--Insert data into Utilisateurs Table
INSERT INTO
    utilisateurs (nom_u, prenom_u, mdp, age, pseudo, sexe)
VALUES
    (
        'Dupont',
        'Jean',
        'motdepasse123',
        30,
        'jeandupont',
        'M'
    ),
    (
        'Martin',
        'Marie',
        'motdepasse456',
        25,
        'mariemartin',
        'M'
    ),
    (
        'Tuss',
        'Moamoa',
        'motdepasse056',
        40,
        'blooow',
        'M'
    ),
    (
        'Mitoma',
        'Titi',
        'motdepasse100',
        28,
        'southsept',
        'F'
    ),
    (
        'Colango',
        'Varen',
        'motdepasse101',
        24,
        'rocketblow',
        'M'
    ),
    (
        'Kfce',
        'Poul',
        'motdepasse110',
        32,
        'misstopo',
        'F'
    ),
    (
        'Rossan',
        'Zen',
        'motdepasse111',
        31,
        'rackett',
        'M'
    ),
    (
        'Messio',
        'Rie',
        'motdepasse135',
        16,
        'moulinlolo',
        'F'
    ),
    (
        'Gahh',
        'Feni',
        'motdepasse654',
        58,
        'sharingan',
        'M'
    ),
    (
        'Maric',
        'Sinoa',
        'motdepasse472',
        20,
        'azerty',
        'F'
    ),
    (
        'Ben',
        'Carlos',
        'motdepasse899',
        20,
        'qiftomit',
        'M'
    ),
    (
        'Bob',
        'Sassi',
        'motdepasse410',
        20,
        'hepconfig',
        'F'
    ),
    (
        'Bisec',
        'Von',
        'motdepasse645',
        20,
        'zaratomi',
        'M'
    ),
    (
        'Dupont',
        'Jean',
        'password123!',
        35,
        'jdupont',
        'M'
    ),
    (
        'Martin',
        'Alice',
        'aliceSecurePwd$',
        28,
        'aliceM',
        'F'
    ),
    (
        'Bernard',
        'Lucas',
        'lucasBernardPass#',
        42,
        'lucasB',
        'M'
    ),
    (
        'Thomas',
        'Marie',
        'marieT2023*',
        30,
        'marieTh',
        'F'
    ),
    (
        'Petit',
        'Émilie',
        'emilieP@ssw0rd',
        25,
        'emilieP',
        'F'
    ),
    (
        'Robert',
        'David',
        'davidR9876!',
        38,
        'davidR',
        'M'
    ),
    (
        'Richard',
        'Sophie',
        'sophieRich2023$',
        33,
        'sophieR',
        'F'
    ),
    (
        'Durand',
        'Étienne',
        'etienneD#Pass',
        29,
        'etienneD',
        'M'
    ),
    (
        'Moreau',
        'Chloé',
        'chloeMdpSecure!',
        26,
        'chloeM',
        'F'
    ),
    (
        'Simon',
        'Mathieu',
        'mathieuS1234$',
        40,
        'mathieuS',
        'M'
    );

-- Insert data into Genres Table
INSERT INTO
    genres (nom_gen)
VALUES
    ('Romance'),
    ('Comodie'),
    ('Action'),
    ('Fantaisie'),
    ('Aventure'),
    ('Horreur'),
    ('Mystere'),
    ('Thriller'),
    ('Science-Fiction'),
    ('Drame Historique'),
    ('Surnaturel');

-- Insert data into Saisons Table
INSERT INTO
    saisons (
        date_de_debut,
        date_de_fin,
        numero_de_saison,
        id_serie
    )
VALUES
    ('2020-01-01', '2020-12-31', 1, 1001),
    ('2021-01-01', '2021-12-31', 2, 1001),
    ('2022-01-04', '2021-06-30', 3, 1001),
    ('2022-07-01', '2022-12-31', 4, 1001),
    ('2021-01-01', '2021-02-28', 1, 1002),
    -- Corrected date
    ('2022-02-01', '2022-10-08', 2, 1002),
    ('2023-01-10', '2023-06-20', 3, 1002),
    ('2011-01-01', '2011-12-31', 1, 1003),
    ('2012-01-01', '2012-12-31', 2, 1003),
    ('2013-01-10', '2013-06-14', 3, 1003),
    ('2014-07-01', '2014-12-31', 4, 1003),
    ('2004-01-01', '2004-12-31', 1, 1004),
    ('2005-01-01', '2005-11-30', 2, 1004),
    -- Corrected date
    ('2006-01-04', '2007-06-16', 3, 1004),
    ('2014-01-01', '2014-12-31', 1, 1005),
    ('2015-01-01', '2015-12-31', 2, 1005),
    ('2016-01-04', '2016-06-06', 3, 1005),
    ('2017-07-01', '2017-12-31', 4, 1005),
    ('1999-01-01', '1999-12-31', 1, 1006),
    ('2000-01-01', '2000-10-30', 2, 1006),
    ('2001-01-04', '2001-11-03', 3, 1006),
    ('2002-07-01', '2002-12-31', 4, 1006),
    ('2011-01-01', '2011-12-31', 1, 1007),
    ('2012-01-01', '2012-12-31', 2, 1007),
    ('2013-01-04', '2013-05-01', 3, 1007),
    ('2014-07-01', '2014-12-31', 4, 1007),
    ('2016-01-11', '2016-12-31', 1, 1008),
    ('2017-01-29', '2017-12-31', 2, 1008),
    ('2018-05-04', '2018-11-30', 3, 1008),
    ('2019-07-01', '2019-12-31', 4, 1008),
    ('2017-03-01', '2017-08-27', 1, 1009),
    ('2018-01-01', '2018-12-31', 3, 1009),
    ('2019-07-04', '2020-05-05', 4, 1009),
    ('2020-07-01', '2020-12-31', 2, 1009),
    ('2016-01-01', '2016-12-31', 1, 1010),
    ('2017-01-01', '2017-12-31', 3, 1010),
    ('2018-01-04', '2018-06-30', 4, 1010);

-- Corrected date
-- Insert data into Acteurs Table
INSERT INTO
    acteurs (nom_act, prenom_act, sexe, age)
VALUES
    ('Moreau', 'Etienne', 'M', 30),
    ('Bernard', 'Claire', 'F', 25),
    ('Petit', 'Olivier', 'M', 40),
    ('Lefebvre', 'Sophie', 'F', 32),
    ('Garcia', 'Lucas', 'M', 28),
    ('Martin', 'Julie', 'F', 35),
    ('Leroy', 'Alexandre', 'M', 45),
    ('Roux', 'Marie', 'F', 22),
    ('David', 'Jean', 'M', 50),
    ('Simon', 'Emilie', 'F', 37),
    ('Blanchard', 'Thomas', 'M', 33),
    ('Chevalier', 'Isabelle', 'F', 29),
    ('Fournier', 'Maxime', 'M', 42),
    ('Roy', 'Catherine', 'F', 38),
    ('Girard', 'Florian', 'M', 24),
    ('Perrin', 'Anne-Laure', 'F', 27),
    ('Lemoine', 'Vincent', 'M', 36),
    ('Caron', 'Elise', 'F', 31),
    ('Poirier', 'Nicolas', 'M', 48),
    ('Mathieu', 'Charlotte', 'F', 22);

-- Insert data into Producteurs Table
NSERT INTO producteurs (nom, prenom, sexe)
VALUES
    ('Leroux', 'Mathieu', 'M'),
    ('Girard', 'Sophie', 'F'),
    ('Morel', 'Pierre', 'M'),
    ('Lefebvre', 'Céline', 'F'),
    ('Lemoine', 'Julien', 'M'),
    ('Mercier', 'Elodie', 'F'),
    ('Boyer', 'Guillaume', 'M'),
    ('Fontaine', 'Amandine', 'F'),
    ('Roux', 'Nicolas', 'M'),
    ('Gaillard', 'Marine', 'F'),
    ('Dupuis', 'Laurent', 'M'),
    ('Moulin', 'Patricia', 'F'),
    ('Lambert', 'Christophe', 'M'),
    ('Bonnet', 'Fanny', 'F'),
    ('Francois', 'Stephane', 'M'),
    ('Martinez', 'Nathalie', 'F'),
    ('Legrand', 'Olivier', 'M'),
    ('Garnier', 'Laetitia', 'F'),
    ('Faure', 'Sebastien', 'M'),
    ('Rousseau', 'Anne', 'F');

INSERT INTO
    categories (nom_cat)
VALUES
    ('Sciences'),
    ('Arts et Litterature'),
    ('Histoire'),
    ('Geographie'),
    ('Technologie'),
    ('Sante et Medecine'),
    ('Divertissement'),
    ('Sports'),
    ('Politique'),
    ('Economie');

-- Insert data into Episodes Table
INSERT INTO
    episodes (titre_ep, duree, date_de_diffusion, id_saison)
VALUES
    (
        'The Silence Is Over',
        '00:45:00',
        '2011-01-09',
        4014
    ),
    (
        'Ghosts of Highway 20',
        '00:45:00',
        '2011-01-16',
        4015
    ),
    (
        'The Substitute Shinigami',
        '00:24:00',
        '2004-10-05',
        4021
    ),
    (
        'The Quincy Archer',
        '00:24:00',
        '2004-10-12',
        1004
    ),
    ('Sassenach', '00:55:00', '2014-08-09', 4028),
    ('Castle Leoch', '00:55:00', '2014-08-16', 4036),
    ('Deja-vu', '00:55:00', '2021-06-27', 4016),
    ('Das Paradies', '00:55:00', '2022-06-27', 4017),
    (
        'Im Luffy! The Man Who Gonna Be King of the Pirates!',
        '00:24:00',
        '1999-10-20',
        4032
    ),
    (
        'Enter the Great Swordsman! Pirate Hunter Roronoa Zoro!',
        '00:24:00',
        '1999-10-27',
        4033
    ),
    (
        'Winter Is Coming',
        '00:55:00',
        '2011-04-17',
        4036
    ),
    (
        'Wolferton Splash',
        '00:55:00',
        '2018-11-04',
        4050
    ),
    (
        'Hyde Park Corner',
        '00:55:00',
        '2016-11-11',
        4044
    ),
    ('Wolferton 2', '00:55:00', '2017-11-04', 4049),
    ('Hyde Park 1', '00:55:00', '2017-11-11', 4049),
    ('The Kingsroad', '00:55:00', '2011-04-24', 4036),
    (
        'The Vanishing of Will Byers',
        '00:50:00',
        '2016-07-15',
        4048
    ),
    (
        'The Weirdo on Maple Street',
        '00:50:00',
        '2016-07-22',
        4048
    ),
    (
        'Wolferton Splash',
        '00:55:00',
        '2016-11-04',
        4040
    ),
    (
        'Hyde Park Corner',
        '00:55:00',
        '2016-11-11',
        4040
    ),
    ('Secrets', '00:50:00', '2017-12-01', 4044),
    ('Lies', '00:50:00', '2017-12-08', 4044),
    ('Pilot', '00:58:00', '2014-01-20', 4028),
    ('Felina', '00:55:00', '2016-09-29', 4030),
    ('The Pilot', '00:30:00', '2011-01-09', 4021),
    ('The Audition', '00:30:00', '2011-01-16', 4021),
    ('The Script', '00:30:00', '2011-01-23', 4021),
    ('The Table Read', '00:30:00', '2012-01-30', 4022),
    (
        'The Photo Shoot',
        '00:30:00',
        '2012-02-06',
        4022
    ),
    ('The Premiere', '00:30:00', '2012-02-13', 4022),
    ('The Review', '00:30:00', '2013-02-20', 4023),
    (
        'The Dinner Party',
        '00:30:00',
        '2013-02-27',
        4023
    ),
    ('The Trip', '00:30:00', '2014-03-06', 4024),
    ('The New Role', '00:30:00', '2014-03-13', 4024),
    (
        'The Substitute Shinigami',
        '00:24:00',
        '2004-10-05',
        4025
    ),
    (
        'The Quincy Archer',
        '00:24:00',
        '2004-10-12',
        4025
    ),
    ('The Hollow', '00:24:00', '2004-10-19', 4025),
    (
        'The Soul Reaper',
        '00:24:00',
        '2005-10-26',
        4026
    ),
    ('The Curse', '00:24:00', '2005-11-02', 4026),
    ('The Fight', '00:24:00', '2005-11-09', 4026),
    ('The Master', '00:24:00', '2005-11-16', 4026),
    ('The Monster', '00:24:00', '2006-11-23', 4027),
    ('The Duel', '00:24:00', '2007-11-30', 4027),
    ('The Awakening', '00:24:00', '2007-12-07', 4027);

-- Insert data into Notes Table
INSERT INTO
    notes (
        commentaire,
        date_note,
        evaluation,
        id_serie,
        id_utilisateur,
        id_episode
    )
VALUES
    (
        'Intrigue captivante et personnages profonds.',
        '2023-01-02',
        8,
        1001,
        2001,
        8018
    ),
    (
        'Un melange parfait d action et de comédie.',
        '2023-01-10',
        4,
        1002,
        2002,
        8020
    ),
    (
        'Une histoire d amour à travers le temps très émouvante.',
        '2023-01-18',
        5,
        1007,
        2003,
        8033
    ),
    (
        'Aventure epique en haute mer avec des personnages mémorables.',
        '2023-01-26',
        5,
        1004,
        2004,
        8034
    ),
    (
        'Une série qui redéfinit le genre fantastique.',
        '2023-02-03',
        9,
        1005,
        2005,
        8048
    ),
    (
        'Suspense et mystère à chaque tournant.',
        '2023-02-11',
        4,
        1006,
        2006,
        8058
    ),
    (
        'Un regard fascinant sur la royaute et histoire britannique.',
        '2023-02-19',
        5,
        1007,
        2007,
        8021
    ),
    (
        'Un thriller psychologique qui vous tiendra en haleine.',
        '2023-02-27',
        5,
        1008,
        2008,
        8060
    ),
    (
        'Excellent character development and plot twists.',
        '2023-03-15',
        5,
        1001,
        2001,
        8050
    ),
    (
        'Great cinematography and soundtrack!',
        '2023-03-16',
        4,
        1002,
        2013,
        8055
    ),
    (
        'The pacing was a bit slow, but overall a good watch.',
        '2023-03-17',
        3,
        1003,
        2003,
        8046
    ),
    (
        'Loved the chemistry between the lead actors.',
        '2023-03-18',
        5,
        1004,
        2014,
        8051
    ),
    (
        'Some episodes felt repetitive, but the finale was satisfying.',
        '2023-03-19',
        4,
        1005,
        2005,
        8061
    ),
    (
        'Intriguing storyline with unexpected plot twists.',
        '2023-03-20',
        5,
        1006,
        2006,
        8041
    ),
    (
        'The special effects were top-notch.',
        '2023-03-21',
        4,
        1002,
        2007,
        8036
    ),
    (
        'A masterpiece in its genre, highly recommended!',
        '2023-03-22',
        5,
        1004,
        2008,
        8022
    ),
    (
        'The writing could be better, but the action scenes were great.',
        '2023-03-23',
        3,
        1009,
        2009,
        8053
    ),
    (
        'A solid addition to the franchise with a few standout episodes.',
        '2023-03-24',
        4,
        1010,
        2021,
        8050
    ),
    (
        'Un début de saison prometteur avec des intrigues bien construites.',
        '2023-03-25',
        5,
        1010,
        2011,
        8040
    ),
    (
        'L episode était un peu lent, mais les performances étaient incroyables.',
        '2023-03-26',
        4,
        1004,
        2012,
        8029
    ),
    (
        'L humour de cette série ne vieillit jamais, toujours aussi drôle.',
        '2023-03-27',
        5,
        1007,
        2013,
        8026
    ),
    (
        'L evolution des personnages est remarquable au fil des saisons.',
        '2023-03-28',
        5,
        1005,
        2014,
        8056
    ),
    (
        'Un episode emouvant qui montre la force du recit.',
        '2023-03-29',
        8,
        1005,
        2015,
        8046
    ),
    (
        'Les decors et costumes sont impressionnants et ajoutent a l ambiance.',
        '2023-03-30',
        5,
        1007,
        2016,
        8057
    ),
    (
        'La bande sonore ajoute une couche supplementaire d emotion aux scenes.',
        '2023-03-31',
        4,
        1008,
        2017,
        8041
    ),
    (
        'Un cliffhanger incroyable qui me laisse impatient pour le prochain episode.',
        '2023-04-01',
        5,
        1009,
        2018,
        8019
    ),
    (
        'Les scenes d action sont bien choregraphiees et captivantes.',
        '2023-04-02',
        8,
        1010,
        2019,
        8044
    ),
    (
        'Une serie qui continue de surprendre et de maintenir l interet.',
        '2023-04-03',
        5,
        1010,
        2020,
        8020
    );

--Insert data into Createurs Table
INSERT INTO
    createurs (nom, prenom, sexe, id_prod)
VALUES
    ('Durand', 'Fabien', 'M', 6001),
    ('Brunet', 'Emilie', 'F', 6002),
    ('Blanc', 'Romain', 'M', 6003),
    ('Leroux', 'Charlotte', 'F', 6004),
    ('Lemoine', 'Alexandre', 'M', 6005),
    ('Marchand', 'Julie', 'F', 6006),
    ('Dufour', 'Nicolas', 'M', 6007),
    ('Meunier', 'Laura', 'F', 6008),
    ('Rodriguez', 'Christophe', 'M', 6009),
    ('Da Silva', 'Sara', 'F', 6010);

-- Insert data into Questions Table
INSERT INTO
    questions (
        question,
        titre_question,
        date_question,
        id_categorie,
        id_utilisateur
    )
VALUES
    (
        'Quelle serie explore les mysteres de la physique quantique ?',
        'Mysteres de la physique quantique',
        '2023-12-06',
        7001,
        2001
    ),
    (
        'Quel serie represente le mieux le mouvement surréaliste ?',
        'Le surrealisme au cinema',
        '2023-12-06',
        7002,
        2002
    ),
    (
        'Quelle serie historique est la plus fidele à la realité ?',
        'Fidélite historique des series',
        '2023-12-06',
        7003,
        2003
    ),
    (
        'Quel serie illustre le mieux la diversite des paysages geographiques ?',
        'Diversite geographique au cinema',
        '2023-12-06',
        7004,
        2004
    ),
    (
        'Quelle serie montre l evolution de la technologie a travers les âges ?',
        'Evolution de la technologie dans les series',
        '2023-12-06',
        7005,
        2005
    ),
    (
        'Quel serie traite de decouvertes medicales importantes ?',
        'Decouvertes medicales au cinema',
        '2023-12-06',
        7006,
        2006
    ),
    (
        'Quelle est la serie la plus divertissante de la decennie ?',
        'Serie la plus divertissante',
        '2023-12-06',
        7007,
        2007
    ),
    (
        'Quel serie sportif est le plus inspirant ?',
        'Films sportifs inspirants',
        '2023-12-06',
        7008,
        2008
    ),
    (
        'Quelle serie dépeint le mieux les enjeux politiques actuels ?',
        'Enjeux politiques dans les series',
        '2023-12-06',
        7009,
        2009
    ),
    (
        'Quel serie explique le mieux les crises economiques ?',
        'Crises economiques au cinema',
        '2023-12-06',
        7010,
        2010
    );

-- Insert data into Reponses table
INSERT INTO
    reponses (
        reponse,
        date_reponse,
        id_question,
        id_utilisateur
    )
VALUES
    (
        'La theorie de la relativite explique le fonctionnement de univers a grande echelle.',
        '2023-12-07',
        11001,
        2001
    ),
    (
        'La serie Un Chien Andalou est un exemple classique du surrealisme.',
        '2023-12-07',
        11002,
        2002
    ),
    (
        'La serie The Crown est reputée pour sa precision historique.',
        '2023-12-07',
        11003,
        2003
    ),
    (
        'La serie Outlander montre une grande variete de paysages naturels.',
        '2023-12-07',
        11004,
        2004
    ),
    (
        'La série Death Rate illustre les implications de la technologie dans la societe moderne.',
        '2023-12-07',
        11005,
        2005
    ),
    (
        'La serie Dark presente des aspects realistes des epidemies et de la recherche medicale.',
        '2023-12-07',
        11006,
        2006
    ),
    (
        'La série Stranger Things est tres populaire pour son melange de suspense, de science-fiction et de nostalgie.',
        '2023-12-07',
        11007,
        2007
    ),
    (
        'La serie Death Rate est inspirant et montre la perseverance dans le sport.',
        '2023-12-07',
        11008,
        2008
    ),
    (
        'La serie Game of Thrones explore les coulisses du pouvoir politique.',
        '2023-12-07',
        11009,
        2009
    ),
    (
        'La serie The Crown explique les causes de la crise financiere de 2008.',
        '2023-12-07',
        11010,
        2010
    );

-- Inserting data into acteurs_episodes
INSERT INTO
    acteurs_episodes (id_episode, id_acteur)
VALUES
    (8018, 5001),
    (8018, 5002),
    (8018, 5003),
    (8018, 5004),
    (8018, 5005),
    (8018, 5006),
    (8018, 5007),
    (8018, 5008),
    (8019, 5001),
    (8019, 5020),
    (8019, 5019),
    (8019, 5010),
    (8019, 5002),
    (8020, 5003),
    (8020, 5004),
    (8020, 5005),
    (8020, 5006),
    (8020, 5007),
    (8020, 5008),
    (8021, 5001),
    (8021, 5020),
    (8021, 5019),
    (8021, 5011),
    (8021, 5002),
    (8021, 5015),
    (8022, 5019),
    (8022, 5018),
    (8022, 5015),
    (8022, 5013),
    (8022, 5012),
    (8023, 5004),
    (8023, 5011),
    (8023, 5010),
    (8023, 5009),
    (8023, 5008),
    (8024, 5004),
    (8024, 5019),
    (8024, 5006),
    (8024, 5018),
    (8024, 5012),
    (8025, 5018),
    (8025, 5012),
    (8025, 5014),
    (8025, 5010),
    (8025, 5011),
    (8026, 5011),
    (8026, 5012),
    (8026, 5014),
    (8026, 5015),
    (8026, 5020),
    (8061, 5020),
    (8061, 5018),
    (8061, 5016),
    (8060, 5007),
    (8060, 5008),
    (8059, 5015),
    (8059, 5014),
    (8059, 5013),
    (8058, 5012),
    (8058, 5011),
    (8058, 5013),
    (8057, 5006),
    (8057, 5013),
    (8057, 5012),
    (8056, 5010),
    (8056, 5012),
    (8056, 5011),
    (8055, 5004),
    (8055, 5019),
    (8055, 5014),
    (8052, 5012),
    (8052, 5010),
    (8052, 5006),
    (8050, 5001),
    (8050, 5016),
    (8050, 5017),
    (8049, 5007),
    (8049, 5015),
    (8049, 5003),
    (8035, 5004),
    (8035, 5002),
    (8035, 5006),
    (8032, 5002),
    (8032, 5001),
    (8032, 5010),
    (8037, 5008),
    (8037, 5015),
    (8037, 5011),
    (8029, 5011),
    (8029, 5015),
    (8029, 5020);

-- Insert data ito Createur_Producteur_Series Table
INSERT INTO
    createur_producteur_series (id_serie, id_create)
VALUES
    (1001, 10001),
    -- Breaking Bad, Durand Fabien
    (1002, 10002),
    -- Death Rate, Brunet Emilie
    (1003, 10003),
    -- Episodes, Blanc Romain
    (1004, 10004),
    -- Bleach, Leroux Charlotte
    (1005, 10005),
    -- Outlander, Lemoine Alexandre
    (1006, 10006),
    -- One Piece, Marchand Julie
    (1007, 10007),
    -- Game of Thrones, Dufour Nicolas
    (1008, 10008),
    -- Stranger Things, Meunier Laura
    (1009, 10009),
    -- Dark, Rodriguez Christophe
    (1010, 10010);

-- The Crown, Da Silva Sara
t
INSERT INTO
    series_genres (id_serie, id_genre)
VALUES
    (1001, 3001),
    -- Breaking Bad, Romance
    (1002, 3002),
    -- Death Rate, Comodie
    (1003, 3003),
    -- Episodes, Action
    (1004, 3004),
    -- Bleach, Fantaisie
    (1005, 3005),
    -- Outlander, Aventure
    (1006, 3006),
    -- One Piece, Horreur
    (1007, 3007),
    -- Game of Thrones, Mystere
    (1008, 3008),
    -- Stranger Things, Thriller
    (1009, 3009),
    -- Dark, Science-Fiction
    (1010, 3010);

-- The Crown, Drame Historique