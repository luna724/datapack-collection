# Init (player)

# デフォルトリーチの設定
execute if score #l.ua_DefaultReach l.ua_Settings matches 999 run attribute @s minecraft:generic.entity_interaction_range base set 0.5
execute if score #l.ua_DefaultReach l.ua_Settings matches 1 run attribute @s minecraft:generic.entity_interaction_range base set 1
execute if score #l.ua_DefaultReach l.ua_Settings matches 3 run attribute @s minecraft:generic.entity_interaction_range base set 3
execute if score #l.ua_DefaultReach l.ua_Settings matches 5 run attribute @s minecraft:generic.entity_interaction_range base set 5
execute if score #l.ua_DefaultReach l.ua_Settings matches 10 run attribute @s minecraft:generic.entity_interaction_range base set 10
execute if score #l.ua_DefaultReach l.ua_Settings matches 999 run attribute @s minecraft:generic.block_interaction_range base set 0.5
execute if score #l.ua_DefaultReach l.ua_Settings matches 1 run attribute @s minecraft:generic.block_interaction_range base set 1
execute if score #l.ua_DefaultReach l.ua_Settings matches 3 run attribute @s minecraft:generic.block_interaction_range base set 3
execute if score #l.ua_DefaultReach l.ua_Settings matches 5 run attribute @s minecraft:generic.block_interaction_range base set 5
execute if score #l.ua_DefaultReach l.ua_Settings matches 10 run attribute @s minecraft:generic.block_interaction_range base set 10

# Only BlockReach ならリセット
execute if score #l.ua_OnlyBlockReach l.ua_Settings matches 1 run attribute @s minecraft:generic.entity_interaction_range base set 3

# #l.ua_CurrentReach を初期化
execute store result score @s l.ua_CurrentReach run attribute @s minecraft:generic.block_interaction_range get 10

# 言語
tellraw @s[tag=!l.AlreadyLang] ["",{"text":"- [Language Options]\n- Please Select your Language\n-\n"},{"text":"- English (US)","clickEvent":{"action":"run_command","value":"/function l.arm:settings/lang_us"}},{"text":"\n"},{"text":"- Japanese (JP)","clickEvent":{"action":"run_command","value":"/function l.arm:settings/lang_ja"}},{"text":"\n- \u0020 \u0020 \u0020 "},{"text":" lunaapi v1.0","color":"gray"}]
tag @s add l.LANG-JA
tag @s add l.AlreadyLang

tag @s add l.ua_AlreadyInit