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
*/
SELECT count(*)
FROM tweets_jsonb
WHERE (to_tsvector('english', data->'extended_tweet'->>'full_text')@@to_tsquery('english', 'coronavirus')
    OR to_tsvector('english', data->>'text')@@to_tsquery('english', 'coronavirus'))
AND data->'lang' ? 'en';

/*CREATE INDEX ON tweets USING gin(to_tsvector('english', text));
to_tsvector('english', COALESCE(data->'extended_tweet'->>'full_text',data->>'text'))
*/

