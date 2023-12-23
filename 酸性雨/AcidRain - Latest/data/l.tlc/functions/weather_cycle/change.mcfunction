# 天気を変える

# -1?
execute if score WCycle_ID luna.ManyWeather matches -1 run function l.tlc:weather_cycle/role

# 1 (Clear)
execute if score WCycle_ID luna.ManyWeather matches 1 run function l.tlc:weather/vannila/clear

# 2 (rain)
execute if score WCycle_ID luna.ManyWeather matches 2 run function l.tlc:weather/vannila/rain

# 3 (Thunderstorm)
execute if score WCycle_ID luna.ManyWeather matches 3 run function l.tlc:weather/vannila/thunderstorm

# 4 (Anvil)

# 5 (Arrow)

# 6 (Die_Block)
execute if score WCycle_ID luna.ManyWeather matches 6 run function l.tlc:weather/die_block/trigger

# 7 (Hard rain)
execute if score WCycle_ID luna.ManyWeather matches 7 run function l.tlc:weather/hard_rain/trigger