tellraw @a [{"text": "Language is Successfully Changed to English (US)!", "color":"green"}]

data modify storage lunaapi:opt "lang_check" set value 1
data merge storage lunaapi:opt {"lang": "en_us", "exist": 1, "lang_check": 1}