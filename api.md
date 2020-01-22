FORMAT: 1A
HOST: https://web.zaico.co.jp
 
# ZAICO API Document
このドキュメントはZAICO APIの機能と使うために必要なパラメータなどを説明するものです。

# Group 認証
## 認証について
### GET
#### 概要
ZAICO APIは認証にBearerトークン認証を採用しています。
リクエストを送る際、HTTPヘッダにAuthorization: Bearerをつけてください。

```http
Authorization: Bearer YOUR_TOKEN_HERE
```


# Group 在庫データ

## 在庫データ一覧取得 [/api/v1/inventories]
### GET
#### 処理概要
  * 自分のアカウントに登録されている在庫データのすべてを返します
  * 在庫データが1件も無い場合は、空の配列を返します
  * 棚卸し日は設定されている場合のみ表示されます
  * 発注点は設定されている場合のみ表示されます
  * 在庫データが1000件以上ある場合はページネーションで分割され、1000件ごと在庫データを返します
  * 任意のページを取得するにはURLにクエリ「page=」をつけることで取得できます。サンプルプログラムなど詳しくはこちらのページをご覧ください( https://www.zaico.co.jp/2019/03/29/zaico-api-update-get-inventories/ )
  * ページ情報はHTTPヘッダ"Link"に最初のページ、前のページ、次のページ、最後のページそれぞれ,(カンマ)で区切られ返されます。最初のページでは「前のページ」、最後のページでは「次のページ」項目は表示されません
  * Link, Total-Countヘッダは在庫一覧でのみ返されます
  + Request
    + Headers
      Authorization: Bearer YOUR_TOKEN
      Content-Type: application/json

  + Response 200 (application/json)
    + Headers
      Link: <https://web.zaico.co.jp/api/v1/inventories?page=1>; rel="first", <https://web.zaico.co.jp/api/v1/inventories?page=前のページ>; rel="prev", <https://web.zaico.co.jp/api/v1/inventories?page=次のページ>; rel="next", <https://web.zaico.co.jp/api/v1/inventories?page=最後のページ>; rel="last"
      Total-Count: 在庫データ件数
    + Attributes (InventoriesViews)



## 在庫データ作成 [/api/v1/inventories]
### POST
#### 処理概要
  * 在庫データを作成します

#### 注意事項
  * タイトルのみあれば作成可能です
  * 画像もつけてデータを作成する場合は、画像をbase64エンコードして送ってください
  * 送られたパラメータにタイトルが無い場合やデータが無い場合はエラーを返します
  * パースできないJSONを送るとエラーを返します
  * 存在しないユーザーグループを送るとエラーを返します
  * 変更履歴のメモも一緒に保存することが可能です。詳しくは下記Bodyをご覧ください
  * 棚卸し日はstocktake_attributes: { checked_at: 日付 }で登録・変更が可能です
  * 発注点を設定することも可能です

+ Request
  + Headers
    Authorization: Bearer YOUR_TOKEN
    Content-Type: application/json

  + Params
    + Attributes (InventoryCreateParams)

+ Response 200 (application/json)
  + Attributes (InventoryCreateSuccessfully)

+ Response 400 (application/json)
  + Attributes (BadRequestNoData)

+ Response 406 (application/json)
  + Attributes (UserGroupNotExist)



## 在庫データ個別取得 [/api/v1/inventories/{id}]
### GET
#### 処理概要
 * 在庫データを1件のみ取得します
 * 棚卸し日は設定されている場合のみ表示されます
 * 発注点は設定されている場合のみ表示されます
 * 在庫データが1000件以上ある場合はページネーションで分割され、1000件ごと在庫データを返します

### 注意事項
  * 在庫データが無い場合は404を返します

+ Parameters
  + id: 1 (number, required) - 在庫データのID

+ Request
  + Headers
    Authorization: Bearer YOUR_TOKEN
    Content-Type: application/json

+ Response 200 (application/json)
  + Attributes (InventoriesViews)

+ Response 404 (application/json)
  + Attributes (InventoryNotFound)



## 在庫データ更新 [/api/v1/inventories/{id}]
### PUT
#### 処理概要
  * 特定の在庫データを更新します

#### 注意事項
  * タイトルのみあれば作成可能です
  * 画像もつけてデータを作成する場合は、画像をbase64エンコードして送ってください
  * 該当する在庫データが無い場合はエラーを返します
  * パースできないJSONを送るとエラーを返します
  * 存在しないユーザーグループを送るとエラーを返します
  * 変更履歴のメモも一緒に保存することが可能です。詳しくは下記Bodyをご覧ください
  * 棚卸し日はstocktake_attributes: { checked_at: 日付 }で登録・変更が可能です
  * 発注点を設定することも可能です

+ Parameters
  + id: 1 (number, required) - 在庫データのID

+ Request
  + Headers
    Authorization: Bearer YOUR_TOKEN
    Content-Type: application/json

  + Params
    + Attributes (InventoryCreateParams)

+ Response 200 (application/json)
  + Attributes (InventoryUpdateSuccessfully)

+ Response 400 (application/json)
  + Attributes (BadRequestNoData)

+ Response 404 (application/json)
  + Attributes (InventoryNotFound)

+ Response 406 (application/json)
  + Attributes (UserGroupNotExist)


## 在庫データ削除 [/api/v1/inventories/{id}]
### DELETE
#### 処理概要
  * 特定の在庫データを削除します

#### 注意事項
  * 該当する在庫データが無い場合はエラーを返します

+ Parameters
  + id: 1 (number, required) - 在庫データのID

+ Request
  + Headers
    Authorization: Bearer YOUR_TOKEN
    Content-Type: application/json

+ Response 200 (application/json)
  + Attributes (InventoryDeleteSuccessfully)

+ Response 404 (application/json)
  + Attributes (InventoryNotFound)
  

## Data Structures
### InventoryCreateSuccessfully
  + code: 200 (number) - ステータスコード
  + status: `success` (string) - 状態
  + message: `Data was successfully created.` (string) - メッセージ
  + data_id: `123456` (number) - 作成した在庫データのID

### InventoryUpdateSuccessfully
  + code: 200 (number) - ステータスコード
  + status: `success` (string) - 状態
  + message: `Data was successfully updated.` (string) - メッセージ

### InventoryDeleteSuccessfully
  + code: 200 (number) - ステータスコード
  + status: `success` (string) - 状態
  + message: `Data was successfully deleted.` (string) - メッセージ

### InventoryCreateParams
+ title: `在庫データ` (string, required) - 在庫データタイトル
+ quantity: 10 (number) - 数量
+ unit: `個` (string) - 単位
+ category: `製品` (string) - カテゴリ
+ state: `新品` (string) - 状態
+ place: `ZAICO倉庫` (string) - 保管場所
+ etc: `備考` (string) - 備考
+ code: `tw201800000000` (string) - バーコードの値
+ item_image: `base64-encoded-image` (string)
+ stocktake_attributes
  + checked_at: `2018-03-27T09:38:19+09:00` (string) - 棚卸し日
+ optional_attributes (array[object],fixed-type)
  + (object)
      + name: `追加項目名` (string) - 追加項目名
      + value: `追加項目値` (string) - 追加項目値
+ quantity_management_attributes (array[object], fixed-type)
  + (object)
      + order_point_quantity: 5 (number) - 発注点
+ inventory_history
  + (object)
    + memo: `変更履歴メモ` (string) - 変更履歴のメモ

### InventoriesViews
+ id: 1 (number) - ID
+ title: `在庫データ` (string) - 在庫データタイトル
+ quantity: 10 (number) - 数量
+ unit: `個` (string) - 単位
+ category: `製品` (string) - カテゴリ
+ state: `新品` (string) - 状態
+ place: `ZAICO倉庫` (string) - 保管場所
+ etc: `備考` (string) - 備考
+ code: `tw201800000000` (string) - バーコードの値
+ item_image (object)
  + url: `itemimageurl` (string) - 画像URL
+ stocktake_attributes
  + checked_at: `2018-03-27T09:38:19+09:00` (string) - 棚卸し日
+ optional_attributes (array[object],fixed-type)
  + (object)
      + name: `追加項目名` (string) - 追加項目名
      + value: `追加項目値` (string) - 追加項目値
+ quantity_management_attributes (array[object], fixed-type)
  + (object)
      + order_point_quantity: 5 (number) - 発注点
+ created_at: `2018-03-27T09:38:19+09:00` (string) - 作成日
+ updated_at `2018-03-27T09:38:19+09:00` (string) - 更新日
+ create_user_name: `田村 太郎` (string) - 作成者
+ update_user_name: `田村 次郎` (string) - 更新者
+ user_group: `基本グループ` (string) - ユーザーグループ

### InventoryNotFound
+ code: 404 ( number ) - ステータスコード
+ status: `error` ( string ) - ステータス
+ message: `Inventory not found` ( string ) - エラー内容

### BadRequestNoData
+ code: 400 ( number ) - ステータスコード
+ status: `error` ( string ) - ステータス
+ message: `error message` ( string ) - エラー内容

### UserGroupNotExist
+ code: 406 ( number ) - ステータスコード
+ status: `error` ( string ) - ステータス
+ message: `UserGroup is NOT exist` ( string ) - エラー内容

### UnprocessableEntity
+ code: 422 ( number ) - ステータスコード
+ status: `error` ( string ) - ステータス
+ message: `error message` ( string ) - エラー内容

### InternalServerErrorResponse
+ code: 503 ( number ) - ステータスコード
+ status: `error` ( string ) - ステータス
+ message: `error message` ( string ) - エラー内容

