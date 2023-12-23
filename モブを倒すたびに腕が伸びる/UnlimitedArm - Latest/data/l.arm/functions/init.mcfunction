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

tag @s add l.ua_AlreadyInit