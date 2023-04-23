/* 01.sql */
create index tagidx on tweets_jsonb using gin((data->'entities'));
create index tagidx2 on tweets_jsonb using gin((data->'extended_tweet'->'entities'));

/* 04.sql */
create index txtidx on tweets_jsonb using gin(to_tsvector('english', data->'extended_tweet'->>'full_text'));
create index txtidx2 on tweets_jsonb using gin(to_tsvector('english', data->>'text'));
CREATE INDEX tweets_jsonb_expr_idx2 ON public.tweets_jsonb USING gin ((data -> 'lang'::text));

/* 01.sql new */
create index tagidx3 on tweets_jsonb using gin((data->'entities'->'hashtags'));

create index tagidx4 on tweets_jsonb using gin((data->'extended_tweet'->'entities'->'hashtags'));

