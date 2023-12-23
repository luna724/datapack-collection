import gradio as gr
from tkinter import Tk, filedialog
import random
from launch import add_arg, langlist
import argparse
import os
import re
import lgs_misc_jsonconfig as jsoncfg

class Shared():
  dev = False

share = Shared()

# メイン処理
def main():
  # Argparser
  parser = argparse.ArgumentParser()
  
  data = [
    "--script",
    ("--use_previous_pack",None),
    "--pppath",
    ("--check_update",None),
    "--mcmetaver",
    ("--only_update",None),
    ("--dev", None),
    "--lang",
    ("--port", None),
    ("--share")
  ]
  
  args = add_arg(data, parser)
  
  if args.dev:
    share.dev = args.dev
  use_previous_pack = False
  if args.use_previous_pack:
    if args.use_previous_pack == True:
      use_previous_pack = args.use_previous_pack
      pppath = args.pppath
      if args.check_update:
        check_update = args.check_update
  if args.mcmetaver:
    mcmeta = args.mcmetaver
  if args.only_update:
    return "ONLY_UPDATE"
  if args.lang:
    lang = args.lang
  if args.port:
    if not isinstance(args.port, int):
      port = 34567
    else:
      port = args.port
  else:
    port = 34567
    
  # 前処理
  lang = jsoncfg.read(os.path.join(os.getcwd(), "lang", f"{lang}_{langlist[lang]}.json"))
  lang = lang["ui"]
  db = jsoncfg.read(os.path.join(os.getcwd(), "database.json"))
  
  session_id = random.randrange(0, 2147483647)
  out_dir = os.getcwd()
  for x in db["output_to"]:
    out_dir = os.path.join(out_dir, x)
    
  if "{}" in out_dir:
    out_dir = out_dir.format(session_id)
  os.makedirs(out_dir, exist_ok=True)
    
  
  # /html/body/div[3]/div[3]/div[5]/div[1]/div[6]/pre/span[18]
  # response = requests.get("https://minecraft.wiki/w/Data_pack")
  #
  # ↑ とりあえず保留中の pack.mcmeta 値取得
  try:
    if mcmeta == "auto":
      mcmeta = jsoncfg.read(os.path.join(os.getcwd(), "database.json"))["pack_number"]
    else:
      mcmeta = mcmeta
  except UnboundLocalError as e:
    print(f"Catched UnboundLocalError: ({e})\nif you're using 'Use Previous Datapack', you can ignored")
    mcmeta = jsoncfg.read(os.path.join(os.getcwd(), "database.json"))["pack_number"]
    
  pack_mcmeta = db["pack_mcmeta"].replace(
    "$PACK_FORMAT", str(mcmeta)
  )
  
  ROOT_DIR = os.getcwd()
  os.chdir(out_dir)
  ROOT = out_dir
  func_root = os.path.join(ROOT, "data", db["datapack_namespace"], "functions")
  
  
  if not use_previous_pack:
    # 初回限定処理
    print("you need customize the datapack?")
    print("go to database.json! (if you don't know this code, probably shouldn't do it)")
    
    # 作成
    # pack.mcmeta
    jsoncfg.write_text(
      pack_mcmeta,
      os.path.join(ROOT, "pack.mcmeta")
    )
    
    
    # data -> datapack_namespace -> functions
    os.makedirs(os.path.join(ROOT, "data"),exist_ok=True)
    os.makedirs(os.path.join(ROOT, "data", db["datapack_namespace"]), exist_ok=True)
    os.makedirs(os.path.join(ROOT, "data", db["datapack_namespace"], "functions"), exist_ok=True)
    
    # data -> minecraft -> tags -> functions -> load.json / tick.json
    if db["have_mcload_tick"]:
      os.makedirs(os.path.join(ROOT, "data", "minecraft"),exist_ok=True)
      os.makedirs(os.path.join(ROOT, "data", "minecraft", "tags"), exist_ok=True)
      mctf_root = os.path.join(ROOT, "data", "minecraft", "tags", "functions")
      os.makedirs(mctf_root, exist_ok=True)
      
      # tick.json
      mctf_tickjson = db["mctf"]["tick.json"]
      mctf_tickjson["values"][0] = f'{db["datapack_namespace"]}:{db["tick"].replace(".mcfunction", "")}'
      jsoncfg.write(mctf_tickjson, os.path.join(mctf_root, "tick.json"),silent=True)
      
      # load.json
      mctf_loadjson = db["mctf"]["load.json"]
      mctf_loadjson["values"][0] = f'{db["datapack_namespace"]}:{db["load"].replace(".mcfunction", "")}'
      jsoncfg.write(mctf_loadjson, os.path.join(mctf_root, "load.json"),silent=True)
      
    # tick / load .mcfunction
    
    # tick.mcfunction のコードを構築
    func_tickmcf = jsoncfg.read_text(os.path.join(ROOT_DIR, "code", db["code"]["tick"]))
    
    func_tickmcf += """
\n
# Gen'd by Script (from below here)
# get holding item (to storage)
data modify storage lunact:holding Item.Mainhand set from entity @s SelectedItem
data modify storage lunact:holding Item.Offhand set from entity @s Inventory[{Slot:-106b}]
# Potion Detection
execute as @a[scores={luna.ThrowedPotion=1..}] at @s run """ + f"function {db['datapack_namespace']}:checker/lingering_potion\n"
    
    if db["activate_setting"]:
      func_tickmcf += f"""\n
execute as @a at @s if score @s luna_ctGen_toggle_feature matches 1.. run function {db["datapack_namespace"]}:{db["settings"]}/trigger
    """
    
    
    # activate setting
    os.makedirs(os.path.join(func_root, db["settings"]),exist_ok=True)
    # 内容をそのまま移動
    jsoncfg.write_text(
      jsoncfg.read_text(os.path.join(ROOT_DIR, "code", db["code"]["setting_trigger"]))
      , os.path.join(func_root, db["settings"], "trigger.mcfunction")
    )
    
    # 今後の処理のための
    func_tickmcf += """\n
# Remove All Offhand tags
tag @s remove Ls.ofh_example\n"""
    func_tickmcf += '\n###DNTL\nexecute unless data storage lunact:holding Item.Mainhand{id:"minecraft:lingering_potion"} run function ' + f'{db["datapack_namespace"]}:offhand_check\ndata remove storage lunact:holding Item\n'
    
    # 書き込み
    jsoncfg.write_text(
      func_tickmcf,
      os.path.join(func_root, db["tick"])
    )
    
    # load.mcfunction
    func_loadmcf = jsoncfg.read_text(os.path.join(
      ROOT_DIR, "code", db["code"]["load"]
    ))
    
    func_loadmcf += f"""
    \n
# Gen'd by Script (from below here)
scoreboard objectives add luna_ctGen_toggle_feature dummy
scoreboard objectives add luna_ctGen_Options dummy\n"""
    func_loadmcf += f'scoreboard objectives add luna.ThrowedPotion minecraft.used:minecraft.lingering_potion'

    if db["activate_setting"]:
      func_loadmcf += f"""\n
scoreboard players enable @a luna_ctGen_toggle_feature\n"""

    # 今後の処理のための
    func_loadmcf += """\n
### Setting Load\n"""
    
    # 書き込み
    jsoncfg.write_text(
      func_loadmcf,
      os.path.join(func_root, db["load"])
    )
    
    
    # reset.mcfunction
    jsoncfg.write_text(
      jsoncfg.read_text(
      os.path.join(ROOT_DIR, "code", db["code"]["reset"])
    ),
      os.path.join(func_root, db["reset"])
    )
    
    # Main Code basic
    os.makedirs(
      os.path.join(func_root, db["main_code"]),exist_ok=True
    )
    
    # /checker/*.mcfunction の設定
    os.makedirs(
      os.path.join(func_root, "checker"), exist_ok=True
    )
    fch_root = os.path.join(func_root, "checker")
    
    checker_lp = jsoncfg.read_text(
        os.path.join(ROOT_DIR, "code", db["jar_code"]["lingering_potion"]["checker_basic"])
      ) 
    checker_lp += f'{db["code_variable"]["ling_resetter"]}'
    # lingering_potion
    jsoncfg.write_text(
      checker_lp,
      os.path.join(fch_root, "lingering_potion.mcfunction"))
    
    # carrot_of_stick
    # jsoncfg.write_text(
    #   jsoncfg.read_text(
    #     os.path.join(ROOT_DIR, "code", db["jar_code"]["carrot_of_stick"]["checker_basic"])
    #   ),
    #   os.path.join(fch_root, "carrot_of_stick.mcfunction")
    # )
    
  # 初回限定処理終了
  else:
    # pack.mcmeta がないならリセット
    if not os.path.exists(os.path.join(pppath, "pack.mcmeta")):
      raise ValueError("Input pppath is not a datapack root.")
    
    func_root = os.path.join(pppath, "data", db["datapack_namespace"], "functions")
  
  # UI Function
  # ファイル選択画面の関数
  def browse_file():
    root = Tk()
    root.attributes("-topmost", True)
    root.withdraw()
    
    filenames = filedialog.askopenfilenames()
    if len(filenames) > 0:
        root.destroy()
        return str(filenames)
    else:
        filename = "Files not seleceted"
        root.destroy()
        return str(filename)
  
  def getSupportedRCItem():
    supportedRCItem = []
    
    supportedRCItem.append("Lingering Potion")
    supportedRCItem.append("Carrot on a Stick")
    
    return supportedRCItem
  
  def convertToMcString(text): # this function are provided by. chatGPT
    # 小文字英字と数字、アンダースコア(_)以外の文字をアンダースコア(_)に変換
    s = re.sub(r'[^a-z0-9_]', '_', text.lower())
    # 連続するアンダースコア(_)を1つにまとめる
    s = re.sub(r'_+', '_', s)
    # 先頭と末尾のアンダースコア(_)を削除
    s = s.strip('_')
    return s

  def give_generator(
    givecmd, itemRegistryName
  ):
    # カスタムタグを追加
    ct_base = f"lunacttype:{itemRegistryName}"
    
    # 最初の "{" に ct_base を追加
    givecmd = re.sub(
      "{", "{" + ct_base + ", ", givecmd, count=1
    )
    givecmd += "\n"
    
    return givecmd

  def rcd_save(
    itemname, usefileinput, targetpath,
    usetextinput, text, clickitem, savefilename,
    writeindex, overwrite, itemRegistryName, givecmd,
    useCIT, CIT
  ):
    print("Starting rcd_save")
    # アイテムレジストリ名を作成 (ない場合)
    if itemRegistryName == "":
      itemRegistryName = convertToMcString(itemname)
    else:
      itemRegistryName = convertToMcString(itemRegistryName)
      
    print(f"setup itemRegistryName: {itemRegistryName}")
    
    # ファイルパスを作成
    dir = os.path.join(
      func_root, db["main_code"], itemRegistryName, f"{savefilename}.mcfunction"
    )
    os.makedirs(
      os.path.join(func_root, db["main_code"], itemRegistryName), exist_ok=True
    )
    
    # アイテムID を作成
    # 既にファイルが生成済みならそこから読み込む
    if not os.path.exists(dir):
      itemcheckerID = itemRegistryName
    else:
      itemcheckerID = re.findall(
        r"###lunascript-itemNameRegistryName.re003=(.*)\n",
        jsoncfg.read_text(dir)
      )[0]
    
    itemRegistryName = itemcheckerID
    # 設定があるなら追加
    if db["activate_setting"]:
      # setting/itemName.mcfunction (ON / OFF トリガー)
      setting_triggercode = jsoncfg.read_text(
        os.path.join(ROOT_DIR, "code", db["code"]["setting_toggle"])
      )
      setting_triggercode = setting_triggercode.replace(
        ".self_itemRegistryName", itemcheckerID
      )
      jsoncfg.write_text(
        setting_triggercode, os.path.join(
          func_root, db["settings"], f"{itemcheckerID.lower()}.mcfunction"
        )
      )
      
      # load.mcfunction (初期値設定トリガー)
      set_default_trigger = db["code"]["setting_set_default"]
      set_default_trigger = set_default_trigger.replace(
        ".self_itemRegistryName", itemcheckerID
      )
      # load.mcf 読み込み
      prv_load = jsoncfg.read_text(
        os.path.join(func_root, db["load"])
      )
      if not f"\n{set_default_trigger}" in prv_load:
        prv_load += '\n' + set_default_trigger
      jsoncfg.write_text(
        prv_load, os.path.join(func_root, db["load"]), True
      )
      
    # checker/
    if clickitem == "Lingering Potion":
      # lingering_potion.mcf
      base = db["jar_code"]["lingering_potion"]["checker_template_code"]
      base = base.replace(
        "%id%", itemcheckerID
      )
      base += f"{db['datapack_namespace']}:{db['main_code']}/{itemRegistryName}/{savefilename}\n"
      
      prv_checker = jsoncfg.read_text(
        os.path.join(func_root, "checker", "lingering_potion.mcfunction"))
      
      # prv_checker から リセットコマンドを切り取る
      prv_checker = prv_checker.replace(db["code_variable"]["ling_resetter"], "")
      
      jsoncfg.write_text(
        prv_checker+"\n"+base+db["code_variable"]["ling_resetter"],
        os.path.join(func_root, "checker", "lingering_potion.mcfunction"),
        True
      )
    #elif clickitem == "Carrot on a Stick":
    
    # インデックスがあるなら
    if writeindex and not os.path.join(dir):
      code_info = f"#> {db['datapack_namespace']}:{db['main_code']}/{itemRegistryName}/{savefilename}\n"
    elif writeindex and not overwrite:
      code_info = f"#> {db['datapack_namespace']}:{db['main_code']}/{itemRegistryName}/{savefilename}\n"
    else:
      code_info = ""
    
    # 概要を追加
    if not os.path.exists(os.path.join(dir)) or not overwrite:
      code_info += f'#lunascript - Do Not Delete this comment!!!\n###lunascript-clickItem.re001={clickitem}\n###lunascript-itemName.re002={itemname}\n###lunascript-itemNameRegistryName.re003={itemcheckerID}\n\n# your code\n\n'
    
    # 追加
    code = code_info
    
    # 書かれたものと結合
    if usefileinput:
      if os.path.exists(targetpath):
        text = jsoncfg.read(targetpath)
      else:
        return f"Can't find file (in usefileinput)"
    
    code += text
    
    if db["kill_potion"] and not os.path.join(dir) or overwrite:
      code = "# Kill Potion\nkill @e[type=potion,sort=nearest,limit=1]\n" + code
    
    # 保存
    jsoncfg.write_text(
      code, dir, overwrite=overwrite
    )
    
    
    # tick.mcfunction
    # オフハンドチェックの作成
    prv_tick = jsoncfg.read_text(
      os.path.join(func_root, db["tick"])
    )
    
    # 一番下にあるべきものを消す
    prv_tick = prv_tick.replace(
      '\n###DNTL\nexecute unless data storage lunact:holding Item.Mainhand{id:"minecraft:lingering_potion"} run function ' + f'{db["datapack_namespace"]}:offhand_check\ndata remove storage lunact:holding Item\n',
      ""
    )
    
    # タグを作成、追加
    tag_name = f'Ls.{itemRegistryName}'
    tag_add = f'tag @s remove {tag_name}\n'
    
    # 重複停止
    if not tag_add in prv_tick:
      prv_tick += tag_add
    prv_tick += '\n###DNTL\nexecute unless data storage lunact:holding Item.Mainhand{id:"minecraft:lingering_potion"} run function ' + f'{db["datapack_namespace"]}:offhand_check\ndata remove storage lunact:holding Item\n'
    
    jsoncfg.write_text(
      prv_tick, os.path.join(
        func_root, db["tick"]
      ), True
    )
    
    # give でのアイテムが Lingering Potion じゃない場合
    if not "lingering_potion" in givecmd:
      return lang["stderr_001"]
    
    # give コマンドを作成
    givecmd = givecmd.strip("/")
    
    # もうあるなら別場所に保存
    if os.path.exists(os.path.join(func_root, db['main_code'], itemRegistryName, "give.mcfunction")):
      jsoncfg.write_text(
        jsoncfg.read_text(os.path.join(func_root, db['main_code'], itemRegistryName, "give.mcfunction")),
        os.path.join(func_root, db['main_code'], itemRegistryName, ".prv_give.mcfunction"))
    jsoncfg.write_text(
    give_generator(
      givecmd, itemRegistryName),
    os.path.join(func_root, db['main_code'], itemRegistryName, "give.mcfunction")
    )
    
    return "Done  "


  
  def get_nested_files(root_dir, endswith):
    file_list = []
    for root, dirs, files in os.walk(root_dir):
        for file in files:
            if file.endswith(endswith):
                file_path = os.path.join(root, file)
                relative_path = os.path.relpath(file_path, root_dir)
                file_list.append((file_path, relative_path))
    return file_list
  
  def loadfrom_rcm_fc_ex():
    datapack_base = f"{db['datapack_namespace']}:"
    
    return_list = []
    filelist = get_nested_files(
      os.path.join(func_root, db["main_code"]), ".mcfunction"
    )
    
    for _, x in filelist:
      x.replace("\\", "/").replace(".mcfunction", "")
      return_list.append(
        f"{datapack_base}{db['main_code']}/{x}"
      )
      
    return return_list
  
  def rcd_fl_load(loadfrom, lfex, useex, nosave,
                  rcd1, rcd2, rcd3, rcd4, rcd5, rcd6, rcd7, rcd8, rcd9, rcd10, rcd11, rcd12, rcd13):
    if useex:
      loadfrom = lfex
    
    if not nosave:
      rcd_save(
        rcd1, rcd2, rcd3, rcd4, rcd5, rcd6, rcd7, rcd8, rcd9, rcd10, rcd11, rcd12, rcd13
      )
    
    # データパック形式 -> ファイル名
    namespace = db['datapack_namespace']
    replace = loadfrom.replace(
      f"{namespace}:", ""
    )
    splitted = replace.split("/")
    
    dir = func_root
    for x in splitted:
      dir = os.path.join(dir, x)
    
    #dir += ".mcfunction"
    print(f"Load Resizer: {loadfrom} -> {dir}")
    
    if os.path.exists(dir):
      code = jsoncfg.read_text(dir)
      
      pattern_clickitem = r"###lunascript-clickItem.re001=(.*)\n"
      pattern_itemname = r"###lunascript-itemName.re002=(.*)\n"

      clickitem = re.findall(pattern_clickitem, code)[0]
      itemname = re.findall(pattern_itemname, code)[0]
      
      print(f"code: {code}\n\ndirectory: {dir}")
      
      loadfrom = re.findall(
        f"{namespace}:{db['main_code']}/(.*).mcfunction",
        loadfrom
      )[0]
      
      return True, code, False, clickitem, loadfrom, True, itemname
    return True, "", False, "", loadfrom, True, ""
  
  
  tab1 = lang["Tab1"]
  t1_fl = tab1["function_loaders"]
  with gr.Blocks() as iface:
    with gr.Tab("RightClick Detector"):
      with gr.Row():
        itemName = gr.Textbox(max_lines=1,placeholder="Gamemode Changer",label=tab1["itemName"])
        itemRegistryName = gr.Textbox(max_lines=1, label=tab1["itemRegistryName"],placeholder="gamemode_changer")
        
      with gr.Blocks():
        with gr.Column():
          with gr.Row():
            useFileInput = gr.Checkbox(
              label=tab1["useFileInput"], value=False
            )
            targetPath = gr.Textbox(
              label=tab1["targetPath"], placeholder="/test/example.mcfunction"
            )
            selectButton = gr.Button(tab1["selectButton"])
            selectButton.click(fn=browse_file,
                              outputs=[targetPath])
          with gr.Row():
            useTextInput = gr.Checkbox(
              label=tab1["useTextInput"], value=True
            )
            texts = gr.Textbox(
              label=tab1["text"], placeholder='tellraw @a [{"text":"Hello, World!"}]'
              ,max_lines=250
            )
          
          with gr.Row():
            clickItem = gr.Dropdown(choices=getSupportedRCItem(),
                                    label=tab1["clickItem"],
                                    value=getSupportedRCItem()[0])
            saveFileName = gr.Textbox(label=tab1["saveFileName"], placeholder=f"{db['datapack_namespace']}:{db['main_code']}/")
          with gr.Row():
            writeIndex = gr.Checkbox(label=tab1["writeIndex"],value=True)
            overwrite = gr.Checkbox(label=tab1["overwrite"], value=False)
          with gr.Row():
            useCustomItemTag = gr.Checkbox(label=tab1["useCustomItemTag"],value=False)
            CustomItemTag = gr.Textbox(label=tab1["CustomItemTag"],placeholder=tab1["CIT_WARN"], value="FEATURE DISABLED")
          
          givecmd = gr.Textbox(label=tab1["givecmd"],max_lines=1)
          gr.Markdown(tab1["givecmd_tip"])
          
          status = gr.Textbox(label=tab1["status"])
          save = gr.Button(tab1["save"])
          save.click(
            fn= rcd_save,
            inputs=[itemName, useFileInput, targetPath, 
                    useTextInput, texts, clickItem, saveFileName,
                    writeIndex, overwrite, itemRegistryName, givecmd, useCustomItemTag, CustomItemTag],
            outputs=[status]
          )
      
      with gr.Accordion(tab1["function_loader"], open=True, visible=not db["ui"]["disable_function_loader"]):
        with gr.Blocks():
          with gr.Column():
            gr.Markdown(t1_fl["warn_message"])
            
            loadFrom = gr.Textbox(label=t1_fl["loadFrom"], placeholder=f"{db['datapack_namespace']}:{db['main_code']}/tick")
            
            with gr.Accordion(t1_fl["experimental_warn"], open=False):
              useThis = gr.Checkbox(label=t1_fl["useThis"], value=False)
              loadFrom_ex = gr.Dropdown(
                choices=loadfrom_rcm_fc_ex(),
                label=t1_fl["loadFrom_EX"]
              )
            
            noSave = gr.Checkbox(label=t1_fl["noSave"], value=False)
            load = gr.Button(t1_fl["load"])
            load.click(
              fn= rcd_fl_load,
              inputs=[loadFrom, loadFrom_ex, useThis, noSave,itemName, useFileInput, targetPath, 
                    useTextInput, texts, clickItem, saveFileName,
                    writeIndex, overwrite, itemRegistryName, givecmd, useCustomItemTag, CustomItemTag],
              outputs=[
                useTextInput, texts, useFileInput, clickItem, saveFileName, overwrite, itemName
              ]
            )
  
  
  
  # Launch
  iface.queue(64)
  iface.launch(
    server_port=port,
    share=args.share
  )

if __name__ == "__main__":
  main()