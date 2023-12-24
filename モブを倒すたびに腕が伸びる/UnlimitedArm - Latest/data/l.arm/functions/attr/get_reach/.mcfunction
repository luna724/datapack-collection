# 減らす
scoreboard players operation @s l.ua_MobKills -= #l.ua_ 0

# スコア値の修正
scoreboard players operation #l.ua_LongArmPerOperation l.ua_Settings = #l.ua_LongArmPerContent l.ua_Settings

# 増加値に応じてリーチ数を示すスコアボードを上昇
scoreboard players operation @s l.ua_CurrentReach += #l.ua_LongArmPerOperation l.ua_Settings

# スコア値によってリーチの値を変更させる
execute as @s run function l.arm:attr/reset

# 正常な値を表示
scoreboard players operation @s l.ua_CurrentReach_resized = @s l.ua_CurrentReach
scoreboard players operation @s l.ua_CurrentReach_resized /= #10 l.ua_Settings

# Actionbar
execute if entity @s[tag=l.LANG-EN] run title @s actionbar [{"text": "[reach up!] your reach has been"}, {"score": {"name": "*", "objective": "l.ua_CurrentReach_resized"}}, {"text": "Blocks!"}]
execute if entity @s[tag=l.LANG-JA] run title @s actionbar [{"text": "[reach up!] 腕の長さが"}, {"score": {"name": "*", "objective": "l.ua_CurrentReach_resized"}}, {"text": "ブロックに上がった!"}]

playsound entity.player.levelup player @s ~ ~ ~ 1 1.4
particle minecraft:witch ~ ~0.925 ~ 1 0.5 1 1 100 normal