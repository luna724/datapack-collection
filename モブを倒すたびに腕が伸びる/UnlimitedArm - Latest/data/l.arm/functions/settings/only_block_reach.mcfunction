# 初期設定 0
scoreboard players add #l.ua_OnlyBlockReach l.ua_Settings 1
execute if score #l.ua_OnlyBlockReach l.ua_Settings matches 2.. run scoreboard players set #l.ua_OnlyBlockReach l.ua_Settings 0

# 効果音 + 再度表示
execute at @s run playsound ui.button.click master @s ~ ~ ~ 100 1.5
tellraw @s [{"text":"\n\n\n\n\n"}]
function l.arm:settings/