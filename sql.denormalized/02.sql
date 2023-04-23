/*
 * Calculates the hashtags that are commonly used with the hashtag #coronavirus
 */
select '#' || (jsonb_array_elements(
                COALESCE(data->'entities'->'hashtags','[]') ||
                COALESCE(data->'extended_tweet'->'entities'->'hashtags','[]')
            )->>'text'::TEXT) AS tag, count(distinct data->>'id')
        FROM tweets_jsonb 
        WHERE data->'entities'->'hashtags' @> '[{"text": "coronavirus"}]' or data->'extended_tweet'->'entities'->'hashtags' @> '[{"text": "coronavirus"}]'
        GROUP BY tag 
        ORDER BY count DESC, tag 
        LIMIT 1000;
