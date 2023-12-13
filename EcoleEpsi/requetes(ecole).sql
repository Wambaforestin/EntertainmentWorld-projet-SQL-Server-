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