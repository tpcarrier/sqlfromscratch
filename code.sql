-- Quiz Funnel 1.1
SELECT *
FROM survey
LIMIT 10;

-- Quiz Funnel 1.2
SELECT question as "Question"
	COUNT(DISTINCT user_id) as "Count"
FROM survey
GROUP BY 1;

-- Quiz Funnel 1.3
-- https://docs.google.com/spreadsheets/d/1-L0hjjM1nLzufZaPDSwV5woa4BAFeB2TEusqx-SIy1o/edit#gid=0

-- Home Try-On Funnel 2.1
SELECT *
FROM quiz
LIMIT 5;

SELECT *
FROM home_try_on
LIMIT 5;

SELECT *
FROM purchase
LIMIT 5;


-- Home Try-On Funnel 2.2
SELECT DISTINCT q.user_id,
   CASE WHEN h.user_ID IS NOT NULL
    THEN 'True' ELSE 'False'
 END AS 'is_home_try_on',
   h.number_of_pairs,
  CASE WHEN p.user_id IS NOT NULL
    THEN 'True' ELSE 'False'
 END AS 'is_purchase'
FROM quiz q
LEFT JOIN home_try_on h
   ON q.user_id = h.user_id
LEFT JOIN purchase p
   ON p.user_id = q.user_id
LIMIT 5;

-- Home Try-On Funnel 2.3

--FUNNEL
WITH funnel AS
(SELECT q.user_id,
    h.user_id IS NOT NULL AS 'is_home_try_on',
    h.number_of_pairs,
    p.user_id IS NOT NULL AS 'is_purchase'
FROM quiz q
LEFT JOIN home_try_on h
    ON q.user_id = h.user_id
LEFT JOIN purchase p
    ON p.user_id = q.user_id)
SELECT COUNT(*) AS 'Total Leads',
SUM(is_home_try_on) AS 'Tried On',
SUM(is_purchase) AS 'Purchased',
1.0 * SUM(is_home_try_on) / COUNT(user_id) AS 'Percent Tried On',
   1.0 * SUM(is_purchase) / SUM(is_home_try_on) AS 'Percent Purchased'
FROM funnel;

--The most common results of the style quiz.
SELECT style AS 'Style', COUNT(style) AS 'COUNT'
FROM quiz
GROUP BY style
ORDER BY 2 DESC;













