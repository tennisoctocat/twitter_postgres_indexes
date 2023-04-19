/* 01.sql */
create index idxgin1 on tweets_jsonb using gin((data->'entities'));
create index idxgin2 on tweets_jsonb using gin((data->'extended_tweet'->'entities'));

/* 02.sql */


