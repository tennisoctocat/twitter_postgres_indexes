/*
 * Calculates the hashtags that are commonly used for English tweets containing the word "coronavirus"
 */
/*SELECT
    tag,
    count(*) AS count
FROM (
    SELECT DISTINCT
        id_tweets,
        tag
    FROM tweets
    JOIN tweet_tags USING (id_tweets)
    WHERE to_tsvector('english',text)@@to_tsquery('english','coronavirus')
      AND lang='en'
) t
GROUP BY tag
ORDER BY count DESC,tag
LIMIT 1000
;*/

SELECT '#' || (jsonb_array_elements(
                COALESCE(data->'entities'->'hashtags','[]') ||
                COALESCE(data->'extended_tweet'->'entities'->'hashtags','[]')
            )->>'text'::TEXT) AS tag, count(DISTINCT data->>'id')
FROM tweets_jsonb
WHERE (to_tsvector('english', data->'extended_tweet'->>'full_text')@@to_tsquery('english', 'coronavirus')
    OR to_tsvector('english', data->>'text')@@to_tsquery('english', 'coronavirus'))
AND data->'lang' ? 'en'
GROUP BY tag
ORDER BY count DESC, tag
LIMIT 1000;
