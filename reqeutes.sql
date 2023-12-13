--les requestes sur les interrogations
-- 1.Quel est la liste des séries de la base ?
SELECT
    titre
FROM
    series;

-- 2.Combien de pays différents ont créé des séries dans notre base ?
SELECT
    COUNT(DISTINCT pays) AS 'Nombre de pays'
FROM
    series;

-- 3.Quels sont les titres des séries originaires du Japon, triés par titre ?
SELECT
    titre
FROM
    series
WHERE
    pays = 'Japon';

--4.Combien y a-t-il de séries originaires de chaque pays ?
SELECT
    pays,
    COUNT(*) as 'nombre de pays'
FROM
    dbo.series
GROUP BY
    pays;

--5.Combien de séries ont été créés entre 2001 et 2015?
SELECT
    COUNT(*) as 'nombre de series'
FROM
    dbo.series
WHERE
    date_de_creation BETWEEN '2001-01-01'
    AND '2015-12-31';

--6.Quelles séries sont à la fois du genre « Comédie » et « Science-Fiction » ?
SELECT
    titre
FROM
    dbo.series
    JOIN dbo.series_genres ON dbo.series.id_serie = dbo.series_genres.id_serie
WHERE
    id_genre = 3002
    AND id_genre = 3009;

--7.Quels sont les séries produites par « Spielberg », affichés par date décroissantes?
SELECT
    titre
FROM
    dbo.series
WHERE
    id_serie IN (
        SELECT
            id_serie
        FROM
            dbo.createur_producteur_series
        WHERE
            id_create IN (
                SELECT
                    id_prod
                FROM
                    dbo.producteurs
                WHERE
                    nom = 'Spielberg'
            )
    )
ORDER BY
    date_de_creation DESC;

--8.Afficher les séries Américaines par ordre de nombre de saisons croissant?
SELECT
    ser.titre,
    COUNT(sai.id_saison) AS 'Nombre de saisons'
FROM
    series ser
    JOIN saisons sai ON ser.id_serie = sai.id_serie
WHERE
    ser.pays = 'Etats-Unis'
GROUP BY
    ser.titre
ORDER BY
    COUNT(sai.id_saison) ASC;

--9.Quelle série a le plus d’épisodes ?
SELECT
    ser.titre,
    COUNT(epi.id_episode) AS 'Nombre d episodes'
FROM
    series ser
    JOIN saisons sai ON ser.id_serie = sai.id_serie
    JOIN episodes epi ON sai.id_saison = epi.id_saison
GROUP BY
    ser.titre
ORDER BY
    COUNT(epi.id_episode) DESC;

-- 10.La série « Big Bang Theory » est-elle plus appréciée des hommes ou des femmes en utilisant une jointure?
SELECT
    ser.titre,
    utilisateurs.sexe,
    COUNT(notes.evaluation) AS 'nombre des notes'
FROM
    series ser
    JOIN notes ON ser.id_serie = notes.id_serie
    JOIN utilisateurs ON notes.id_utilisateur = utilisateurs.id_utilisateur
WHERE
    ser.titre = 'Big Bang Theory'
GROUP BY
    ser.titre,
    utilisateurs.sexe
ORDER BY
    COUNT(notes.id_utilisateur) DESC;

--11.Affichez les séries qui ont une note moyenne inférieure à 5, classé par note.
SELECT
    ser.titre,
    AVG(notes.evaluation) AS 'note moyenne'
FROM
    series ser
    JOIN notes ON ser.id_serie = notes.id_serie
GROUP BY
    ser.titre
HAVING
    AVG(notes.evaluation) < 5
ORDER BY
    AVG(notes.evaluation) DESC;

--12.Pour chaque série, afficher le commentaire correspondant à la meilleure note.
SELECT
    ser.titre,
    notes.commentaire,
    MAX(notes.evaluation) AS 'meilleure note'
FROM
    series ser
    JOIN notes ON ser.id_serie = notes.id_serie
GROUP BY
    ser.titre,
    notes.commentaire
ORDER BY
    MAX(notes.evaluation) DESC;

--13.Affichez les séries qui ont une note moyenne sur leurs épisodes supérieure à 8.
SELECT
    ser.titre,
    AVG(notes.evaluation) AS 'note moyenne'
FROM
    series ser
    JOIN notes ON ser.id_serie = notes.id_serie
GROUP BY
    ser.titre
HAVING
    AVG(notes.evaluation) > 8
ORDER BY
    AVG(notes.evaluation) DESC;

--14.Afficher le nombre moyen d’épisodes des séries avec l’acteur « Bryan Cranston ».
SELECT
    AVG(CAST(epi.id_episode AS FLOAT)) AS 'nombre moyen d episodes'
FROM
    series ser
    JOIN saisons sai ON ser.id_serie = sai.id_serie
    JOIN episodes epi ON sai.id_saison = epi.id_saison
    JOIN acteurs_episodes act_epi ON epi.id_episode = act_epi.id_episode
    JOIN acteurs act ON act_epi.id_acteur = act.id_acteur
WHERE
    act.nom_act = 'Cranston'
    AND act.prenom_act = 'Bryan';

--15.Quels acteurs ont réalisé des épisodes de série utilise une requête simple?
SELECT
    act.nom_act,
    act.prenom_act
FROM
    acteurs act
    JOIN acteurs_episodes act_epi ON act.id_acteur = act_epi.id_acteur
    JOIN episodes epi ON act_epi.id_episode = epi.id_episode
WHERE
    epi.id_realisateur = act.id_acteur; 
--16.Quels acteurs ont joué ensemble dans plus de 80% des épisodes d’une série ?
SELECT
    act.nom_act,
    act.prenom_act,
    COUNT(epi.id_episode) AS 'nombre d episodes'
FROM
    acteurs act
    JOIN acteurs_episodes act_epi ON act.id_acteur = act_epi.id_acteur
    JOIN episodes epi ON act_epi.id_episode = epi.id_episode
GROUP BY
    act.nom_act,
    act.prenom_act
HAVING
    COUNT(epi.id_episode) > 80
ORDER BY
    COUNT(epi.id_episode) DESC;

--17.Quels acteurs ont joué dans tous les épisodes de la série « Breaking Bad » ?
SELECT
    act.nom_act,
    act.prenom_act,
    COUNT(epi.id_episode) AS 'nombre d episodes'
FROM
    acteurs act
    JOIN acteurs_episodes act_epi ON act.id_acteur = act_epi.id_acteur
    JOIN episodes epi ON act_epi.id_episode = epi.id_episode
    JOIN saisons sai ON epi.id_saison = sai.id_saison
    JOIN series ser ON sai.id_serie = ser.id_serie
WHERE
    ser.titre = 'Breaking Bad'  
GROUP BY
    act.nom_act,
    act.prenom_act
HAVING
    COUNT(epi.id_episode) = (
        SELECT
            COUNT(*)
        FROM
            dbo.episodes
            JOIN dbo.saisons ON dbo.episodes.id_saison = dbo.saisons.id_saison
            JOIN dbo.series ON dbo.saisons.id_serie = dbo.series.id_serie
        WHERE
            dbo.series.titre = 'Breaking Bad'
    );
    
--18.Quels utilisateurs ont donné une note à chaque série de la base
SELECT
    utilisateurs.nom,
    utilisateurs.prenom,
    COUNT(notes.id_serie) AS 'nombre de series'
FROM
    utilisateurs
    JOIN notes ON utilisateurs.id_utilisateur = notes.id_utilisateur
GROUP BY
    utilisateurs.nom,
    utilisateurs.prenom
HAVING
    COUNT(notes.id_serie) = (
        SELECT
            COUNT(*)
        FROM
            dbo.series
    )
ORDER BY
    COUNT(notes.id_serie) DESC;

--19.Pour chaque message, affichez son niveau et si possible le titre de la série en question.
SELECT
    questions.titre_question,
    questions.question,
    questions.date_question,
    categories.nom_cat,
    series.titre
FROM
    questions
    JOIN categories ON questions.id_categorie = categories.id_categorie
    JOIN series ON questions.id_serie = series.id_serie;

--20.Les messages initiés par « Azrod95 » génèrent combien de réponses en moyenne ?
SELECT
    questions.question,
    COUNT(reponses.id_question) AS 'nombre de reponses'
FROM
    questions
    JOIN reponses ON questions.id_question = reponses.id_question
    JOIN utilisateurs ON questions.id_utilisateur = utilisateurs.id_utilisateur
WHERE
    utilisateurs.pseudo = 'Azrod95'
GROUP BY
    questions.question;