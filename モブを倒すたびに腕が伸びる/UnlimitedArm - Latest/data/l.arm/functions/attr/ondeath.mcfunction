execute as @s if score #l.ua_ResetOnDeath l.ua_Settings matches 0 run function l.arm:attr/reset
execute as @s if score #l.ua_ResetOnDeath l.ua_Settings matches 1 run function l.arm:attr/true_reset