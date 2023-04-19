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

select count(distinct data->>'id') FROM tweets_jsonb
WHERE data->'entities' @> '{"hashtags": [{"text": "coronavirus"}]}' or data->'extended_tweet'->'entities' @> '{"hashtags": [{"text": "coronavirus"}]}';
