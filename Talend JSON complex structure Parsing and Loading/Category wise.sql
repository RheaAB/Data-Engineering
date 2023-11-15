
WITH CTE_movie AS (
    SELECT t.name,
    w.SK_Writers,
    w.Writers,
    a.actors,
    c.CategorieCSV 
    FROM movie t
    LEFT JOIN json.movie_actor a
    ON t.name = a.title
    LEFT JOIN movie_writer w
    ON t.name = w.title
    LEFT JOIN categories c
    ON t.name = c.name
)

SELECT name,
CategorieCSV, 
COUNT(DISTINCT SK_Writers) AS no_of_writer, 
COUNT(DISTINCT actors) AS no_of_actor

FROM CTE_movie
GROUP BY name,
CategorieCSV
HAVING no_of_writer > 4 AND no_of_actor > 3; 