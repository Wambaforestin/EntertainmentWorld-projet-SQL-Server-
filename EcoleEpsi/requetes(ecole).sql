-- =========================================
-- Reponse des interrogations
-- =========================================

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