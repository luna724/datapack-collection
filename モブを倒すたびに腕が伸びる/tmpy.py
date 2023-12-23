# tmp py

template = "execute if score @s l.ua_CurrentReach matches {} run attribute @s minecraft:generic.entity_interaction_range base set {}"
ranges = (1, 1000)
scale_div = (1, 10) # = base / scale

basic = ""
for x in range(ranges[0], ranges[1]):
  resized_template = template.format(int(x / scale_div[0]), x / scale_div[1])
  
  basic += resized_template + "\n"
  

with open("tmppy_upld.txt", "w") as f:
  f.write(basic)