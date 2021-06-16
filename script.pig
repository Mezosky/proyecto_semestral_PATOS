
-- ssh -p 220 uhadoop@cm.dcc.uchile.cl
-- PW: HADcc5212$oop

raw = LOAD 'hdfs://cm:9000/uhadoop2021/g34/steam_reviews.csv' USING PigStorage(',') AS (row_id, app_id, app_name, review_id, language, review, timestamp_created, timestamp_updated, recommended, votes_helpful, votes_funny, weighted_vote_score, comment_count, steam_purchase, received_for_free, written_during_early_access, author_steamid, author_num_games_owned, author_num_reviews, author_playtime_forever, author_playtime_last_two_weeks, author_playtime_at_review, author_last_played);
english_reviews = FILTER raw BY language == 'english';
DUMP english_reviews;
