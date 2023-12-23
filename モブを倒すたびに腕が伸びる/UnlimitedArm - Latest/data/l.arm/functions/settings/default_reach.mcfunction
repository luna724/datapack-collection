# 初期設定 1Blocks (1)
scoreboard players add #l.ua_DRN l.ua_Settings 1
execute if score #l.ua_DRN l.ua_Settings matches 5.. run scoreboard players set #l.ua_DRN l.ua_Settings 0

# 0 = 0.5
# 1 = 1
# 2 = 3
# 3 = 5
# 4 = 10
execute if score #l.ua_DRN l.ua_Settings matches 0 run scoreboard players set #l.ua_DefaultReach l.ua_Settings 999
execute if score #l.ua_DRN l.ua_Settings matches 1 run scoreboard players set #l.ua_DefaultReach l.ua_Settings 1
execute if score #l.ua_DRN l.ua_Settings matches 2 run scoreboard players set #l.ua_DefaultReach l.ua_Settings 3
execute if score #l.ua_DRN l.ua_Settings matches 3 run scoreboard players set #l.ua_DefaultReach l.ua_Settings 5
execute if score #l.ua_DRN l.ua_Settings matches 4 run scoreboard players set #l.ua_DefaultReach l.ua_Settings 10

# 効果音 + 再度表示
execute at @s run playsound ui.button.click master @s ~ ~ ~ 100 1.5
tellraw @s [{"text":"\n\n\n\n\n"}]
function l.arm:settings/