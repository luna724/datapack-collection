

playsound minecraft:ui.button.click master @a ~ ~ ~ 100 2

# スコアボードの値を動的に変更
scoreboard players add #.self_itemRegistryName luna_ctGen_Options 1
execute if score #.self_itemRegistryName luna_ctGen_Options matches 2.. run scoreboard players set #.self_itemRegistryName luna_ctGen_Options 0

# 0 = enable / default
# 1 = disable

# 再表示
scoreboard players enable @a luna_ctGen_toggle_feature
# ゲームルールによる
execute if score #.builtin_reShow luna_ctGen_Options matches 0 run trigger luna_ctGen_toggle_feature


# e.g.
# playsound minecraft:ui.button.click master @a ~ ~ ~ 100 2

# # スコアボードの値を動的に変更
# scoreboard players add #.builtin_toggleAll luna_ctGen_Options 1
# execute if score #.builtin_toggleAll luna_ctGen_Options matches 2.. run scoreboard players set #.builtin_toggleAll luna_ctGen_Options 0

# # 0 = enable / default
# # 1 = disable

# # 再表示
# scoreboard players enable @a luna_ctGen_toggle_feature
# # ゲームルールによる
# execute if score #.builtin_reShow luna_ctGen_Options matches 0 run trigger luna_ctGen_toggle_feature
