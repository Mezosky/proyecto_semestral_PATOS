
raw = LOAD 'hdfs://cm:9000/uhadoop2021/g34/steam.tsv' USING PigStorage('\t') AS (row_id, 
app_id, app_name, review_id, language, timestamp_created, timestamp_updated, recommended, 
votes_helpful, votes_funny, weighted_vote_score, comment_count, steam_purchase, received_for_free, 
written_during_early_access, steamid, num_games_owned, num_reviews, playtime_forever, playtime_last_two_weeks, 
playtime_at_review, last_played);

-- Obtenemos el total de reviews por juegos del dataset
group_total_reviews = GROUP raw BY (app_name);
count_total_reviews = FOREACH group_total_reviews GENERATE COUNT(raw) as conteo, $0 as game_name;

-- Transformamos el Timestamp a fecha en el formato yyyy-MM para poder agrupar los reviews por meses
result = FOREACH raw GENERATE $2 as name, ToString(ToDate((long) $5*1000), 'yyyy-MM') as date, 
$7 as recommended;

-- Obtenemos el total de reviews realizadas por mes
result_grouped_total_month = GROUP result BY (name, date);
result_count_total_month = FOREACH result_grouped_total_month GENERATE COUNT(result) as conteo, $0 as nombre;

-- Se obtiene el promedio de reviews realizadas en todos los meses disponibles
clean_average = FOREACH result_count_total_month GENERATE FLATTEN($1) as (game_name, date), conteo;
group_average = GROUP clean_average BY (game_name);
average_by_group = FOREACH group_average GENERATE AVG(clean_average.conteo), $0 as game_name;

-- Las siguientes lineas obtiene el numero de veces que no recomiendan los juegos
result_filtered_not = FILTER result BY recommended == 'False';
result_grouped_not = GROUP result_filtered_not BY (name, date);
result_count_not = FOREACH result_grouped_not GENERATE COUNT(result_filtered_not) as conteo, $0 as nombre;

-- Se realiza un Join con los datos procesados, las llaves son (nombre de juego, fecha)
result_joined = JOIN result_count_total_month BY $1, result_count_not by $1;

-- Se ajusta la salida para que esta sea mas ordenada
result_output = FOREACH result_joined GENERATE FLATTEN(result_count_total_month::nombre) as (game_name, date), 
result_count_total_month::conteo as total_count,
result_count_total_month::conteo - result_count_not::conteo as recommended,
result_count_not::conteo as not_reccomended;

-- Se realiza otro JOIN para juntar el total de reviews con la cantidad de recomendaciones positivas
-- y negativas que tienen los juegos. Aquí las llaves son (nombre de juego)
result_output_final = JOIN result_output BY game_name, count_total_reviews by game_name;

-- Reordenamos la tabla obtenida.
new_result = FOREACH result_output_final GENERATE result_output::game_name as game_name, result_output::date as date,
result_output::total_count as total_count_month, result_output::recommended as recommended, result_output::not_reccomended as not_reccomended,
count_total_reviews::conteo as total_count;

-- Se obtienen los primeros 3 meses de reviews por juego con todas las caracteristicas anteriores.
group_new_result = GROUP new_result BY game_name;


group_top3 = FOREACH group_new_result {
        sorted = ORDER new_result BY date ASC;
        top    = LIMIT sorted 3;
        GENERATE group, FLATTEN(top);
};
----------------------- LO NUEVO -----------------------------
-- No e s mucho pero e strabajo honesto
-- Se obtiene el mes con mas reviews de cada juego
group_best_month_per_game = FOREACH group_new_result{
    sorted = ORDER new_result By total_count_month ;
    top = LIMIT sorted 1;
    GENERATE group , FLATTEN(top) ;
}
order_best = ORDER group_best_month_per_game BY total_count_month DESC ;
--rank_games_best_month = RANK  order_best BY total_count_month;
--rank_games_best_month_top10 = FILTER rank_games_best_month BY $0 <= 10;


DUMP order_best; 

-- STORE rank_games_best_month_top10 INTO 'hdfs://cm:9000/uhadoop2021/g34/top_month/';
(三国群英传8 Heroes of the Three Kingdoms 8,三国群英传8 Heroes of the Three Kingdoms 8,2021-01,8111,4677,3434,8111)

(Phasmophobia,Phasmophobia,2020-09,5905,5792,113,219090)

(PLAYERUNKNOWN'S BATTLEGROUNDS,PLAYERUNKNOWN'S 
BATTLEGROUNDS,2019-09,5601,2705,2896,1644255)

--(Grand Theft Auto V,Grand Theft Auto V,2015-09,3001,2530,471,1019116)
--(Satisfactory,Satisfactory,2020-10,2702,2614,88,42449)
--(Dead by Daylight,Dead by Daylight,2017-04,2258,1767,491,418897)
--(DOOM Eternal,DOOM Eternal,2020-09,2175,2008,167,105196)
--(DEATH STRANDING,DEATH STRANDING,2020-10,2096,1925,171,47781)
--(Crusader Kings III,Crusader Kings III,2021-01,2016,1873,143,45151)
--(NBA 2K21,NBA 2K21,2020-10,1889,691,1198,15735)
--(Helltaker,Helltaker,2021-01,1860,1796,64,86306)
--(Borderlands 3,Borderlands 3,2020-10,1809,1520,289,67080)
--(Rust,Rust,2014-09,1606,1358,248,549074)
--(Persona 4 Golden,Persona 4 Golden,2021-01,1596,1547,49,40180)
--(Monster Hunter: World,Monster Hunter: World,2019-03,1566,1320,246,290946)

---------------------------------------------------------------

-- Filtramos los juegos donde el promedio de reviews de los primeros 3 meses es mayor que el total 
-- de reviews generados hasta la fecha
reorder_output_final1 = FOREACH group_top3 GENERATE top::game_name as game_name, top::date as date, 
top::total_count_month as total_count_month, top::recommended as recommended, top::not_reccomended as not_reccomended, 
top::total_count as total_count;
final_filtered = FILTER reorder_output_final1 BY recommended*0.45 < not_reccomended;
reorder_output_final2 = FOREACH final_filtered GENERATE game_name as game_name, total_count as total;

output_distinct = DISTINCT reorder_output_final2;
final_sort = ORDER output_distinct BY total DESC;

--DUMP final_sort


-- sorted_num_reviews_by_game = ORDER num_reviews_by_game BY count DESC;
-- STORE num_reviews_by_game INTO 'hdfs://cm:9000/uhadoop2021/g34/test_X/';