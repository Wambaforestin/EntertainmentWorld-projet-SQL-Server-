-- Suppression des contraintes FK avant de supprimer les tables
IF OBJECT_ID('RESULTATS', 'U') IS NOT NULL BEGIN
ALTER TABLE
    RESULTATS DROP CONSTRAINT FK_RESULTATS_ELEVES;

ALTER TABLE
    RESULTATS DROP CONSTRAINT FK_RESULTATS_COURS;

END -- Suppression des tables
IF OBJECT_ID('ACTIVITES_PRATIQUEES', 'U') IS NOT NULL DROP TABLE ACTIVITES_PRATIQUEES;

IF OBJECT_ID('CHARGE', 'U') IS NOT NULL DROP TABLE CHARGE;

IF OBJECT_ID('RESULTATS', 'U') IS NOT NULL DROP TABLE RESULTATS;

IF OBJECT_ID('ACTIVITES', 'U') IS NOT NULL DROP TABLE ACTIVITES;

IF OBJECT_ID('PROFESSEURS', 'U') IS NOT NULL DROP TABLE PROFESSEURS;

IF OBJECT_ID('COURS', 'U') IS NOT NULL DROP TABLE COURS;

IF OBJECT_ID('ELEVES', 'U') IS NOT NULL DROP TABLE ELEVES;

IF OBJECT_ID('AGGLOMERATION', 'U') IS NOT NULL DROP TABLE AGGLOMERATION;

IF OBJECT_ID('CHARGE', 'U') IS NOT NULL DROP TABLE CHARGE;

IF OBJECT_ID('ACTIVITES_PRATIQUEES', 'U') IS NOT NULL DROP TABLE ACTIVITES_PRATIQUEES;

-- =========================================
-- Initialisation du type date
-- =========================================
SET
    DATEFORMAT dmy;

-- =========================================
-- Création des tables de la bd ELEVE
-- =========================================
-- Table : ELEVES
CREATE TABLE ELEVES (
    NUM_ELEVE INT,
    NOM VARCHAR(25),
    PRENOM VARCHAR(25),
    DATE_NAISSANCE DATE,
    POIDS INT,
    ANNEE INT,
    SEXE CHAR(1),
    CONSTRAINT PK_ELEVES PRIMARY KEY(NUM_ELEVE),
    CONSTRAINT NN_ELEVE_NOM CHECK(NOM IS NOT NULL),
    CONSTRAINT NN_ELEVE_PRENOM CHECK(PRENOM IS NOT NULL)
);

-- =========================================
-- Table : COURS
-- =========================================
CREATE TABLE COURS (
    NUM_COURS INT,
    NOM VARCHAR(20),
    NBHEURES INT,
    ANNEE INT,
    CONSTRAINT PK_COURS PRIMARY KEY(NUM_COURS),
    CONSTRAINT NN_COURS_NOM CHECK(NOM IS NOT NULL)
);

-- =========================================
-- Table : PROFESSEURS
-- =========================================
CREATE TABLE PROFESSEURS (
    NUM_PROF INT,
    NOM VARCHAR(25),
    SPECIALITE VARCHAR(20),
    DATE_ENTREE DATE,
    DER_PROM DATE,
    SALAIRE_BASE INT,
    SALAIRE_ACTUEL INT,
    CONSTRAINT PK_PROFESSEURS PRIMARY KEY(NUM_PROF),
    CONSTRAINT NN_PROFESSEURS_NOM CHECK(NOM IS NOT NULL)
);

-- =========================================
-- Table : ACTIVITES
-- =========================================
CREATE TABLE ACTIVITES (
    NIVEAU INT,
    NOM VARCHAR(20),
    EQUIPE VARCHAR(32),
    CONSTRAINT PK_ACTIVITES PRIMARY KEY(NIVEAU, NOM)
);

-- =========================================
-- Table : RESULTATS
-- =========================================
CREATE TABLE RESULTATS (
    NUM_ELEVE INT,
    NUM_COURS INT,
    POINTS INT,
    CONSTRAINT PK_RESULTATS PRIMARY KEY(NUM_ELEVE, NUM_COURS),
    CONSTRAINT FK_RESULTATS_ELEVES FOREIGN KEY (NUM_ELEVE) REFERENCES ELEVES(NUM_ELEVE),
    CONSTRAINT FK_RESULTATS_COURS FOREIGN KEY (NUM_COURS) REFERENCES COURS(NUM_COURS)
);

CREATE TABLE CHARGE (
    NUM_PROF INT NOT NULL,
    NUM_COURS INT NOT NULL,
    CONSTRAINT PK_CHARGE PRIMARY KEY(NUM_COURS, NUM_PROF),
    CONSTRAINT FK_CHARGE_PROF FOREIGN KEY (NUM_PROF) REFERENCES PROFESSEURS(NUM_PROF),
    CONSTRAINT FK_CHARGE_COURS FOREIGN KEY (NUM_COURS) REFERENCES COURS(NUM_COURS)
);

CREATE TABLE ACTIVITES_PRATIQUEES (
    NUM_ELEVE INT,
    NIVEAU INT,
    NOM VARCHAR(20),
    CONSTRAINT PK_ACTIVITES_PRATIQUEES PRIMARY KEY(NUM_ELEVE, NIVEAU, NOM),
    CONSTRAINT FK_ACTIVITES_PRATIQUEES_ELEVES FOREIGN KEY (NUM_ELEVE) REFERENCES ELEVES(NUM_ELEVE),
    CONSTRAINT FK_ACTIVITES_PRATIQUEES_ACTIVITES FOREIGN KEY (NIVEAU, NOM) REFERENCES ACTIVITES(NIVEAU, NOM)
);

Insert into
    eleves (
        Num_eleve,
        nom,
        prenom,
        date_naissance,
        Poids,
        annee,
        sexe
    )
Values
    (1, 'Brisefer', 'Benoit', '10-12-1978', 35, 1, 'M');

Insert into
    eleves (
        Num_eleve,
        nom,
        prenom,
        date_naissance,
        Poids,
        annee,
        sexe
    )
Values
    (2, 'Génial', 'Olivier', '10-04-1978', 42, 1, 'M');

Insert into
    eleves (
        num_eleve,
        nom,
        prenom,
        date_naissance,
        Poids,
        annee,
        sexe
    )
Values
    (3, 'Jourdan', 'Gil', '28-06-1974', 72, 2, 'F');

Insert into
    eleves (
        num_eleve,
        nom,
        prenom,
        date_naissance,
        Poids,
        annee,
        sexe
    )
Values
    (4, 'Spring', 'Jerry', '16-02-1974', 78, 2, 'M');

Insert into
    eleves (
        num_eleve,
        nom,
        prenom,
        date_naissance,
        Poids,
        annee,
        sexe
    )
Values
    (5, 'Tsuno', 'Yoko', '29-10-1977', 45, 1, 'F');

Insert into
    eleves (
        num_eleve,
        nom,
        prenom,
        date_naissance,
        Poids,
        annee,
        sexe
    )
Values
    (6, 'Lebut', 'Marc', '29-04-1974', 75, 2, 'M');

Insert into
    eleves (
        num_eleve,
        nom,
        prenom,
        date_naissance,
        Poids,
        annee,
        sexe
    )
Values
    (7, 'Lagaffe', 'Gaston', '08-04-1975', 61, 1, 'M');

Insert into
    eleves (
        num_eleve,
        nom,
        prenom,
        date_naissance,
        Poids,
        annee,
        sexe
    )
Values
    (8, 'Dubois', 'Robin', '20-04-1976', 60, 2, 'M');

Insert into
    eleves (
        num_eleve,
        nom,
        prenom,
        date_naissance,
        Poids,
        annee,
        sexe
    )
Values
    (
        9,
        'Walthéry',
        'Natacha',
        '07-09-1977',
        59,
        1,
        'F'
    );

Insert into
    eleves (
        num_eleve,
        nom,
        prenom,
        date_naissance,
        Poids,
        annee,
        sexe
    )
Values
    (10, 'Danny', 'Buck', '15-02-1973', 82, 2, 'M');

Insert into
    cours (Num_cours, Nom, Nbheures, annee)
Values
    (1, 'Réseau', 15, 1);

Insert into
    cours (Num_cours, Nom, Nbheures, annee)
Values
    (2, 'Sgbd', 30, 1);

Insert into
    cours (Num_cours, Nom, Nbheures, annee)
Values
    (3, 'Programmation', 15, 1);

Insert into
    cours (Num_cours, Nom, Nbheures, annee)
Values
    (4, 'Sgbd', 30, 2);

Insert into
    cours (Num_cours, Nom, Nbheures, annee)
Values
    (5, 'Analyse', 60, 2);

Insert into
    PROFESSEURS (
        Num_prof,
        nom,
        specialite,
        Date_entree,
        Der_prom,
        Salaire_base,
        Salaire_actuel
    )
Values
(
        1,
        'Bottle',
        'poésie',
        '01-10-1970',
        '01-10-1988',
        2000000,
        2600000
    );

Insert into
    PROFESSEURS (
        Num_prof,
        nom,
        specialite,
        Date_entree,
        Der_prom,
        Salaire_base,
        Salaire_actuel
    )
Values
(
        2,
        'Bolenov',
        'réseau',
        '15-11-1968',
        '01-10-1998',
        1900000,
        2468000
    );

Insert into
    PROFESSEURS (
        Num_prof,
        nom,
        specialite,
        Date_entree,
        Der_prom,
        Salaire_base,
        Salaire_actuel
    )
Values
(
        3,
        'Tonilaclasse',
        'poo',
        '01-10-1979',
        '01-01-1989',
        1900000,
        2360000
    );

Insert into
    PROFESSEURS (
        Num_prof,
        nom,
        specialite,
        Date_entree,
        Der_prom,
        Salaire_base,
        Salaire_actuel
    )
Values
(
        4,
        'Pastecnov',
        'sql',
        '01-10-1975',
        '',
        2500000,
        2500000
    );

Insert into
    PROFESSEURS (
        Num_prof,
        nom,
        specialite,
        Date_entree,
        Der_prom,
        Salaire_base,
        Salaire_actuel
    )
Values
(
        5,
        'Selector',
        'sql',
        '15-10-1982',
        '01-10-1988',
        1900000,
        1900000
    );

Insert into
    PROFESSEURS (
        Num_prof,
        nom,
        specialite,
        Date_entree,
        Der_prom,
        Salaire_base,
        Salaire_actuel
    )
Values
(
        6,
        'Vilplusplus',
        'poo',
        '25-04-1990',
        '05-06-1994',
        1900000,
        2200000
    );

Insert into
    PROFESSEURS (
        Num_prof,
        nom,
        specialite,
        Date_entree,
        Der_prom,
        Salaire_base,
        Salaire_actuel
    )
Values
(
        7,
        'Francesca',
        '',
        '01-10-1975',
        '11-01-1998',
        2000000,
        3200000
    );

Insert into
    PROFESSEURS (
        Num_prof,
        nom,
        specialite,
        Date_entree,
        Der_prom,
        Salaire_base,
        Salaire_actuel
    )
Values
(
        8,
        'Pucette',
        'sql',
        '06-12-1988',
        '29-02-1996',
        2000000,
        2500000
    );

Insert into
    CHARGE (Num_prof, Num_cours)
Values
(1, 1);

Insert into
    CHARGE (Num_prof, Num_cours)
Values
(1, 4);

Insert into
    CHARGE (Num_prof, Num_cours)
Values
(2, 1);

Insert into
    CHARGE (Num_prof, Num_cours)
Values
(3, 2);

Insert into
    CHARGE (Num_prof, Num_cours)
Values
(3, 4);

Insert into
    CHARGE (Num_prof, Num_cours)
Values
(3, 5);

Insert into
    CHARGE (Num_prof, Num_cours)
Values
(4, 2);

Insert into
    CHARGE (Num_prof, Num_cours)
Values
(7, 4);

Insert into
    CHARGE (Num_prof, Num_cours)
Values
(8, 1);

Insert into
    CHARGE (Num_prof, Num_cours)
Values
(8, 2);

Insert into
    CHARGE (Num_prof, Num_cours)
Values
(8, 3);

Insert into
    CHARGE (Num_prof, Num_cours)
Values
(8, 4);

Insert into
    CHARGE (Num_prof, Num_cours)
Values
(8, 5);

Insert into
    RESULTATS (Num_eleve, Num_cours, points)
Values
(1, 1, 15);

Insert into
    RESULTATS (Num_eleve, Num_cours, points)
Values
(1, 2, 10.5);

Insert into
    RESULTATS (Num_eleve, Num_cours, points)
Values
(1, 4, 8);

Insert into
    RESULTATS (Num_eleve, Num_cours, points)
Values
(1, 5, 20);

Insert into
    RESULTATS (Num_eleve, Num_cours, points)
Values
(2, 1, 13.5);

Insert into
    RESULTATS (Num_eleve, Num_cours, points)
Values
(2, 2, 12);

Insert into
    RESULTATS (Num_eleve, Num_cours, points)
Values
(2, 4, 11);

Insert into
    RESULTATS (Num_eleve, Num_cours, points)
Values
(2, 5, 1.5);

Insert into
    RESULTATS (Num_eleve, Num_cours, points)
Values
(3, 1, 14);

Insert into
    RESULTATS (Num_eleve, Num_cours, points)
Values
(3, 2, 15);

Insert into
    RESULTATS (Num_eleve, Num_cours, points)
Values
(3, 4, 16);

Insert into
    RESULTATS (Num_eleve, Num_cours, points)
Values
(3, 5, 20);

Insert into
    RESULTATS (Num_eleve, Num_cours, points)
Values
(4, 1, 16.5);

Insert into
    RESULTATS (Num_eleve, Num_cours, points)
Values
(4, 2, 14);

Insert into
    RESULTATS (Num_eleve, Num_cours, points)
Values
(4, 4, 11);

Insert into
    RESULTATS (Num_eleve, Num_cours, points)
Values
(4, 5, 8);

Insert into
    RESULTATS (Num_eleve, Num_cours, points)
Values
(5, 1, 5);

Insert into
    RESULTATS (Num_eleve, Num_cours, points)
Values
(5, 2, 6.5);

Insert into
    RESULTATS (Num_eleve, Num_cours, points)
Values
(5, 4, 13);

Insert into
    RESULTATS (Num_eleve, Num_cours, points)
Values
(5, 5, 13);

Insert into
    RESULTATS (Num_eleve, Num_cours, points)
Values
(6, 1, 15);

Insert into
    RESULTATS (Num_eleve, Num_cours, points)
Values
(6, 2, 3.5);

Insert into
    RESULTATS (Num_eleve, Num_cours, points)
Values
(6, 4, 16);

Insert into
    RESULTATS (Num_eleve, Num_cours, points)
Values
(6, 5, 5);

Insert into
    RESULTATS (Num_eleve, Num_cours, points)
Values
(7, 1, 2.5);

Insert into
    RESULTATS (Num_eleve, Num_cours, points)
Values
(7, 2, 18);

Insert into
    RESULTATS (Num_eleve, Num_cours, points)
Values
(7, 4, 11);

Insert into
    RESULTATS (Num_eleve, Num_cours, points)
Values
(7, 5, 10);

Insert into
    RESULTATS (Num_eleve, Num_cours, points)
Values
(8, 1, 16);

Insert into
    RESULTATS (Num_eleve, Num_cours, points)
Values
(8, 2, 0);

Insert into
    RESULTATS (Num_eleve, Num_cours, points)
Values
(8, 4, 6);

Insert into
    RESULTATS (Num_eleve, Num_cours, points)
Values
(8, 5, 11.5);

Insert into
    RESULTATS (Num_eleve, Num_cours, points)
Values
(9, 1, 20);

Insert into
    RESULTATS (Num_eleve, Num_cours, points)
Values
(9, 2, 20);

Insert into
    RESULTATS (Num_eleve, Num_cours, points)
Values
(9, 4, 14);

Insert into
    RESULTATS (Num_eleve, Num_cours, points)
Values
(9, 5, 9.5);

Insert into
    RESULTATS (Num_eleve, Num_cours, points)
Values
(10, 1, 3);

Insert into
    RESULTATS (Num_eleve, Num_cours, points)
Values
(10, 2, 12.5);

Insert into
    RESULTATS (Num_eleve, Num_cours, points)
Values
(10, 4, 0);

Insert into
    RESULTATS (Num_eleve, Num_cours, points)
Values
(10, 5, 16);

Insert into
    ACTIVITES (Niveau, Nom, equipe)
Values
(1, 'Mini foot', 'Amc Indus');

Insert into
    ACTIVITES (Niveau, Nom, equipe)
values
    (1, 'Surf', 'Les planchistes ...');

Insert into
    ACTIVITES (Niveau, Nom, equipe)
Values
(2, 'Tennis', 'Ace Club');

Insert into
    ACTIVITES (Niveau, Nom, equipe)
Values
(3, 'Tennis', 'Ace Club');

Insert into
    ACTIVITES (Niveau, Nom, equipe)
Values
(1, 'Volley ball', 'Avs80');

Insert into
    ACTIVITES (Niveau, Nom, equipe)
Values
(2, 'Mini foot', 'Les as du ballon');

Insert into
    ACTIVITES (Niveau, Nom, equipe)
Values
(2, 'Volley ball', 'smash');

Insert into
    ACTIVITES_PRATIQUEES (Num_eleve, Niveau, Nom)
Values
    (1, 1, 'Mini foot');

Insert into
    ACTIVITES_PRATIQUEES (Num_eleve, Niveau, Nom)
Values
    (1, 1, 'Surf');

Insert into
    ACTIVITES_PRATIQUEES (Num_eleve, Niveau, Nom)
Values
    (1, 1, 'Volley ball');

Insert into
    ACTIVITES_PRATIQUEES (Num_eleve, Niveau, Nom)
Values
    (1, 2, 'Tennis');

Insert into
    ACTIVITES_PRATIQUEES (Num_eleve, Niveau, Nom)
Values
    (2, 1, 'Mini foot');

Insert into
    ACTIVITES_PRATIQUEES (Num_eleve, Niveau, Nom)
Values
    (2, 2, 'Tennis');

Insert into
    ACTIVITES_PRATIQUEES (Num_eleve, Niveau, Nom)
Values
    (3, 2, 'Mini foot');

Insert into
    ACTIVITES_PRATIQUEES (Num_eleve, Niveau, Nom)
Values
    (3, 2, 'Tennis');

Insert into
    ACTIVITES_PRATIQUEES (Num_eleve, Niveau, Nom)
Values
    (3, 2, 'Volley ball');

Insert into
    ACTIVITES_PRATIQUEES (Num_eleve, Niveau, Nom)
Values
    (4, 1, 'Surf');

Insert into
    ACTIVITES_PRATIQUEES (Num_eleve, Niveau, Nom)
Values
    (4, 2, 'Mini foot');

Insert into
    ACTIVITES_PRATIQUEES (Num_eleve, Niveau, Nom)
Values
    (5, 1, 'Mini foot');

Insert into
    ACTIVITES_PRATIQUEES (Num_eleve, Niveau, Nom)
Values
    (5, 1, 'Surf');

Insert into
    ACTIVITES_PRATIQUEES (Num_eleve, Niveau, Nom)
Values
    (5, 1, 'Volley ball');

Insert into
    ACTIVITES_PRATIQUEES (Num_eleve, Niveau, Nom)
Values
    (8, 1, 'Mini foot');

Insert into
    ACTIVITES_PRATIQUEES (Num_eleve, Niveau, Nom)
Values
    (8, 1, 'Volley ball');

Insert into
    ACTIVITES_PRATIQUEES (Num_eleve, Niveau, Nom)
Values
    (8, 2, 'Volley ball');

Insert into
    ACTIVITES_PRATIQUEES (Num_eleve, Niveau, Nom)
Values
    (9, 1, 'Mini foot');

Insert into
    ACTIVITES_PRATIQUEES (Num_eleve, Niveau, Nom)
Values
    (9, 2, 'Volley ball');

Insert into
    ACTIVITES_PRATIQUEES (Num_eleve, Niveau, Nom)
Values
    (10, 1, 'Mini foot');

Insert into
    ACTIVITES_PRATIQUEES (Num_eleve, Niveau, Nom)
Values
    (10, 2, 'Tennis');

Insert into
    ACTIVITES_PRATIQUEES (Num_eleve, Niveau, Nom)
Values
    (10, 2, 'Volley ball');

-- =========================================
-- Reponse des interrogations
-- =========================================

--I.Contraintes

--1.Essayez de modifier les tables pour ajouter les contraintes suivantes en SQL :
--1.1 La note d’un étudiant doit être comprise entre 0 et 20.
ALTER TABLE
    RESULTATS ADD CONSTRAINT CK_RESULTATS_POINTS CHECK(POINTS BETWEEN 0 AND 20);
--1.2 Le sexe d’un étudiant doit être dans la liste: ‘m’, ‘M’, ‘f’, ‘F’ ou Null.
ALTER TABLE
    ELEVES ADD CONSTRAINT CK_ELEVES_SEXE CHECK(SEXE IN ('m', 'M', 'f', 'F', NULL));
--1.3 Contrainte horizontale : Le salaire de base d’un professeur doit être inférieur au salaire actuel.
ALTER TABLE
    PROFESSEURS ADD CONSTRAINT CK_PROFESSEURS_SALAIRE CHECK(Salaire_base < Salaire_actuel);
--1.4 Contrainte verticale : Le salaire d’un professeur ne doit pas dépasser le double de la moyenne des salaires des enseignants de la même spécialité.
ALTER TABLE
    PROFESSEURS ADD CONSTRAINT CK_PROFESSEURS_SALAIRE2 CHECK(Salaire_actuel < 2 * (SELECT AVG(Salaire_actuel) FROM PROFESSEURS WHERE SPECIALITE = PROFESSEURS.SPECIALITE));
--2.Que constatez-vous?
La contrainte horizontale est vérifiée pour chaque ligne de la table, alors que la contrainte verticale est vérifiée pour la table entière.

--II.Triggers

--1.Créez un trigger permettant de vérifier la contrainte : « Le salaire d’un Professeur ne peut pas diminuer ». Ce trigger doit être déclenché avant la modification d’un salaire.noté que aucune transactions a été créé.
CREATE TRIGGER TRG_PROFESSEURS_SALAIRE
ON PROFESSEURS
FOR UPDATE
AS
    IF UPDATE(SALAIRE_ACTUEL)
    BEGIN
        IF EXISTS(SELECT * FROM inserted WHERE Salaire_actuel < deleted.Salaire_actuel)
        BEGIN
            ROLLBACK TRANSACTION
            RAISERROR('Le salaire ne peut pas diminuer', 16, 1)
        END
    END
--2.Gestion automatique de la redondance
--2.1 Créez la table suivante :
-- CREATE TABLE PROF_SPECIALITE (
--     SPECIALITE VARCHAR(20), 
--     NB_PROFESSEURS NUMBER);
--2.2Créez un trigger permettant de remplir et mettre à jour automatiquement cette table suite à chaque opération de MAJ (insertion, suppression, modification) sur la table des professeurs.
CREATE TRIGGER TRG_PROFESSEURS_SPECIALITE
ON PROFESSEURS
FOR INSERT, UPDATE, DELETE
AS
    IF UPDATE(SPECIALITE)
    BEGIN
        IF EXISTS(SELECT * FROM inserted)
        BEGIN
            UPDATE PROF_SPECIALITE
            SET NB_PROFESSEURS = NB_PROFESSEURS + 1
            WHERE SPECIALITE = inserted.SPECIALITE
        END
        IF EXISTS(SELECT * FROM deleted)
        BEGIN
            UPDATE PROF_SPECIALITE
            SET NB_PROFESSEURS = NB_PROFESSEURS - 1
            WHERE SPECIALITE = deleted.SPECIALITE
        END
    END
--3.Mise à jour en cascade : Créez un trigger qui met à jour la table CHARGE lorsqu’on supprime un professeur dans la table PROFESSEUR ou que l’on change son numéro.
CREATE TRIGGER TRG_PROFESSEURS_CHARGE
ON PROFESSEURS
FOR DELETE, UPDATE
AS
    IF UPDATE(NUM_PROF)
    BEGIN
        IF EXISTS(SELECT * FROM deleted)
        BEGIN
            UPDATE CHARGE
            SET NUM_PROF = inserted.NUM_PROF
            WHERE NUM_PROF = deleted.NUM_PROF
        END
    END
    ELSE
    BEGIN
        IF EXISTS(SELECT * FROM deleted)
        BEGIN
            DELETE FROM CHARGE
            WHERE NUM_PROF = deleted.NUM_PROF
        END
    END
--III.Sécurite: enregistrement des acces
--1.1 Créez la table suivante :
-- CREATE TABLE AUDIT_RESULTATS (
--     UTILISATEUR VARCHAR(50),
--     DATE_MAJ DATETIME,
--     DESC_MAJ VARCHAR(20),
--     NUM_ELEVE INT NOT NULL,
--     NUM_COURS INT NOT NULL,
--     POINTS INT
-- );
-- Créez un trigger qui met à jours la table audit_resultats à chaque modification de la table RÉSULTAT. Il faut donner l’utilisateur qui a fait la modification (USER), la date de la modification et une description de la modification (‘INSERT’, ‘DELETE’, ‘NOUVEAU’, ‘ANCIEN’). Par exemple pour une insertion :
CREATE TRIGGER TRG_RESULTATS_AUDIT
ON RESULTATS
FOR INSERT, UPDATE, DELETE
AS
    DECLARE @user VARCHAR(50)
    SET @user = USER_NAME()
    IF EXISTS(SELECT * FROM inserted)
    BEGIN
        INSERT INTO AUDIT_RESULTATS
        VALUES (@user, GETDATE(), 'INSERT', inserted.NUM_ELEVE, inserted.NUM_COURS, inserted.POINTS)
    END
    IF EXISTS(SELECT * FROM deleted)
    BEGIN
        INSERT INTO AUDIT_RESULTATS
        VALUES (@user, GETDATE(), 'DELETE', deleted.NUM_ELEVE, deleted.NUM_COURS, deleted.POINTS)
    END
    IF EXISTS(SELECT * FROM inserted) AND EXISTS(SELECT * FROM deleted)
    BEGIN
        INSERT INTO AUDIT_RESULTATS
        VALUES (@user, GETDATE(), 'UPDATE', inserted.NUM_ELEVE, inserted.NUM_COURS, inserted.POINTS)
    END

-- INSERT INTO audit_resultats
-- VALUES (USER_NAME(), GETDATE(), 'INSERT', INSERTED.NUM_ELEVE, INSERTED.NUM_COURS, INSERTED.POINTS);
-- Confidentialité: On souhaite que seul l’utilisateur ‘GrandChef’ puisse augmenter les salaires des professeurs de plus de 20%. Le trigger doit retourner une erreur (No -20002) et le message ‘Modification interdite’ si la condition n’est pas respectée.
-- Fonctions et procédures
-- Créez une fonction fn_moyenne calculant la moyenne d’un étudiant passé en paramètre.
CREATE FUNCTION fn_moyenne (@num_eleve INT)
RETURNS FLOAT
AS
BEGIN
    DECLARE @moy FLOAT
    SELECT @moy = AVG(POINTS)
    FROM RESULTATS
    WHERE NUM_ELEVE = @num_eleve
    RETURN @moy
END
-- Créez une procédure pr_resultat permettant d’afficher la moyenne de chaque élève avec la mention adéquate : échec, passable, assez bien, bien, très bien.
CREATE PROCEDURE pr_resultat
AS
    DECLARE @num_eleve INT
    DECLARE @moy FLOAT
    DECLARE @mention VARCHAR(20)
    DECLARE cur CURSOR FOR
        SELECT NUM_ELEVE
        FROM RESULTATS
        GROUP BY NUM_ELEVE
    OPEN cur
    FETCH NEXT FROM cur INTO @num_eleve
    WHILE @@FETCH_STATUS = 0
    BEGIN
        SELECT @moy = fn_moyenne(@num_eleve)
        IF @moy < 8
            SET @mention = 'Echec'
        ELSE IF @moy < 10
            SET @mention = 'Passable'
        ELSE IF @moy < 12
            SET @mention = 'Assez bien'
        ELSE IF @moy < 14
            SET @mention = 'Bien'
        ELSE
            SET @mention = 'Très bien'
        PRINT 'L''élève ' + CAST(@num_eleve AS VARCHAR(10)) + ' a une moyenne de ' + CAST(@moy AS VARCHAR(10)) + ' et a donc la mention ' + @mention
        FETCH NEXT FROM cur INTO @num_eleve
    END
    CLOSE cur
    DEALLOCATE cur