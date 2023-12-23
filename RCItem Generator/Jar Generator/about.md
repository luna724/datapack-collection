## About for Database.json

<details> <summary> 日本語版 / ja-jp </summary>

| キー | 説明 | 記入方式 | 入力可能変数 | 予測されるエラー |
| --- | --- | --- | --- | --- |
| pack_number | pack.mcmetaの変数 `--mcmeta auto` が渡された際に使用される | [有効なpack_number](https://minecraft.wiki/w/Data_pack#pack.mcmeta) | 整数値 | マインクラフト> `Made for an (older / newer) version of minecraft` |
| pack_mcmeta | `pack.mcmeta`のベース `pack.mcmeta` のカスタマイズが可能 | [pack.mcmeta](https://misode.github.io/pack-mcmeta/) | 文字列 | マインクラフトがデータパックと認識しない |
| datapack_nemspace | データパックの名前空間を指定 | [a-z0-9_.] | 文字列 | データパックを読み込めない |
| tick | `data/namespace/functions` からの相対パスで tick.mcfunction の位置を指定 | 相対パス (osモジュールで読み取り可能な) | 文字列 | データパックの予期せぬ動作 (tick.mcfunctionの消失) |
| load | `data/namespace/functions` からの相対パスで load.mcfunction の位置を指定 | 相対パス (osモジュールで読み取り可能な) | 文字列 | データパックの読みせぬ動作 (load.mcfunctionの消失) |
| reset | `data/namespace/functions` からの相対パスで reset.mcfunction の位置を指定 | 相対パス (osモジュールで読み取り可能な) | 文字列 | 設定リセット機能の消失 |
| settings | `data/namespace/functions` からの相対パスで 設定関係のルートパスを指定 | 相対パス (osモジュールで読み取り可能な) | 文字列 | 設定機能の予期せぬ動作 |
| main_code | `data/namespace/functions` からの相対パスで メインコード関係のルートパスを指定 | 相対パス (osモジュールで読み取り可能な) | 文字列 | メイン機能の予期せぬ動作 |
| activate_setting | 設定機能の有効化 | - | boolean | 特になし |
| code | `Jar Generator/code` からの相対パスで キーに応じた位置への基礎コードのパスを指定 | 相対パス (osモジュールで読み取り可能な) | 辞書 | FileNotFoundError |
| jar_code / アイテム名 / checker_basic | アイテム名に応じた 対象チェックの基礎コードのパスを指定 (`Jar Generator/code`からの相対パス) | 相対パス (osモジュールで読み取り可能な) | 文字列 | メイン機能の予期せぬ動作 |
| jar_code / アイテム名 / checker_template_code | アイテム名に応じた 対象チェックのテンプレコード | マインクラフトコマンド | 文字列 | メイン機能の予期せぬ動作 |
| have_mcload_tick | `data/minecraft/tags/functions/` `tick.json / load.json` の実装 | - | boolean | false にした場合、拡張機能でも作らない限り動作しない (仕様) |
| mctf | `MineCraft/Tags/Functions` の略で tick.json / load.json の基礎コードの設定 | json記入式 | 辞書 | mctfに対する問題 have_mcload_tick を false にした際の問題が発生する可能性 |
| output_to | データパックの出力先 for x in THIS で os.path.join に渡される | `Jar Generator` からの相対パスを os.path.join() の形式 | List | 特になし |
| kill_potion | ポーションを投げた際に着地前にキルを行う | - | boolean | 特になし |
| ui / disable_function_loader | Function Loader の無効化 | - | boolean | 特になし |
| code_variable | Python コードにて重要な共有変数 | - | 辞書 | 予期せぬ動作 |

</details>

| Key | desc | syntax | inputtable variable pattern |
| --- | --- | --- | --- |
| in | pre | para | tion |
| pack_number | variable of `pack.mcmeta` using in if passed `--mcmeta auto` (in argment) | - | integer | Minecraft> `Made for an (older / newer) version of minecraft` |
| pack_mcmeta | - | [pack.mcmeta](https://misode.github.io/pack-mcmeta/) | String | Minecraft is can't readable this datapack |
| datapack_namespace | - | [a-z0-9_.] | String | canno't load Datapack |
| tick | - | relative path (can readable for os module) | String | 
| coming soon! | | | |
