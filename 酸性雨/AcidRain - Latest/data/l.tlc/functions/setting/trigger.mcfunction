# リセット
scoreboard players set @s luna_acid_rain_settings 0

# 表示

# \n\n\n\n\n\n\n
# |--- Acid Rain Setting ---|
# | Settings  :  Value (Click for change) | 
# | Override Weather Cycle : True / False |
# | Acid Rain Damage       : Easy (1) / Normal (2) / Hard (4) / Very Hard (12) |
# | Experimental Cycle Mode: True / False |
# |                        |
# | by. luna_       v1.0   |
# |------------------------|
# 


tellraw @s ["",{"text":"\n\n\n\n|--------","color":"gray"},{"text":" Acid Rain Setting","color":"yellow"},{"text":" --------|","color":"gray"}]
tellraw @s [{"text":""},{"text":"|","color":"gray"},{"text":" Settings : Value (Click for change)  "},{"text":"|","color":"gray"}]

# Weather Cycle System
execute if score #SETTING_OVERRIDE_WEATHER_CYCLE luna.ManyWeather matches 1 run tellraw @s [{"text":""},{"text":"|","color":"gray"},{"text":" Weather Cycle System  : "},{"text":"roll if daytime = 23999","color":"green","clickEvent":{"action":"run_command","value":"/function l.tlc:setting/override_weather_cycle"},"hoverEvent":{"action":"show_text","contents":"Click for Change!"}},{"text":"      |","color":"gray"}]
execute unless score #SETTING_OVERRIDE_WEATHER_CYCLE luna.ManyWeather matches 1 run tellraw @s [{"text":""},{"text":"|","color":"gray"},{"text":" Weather Cycle System  : "},{"text":"roll Every 20min","color":"red","clickEvent":{"action":"run_command","value":"/function l.tlc:setting/override_weather_cycle"},"hoverEvent":{"action":"show_text","contents":"Click for Change!"}},{"text":"     |","color":"gray"}]

#tellraw @s []
# Acid Rain Damage
execute if score #SETTING_WEATHER_DIFFICULTY luna.ManyWeather matches 1 run tellraw @s [{"text":"|","color":"gray"},{"text":" Acid Rain Damage","color":"white"},{"text":"         :","color":"white"},{"text":" ","color":"#6A9955"},{"text":"Easy (1)","color":"aqua","clickEvent":{"action":"run_command","value":"/function l.tlc:setting/acid_rain_difficulty"},"hoverEvent":{"action":"show_text","contents":"Click for Change!"}},{"text":"|","color":"gray"}]
execute if score #SETTING_WEATHER_DIFFICULTY luna.ManyWeather matches 2 run tellraw @s [{"text":"|","color":"gray"},{"text":" Acid Rain Damage","color":"white"},{"text":"         :","color":"white"},{"text":" ","color":"#6A9955"},{"text":"Normal (2)","color":"green","clickEvent":{"action":"run_command","value":"/function l.tlc:setting/acid_rain_difficulty"},"hoverEvent":{"action":"show_text","contents":"Click for Change!"}},{"text":"|","color":"gray"}]
execute if score #SETTING_WEATHER_DIFFICULTY luna.ManyWeather matches 3 run tellraw @s [{"text":"|","color":"gray"},{"text":" Acid Rain Damage","color":"white"},{"text":"         :","color":"white"},{"text":" ","color":"#6A9955"},{"text":"Hard (5)","color":"red","clickEvent":{"action":"run_command","value":"/function l.tlc:setting/acid_rain_difficulty"},"hoverEvent":{"action":"show_text","contents":"Click for Change!"}},{"text":"|","color":"gray"}]
execute if score #SETTING_WEATHER_DIFFICULTY luna.ManyWeather matches 4 run tellraw @s [{"text":"|","color":"gray"},{"text":" Acid Rain Damage","color":"white"},{"text":"         :","color":"white"},{"text":" ","color":"#6A9955"},{"text":"Very Hard (12)","color":"dark_red","clickEvent":{"action":"run_command","value":"/function l.tlc:setting/acid_rain_difficulty"},"hoverEvent":{"action":"show_text","contents":"Click for Change!"}},{"text":" |","color":"gray"}]

# Acid Rain Rarity
execute if score #SETTING_ACID_RAIN_RARITY luna.ManyWeather matches 1 run tellraw @s [{"text":"|","color":"gray"},{"text":" Acid Rain Rarity","color":"white"},{"text":"      :","color":"white"},{"text":" "},{"text":"Rare (5%)","color":"aqua","clickEvent":{"action":"run_command","value":"/function l.tlc:setting/acid_rain_rarity"},"hoverEvent":{"action":"show_text","contents":"Click for Change!"}},{"text":" |","color":"gray"}]
execute if score #SETTING_ACID_RAIN_RARITY luna.ManyWeather matches 2 run tellraw @s [{"text":"|","color":"gray"},{"text":" Acid Rain Rarity","color":"white"},{"text":"      :","color":"white"},{"text":" "},{"text":"Default (30%)","color":"green","clickEvent":{"action":"run_command","value":"/function l.tlc:setting/acid_rain_rarity"},"hoverEvent":{"action":"show_text","contents":"Click for Change!"}},{"text":" |","color":"gray"}]
execute if score #SETTING_ACID_RAIN_RARITY luna.ManyWeather matches 3 run tellraw @s [{"text":"|","color":"gray"},{"text":" Acid Rain Rarity","color":"white"},{"text":"      :","color":"white"},{"text":" "},{"text":"Common (75%)","color":"red","clickEvent":{"action":"run_command","value":"/function l.tlc:setting/acid_rain_rarity"},"hoverEvent":{"action":"show_text","contents":"Click for Change!"}},{"text":" |","color":"gray"}]
execute if score #SETTING_ACID_RAIN_RARITY luna.ManyWeather matches 4 run tellraw @s [{"text":"|","color":"gray"},{"text":" Acid Rain Rarity","color":"white"},{"text":"      :","color":"white"},{"text":" "},{"text":"Always (100%)","color":"dark_red","clickEvent":{"action":"run_command","value":"/function l.tlc:setting/acid_rain_rarity"},"hoverEvent":{"action":"show_text","contents":"Click for Change!"}},{"text":" |","color":"gray"}]

tellraw @s [{"text":"|                                              |\n| by. luna_                     v1.0        |\n|-------------------------------|","color":"gray"}]  

scoreboard players enable @a luna_acid_rain_settings