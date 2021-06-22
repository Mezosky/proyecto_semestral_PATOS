# Proyecto Semestral

<p align="center">
<img src="https://steamuserimages-a.akamaihd.net/ugc/31859108324626554/B406C9A1DA13840BF539A901DCABD443F1F5219E/" alt="cassandra" height="300">
</p>

## Indice

- [Objetivos](https://github.com/Mezosky/proyecto_semestral_PATOS#Objetivos)
- [Entregables](https://github.com/Mezosky/proyecto_semestral_PATOS#entregables)
- [Códigos](https://github.com/Mezosky/proyecto_semestral_PATOS#Codigos)
- [Resultados](https://github.com/Mezosky/proyecto_semestral_PATOS#Resultados)
- [Códigos utiles para la ejecución del Lab](https://github.com/Mezosky/proyecto_semestral_PATOS#Códigos-útiles-para-la-ejecución-del-cluster-y-otros)


## Objetivos
<p align="center">
<img src="https://media1.tenor.com/images/dd0a30cba014e29bdac0c59c7a0cef45/tenor.gif?itemid=5684151" alt="goals" height="300">
</p>

- [ ] Generar una consulta que nos permita obtener una lista con juegos controversiales.
- [ ] Generar graficos que muestren la conducta que tienen los juegos controversiales.
- [ ] Realizar otras consultas exploratorias del dataset

## Metodología

### Definiendo Controversial

# Resultados

| Nombre de juego                             | Cantidad totales de Reviews |
|---------------------------------------------|-----------------------------|
|        PLAYERUNKNOWN'S BATTLEGROUNDS        |           1644255           |
|            Monster Hunter: World            |            290946           |
|                 No Man's Sky                |            182045           |
|         Sid Meier's Civilization VI         |            143789           |
| The Elder Scrolls V: Skyrim Special Edition |            142509           |
|                 DOOM Eternal                |            105196           |
|                  For Honor                  |            93971            |
|           The Elder Scrolls Online          |            91923            |
|                  Far Cry 5                  |            85745            |
|                 Just Cause 3                |            82168            |
|                NieR:Automata™               |            81110            |
|         theHunter: Call of the Wild™        |            67240            |
|                 Conan Exiles                |            62151            |
|           Warhammer: Vermintide 2           |            61887            |

## Codigos utiles para enviar archivos

ssh -p 220 uhadoop@cm.dcc.uchile.cl
PW: HADcc5212$oop

scp -P 220 local-path D:/pandicosas/Codes/Eclipe_projects/proyecto_semestral_PATOS/Codes/script_test.pig uhadoop@cm.dcc.uchile.cl:/data/2021/uhadoop/grupo34/

hdfs dfs -ls /uhadoop2021/g34
hdfs dfs -cat /uhadoop2021/g34/test_X/part-r-00000 | head -n 50
hdfs dfs -rmr /uhadoop2021/g34/test_X/

hdfs dfs -rmr -skipTrash /uhadoop2021/uwuLOVE/
