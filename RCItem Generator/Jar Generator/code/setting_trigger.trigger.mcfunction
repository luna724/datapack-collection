# リセット
scoreboard players set @s luna_ctGen_toggle_feature 0

tellraw @s ["",{"text":"\n\n\n\n|--------","color":"gray"},{"text":" Luna's Creator Tool Generator Feature Toggle ","color":"yellow"},{"text":" --------|","color":"gray"}]
tellraw @s [{"text":""},{"text":"|","color":"gray"},{"text":" Feature : Value (Click for change)  "},{"text":"|","color":"gray"}]

# execute if score #SETTING_OVERRIDE_WEATHER_CYCLE luna.ManyWeather matches 1 run tellraw @s [{"text":""},{"text":"|","color":"gray"},{"text":" Weather Cycle System  : "},{"text":"roll if daytime = 23999","color":"green","clickEvent":{"action":"run_command","value":"/function l.tlc:setting/override_weather_cycle"},"hoverEvent":{"action":"show_text","contents":"Click for Change!"}},{"text":"      |","color":"gray"}]
# execute unless score #SETTING_OVERRIDE_WEATHER_CYCLE luna.ManyWeather matches 1 run tellraw @s [{"text":""},{"text":"|","color":"gray"},{"text":" Weather Cycle System  : "},{"text":"roll Every 20min","color":"red","clickEvent":{"action":"run_command","value":"/function l.tlc:setting/override_weather_cycle"},"hoverEvent":{"action":"show_text","contents":"Click for Change!"}},{"text":"     |","color":"gray"}]







#Don'tDeleteThisLine!
scoreboard players enable @s luna_ctGen_toggle_feature