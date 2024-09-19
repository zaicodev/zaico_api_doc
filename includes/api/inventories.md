# Group 在庫データ

## 在庫データ一覧取得 [/api/v1/inventories]
### GET
#### 処理概要
* 自分のアカウントに登録されている在庫データのすべてを返します
* 在庫データが1件も無い場合は、空の配列を返します
* 棚卸日は設定されている場合のみ表示されます
* 発注点は設定されている場合のみ表示されます
* 在庫データが1000件以上ある場合はページネーションで分割され、1000件ごと在庫データを返します
* 任意のページを取得するにはURLにクエリ「page=」をつけることで取得できます。サンプルプログラムなど詳しくはこちらのページをご覧ください( https://www.zaico.co.jp/2019/03/29/zaico-api-update-get-inventories/ )
* ページ情報はHTTPヘッダ"Link"に最初のページ、前のページ、次のページ、最後のページそれぞれ,(カンマ)で区切られ返されます。最初のページでは「前のページ」、最後のページでは「次のページ」項目は表示されません
* Link, Total-Countヘッダは在庫一覧でのみ返されます
* 条件を指定して検索できます。検索できる項目は「title」、「category」、「place」、「code」と追加項目の5つです。検索する場合は以下のようにリクエストを送ってください。（下記の例は全部の項目に該当する在庫データを検索するものです。必要な項目のクエリを発行ください。）
  * 1つの項目に複数の値をいれて検索することはできません。
  * 「code(QRコード・バーコードの値)」は完全一致での検索となります。
  * 追加項目は一つだけ条件を指定することができ、また完全一致での検索となります。追加項目の検索はパラメータ「optional_attributes_name」に追加項目名を、「optional_attributes_value」に追加項目の値を指定してください。

  ```http
  Ref：
  https://web.zaico.co.jp/api/v1/inventories/?title={TITLE}&category={CATEGORY}&place={PLACE}&code={CODE}&optional_attributes_name={OPTIONAL_ATTRIBUTES_NAME}&optional_attributes_value={OPTIONAL_ATTRIBUTES_VALUE}
  例：
  https://web.zaico.co.jp/api/v1/inventories/?title=在庫データ&category=物品&place=ZAICO倉庫&code=123456789&optional_attributes_name=担当者&optional_attributes_value=宮下
  ```
  
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
* 棚卸日はstocktake_attributes: { checked_at: 日付 }で登録・変更が可能です
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
* 棚卸日は設定されている場合のみ表示されます
* 発注点は設定されている場合のみ表示されます

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
* 棚卸日はstocktake_attributes: { checked_at: 日付 }で登録・変更が可能です
* 発注点を設定することも可能です
* ユーザーグループが未指定または空の場合は場合は更新しません

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
+ group_tag: `グループタグ` (string) - グループタグ（フルプランのみ）
+ user_group: `ユーザーグループ` (string) - ユーザーグループ(カンマ区切りで複数指定可)
+ code: `tw201800000000` (string) - バーコードの値
+ item_image: `base64-encoded-image` (string)
+ stocktake_attributes
  + checked_at: `2018-03-27T09:38:19+09:00` (string) - 棚卸日
+ optional_attributes (array[object],fixed-type)
  + (object)
    + name: `追加項目名` (string) - 追加項目名
    + value: `追加項目値` (string) - 追加項目値
+ quantity_management_attributes
  + order_point_quantity: 5 (number) - 発注点
+ inventory_history
  + memo: `変更履歴メモ` (string) - 変更履歴のメモ
+ is_quantity_auto_conversion_by_unit: `1` (string) - 単位換算するかどうか。"1"なら単位換算する、"0"なら単位換算しない
+ quantity_auto_conversion_by_unit_name: `箱` (string) - 単位換算後の単位名
+ quantity_auto_conversion_by_unit_factor: `12` (string) - 単位換算係数

### InventoriesViews
+ id: 1 (number) - ID
+ title: `在庫データ` (string) - 在庫データタイトル
+ quantity: 10 (number) - 数量
+ logical_quantity: 10 (number) - 予定フリー在庫数（フルプランのみ）
+ unit: `個` (string) - 単位
+ category: `製品` (string) - カテゴリ
+ state: `新品` (string) - 状態
+ place: `ZAICO倉庫` (string) - 保管場所
+ etc: `備考` (string) - 備考
+ group_tag: `グループタグ` (string) - グループタグ（フルプランのみ）
+ code: `tw201800000000` (string) - バーコードの値
+ item_image (object)
  + url: `itemimageurl` (string) - 画像URL
+ stocktake_attributes
  + checked_at: `2018-03-27T09:38:19+09:00` (string) - 棚卸日
+ optional_attributes (array[object],fixed-type)
  + (object)
    + name: `追加項目名` (string) - 追加項目名
    + value: `追加項目値` (string) - 追加項目値
+ quantity_management_attributes
  + order_point_quantity: 5 (number) - 発注点
+ created_at: `2018-03-27T09:38:19+09:00` (string) - 作成日
+ updated_at `2018-03-27T09:38:19+09:00` (string) - 更新日
+ create_user_name: `田村 太郎` (string) - 作成者
+ update_user_name: `田村 次郎` (string) - 更新者
+ user_group: `基本グループ` (string) - ユーザーグループ
+ is_quantity_auto_conversion_by_unit: `1` (string) - 単位換算するかどうか。"1"なら単位換算する、"0"なら単位換算しない
+ quantity_auto_conversion_by_unit_name: `箱` (string) - 単位換算後の単位名
+ quantity_auto_conversion_by_unit_factor: `12` (string) - 単位換算係数
+ attachments
  + (object)
    + id: `1` (number) - 写真・ファイルのID
    + original_filename: `image.jpg` (string) - ファイル名
    + url: `https://web.zaico.co.jp/files/image.jpg` (string) - ファイルのURL
    + created_at: `2022-01-01 09:00:00` (string) - 作成日時

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

