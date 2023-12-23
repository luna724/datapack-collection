# ロールする

# リセット
scoreboard players set WCycle_ID luna.ManyWeather -1

# 50% 晴れ
execute if predicate l.tlc:roll/050 run scoreboard players set WCycle_ID luna.ManyWeather 1

# 5% 雨 (50% * 5%)
execute if predicate l.tlc:roll/005 run scoreboard players set WCycle_ID luna.ManyWeather 2

# 5% 雷雨 (50% * 95% * 5%)
execute if predicate l.tlc:roll/005 run scoreboard players set WCycle_ID luna.ManyWeather 3

# 50% Hard rain (50% * 95 * 95 * 50%)
execute if predicate l.tlc:roll/050 run scoreboard players set WCycle_ID luna.ManyWeather 7

# 5% Thunder (NOT RELEASED)

# 何もロールされていない？
execute if score WCycle_ID luna.ManyWeather matches -1 run function l.tlc:weather_cycle/role

tellraw @a[tag=luna.Debug] [{"text":"[l.tlc:weather_cycle/role]: Uncatched score cord -1 (Passed)"}]
