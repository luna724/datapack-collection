# 1以上なら -1 へ
# 1以外なら +1
execute if score #SETTING_OVERRIDE_WEATHER_CYCLE luna.ManyWeather matches 1.. run scoreboard players set #SETTING_OVERRIDE_WEATHER_CYCLE luna.ManyWeather -1

scoreboard players add #SETTING_OVERRIDE_WEATHER_CYCLE luna.ManyWeather 1




# 効果音 + 再度表示
execute at @s run playsound ui.button.click master @s ~ ~ ~ 100 1.5

function l.tlc:setting/trigger