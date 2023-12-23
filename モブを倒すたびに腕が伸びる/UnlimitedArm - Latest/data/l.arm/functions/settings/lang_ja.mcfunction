tag @s remove l.LANG-EN
tag @s add l.LANG-JA

# 効果音 + 再度表示
execute at @s run playsound ui.button.click master @s ~ ~ ~ 100 1.5
tellraw @s [{"text":"\n\n\n\n\n"}]
function l.arm:settings/

tellraw @a [{"text": "\n言語が 日本語 に設定されました", "color":"green"}]