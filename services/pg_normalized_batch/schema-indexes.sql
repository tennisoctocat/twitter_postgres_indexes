/* 01.sql */
CREATE INDEX ON tweet_tags(tag, id_tweets);

/* 03.sql */
CREATE INDEX ON tweets(id_tweets, lang);

/* 05.sql */
CREATE INDEX ON tweets USING gin(to_tsvector('english', text));
CREATE INDEX ON tweet_tags(id_tweets, tag);
