/*
 * Calculates the languages that use the hashtag #coronavirus
 */
/*SELECT
    lang,
    count(DISTINCT id_tweets) as count
FROM tweet_tags
JOIN tweets USING (id_tweets)
WHERE tag='#coronavirus'
GROUP BY lang
ORDER BY count DESC,lang;*/

SELECT data->>'lang' AS lang, count(distinct data->>'id')
FROM tweets_jsonb
WHERE data->'entities' @> '{"hashtags": [{"text": "coronavirus"}]}' or data->'extended_tweet'->'entities' @> '{"hashtags": [{"text": "coronavirus"}]}'
GROUP BY data->>'lang'
ORDER BY count DESC, data->>'lang';
