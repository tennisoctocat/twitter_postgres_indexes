/* 01.sql */
CREATE INDEX ON tweet_tags(tag, id_tweets);

/* 03.sql */
/* maybe shouldn't have lang, idk */
/* CREATE INDEX ON tweet_tags(id_tweets, tag); 
 */
CREATE INDEX ON tweets(id_tweets, lang);

/* 04.sql */
/* CREATE INDEX ON tweets USING rum(to_tsvector('english', text), RUM_TSVECTOR(ADDON_OPS, lang) WITH(ATTACH='lang', TO="to_tsvector('english', text)");
*/
/* Commenting out because this is covered by 05.sql's indices */

/* 05.sql */
/* Idea: Use this along with another with clause for the id_tweets? and also include the tag somewhere as well? at the very end??) Also we would need one for tweet_tags as well */
/*CREATE INDEX ON tweets USING rum(to_tsvector('english', text), RUM_TSVECTOR(ADDON_OPS, lang) WITH(ATTACH='lang', TO="to_tsvector('english', text)"), RUM_TSVECTOR(ADDON_OPS, id_tweets) WITH(ATTACH='id_tweets', TO="to_tsvector('english', text)"));*/
CREATE INDEX ON tweets USING gin(to_tsvector('english', text));
CREATE INDEX ON tweet_tags(id_tweets, tag);
