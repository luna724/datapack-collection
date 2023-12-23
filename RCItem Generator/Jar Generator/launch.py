import argparse
import os
import sys
import subprocess
from builtins import print as bi_print
from lgs_misc_jsonconfig import read as readjson
from lgs_misc_jsonconfig import write as writejson

langlist = {"en": "us",
            "ja": "jp"}

def add_arg(data, parser):
  for x in data:
    if len(x) == 1:
      parser.add_argument(x[0])
    elif isinstance(x, str):
      parser.add_argument(x)
    elif len(x) == 2:
      parser.add_argument(x[0], action='store_true')
    else:
      print(f"Failed .add_argument ({x})")
  
  return parser.parse_args()

def devcheck():
  if "--dev" in sys.argv:
    bi_print("Launching in Developing Mode")
    return True
  else:
    return False

dev = devcheck()

# print() のオーバーライド
def print(*args, end="\n"):
  if not dev:
    return
  bi_print("[dev]: ",end="")
  for x in args:
    bi_print(x, end="")
  bi_print("",end=end)

def launch():
  parser = argparse.ArgumentParser(description="parser")
  
  data = [
    ("--self", True),
    ("--use_cache", True),
    ("--dev", True)
  ]
  
  args = add_arg(data, parser)

  if args.use_cache:
    datedict = {"CACHE_LOADING": True} #cache_loader()
  else:
    datedict = {"CACHE_LOADING": False}
    
  

  def syntax_checker(object: str, type: str, accept: list, isbool: bool = False, mode: str = "Experimental"):
    if mode == "Stable" or not mode == "Experimental":
      ezbool = {"y": True, "n": False}
      
      if type == "lang":
        r = object.lower().strip()
        if r in ["en", "ja"]:
          return r
        else:
          print(f"SyntaxError: in 'lang'\nInput: {r}")
          return "en"
      elif type == "chl":
        r = object.lower().strip()
        if r in ["y", "n"]:
          return ezbool[r]
        else:
          print(f"SyntaxError: in 'chl'\nInput: {r}")
          return False
      elif type == "uppk":
        r = object.lower().strip()
        if r in ["y", "n"]:
          return ezbool[r]
        else:
          print(f"SyntaxError: in 'uppk'\nInput: {r}")
          return False
      elif type == "mcmeta_ver":
        r = object.lower().strip()
        if r == "auto":
          return r
        elif int(r) == int:
          if 5 < r:
            return r
        else:
          print(f"SyntaxErorr: in 'mcmeta_ver'\nInput: {r}")
    elif mode == "Experimental":
      ezbool = {"y": True, "n": False, "yes": True, "no": False}
      
      r = object.lower().strip()
      if not isbool and len(accept) == 0:
        return object
      
      if isbool:
        accept = ["y", "n", "yes", "no"]
      if r in accept:
        if isbool:
          return ezbool[r]
        else:
          return r
      else:
        print(f"SyntaxError: in `{type}`\nInput: {r}")
        if isbool:
          return False
        else:
          return accept[0]
  
  datedict["DONE"] = False
  
  bi_print("Rule: Only items in \"[]\" can be entered.\nルール: 質問への回答には\"[]\"の中の文字のみ入力してください")
  
  lang = syntax_checker(input(
    "Select Launguage / 言語の選択:  [en / ja]: "
  ), "lang", [], False, "Stable")
  lang = readjson(os.path.join(os.getcwd(), "lang", f"{lang}_{langlist[lang]}.json"))
  datedict["LANG"] = lang
  
  datedict["CACHE_LOADING"] = syntax_checker(input(
    lang["q001"]
  ), "chl", [], False, "Stable")
  
  if datedict["CACHE_LOADING"] and os.path.exists(os.path.join(os.getcwd(), "cache", "previous_answer.json")):
    return readjson(os.path.join(os.getcwd(), "cache", "previous_answer.json"))
  
  datedict["SCRIPT"] = "Latest"
  #syntax_checker(input(lang["q002"]), "")
  
  datedict["USE_PP"] = syntax_checker(input(
    lang["q003"]
  ), "uppk", [], False, "Stable")
  
  if datedict["USE_PP"]:
    datedict["PPPATH"] = syntax_checker(input(
      lang["q004"]
    ), "pppath", [])
    
    datedict["CHECK_UPDATE"] = syntax_checker(input(
      lang["q005"]
    ), "check_update", [], True)
      
  else:
    datedict["MCMETA_VER"] = syntax_checker(input(
      lang["q006"]
    ), "mcmeta_ver", [], False, "Stable")
  
  datedict["DONE"] = True
  os.makedirs(os.path.join(os.getcwd(), "cache"),exist_ok=True)
  writejson(datedict,
            os.path.join(os.getcwd(), "cache", "previous_answer.json"))
  bi_print(lang["q999"])
  return datedict


def launch_main(datedict):
  arg = ""
  
  lsc = datedict["LANG"]["sc"]
  script = datedict["SCRIPT"]
  upp = datedict["USE_PP"]
  
  if upp:
    ppp = datedict["PPPATH"]
    cu = datedict["CHECK_UPDATE"]
    arg += f"--use_previous_pack --pppath \"{ppp}\" "
    if cu:
      arg += "--check_update "
  else:
      mcmeta = datedict["MCMETA_VER"]
      arg += f"--mcmetaver {mcmeta} "
  
  if dev:
    arg += "--dev "
  
  arg += f"--lang {lsc} --script {script}"
  
  
  print(f"arg: {arg}")
  
  return f"python main.py {arg}"

def preprocessing():
  # とりあえず適当処理 で入れても損しない!
  subprocess.run("pip install -r requirements.txt")

if __name__ == "__main__":
  cmd = launch_main(launch())
  preprocessing()
  
  subprocess.Popen(cmd)