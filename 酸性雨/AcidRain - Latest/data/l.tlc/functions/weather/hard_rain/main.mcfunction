# Weather_Trigger が 7 ならLoopback

# プレイヤーが空にさらされているなら
execute if score #SETTING_WEATHER_DIFFICULTY luna.ManyWeather matches 1 run execute as @a at @s positioned over motion_blocking unless block ~ ~1 ~ stone if entity @s[distance=..2.3] run damage @s 1 minecraft:magic
execute if score #SETTING_WEATHER_DIFFICULTY luna.ManyWeather matches 2 run execute as @a at @s positioned over motion_blocking unless block ~ ~1 ~ stone if entity @s[distance=..2.3] run damage @s 2 minecraft:magic
execute if score #SETTING_WEATHER_DIFFICULTY luna.ManyWeather matches 3 run execute as @a at @s positioned over motion_blocking unless block ~ ~1 ~ stone if entity @s[distance=..2.3] run damage @s 5 minecraft:magic
execute if score #SETTING_WEATHER_DIFFICULTY luna.ManyWeather matches 4 run execute as @a at @s positioned over motion_blocking unless block ~ ~1 ~ stone if entity @s[distance=..2.3] run damage @s 12 minecraft:magic


execute if score Weather_Trigger luna.ManyWeather matches 7 run schedule function l.tlc:weather/hard_rain/main 1t