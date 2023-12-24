#> tick

# 死亡時の処理
execute as @a at @s if score @s l.ua_DeathCheck matches 1.. run function l.arm:attr/ondeath

# キル数検出
execute as @a at @s if score @s l.ua_MobKills >= #l.ua_EntityPerLongArm l.ua_Settings run function l.arm:attr/get_reach/

# トリガー
execute as @a at @s if score @s luna_unlimited_arm_setting matches 1.. run function l.arm:settings/