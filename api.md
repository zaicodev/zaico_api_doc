FORMAT: 1A
HOST: https://web.zaico.co.jp

# ZAICO API Document
このドキュメントはZAICO APIの機能と使うために必要なパラメータなどを説明するものです。
2020年10月6日更新

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
  * 在庫一覧画面でのみ在庫データを検索できます。検索できる項目は「title」、「category」、「place」、「code」の4つです。検索する場合は以下のようにリクエストを送ってください。（下記の例は全部の項目に該当する在庫データを検索するものです。必要な項目のクエリを発行ください。）
    * 【注意】1つの項目に複数の値をいれて検索することはできません。
    * 【注意】「code(QRコード・バーコードの値)」のみ完全一致での検索となります。
  ```http
  Ref：
  https://web.zaico.co.jp/api/v1/inventories/?title={TITLE}&category={CATEGORY}&place={PLACE}&code={CODE}
  例：
  https://web.zaico.co.jp/api/v1/inventories/?title=在庫データ&category=物品&place=ZAICO倉庫&code=123456789
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
+ user_group: `ユーザーグループ` (string) - ユーザーグループ(カンマ区切りで複数指定可)
+ code: `tw201800000000` (string) - バーコードの値
+ item_image: `base64-encoded-image` (string)
+ stocktake_attributes
  + checked_at: `2018-03-27T09:38:19+09:00` (string) - 棚卸し日
+ optional_attributes (array[object],fixed-type)
  + (object)
      + name: `追加項目名` (string) - 追加項目名
      + value: `追加項目値` (string) - 追加項目値
+ quantity_management_attributes
    + order_point_quantity: 5 (number) - 発注点
+ inventory_history
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
+ quantity_management_attributes
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


# Group 納品データ

## 納品データ一覧取得 [/api/v1/packing_slips/]
### 納品データ一覧取得 [GET]
#### 処理概要
* 自分のアカウントに登録されている納品データのすべてを返します
* 納品データが1件も無い場合は、空の配列を返します
* 納品データが1000件以上ある場合はページネーションで分割され、1000件ごと納品データを返します
* 任意のページを取得するにはURLにクエリ「page=」をつけることで取得できます。
* ページ情報はHTTPヘッダ"Link"に最初のページ、前のページ、次のページ、最後のページそれぞれ,(カンマ)で区切られ返されます。最初のページでは「前のページ」、最後のページでは「次のページ」項目は表示されません
* Link, Total-Countヘッダは納品一覧でのみ返されます
* 各納品データの項目について以下のようになります
  * id : 納品データID
  * num : 納品データ番号（ユーザーが任意に設定できる番号）
  * customer_name : 取引先名
  * status : 納品データの状態
    * 以下の2つのどちらかが設定されています
    * before_delivery : 納品前
    * completed_delivery : 納品済み
  * total_amount : 納品データの合計金額
  * delivery_date : 納品日
  * estimated_delivery_date : 納品予定日
    * この納品予定日は納品データの物品のうち、最も早い納品予定日を表示します
  * created_at : 納品データ作成日
  * updated_at : 納品データ更新日
  * deliveries : 納品データに登録している在庫データ一覧
    * inventory_id : 在庫データID
    * title : 物品名
    * quantity : 納品数量
    * unit : 単位
    * unit_price : 納品単価
    * status : 状態
      * 以下の2つのどちらかが設定されています
      * before_delivery : 納品前
      * completed_delivery : 納品済み
    * delivery_date : 納品日
    * estimated_delivery_date : 納品予定日
    * etc : 摘要・備考

+ Request
    + Headers

            Authorization: Bearer YOUR_TOKEN
            Content-Type: application/json

+ Response 200 (application/json)
    + Attributes (array)
        + ()
            + id: 10 (number)
            + num: 100 (string)
            + customer_name: 株式会社ZAICO (string) - 取引先名
            + status: `completed_delivery` (string) - 状態
            + total_amount: 1000 (number)
            + delivery_date: `2019-09-01` (string) - 納品日
            + estimated_delivery_date (string, optional, nullable)
            + created_at: `2018-03-27T09:38:19+09:00`
            + updated_at: `2018-03-27T09:38:19+09:00`
            + deliveries (array[object], fixed-type)
                + (object)
                    + inventory_id: 1 (number)
                    + title: 掃除機 (string) - 物品名
                    + quantity: 3 (number) - 納品数量
                    + unit: 台 (string) - 単位
                    + unit_price: 100 (number) - 納品単価
                    + status: completed_delivery (string)
                    + delivery_date: `2019-09-01` (string)
                    + estimated_delivery_date (string, optional, nullable)
                    + etc: 黒色 (string) - 摘要・備考
                + (object)
                    + inventory_id: 2 (number)
                    + title: テレビ (string) - 物品名
                    + quantity: 3 (number) - 納品数量
                    + unit: 台 (string) - 単位
                    + unit_price: 100 (number) - 納品単価
                    + status: completed_delivery (string)
                    + delivery_date: `2019-09-01` (string)
                    + estimated_delivery_date (string, optional, nullable)
                    + etc: (string) - 摘要・備考
        + ()
            + id: 11 (number)
            + num: 1001 (string)
            + customer_name: 株式会社ZAICO (string) - 取引先名
            + status: `before_delivery` (string) - 状態
            + total_amount: 1000 (number)
            + delivery_date: `2019-09-01` (string) - 納品日
            + estimated_delivery_date: `2019-09-01` (string) - 納品予定日
            + created_at: `2018-03-27T09:38:19+09:00`
            + updated_at: `2018-03-27T09:38:19+09:00`
            + deliveries (array[object], fixed-type)
                + (object)
                    + inventory_id: 5 (number)
                    + title: 掃除機 (string) - 物品名
                    + quantity: 3 (number) - 納品数量
                    + unit: 台 (string) - 単位
                    + unit_price: 100 (number) - 納品単価
                    + status: completed_delivery
                    + delivery_date: `2019-09-01`
                    + estimated_delivery_date: `2019-09-01` (string, optional, nullable)
                    + etc: (string) - 摘要・備考


## 納品データ作成 [/api/v1/packing_slips/]
### 納品データ作成 [POST]
#### 処理概要

* 納品データを作成します
* パースできないJSONを送るとエラーを返します
* 登録できる項目について
    * num : 納品データ番号（ユーザーが任意に設定できる番号）
    * customer_name : 取引先名
    * status : 納品データの状態
        * 以下の2つのどちらかを指定してください
        * 納品前の場合は before_delivery
        * 納品済みの場合は completed_delivery
        * **納品済みを指定した場合は、対象の在庫データの数量を減少します**
    * delivery_date : 納品日
        * statusによって必須かどうか変わります
        * status=completed_delivery
            * delivery_dateが必須
        * status=before_delivery
            * delivery_dateは不要
    * deliveries : 対象となる在庫データの配列
        * 以下のパラメータを含むオブジェクトを配列の要素とします
            * inventory_id : 在庫データID
            * quantity : 納品数量
            * unit_price : 納品単価
            * estimated_delivery_date : 納品予定日
            * etc : 摘要・備考

+ Request
    + Headers

            Authorization: Bearer YOUR_TOKEN
            Content-Type: application/json

    + Attributes
        + num: 100 (string, optional) - 納品データ番号（ユーザーが任意に設定できる番号）
        + customer_name: 株式会社ZAICO (string, optional) - 取引先名
        + status: `completed_delivery` (string, required) - 状態
        + delivery_date: `2019-09-01` (string) - 納品日
        + deliveries (array[CreateDelivery], required)

+ Response 200 (application/json)
    + Attributes
        + code: 200 (number) - ステータスコード
        + status: success (string) - 状態
        + message: Data was successfully created. (string) - メッセージ
        + data_id: 12345 (number) - 作成した納品データID

+ Response 422 (application/json)
    + Attributes
        + code: 422 (number) - ステータスコード
        + status: error (string) - 状態
        + message: Invalid data. (string) - メッセージ


## 納品データ個別取得 [/api/v1/packing_slips/{id}]
### 納品データ個別取得 [GET]
#### 処理概要

* 納品データを1件のみ取得します
* 納品データの項目について以下のようになります
  * id : 納品データID
  * num : 納品データ番号（ユーザーが任意に設定できる番号）
  * customer_name : 取引先名
  * status : 納品データの状態
    * 以下の2つのどちらかが設定されています
    * before_delivery : 納品前
    * completed_delivery : 納品済み
  * total_amount : 納品データの合計金額
  * delivery_date : 納品日
  * estimated_delivery_date : 納品予定日
    * この納品予定日は納品データの物品のうち、最も早い納品予定日を表示します
  * created_at : 納品データ作成日
  * updated_at : 納品データ更新日
  * deliveries : 納品データに登録している在庫データ一覧
    * inventory_id : 在庫データID
    * title : 物品名
    * quantity : 納品数量
    * unit : 単位
    * unit_price : 納品単価
    * status : 状態
      * 以下の2つのどちらかが設定されています
      * before_delivery : 納品前
      * completed_delivery : 納品済み
    * delivery_date : 納品日
    * estimated_delivery_date : 納品予定日
    * etc: 摘要・備考

+ Parameters
    + id: 1 (number) - 納品データのID

+ Request
    + Headers

            Authorization: Bearer YOUR_TOKEN
            Content-Type: application/json

+ Response 200 (application/json)
    + Attributes
        + id: 10 (number)
        + num: 100 (string)
        + customer_name: 株式会社ZAICO (string) - 取引先名
        + status: `completed_delivery` (string) - 状態
        + total_amount: 1000 (number)
        + delivery_date: `2019-09-01` (string) - 納品日
        + estimated_delivery_date: `2019-09-01` (string) - 納品日
        + created_at: `2018-03-27T09:38:19+09:00`
        + updated_at: `2018-03-27T09:38:19+09:00`
            + deliveries (array[object], fixed-type)
                + (object)
                    + inventory_id: 1 (number)
                    + title: 掃除機 (string) - 物品名
                    + quantity: 3 (number) - 納品数量
                    + unit: 台 (string) - 単位
                    + unit_price: 100 (number) - 納品単価
                    + status: completed_delivery (string)
                    + delivery_date: `2019-09-01` (string)
                    + estimated_delivery_date (string, optional, nullable)
                    + etc: 白色 (string) - 摘要・備考
                + (object)
                    + inventory_id: 2 (number)
                    + title: テレビ (string) - 物品名
                    + quantity: 3 (number) - 納品数量
                    + unit: 台 (string) - 単位
                    + unit_price: 100 (number) - 納品単価
                    + status: completed_delivery (string)
                    + delivery_date: `2019-09-01` (string)
                    + estimated_delivery_date: `2019-09-01` (string, optional, nullable)
                    + etc: (string) - 摘要・備考

## 納品データ更新 [/api/v1/packing_slips/{id}]
### 納品データ更新 [PUT]
#### 処理概要

* 納品データを更新します
* パースできないJSONを送るとエラーを返します
* 項目について
    * num : 納品データ番号（ユーザーが任意に設定できる番号）
    * customer_name : 取引先名
    * deliveries : 対象となる在庫データの配列
        * 以下のパラメータを含むオブジェクトを配列の要素とします
            * inventory_id : 在庫データID
                * 在庫データIDは対象の物品を特定するために指定するため、これを更新することはできません
            * quantity : 納品数量
            * unit_price : 納品単価
            * status : 状態
                * 納品前在庫を更新するときは before_delivery または completed_delivery を指定できます
                納品前在庫を納品済みに更新すると **対象の在庫データの数量を減少します**
                * 納品済み在庫の状態を更新することはできません
            * delivery_date : 納品日
            * estimated_delivery_date : 納品予定日
            * etc : 摘要・備考

+ Parameters
    + id: 1 (number) - 納品データのID

+ Request
    + Headers

            Authorization: Bearer YOUR_TOKEN
            Content-Type: application/json

    + Attributes
        + num: 100 (string, optional) - 納品データ番号（ユーザーが任意に設定できる番号）
        + customer_name: 株式会社ZAICO (string, optional) - 取引先名
        + deliveries (array[UpdateDeliveryToCompleted, UpdateDeliveryToBefore], required)

+ Response 200 (application/json)
    + Attributes
        + code: 200 (number) - ステータスコード
        + status: success (string) - 状態
        + message: Data was successfully created. (string) - メッセージ
        + data_id: 12345 (number) - 作成した納品データID

+ Response 422 (application/json)
    + Attributes
        + code: 422 (number) - ステータスコード
        + status: error (string) - 状態
        + message: Invalid data. (string) - メッセージ



## 納品データ削除 [/api/v1/packing_slips/{id}]
### 納品データ削除 [DELETE]
#### 処理概要

* 特定の納品データを削除します
* 納品データの各物品の状態によって在庫データの取り扱いが変わります
    * 納品前：変化なし
    * 納品済み：在庫データの数量を納品数量分だけ戻します

+ Parameters
    + id: 1 (number) - 納品データのID

+ Request
    + Headers

            Authorization: Bearer YOUR_TOKEN
            Content-Type: application/json

+ Response 200 (application/json)
    + Attributes
        + code: 200 (number) - ステータスコード
        + status: success (string) - 状態
        + message: Data was successfully deleted (string) - メッセージ

+ Response 404 (application/json)
    + Attributes
        + code: 404 (number) - ステータスコード
        + status: error (string) - 状態
        + message: Packing slip not found (string) - メッセージ

# Group 仕入データ

HOST: https://web.zaico.co.jp/

## 仕入データ一覧取得 [/api/v1/purchases/]
### 仕入データ一覧取得 [GET]
#### 処理概要

* 自分のアカウントに登録されている仕入データのすべてを返します
* 仕入データが1件も無い場合は、空の配列を返します
* 仕入データが1000件以上ある場合はページネーションで分割され、1000件ごと仕入データを返します
* 任意のページを取得するにはURLにクエリ「page=」をつけることで取得できます
* ページ情報はHTTPヘッダ"Link"に最初のページ、前のページ、次のページ、最後のページそれぞれ,(カンマ)で区切られ返されます。最初のページでは「前のページ」、最後のページでは「次のページ」項目は表示されません
* Link, Total-Countヘッダは仕入一覧でのみ返されます
* 各仕入データの項目について以下のようになります
  * id : 仕入データID
  * num : 仕入データ番号（ユーザーが任意に設定できる番号）
  * customer_name : 取引先名
  * status : 仕入データの状態
    * 以下の3つのいずれかが設定されています
    * not_ordered : 発注前
    * ordered : 発注済み
    * purchased : 仕入済み
  * total_amount : 仕入データの合計金額
  * purchase_date: 仕入日
  * estimated_purchase_date　: 仕入予定日
  * create_user_name : 仕入データ作成者名
  * created_at : 仕入データ作成日
  * updated_at : 仕入データ更新日
  * purchase_items : 仕入データに登録している在庫データ一覧
    * inventory_id : 在庫データID
    * title : 物品名
    * quantity : 仕入数量
    * unit : 単位
    * unit_price : 仕入単価
    * status : 状態
        * 以下の3つのいずれかが設定されています
        * not_ordered : 発注前
        * ordered : 発注済み
        * purchased : 仕入済み
    * purchase_date: 仕入日
    * estimated_purchase_date　: 仕入予定日

+ Request
    + Headers

            Authorization: Bearer YOUR_TOKEN
            Content-Type: application/json

+ Response 200 (application/json)
    + Attributes (array)
        + ()
            + id: 10 (number)
            + num: 100 (string)
            + customer_name: 株式会社ZAICO (string) - 取引先名
            + status: `ordered` (string) - 状態
            + total_amount: 1000 (number)
            + purchase_date: null (string) - 仕入日
            + estimated_purchase_date: `2020-01-01` (string) - 仕入予定日
            + create_user_name: 在庫太郎 (string) - 仕入データ作成者名
            + created_at: `2019-12-27T09:38:19+09:00`
            + updated_at: `2019-12-27T09:38:19+09:00`
            + purchase_items (array)
                + ()
                    + inventory_id: 1
                    + title: 掃除機 (string) - 物品名
                    + quantity: 3 (string) - 仕入数量
                    + unit: 台 (string) - 単位
                    + unit_price: 100 (string) - 仕入単価
                    + status: ordered (string)
                    + purchase_date: null (string)
                    + estimated_purchase_date: `2020-01-01` (string)
                + ()
                    + inventory_id: 1
                    + title: 掃除機 (string) - 物品名
                    + quantity: 3 (string) - 仕入数量
                    + unit: 台 (string) - 単位
                    + unit_price: 100 (string) - 仕入単価
                    + status: ordered (string)
                    + purchase_date: null (string)
                    + estimated_purchase_date: `2020-01-01` (string)
        + ()
            + id: 11 (number)
            + num: 1001 (string)
            + customer_name: 株式会社ZAICO (string) - 取引先名
            + status: `purchased` (string) - 状態
            + total_amount: 1000 (number)
            + purchase_date: `2020-01-01` (string) - 仕入日
            + estimated_purchase_date: null (string) - 仕入予定日
            + create_user_name: 在庫太郎 (string) - 仕入データ作成者名
            + created_at: `2019-12-27T09:38:19+09:00`
            + updated_at: `2019-12-27T09:38:19+09:00`
            + purchase_items (array)
                + ()
                    + inventory_id: 5
                    + title: 掃除機 (string) - 物品名
                    + quantity: 3 (string) - 仕入数量
                    + unit: 台 (string) - 単位
                    + unit_price: 100 (string) - 仕入単価
                    + status: purchased
                    + purchase_date: `2020-01-01`
                    + estimated_purchase_date: null


## 仕入データ作成 [/api/v1/purchases/]
### 仕入データ作成 [POST]
#### 処理概要

* 仕入データを作成します
* パースできないJSONを送るとエラーを返します
* 登録できる項目について
    * num : 仕入データ番号（ユーザーが任意に設定できる番号）
    * customer_name : 取引先名
    * status : 仕入データの状態
        * 以下の2つのどちらかを指定してください
        * 仕入前の場合は not_ordered
        * 仕入済みの場合は purchased
        * **仕入済みを指定した場合は、対象の在庫データの数量を増加します**
    * purchase_date : 仕入日
        * statusによって必須かどうか変わります
        * status=purchased
            * purcahse_dateが必須
        * status=not_ordered
            * purchase_dateは不要
    * purchase_items : 対象となる在庫データの配列
        * 以下のパラメータを含むオブジェクトを配列の要素とします
            * inventory_id : 在庫データID
            * quantity : 仕入数量
            * unit_price : 仕入単価
            * estimated_purchase_date : 仕入予定日
            * etc : 摘要・備考

+ Request
    + Headers

            Authorization: Bearer YOUR_TOKEN
            Content-Type: application/json

    + Attributes
        + num: 100 (string, optional) - 仕入データ番号（ユーザーが任意に設定できる番号）
        + customer_name: 株式会社ZAICO (string, optional) - 取引先名
        + status: `purchased` (string, required) - 状態
        + purchase_date: `2019-09-01` (string) - 仕入日
        + purchase_items (array[CreatePurchaseItem], required)

+ Response 200 (application/json)
    + Attributes
        + code: 200 (number) - ステータスコード
        + status: success (string) - 状態
        + message: Data was successfully created. (string) - メッセージ
        + data_id: 12345 (number) - 作成した仕入データID

+ Response 422 (application/json)
    + Attributes
        + code: 422 (number) - ステータスコード
        + status: error (string) - 状態
        + message: Invalid data. (string) - メッセージ


## 仕入データ個別取得 [/api/v1/purchases/{id}]
### 仕入データ個別取得 [GET]
#### 処理概要

* 仕入データを1件のみ取得します
* 仕入データの項目について以下のようになります
  * id : 仕入データID
  * num : 仕入データ番号（ユーザーが任意に設定できる番号）
  * customer_name : 取引先名
  * status : 仕入データの状態
    * 以下の3つのいずれかが設定されています
    * not_ordered : 発注前
    * ordered : 発注済み
    * purchased : 仕入済み
  * total_amount : 仕入データの合計金額
  * purchase_date : 仕入日
  * estimated_purchase_date : 仕入予定日
    * この仕入予定日は仕入データの物品のうち、最も早い仕入予定日を表示します
  * create_user_name : 仕入データ作成者名
  * created_at : 仕入データ作成日
  * updated_at : 仕入データ更新日
  * deliveries : 仕入データに登録している在庫データ一覧
    * inventory_id : 在庫データID
    * title : 物品名
    * quantity : 仕入数量
    * unit : 単位
    * unit_price : 仕入単価
    * status : 状態
        * 以下の3つのいずれかが設定されています
        * not_ordered : 発注前
        * ordered : 発注済み
        * purchased : 仕入済み
    * purchase_date : 仕入日
    * estimated_purchase_date : 仕入予定日
    * etc: 摘要・備考

+ Parameters
    + id: 10 (number) - 仕入データのID

+ Request
    + Headers

            Authorization: Bearer YOUR_TOKEN
            Content-Type: application/json

+ Response 200 (application/json)
    + Attributes
        + id: 10 (number)
        + num: 100 (string)
        + customer_name: 株式会社ZAICO (string) - 取引先名
        + status: `purchased` (string) - 状態
        + total_amount: 1000 (number)
        + purchase_date: null (string) - 仕入日
        + estimated_purchase_date: `2020-01-01` (string) - 仕入予定日
        + create_user_name: 在庫太郎 (string) - 仕入データ作成者名
        + created_at: `2019-12-27T09:38:19+09:00`
        + updated_at: `2019-12-27T09:38:19+09:00`
        + purchase_items (array)
            + ()
                + inventory_id: 1
                + title: 掃除機 (string) - 物品名
                + quantity: 3 (string) - 仕入数量
                + unit: 台 (string) - 単位
                + unit_price: 100 (string) - 仕入単価
                + status: purchased (string)
                + purchase_date: null (string)
                + estimated_purchase_date: `2020-01-01` (string)
            + ()
                + inventory_id: 1
                + title: 掃除機 (string) - 物品名
                + quantity: 3 (string) - 仕入数量
                + unit: 台 (string) - 単位
                + unit_price: 100 (string) - 仕入単価
                + status: purchased (string)
                + purchase_date: null (string)
                + estimated_purchase_date: `2020-01-01` (string)

## 仕入データ更新 [/api/v1/purchases/{id}]
### 仕入データ更新 [PUT]
#### 処理概要

* 仕入データを更新します
* パースできないJSONを送るとエラーを返します
* 項目について
    * num : 仕入データ番号（ユーザーが任意に設定できる番号）
    * customer_name : 取引先名
    * purchase_items : 対象となる在庫データの配列
        * 以下のパラメータを含むオブジェクトを配列の要素とします
            * inventory_id : 在庫データID
                * 在庫データIDは対象の物品を特定するために指定するため、これを更新することはできません
            * quantity : 仕入数量
            * unit_price : 仕入単価
            * status : 状態
                * 仕入前在庫を更新するときは not_ordered, ordered, purchased を指定できます
                仕入前在庫を仕入済みに更新すると **対象の在庫データの数量を増加します**
                * 仕入済み在庫の状態を更新することはできません
            * purchase_date : 仕入日
            * estimated_purchase_date : 仕入予定日
            * etc : 摘要・備考

+ Parameters
    + id: 1 (number) - 仕入データのID

+ Request
    + Headers

            Authorization: Bearer YOUR_TOKEN
            Content-Type: application/json

    + Attributes
        + num: 100 (string, optional) - 仕入データ番号（ユーザーが任意に設定できる番号）
        + customer_name: 株式会社ZAICO (string, optional) - 取引先名
        + purchase_items (array[UpdatePurchaseItemToPurchased, UpdatePurchaseItemToOrdered, UpdatePurchaseItemToNotOrdered], required)

+ Response 200 (application/json)
    + Attributes
        + code: 200 (number) - ステータスコード
        + status: success (string) - 状態
        + message: Data was successfully created. (string) - メッセージ
        + data_id: 12345 (number) - 作成した仕入データID

+ Response 422 (application/json)
    + Attributes
        + code: 422 (number) - ステータスコード
        + status: error (string) - 状態
        + message: Invalid data. (string) - メッセージ



## 仕入データ削除 [/api/v1/packing_slips/{id}]
### 仕入データ削除 [DELETE]
#### 処理概要

* 特定の仕入データを削除します
* 仕入データの各物品の状態によって在庫データの取り扱いが変わります
    * 仕入前：変化なし
    * 仕入済み：在庫データの数量を仕入数量分だけ戻します

+ Parameters
    + id: 1 (number) - 仕入データのID

+ Request
    + Headers

            Authorization: Bearer YOUR_TOKEN
            Content-Type: application/json

+ Response 200 (application/json)
    + Attributes
        + code: 200 (number) - ステータスコード
        + status: success (string) - 状態
        + message: Data was successfully deleted (string) - メッセージ

+ Response 404 (application/json)
    + Attributes
        + code: 404 (number) - ステータスコード
        + status: error (string) - 状態
        + message: Packing slip not found (string) - メッセージ


# Data Structures

## CreateDelivery (object)
+ inventory_id: 1 (number, required) - 在庫データID
+ quantity: 3 (number, required) - 納品数量
+ unit_price: 100 (number, optional) - 納品単価
+ estimated_delivery_date: `2019-09-01` (string, optional, nullable)

## UpdateDeliveryToCompleted
+ inventory_id: 1 (number, required) - 在庫データID
+ quantity: 3 (number, required) - 納品数量
+ unit_price: 100 (number, optional) - 納品単価
+ status: completed_delivery (string)
+ delivery_date: `2019-11-11` (string)
+ estimated_delivery_date: `2019-11-11` (string, optional, nullable)

## UpdateDeliveryToBefore
+ inventory_id: 2 (number, required) - 在庫データID
+ quantity: 5 (number, required) - 納品数量
+ unit_price: 100 (number, optional, nullable) - 納品単価
+ status: before_delivery
+ estimated_delivery_date: `2019-11-11` (string, optional, nullable)

## CreatePurchaseItem (object)
+ inventory_id: 1 (number, required) - 在庫データID
+ quantity: 3 (number, required) - 仕入数量
+ unit_price: 100 (number, optional) - 仕入単価
+ estimated_purchase_date: `2019-09-01` (string, optional, nullable)

## UpdatePurchaseItemToPurchased
+ inventory_id: 1 (number, required) - 在庫データID
+ quantity: 3 (number, required) - 仕入数量
+ unit_price: 100 (number, optional) - 仕入単価
+ status: purchased (string)
+ purchase_date: `2019-11-11` (string)
+ estimated_purchase_date: `2019-11-11` (string, optional, nullable)

## UpdatePurchaseItemToOrdered
+ inventory_id: 1 (number, required) - 在庫データID
+ quantity: 3 (number, required) - 仕入数量
+ unit_price: 100 (number, optional) - 仕入単価
+ status: ordered (string)
+ purchase_date: `2019-11-11` (string)
+ estimated_purchase_date: `2019-11-11` (string, optional, nullable)

## UpdatePurchaseItemToNotOrdered
+ inventory_id: 2 (number, required) - 在庫データID
+ quantity: 5 (number, required) - 仕入数量
+ unit_price: 100 (number, optional, nullable) - 仕入単価
+ status: not_ordered
+ estimated_purchase_date: `2019-11-11` (string, optional, nullable)

