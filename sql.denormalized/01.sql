/*
 * Count the number of tweets that use #coronavirus
 */
/* SELECT count(distinct id_tweets)
FROM tweet_tags
WHERE tag='#coronavirus';*/
/*
SELECT count(distinct data->>'id')
FROM tweets_jsonb
WHERE to_tsvector('english', data) @> to_tsquery('english', '#coronavirus') */
/*
SELECT count(DISTINCT(data->>'id')) 
FROM tweets_jsonb
WHERE jsonb_array_elements(
    COALESCE(data->'entities'->'hashtags','[]') ||
    COALESCE(data->'extended_tweet'->'entities'->'hashtags','[]')
)->>'text'::TEXT @> 'coronavirus'::TEXT;*/ 
/* Most likely issue with this is that postgres just thinks that the filter will be faster. So we should change the query (or index)? so that postgres will think that the index scan is faster. A hacky fix would be to do set set enable_seqscan=off; inside this file but that's probably not the best. */
/* select count(distinct data->>'id') FROM tweets_jsonb
WHERE data->'entities' @> '{"hashtags": [{"text": "coronavirus"}]}' or data->'extended_tweet'->'entities' @> '{"hashtags": [{"text": "coronavirus"}]}';
*/
select count(distinct data->>'id') FROM tweets_jsonb
WHERE data->'entities'->'hashtags' @> '[{"text": "coronavirus"}]' or data->'extended_tweet'->'entities'->'hashtags' @> '[{"text": "coronavirus"}]';
