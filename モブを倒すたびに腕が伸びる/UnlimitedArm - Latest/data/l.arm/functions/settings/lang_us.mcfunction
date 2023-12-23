tag @s remove l.LANG-JA
tag @s add l.LANG-EN

# 効果音 + 再度表示
execute at @s run playsound ui.button.click master @s ~ ~ ~ 100 1.5
tellraw @s [{"text":"\n\n\n\n\n"}]
function l.arm:settings/

# tellraw @a [{"text": "\nLanguage is Successfully Changed to English (US)!", "color":"green"}]