/*
 * Count the number of English tweets containing the word "coronavirus"
 */
/* SELECT
    count(*)
FROM tweets
WHERE to_tsvector('english',text)@@to_tsquery('english','coronavirus')
  AND lang='en'
;*/
/*
SELECT count(*)
FROM tweets_jsonb
WHERE (to_tsvector('english', data->'extended_tweet'->>'full_text')@@to_tsquery('english', 'coronavirus')
    OR to_tsvector('english', data->>'text')@@to_tsquery('english', 'coronavirus'))
AND (data->>'lang')@@'en';
SELECT count(*)
FROM tweets_jsonb
WHERE
     data->'lang' ? 'en' AND
(to_tsvector('english', data->'extended_tweet'->>'full_text')@@to_tsquery('english', 'coronavirus')
    OR (to_tsvector('english', data->>'text')@@to_tsquery('english', 'coronavirus') AND data->'extended_tweet'->>'full_text' IS NULL ));
*/

SELECT count(*)
FROM tweets_jsonb
WHERE
     data->'lang' ? 'en' AND
     to_tsvector('english', COALESCE(data->'extended_tweet'->>'full_text', data->>'text'))@@to_tsquery('english', 'coronavirus');

/*
SELECT count(*)
FROM tweets_jsonb
WHERE (to_tsvector('english', data->'extended_tweet'->>'full_text')@@to_tsquery('english', 'coronavirus')
    OR (data->'extended_tweet'->>'full_text' IS NULL AND to_tsvector('english', data->>'text')@@to_tsquery('english', 'coronavirus')))
    AND data->'lang' ? 'en';*/
/*
SELECT *
FROM tweets_jsonb
WHERE (to_tsvector('english', data->'extended_tweet'->>'full_text')@@to_tsquery('english', 'coronavirus')
    OR to_tsvector('english', data->>'text')@@to_tsquery('english', 'coronavirus')) AND data->'lang' ? 'en';
*/

/*CREATE INDEX ON tweets USING gin(to_tsvector('english', text));
to_tsvector('english', COALESCE(data->'extended_tweet'->>'full_text',data->>'text'))
*/
/* Current issue:  returns 6058 instead of 6056, i don't know why! If it was greater then fix is to tell gin to return more heap tuples. set gin_fuzzy_search_limit = 1000; */
