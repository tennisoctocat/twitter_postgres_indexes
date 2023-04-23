/* 04.sql new? */
create index txtidx4 on tweets_jsonb using gin(to_tsvector('english', COALESCE(data->'extended_tweet'->>'full_text', data->>'text')));
CREATE INDEX tweets_jsonb_expr_idx2 ON public.tweets_jsonb USING gin ((data -> 'lang'::text));

/* 01.sql new */
create index tagidx3 on tweets_jsonb using gin((data->'entities'->'hashtags'));
create index tagidx4 on tweets_jsonb using gin((data->'extended_tweet'->'entities'->'hashtags'));

