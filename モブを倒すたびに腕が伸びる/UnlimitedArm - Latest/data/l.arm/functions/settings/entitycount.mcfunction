# 初期設定 12 (2)
scoreboard players add #l.ua_ECN l.ua_Settings 1
execute if score #l.ua_ECN l.ua_Settings matches 4.. run scoreboard players set #l.ua_ECN l.ua_Settings 0

# 0 = 1
# 1 = 5
# 2 = 12
# 3 = 50
execute if score #l.ua_ECN l.ua_Settings matches 0 run scoreboard players set #l.ua_EntityPerLongArm l.ua_Settings 1
execute if score #l.ua_ECN l.ua_Settings matches 1 run scoreboard players set #l.ua_EntityPerLongArm l.ua_Settings 5
execute if score #l.ua_ECN l.ua_Settings matches 2 run scoreboard players set #l.ua_EntityPerLongArm l.ua_Settings 12
execute if score #l.ua_ECN l.ua_Settings matches 3 run scoreboard players set #l.ua_EntityPerLongArm l.ua_Settings 50

# 効果音 + 再度表示
execute at @s run playsound ui.button.click master @s ~ ~ ~ 100 1.5
tellraw @s [{"text":"\n\n\n\n\n"}]
function l.arm:settings/