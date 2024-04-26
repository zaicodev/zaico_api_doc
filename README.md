# クラウド在庫管理ソフトZAICOのAPIドキュメント

https://zaicodev.github.io/zaico_api_doc/

## 必要な設定

api.mdを編集してHTMLに変換するときは「aglio」を使います。
そのため最初だけこの操作を行ってください。

1. Node.jsをインストール https://nodejs.org/ja/
2. nodeのバージョンを`16.20.1`にする（`nvm use v16.20.1; node -v`）
3. `node --version`
4. `yarn` を実行

## 開発（変更の自動検知）

`yarn dev`

http://localhost:3005/

## ビルド（HTMLに変換）

HTMLに変換するときは `yarn build` を実行してください。`dist/index.html` に出力されます。

## ドキュメントの公開について

Github Actionsを使って公開しています。
masterブランチにコミットがあったときに、自動的にデプロイされます。
