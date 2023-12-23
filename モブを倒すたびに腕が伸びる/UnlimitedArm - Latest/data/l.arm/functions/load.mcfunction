#> load

# スコアボード
scoreboard objectives add l.ua_MobKills minecraft.custom:minecraft.mob_kills
scoreboard objectives add l.ua_DeathCheck minecraft.custom:minecraft.deaths
scoreboard objectives add l.ua_CurrentReach dummy
scoreboard objectives add l.ua_Settings dummy
scoreboard objectives add luna_unlimited_arm_setting trigger

scoreboard players set #10 l.ua_Settings 10

# 設定
# Acceptable (from Setting) Value [1, 5, 12, 50]
# can input 1 ~ 2.1b Integer
execute unless score #l.ua_ECN l.ua_Settings = #l.ua_ECN l.ua_Settings run scoreboard players set #l.ua_ECN l.ua_Settings 2
execute unless score #l.ua_EntityPerLongArm l.ua_Settings = #l.ua_EntityPerLongArm l.ua_Settings run scoreboard players set #l.ua_EntityPerLongArm l.ua_Settings 12
# 10 = 1 / input_value = x/10 Reach per Operation 
# Acceptable (from Setting) Value [1, 5, 10, 20, 30, 50, 100]
# can input 1 ~ 1000 Integer
execute unless score #l.ua_RON l.ua_Settings = #l.ua_RON l.ua_Settings run scoreboard players set #l.ua_RON l.ua_Settings 1
execute unless score #l.ua_LongArmPerContent l.ua_Settings = #l.ua_LongArmPerContent l.ua_Settings run scoreboard players set #l.ua_LongArmPerContent l.ua_Settings 20
# Acceptable Value: [0.5 (999), 1, 3, 5, 10]
# DefaultReach  Normalization Scoreobject = #l.ua_DRN
execute unless score #l.ua_DRN l.ua_Settings = #l.ua_DRN l.ua_Settings run scoreboard players set #l.ua_DRN l.ua_Settings 1
execute unless score #l.ua_DefaultReach l.ua_Settings = #l.ua_DefaultReach l.ua_Settings run scoreboard players set #l.ua_DefaultReach l.ua_Settings 1
# 0 = False / bool
execute unless score #l.ua_OnlyBlockReach l.ua_Settings = #l.ua_OnlyBlockReach l.ua_Settings run scoreboard players set #l.ua_OnlyBlockReach l.ua_Settings 0
# 0 = False / bool
execute unless score #l.ua_ResetOnDeath l.ua_Settings = #l.ua_ResetOnDeath l.ua_Settings run scoreboard players set #l.ua_ResetOnDeath l.ua_Settings 0

# Init
execute as @a at @s if entity @s[tag=!l.ua_AlreadyInit] run function l.arm:init

# 定期的なリーチ検査
function l.arm:rld_reach