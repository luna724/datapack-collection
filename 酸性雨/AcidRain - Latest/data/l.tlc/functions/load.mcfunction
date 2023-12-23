scoreboard objectives add luna.ManyWeather dummy
#execute unless score #LOAD_ONCE luna.ManyWeather matches 1 run function l.tlc:load_once
scoreboard objectives add luna_acid_rain_settings trigger
scoreboard players enable @a luna_acid_rain_settings

#scoreboard players set #LOAD_ONCE luna.ManyWeather 1