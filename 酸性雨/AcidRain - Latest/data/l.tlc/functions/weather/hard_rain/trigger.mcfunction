# scoreboard players set Weather_ID luna.ManyWeather 1

# 雨を降らす
scoreboard players set Set_Weather luna.ManyWeather 2

# (ダメージ判定が) くるぞ 気をつけろ!
scoreboard players set Weather_Trigger luna.ManyWeather 7

# 天候ロールトリガーを停止
scoreboard players set WCycle_ID luna.ManyWeather -2

# 天候表示モードなら表示
execute if score #SETTING_WEATHER_ANOUNCE luna.ManyWeather matches 1 run tellraw @a [{"text": "--- Todays weather ---\n| 今日の天候は \"打ち付けるような雨\" です。 |"}]

tellraw @a[tag=luna.Debug] [{"text":"[l.tlc:weather/hard_rain/trigger]: Successfully Rolled!"}]

function l.tlc:weather/hard_rain/main