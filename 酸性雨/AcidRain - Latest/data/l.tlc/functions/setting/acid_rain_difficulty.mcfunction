


execute if score #SETTING_WEATHER_DIFFICULTY luna.ManyWeather matches 4.. run scoreboard players set #SETTING_WEATHER_DIFFICULTY luna.ManyWeather 0

scoreboard players add #SETTING_WEATHER_DIFFICULTY luna.ManyWeather 1



# 効果音 + 再度表示
execute at @s run playsound ui.button.click master @s ~ ~ ~ 100 1.5

function l.tlc:setting/trigger