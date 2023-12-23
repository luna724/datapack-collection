## クリエイターツール生成器
`右クリックするとコマンドを実行` という動作を行える瓶を作るツール


## 使用方法
`launch.bat` ファイルを実行 <br>
その後 値を渡し`Running on local URL:  http://127.0.0.1:34567` 
が表示されたら接続する。 <br >

<details><summary> その他の実行方法 </summary>

- MacOS(x) など バッチファイルが実行できない場合

```sh
python launch.py
```

と実行するだけで同じ動作が可能 <br>


`launch.py` を実行し事前準備を行う <br>
その後 `launch.py` を参考に設定を引数に渡し、`main.py` を実行 <br>

実行例 (初回実行や新規生成):
```sh
python launch.py --self
# output> Done.

python main.py --script Latest --mcmetaver auto --lang en
```

実行例2 (すでに生成済みのものに機能を追加)
```sh
python launch.py --self
# output> Done.

python main.py --script Latest --use_previous_pack --pppath /previous_datapack_path_is_here --check_update --lang en
```

実行例3 (アップデートのみ)
```sh
python launch.py --self
# output> Done.

python main.py --script Latest --only_update --use_previous_pack --pppath /previous_datapack_path_is_here --lang en
```

</details>

[Database.json に関する情報](./about.md)

## 要求環境

Python 3.9以上 (推奨 3.10.9) <br>


## 早見表

| Name | Luna's Creator Tool / Jar Generator |
| --- | --- |
| Compatibility MCVer | 1.16 ~ |
| Setting Trigger | luna_ctGen_toggle_feature |
| Available lang | en-us / ja-jp |
| License | MIT |
| DP-ID | None |