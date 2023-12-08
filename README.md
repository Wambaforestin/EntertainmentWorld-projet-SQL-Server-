# Projet Transversal : Conception et Administration d'une Base de données sous SQL Server

Contexte : À partir des connaissances que vous avez acquis lors des différents cours en lien avec SQL et SQL Server, vous allez pouvoir mettre en application vos acquis à travers de ce projet.

Rendu : 
* Tout les scripts au format .SQL
* Modélisation de vos tables : 
    * Modèle conceptuel de données (MCD)
    * Modèle logique de données (MLD)
    * Modèle physique de données (MPD)
* Rapport avec les résultats des questions avec en plus le plan du partionnement (vertical / horizontal) de la base de données
* Transactions, Fonctions, Procédures stockés

Nomenclature du rendu : 
:email: Par mail : noobzik@pm.me
:pencil: Le sujet : **[EPSI Paris : SN2 G2 : PT-BDD] Noms des groupes**
:calendar: Date du rendu : 13/12 à 6h00 du matin
Envoyez moi un lien vers votre github / bitbucket ou gitlab et le fichier zippé.

Information confirmé  : 
* Oral de 15 minutes pour chaque groupe (10 minutes de présentation + 5 minutes de question/réponses)
* Démonstration live des requêtes


## Sujet partie 1 : Site internet des séries/filmes télévisées

On souhaite créer un site internet donnant des informations détaillés sur les séries télévisées.

Chaque série est définie par un titre et une année. On connait aussi son ou ses créateurs, ses producteurs (qui sont parfois aussi créateurs), son pays d’origine, sa date de création et la liste de ses genres (drame, comédie, etc…). Les créateurs et producteurs sont connus par leur nom et prénom. 

Chaque série est composée d’un ensemble d’épisodes, qui sont connus par leur titre.  Chaque épisode à une durée, une date de première diffusion, un ou des réalisateurs, un ensemble d’acteurs, ainsi qu’un résumé. Chaque épisode est inclus dans une saison, définie par un numéro. Les acteurs sont définis par leur nom et prénom.

Notre site doit aussi gérer un ensemble d’utilisateurs, définis par leur pseudo. On connait leur date d’inscription au site, ainsi que leur âge et leur sexe. Chaque utilisateur peut donner une note (sur 10) à une série ou un épisode. Il peut aussi laisser un commentaire expliquant sa note. 
On garde la date à laquelle la note a été donnée.

Pour finir, on souhaite que les que les utilisateurs puissent converser entre eux dans un forum de discussion. Chaque message est envoyé par un utilisateur à une date précise, il contient un texte et peut répondre à un autre message. Chaque message initial (qui ne réponds pas à un autre message) possède un titre et peut être associée à une série (mais ce n’est pas obligatoire)

### 0. Les utilisateurs
 
* Créez des roles suivants : 
    * Administrateur
    * Data Engineer (Pouvant créer et inserver des données, créer des bases de données, et les supprimer, créer et supprimer les vues matérialisées)
    * Data Analyst (Pouvant récupérer des données et peut créer des vues matérialisés)
    * Data Scientist (Pouvant récupérer et insérer des données, peut créer des bases de données, peut créer et supprimer des vues matérialisées)
    * Stagiaire avec une limite de 6 mois d'accès
    * Métier (Pouvant uniquement consulter les vues)
* Créez au moins deux utilisateurs pour chaque role définit ci-dessus

### 1. La conception

* Proposez un modèle entité association pour modéliser ce problème. Pour rappel, cela correspond à un Modèle de donnée conceptuelle (MCD). 
* Proposez un modèle entité relation (Schema) pour modéliser ce problème. Pour rappel, cela correspond à un modèle de donnée logique (MLD).
* Proposez un modèle entité relation (Schema) pour modéliser ce problème. Pour rappel, cela correspond à un modèle de donnée physique (MPD).
* Faites en sorte qu'elle respecte au moins la forme normale 3 (3FN) pour votre base de données

### 2. La création

* Créez un script creation.sql qui crée les tables du modèle relationnel.
* Ajoutez aux tables toutes les contraintes qui vous semblent pertinentes pour une bonne gestion de cette base.
* Expliquez et justifiez vos choix.

### 4. Insertion

1. Créez le script `insertion.sql` afin d'insérer suffisamment de données dans les tables pour que les requêtes de la section 5 ne renvoient pas de réponses vides.
2. Essayez de remplir les tables avec des informations réelles (ou au moins cohérentes)
3. Mettez en oeuvre la notion d'une vue matérialisées tel que vu en cours de conception et exploitation d'une base de données et justifiez les vues mise en oeuvre.
 
### 5. Interrogation

Répondez au question suivantes à l'aide SQL Server, dans `requetes.sql`

1. Quel est la liste des séries de la base ?
2. Combien de pays différents ont créé des séries dans notre base ?
3. Quels sont les titres des séries originaires du Japon, triés par titre ?
4. Combien y a-t-il de séries originaires de chaque pays ?
5. Combien de séries ont été créés entre 2001 et 2015?
6. Quelles séries sont à la fois du genre « Comédie » et « Science-Fiction » ?
7. Quels sont les séries produites par « Spielberg », affichés par date décroissantes ?
8. Afficher les séries Américaines par ordre de nombre de saisons croissant.
9. Quelle série a le plus d’épisodes ?
10. La série « Big Bang Theory » est-elle plus appréciée des hommes ou des femmes ?
11. Affichez les séries qui ont une note moyenne inférieure à 5, classé par note.
12. Pour chaque série, afficher le commentaire correspondant à la meilleure note.
13. Affichez les séries qui ont une note moyenne sur leurs épisodes supérieure à 8.
14. Afficher le nombre moyen d’épisodes des séries avec l’acteur « Bryan Cranston ».
15. Quels acteurs ont réalisé des épisodes de série ?
16. Quels acteurs ont joué ensemble dans plus de 80% des épisodes d’une série ?
17. Quels acteurs ont joué dans tous les épisodes de la série « Breaking Bad » ?
18. Quels utilisateurs ont donné une note à chaque série de la base ?
19. Pour chaque message, affichez son niveau et si possible le titre de la série en question.
20. Les messages initiés par « Azrod95 » génèrent combien de réponses en moyenne ?

## Sujet partie 2 : Une école !

### Contraintes

Lien vers le fichier SQL en question : 

Context : Vous avez en votre possession une base de donnée qui simule le fonctionnement d'une école lambda. Prenez connaissance ce cette base de donnée et répondez aux questions suivantes. 

1. Essayez de modifier les tables pour ajouter les contraintes suivantes en SQL : 

    * La note d'un étudiant doit être comprise entre 0 et 20.
    * Le sexe d'un étudiant doit être dans la liste: 'm', 'M', 'f', 'F' ou Null.
    * Contrainte horizontale : Le salaire de base d’un professeur doit être inférieur au salaire actuel.
    * Contrainte verticale : Le salaire d'un professeur ne doit pas dépasser le double de la moyenne des salaires des enseignants de la même spécialité.


2. Que constatez-vous ?


### Triggers

1. Créez un trigger permettant de vérifier la contrainte : « Le salaire d'un Professeur ne peut pas diminuer ».
2. Gestion automatique de la redondance
    * Créez la table suivante : 
    ```sql= 
    CREATE TABLE PROF_SPECIALITE (
        SPECIALITE VARCHAR(20), 
        NB_PROFESSEURS NUMBER);
    ```
    * Créez un trigger permettant de remplir et mettre à jour automatiquement cette table suite à chaque opération de MAJ (insertion, suppression, modification) sur la table des professeurs.
    * Testez le trigger sur des exemples de mise à jour.
3. Mise à jour en cascade : Créez un trigger qui met à jour la table CHARGE lorsqu’on supprime un professeur dans la table PROFESSEUR ou que l’on change son numéro.


### Sécurité : enregistrement des accès
* Créez la table audit_resultats :
```sql=
CREATE TABLE AUDIT_RESULTATS (
    UTILISATEUR VARCHAR(50),
    DATE_MAJ DATETIME,
    DESC_MAJ VARCHAR(20),
    NUM_ELEVE INT NOT NULL,
    NUM_COURS INT NOT NULL,
    POINTS INT
);

```

* Créez un trigger qui met à jours la table audit_resultats à chaque modification de la table `RÉSULTAT`. Il faut donner l’utilisateur qui a fait la modification `(USER)`, la date de la modification et une description de la modification `(‘INSERT’, ‘DELETE’, ‘NOUVEAU’, ‘ANCIEN’)`. Par exemple pour une insertion :
```sql=
INSERT INTO audit_resultats
VALUES (USER_NAME(), GETDATE(), 'INSERT', INSERTED.NUM_ELEVE, INSERTED.NUM_COURS, INSERTED.POINTS);
```

5. Confidentialité: On souhaite que seul l'utilisateur 'GrandChef' puisse augmenter les salaires des professeurs de plus de 20%. Le trigger doit retourner une erreur (No -20002) et le message 'Modification interdite' si la condition n’est pas respectée.

#### Fonctions et procédures
* Créez une fonction `fn_moyenne` calculant la moyenne d’un étudiant passé en paramètre.
* Créez une procédure `pr_resultat` permettant d’afficher la moyenne de chaque élève avec la mention adéquate : échec, passable, assez bien, bien, très bien.