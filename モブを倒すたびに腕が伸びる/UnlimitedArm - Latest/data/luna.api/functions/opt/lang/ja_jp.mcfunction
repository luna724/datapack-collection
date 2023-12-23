tellraw @a [{"text": "言語が 日本語 に設定されました", "color":"green"}]

data modify storage lunaapi:opt "lang_check" set value 1
data merge storage lunaapi:opt {"lang": "ja_jp", "exist": 1, "lang_check": 1}