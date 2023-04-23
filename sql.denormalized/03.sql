/*
 * Calculates the languages that use the hashtag #coronavirus
 */
SELECT data->>'lang' AS lang, count(distinct data->>'id')
FROM tweets_jsonb
WHERE data->'entities'->'hashtags' @> '[{"text": "coronavirus"}]' or data->'extended_tweet'->'entities'->'hashtags' @> '[{"text": "coronavirus"}]'
GROUP BY data->>'lang'
ORDER BY count DESC, data->>'lang';
