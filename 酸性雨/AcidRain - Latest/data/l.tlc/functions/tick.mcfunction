# 天候のオーバーライド
# execute if score #SETTING_OVERRIDE_WEATHER_CYCLE luna.ManyWeather matches 1 run function l.tlc:weather/override/tick
function l.tlc:weather/override/tick

# 日付変更チェック
execute store result score #DAYTIME luna.ManyWeather run time query daytime
execute if score #SETTING_OVERRIDE_WEATHER_CYCLE luna.ManyWeather matches 1 run execute if score #DAYTIME luna.ManyWeather matches 23999 run function l.tlc:weather_cycle/trigger

# 設定
execute as @a at @s run execute if score @s luna_acid_rain_settings matches 1.. run function l.tlc:setting/trigger

# 20分タイマー
execute unless score #SETTING_OVERRIDE_WEATHER_CYCLE luna.ManyWeather matches 1 run execute if score #20min_timer luna.ManyWeather matches 0.. run scoreboard players remove #20min_timer luna.ManyWeather 1
execute unless score #SETTING_OVERRIDE_WEATHER_CYCLE luna.ManyWeather matches 1 run execute if score #20min_timer luna.ManyWeather matches ..-1 run function l.tlc:20min_triggered