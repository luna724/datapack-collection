# 初期設定 20
scoreboard players add #l.ua_RON l.ua_Settings 1
execute if score #l.ua_RON l.ua_Settings matches 7.. run scoreboard players set #l.ua_RON l.ua_Settings 0

# 0 = 1
# 1 = 5
# 2 = 10
# 3 = 20
# 4 = 30
# 5 = 50
# 6 = 100
execute if score #l.ua_RON l.ua_Settings matches 0 run scoreboard players set #l.ua_LongArmPerContent l.ua_Settings 1
execute if score #l.ua_RON l.ua_Settings matches 1 run scoreboard players set #l.ua_LongArmPerContent l.ua_Settings 5
execute if score #l.ua_RON l.ua_Settings matches 2 run scoreboard players set #l.ua_LongArmPerContent l.ua_Settings 10
execute if score #l.ua_RON l.ua_Settings matches 3 run scoreboard players set #l.ua_LongArmPerContent l.ua_Settings 20
execute if score #l.ua_RON l.ua_Settings matches 4 run scoreboard players set #l.ua_LongArmPerContent l.ua_Settings 30
execute if score #l.ua_RON l.ua_Settings matches 5 run scoreboard players set #l.ua_LongArmPerContent l.ua_Settings 50
execute if score #l.ua_RON l.ua_Settings matches 6 run scoreboard players set #l.ua_LongArmPerContent l.ua_Settings 100

# 効果音 + 再度表示
execute at @s run playsound ui.button.click master @s ~ ~ ~ 100 1.5
tellraw @s [{"text":"\n\n\n\n\n"}]
function l.arm:settings/