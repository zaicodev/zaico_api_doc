FORMAT: 1A
HOST: https://web.zaico.co.jp

# zaico API Document
このドキュメントはZAICO APIの機能と使うために必要なパラメータなどを説明するものです。  
2022年12月14日更新

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
  * 棚卸日は設定されている場合のみ表示されます
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
  * 棚卸日はstocktake_attributes: { checked_at: 日付 }で登録・変更が可能です
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
+ group_tag: `グループタグ` (string) - グループタグ（ビジネス・フルプランのみ） 
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

### InventoriesViews
+ id: 1 (number) - ID
+ title: `在庫データ` (string) - 在庫データタイトル
+ quantity: 10 (number) - 数量
+ logical_quantity: 10 (number) - 予定フリー在庫数（ビジネス・フルプランのみ）
+ unit: `個` (string) - 単位
+ category: `製品` (string) - カテゴリ
+ state: `新品` (string) - 状態
+ place: `ZAICO倉庫` (string) - 保管場所
+ etc: `備考` (string) - 備考
+ group_tag: `グループタグ` (string) - グループタグ（ビジネス・フルプランのみ） 
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


# Group 出庫データ

## 出庫データ一覧取得 [/api/v1/packing_slips/]
### 出庫データ一覧取得 [GET]
#### 処理概要
* 自分のアカウントに登録されている出庫データのすべてを返します
* 出庫データが1件も無い場合は、空の配列を返します
* 出庫データが1000件以上ある場合はページネーションで分割され、1000件ごと出庫データを返します
* 任意のページを取得するにはURLにクエリ「page=」をつけることで取得できます。
* ページ情報はHTTPヘッダ"Link"に最初のページ、前のページ、次のページ、最後のページそれぞれ,(カンマ)で区切られ返されます。最初のページでは「前のページ」、最後のページでは「次のページ」項目は表示されません
* Link, Total-Countヘッダは納品一覧でのみ返されます
* 各出庫データの項目について以下のようになります
  * id : 出庫データID
  * num : 出庫データ番号（ユーザーが任意に設定できる番号）
  * customer_name : 取引先名
  * status : 出庫データの状態
    * 以下の2つのどちらかが設定されています
    * before_delivery : 出庫前
    * completed_delivery : 出庫済
  * total_amount : 出庫データの合計金額
  * delivery_date : 出庫日
  * estimated_delivery_date : 出庫予定日
    * この出庫予定日は出庫データの物品のうち、最も早い出庫予定日を表示します
  * created_at : 出庫データ作成日
  * updated_at : 出庫データ更新日
  * deliveries : 出庫データに登録している在庫データ一覧
    * inventory_id : 在庫データID
    * title : 物品名
    * quantity : 出庫数量
    * unit : 単位
    * unit_price : 納品単価
    * status : 状態
      * 以下の2つのどちらかが設定されています
      * before_delivery : 出庫前
      * completed_delivery : 出庫済
    * delivery_date : 出庫日
    * estimated_delivery_date : 出庫予定日
    * etc : 摘要・備考
  * shipping_instruction : 発送情報（フルプラン、かつ設定されている場合のみ表示されます）
    * to_name : 宛名
    * to_name_postfix : 敬称
    * to_zip : 郵便番号
    * to_address : 住所
    * building_name : 建物名・部屋番号
    * to_phone_number : 電話番号
    * shipping_client_id : 発送元ID
    * invoice_type_name : 便指定
    * product_name_on_invoice : 品名
    * freight_handling : 荷扱い
    * freight_handling2 : 荷扱い
    * arrival_date : 希望お届け日
    * arrival_hour : 希望お届け時間帯

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
            + delivery_date: `2019-09-01` (string) - 出庫日
            + estimated_delivery_date (string, optional, nullable)
            + created_at: `2018-03-27T09:38:19+09:00`
            + updated_at: `2018-03-27T09:38:19+09:00`
            + deliveries (array[object], fixed-type)
                + (object)
                    + inventory_id: 1 (number)
                    + title: 掃除機 (string) - 物品名
                    + quantity: 3 (number) - 出庫数量
                    + unit: 台 (string) - 単位
                    + unit_price: 100 (number) - 納品単価
                    + status: completed_delivery (string)
                    + delivery_date: `2019-09-01` (string)
                    + estimated_delivery_date (string, optional, nullable)
                    + etc: 黒色 (string) - 摘要・備考
                + (object)
                    + inventory_id: 2 (number)
                    + title: テレビ (string) - 物品名
                    + quantity: 3 (number) - 出庫数量
                    + unit: 台 (string) - 単位
                    + unit_price: 100 (number) - 納品単価
                    + status: completed_delivery (string)
                    + delivery_date: `2019-09-01` (string)
                    + estimated_delivery_date (string, optional, nullable)
                    + etc: (string) - 摘要・備考
            + shipping_instruction (ShippingInstructionView)
        + ()
            + id: 11 (number)
            + num: 1001 (string)
            + customer_name: 株式会社ZAICO (string) - 取引先名
            + status: `before_delivery` (string) - 状態
            + total_amount: 1000 (number)
            + delivery_date: `2019-09-01` (string) - 出庫日
            + estimated_delivery_date: `2019-09-01` (string) - 出庫予定日
            + created_at: `2018-03-27T09:38:19+09:00`
            + updated_at: `2018-03-27T09:38:19+09:00`
            + deliveries (array[object], fixed-type)
                + (object)
                    + inventory_id: 5 (number)
                    + title: 掃除機 (string) - 物品名
                    + quantity: 3 (number) - 出庫数量
                    + unit: 台 (string) - 単位
                    + unit_price: 100 (number) - 納品単価
                    + status: completed_delivery
                    + delivery_date: `2019-09-01`
                    + estimated_delivery_date: `2019-09-01` (string, optional, nullable)
                    + etc: (string) - 摘要・備考


## 出庫データ作成 [/api/v1/packing_slips/]
### 出庫データ作成 [POST]
#### 処理概要

* 出庫データを作成します
* パースできないJSONを送るとエラーを返します
* 登録できる項目について
    * num : 出庫データ番号（ユーザーが任意に設定できる番号）
    * customer_name : 取引先名
    * status : 出庫データの状態
        * 以下の2つのどちらかを指定してください
        * 出庫前の場合は before_delivery
        * 出庫済の場合は completed_delivery
        * **出庫済みを指定した場合は、対象の在庫データの数量を減少します**
    * delivery_date : 出庫日
        * statusによって必須かどうか変わります
        * status=completed_delivery
            * delivery_dateが必須
        * status=before_delivery
            * delivery_dateは不要
    * deliveries : 対象となる在庫データの配列
        * 以下のパラメータを含むオブジェクトを配列の要素とします
            * inventory_id : 在庫データID
            * quantity : 出庫数量
            * unit_price : 納品単価
            * estimated_delivery_date : 出庫予定日
            * etc : 摘要・備考
    * shipping_instruction : 発送情報（フルプランのみ設定できます）
        * to_name : 宛名
        * to_name_postfix : 敬称
        * to_zip : 郵便番号
        * to_address : 住所
        * building_name : 建物名・部屋番号
        * to_phone_number : 電話番号
        * shipping_client_id : 発送元ID
        * invoice_type_name : 便指定
        * product_name_on_invoice : 品名
        * freight_handling : 荷扱い
        * freight_handling2 : 荷扱い
        * arrival_date : 希望お届け日
        * arrival_hour : 希望お届け時間帯

+ Request
    + Headers

            Authorization: Bearer YOUR_TOKEN
            Content-Type: application/json

    + Attributes
        + num: 100 (string, optional) - 出庫データ番号（ユーザーが任意に設定できる番号）
        + customer_name: 株式会社ZAICO (string, optional) - 取引先名
        + status: `completed_delivery` (string, required) - 状態
        + delivery_date: `2019-09-01` (string) - 出庫日
        + deliveries (array[CreateDelivery], required)
        + shipping_instruction (ShippingInstructionView)

+ Response 200 (application/json)
    + Attributes
        + code: 200 (number) - ステータスコード
        + status: success (string) - 状態
        + message: Data was successfully created. (string) - メッセージ
        + data_id: 12345 (number) - 作成した出庫データID

+ Response 422 (application/json)
    + Attributes
        + code: 422 (number) - ステータスコード
        + status: error (string) - 状態
        + message: Invalid data. (string) - メッセージ


## 出庫データ個別取得 [/api/v1/packing_slips/{id}]
### 出庫データ個別取得 [GET]
#### 処理概要

* 出庫データを1件のみ取得します
* 出庫データの項目について以下のようになります
  * id : 出庫データID
  * num : 出庫データ番号（ユーザーが任意に設定できる番号）
  * customer_name : 取引先名
  * status : 出庫データの状態
    * 以下の2つのどちらかが設定されています
    * before_delivery : 出庫前
    * completed_delivery : 出庫済み
  * total_amount : 出庫データの合計金額
  * delivery_date : 出庫日
  * estimated_delivery_date : 出庫予定日
    * この出庫予定日は出庫データの物品のうち、最も早い出庫予定日を表示します
  * created_at : 出庫データ作成日
  * updated_at : 出庫データ更新日
  * deliveries : 出庫データに登録している在庫データ一覧
    * inventory_id : 在庫データID
    * title : 物品名
    * quantity : 出庫数量
    * unit : 単位
    * unit_price : 納品単価
    * status : 状態
      * 以下の2つのどちらかが設定されています
      * before_delivery : 出庫前
      * completed_delivery : 出庫済み
    * delivery_date : 出庫日
    * estimated_delivery_date : 出庫予定日
    * etc: 摘要・備考
  * shipping_instruction : 発送情報（フルプラン、かつ設定されている場合のみ表示されます）
    * to_name : 宛名
    * to_name_postfix : 敬称
    * to_zip : 郵便番号
    * to_address : 住所
    * building_name : 建物名・部屋番号
    * to_phone_number : 電話番号
    * shipping_client_id : 発送元ID
    * invoice_type_name : 便指定
    * product_name_on_invoice : 品名
    * freight_handling : 荷扱い
    * freight_handling2 : 荷扱い
    * arrival_date : 希望お届け日
    * arrival_hour : 希望お届け時間帯

+ Parameters
    + id: 1 (number) - 出庫データのID

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
        + delivery_date: `2019-09-01` (string) - 出庫日
        + estimated_delivery_date: `2019-09-01` (string) - 出庫日
        + created_at: `2018-03-27T09:38:19+09:00`
        + updated_at: `2018-03-27T09:38:19+09:00`
        + deliveries (array[object], fixed-type)
            + (object)
                + inventory_id: 1 (number)
                + title: 掃除機 (string) - 物品名
                + quantity: 3 (number) - 出庫数量
                + unit: 台 (string) - 単位
                + unit_price: 100 (number) - 納品単価
                + status: completed_delivery (string)
                + delivery_date: `2019-09-01` (string)
                + estimated_delivery_date (string, optional, nullable)
                + etc: 白色 (string) - 摘要・備考
            + (object)
                + inventory_id: 2 (number)
                + title: テレビ (string) - 物品名
                + quantity: 3 (number) - 出庫数量
                + unit: 台 (string) - 単位
                + unit_price: 100 (number) - 納品単価
                + status: completed_delivery (string)
                + delivery_date: `2019-09-01` (string)
                + estimated_delivery_date: `2019-09-01` (string, optional, nullable)
                + etc: (string) - 摘要・備考
        + shipping_instruction (ShippingInstructionView)

## 出庫データ更新 [/api/v1/packing_slips/{id}]
### 出庫データ更新 [PUT]
#### 処理概要

* 出庫データを更新します
* パースできないJSONを送るとエラーを返します
* 項目について
    * num : 出庫データ番号（ユーザーが任意に設定できる番号）
    * customer_name : 取引先名
    * deliveries : 対象となる在庫データの配列
        * 以下のパラメータを含むオブジェクトを配列の要素とします
            * inventory_id : 在庫データID
                * 在庫データIDは対象の物品を特定するために指定するため、これを更新することはできません
            * quantity : 出庫数量
            * unit_price : 納品単価
            * status : 状態
                * 出庫前在庫を更新するときは before_delivery または completed_delivery を指定できます
                出庫前在庫を出庫済に更新すると **対象の在庫データの数量を減少します**
                * 出庫済在庫の状態を更新することはできません
            * delivery_date : 出庫日
            * estimated_delivery_date : 出庫予定日
            * etc : 摘要・備考
    * shipping_instruction : 発送情報（フルプランのみ設定できます）
        * to_name : 宛名
        * to_name_postfix : 敬称
        * to_zip : 郵便番号
        * to_address : 住所
        * building_name : 建物名・部屋番号
        * to_phone_number : 電話番号
        * shipping_client_id : 発送元ID
        * invoice_type_name : 便指定
        * product_name_on_invoice : 品名
        * freight_handling : 荷扱い
        * freight_handling2 : 荷扱い
        * arrival_date : 希望お届け日
        * arrival_hour : 希望お届け時間帯

+ Parameters
    + id: 1 (number) - 出庫データのID

+ Request
    + Headers

            Authorization: Bearer YOUR_TOKEN
            Content-Type: application/json

    + Attributes
        + num: 100 (string, optional) - 出庫データ番号（ユーザーが任意に設定できる番号）
        + customer_name: 株式会社ZAICO (string, optional) - 取引先名
        + deliveries (array[UpdateDeliveryToCompleted, UpdateDeliveryToBefore], required)
        + shipping_instruction (ShippingInstructionView)

+ Response 200 (application/json)
    + Attributes
        + code: 200 (number) - ステータスコード
        + status: success (string) - 状態
        + message: Data was successfully created. (string) - メッセージ
        + data_id: 12345 (number) - 作成した出庫データID

+ Response 422 (application/json)
    + Attributes
        + code: 422 (number) - ステータスコード
        + status: error (string) - 状態
        + message: Invalid data. (string) - メッセージ



## 出庫データ削除 [/api/v1/packing_slips/{id}]
### 出庫データ削除 [DELETE]
#### 処理概要

* 特定の出庫データを削除します
* 出庫データの各物品の状態によって在庫データの取り扱いが変わります
    * 出庫前：変化なし
    * 出庫済：在庫データの数量を出庫数量分だけ戻します

+ Parameters
    + id: 1 (number) - 出庫データのID

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

# Group 入庫データ

HOST: https://web.zaico.co.jp/

## 入庫データ一覧取得 [/api/v1/purchases/]
### 入庫データ一覧取得 [GET]
#### 処理概要

* 自分のアカウントに登録されている入庫データのすべてを返します
* 入庫データが1件も無い場合は、空の配列を返します
* 入庫データが1000件以上ある場合はページネーションで分割され、1000件ごと入庫データを返します
* 任意のページを取得するにはURLにクエリ「page=」をつけることで取得できます
* ページ情報はHTTPヘッダ"Link"に最初のページ、前のページ、次のページ、最後のページそれぞれ,(カンマ)で区切られ返されます。最初のページでは「前のページ」、最後のページでは「次のページ」項目は表示されません
* Link, Total-Countヘッダは仕入一覧でのみ返されます
* 各入庫データの項目について以下のようになります
  * id : 入庫データID
  * num : 入庫データ番号（ユーザーが任意に設定できる番号）
  * customer_name : 取引先名
  * status : 入庫データの状態
    * 以下の3つのいずれかが設定されています
    * not_ordered : 発注前
    * ordered : 発注済み
    * purchased : 入庫済
  * total_amount : 入庫データの合計金額
  * purchase_date: 入庫日
  * estimated_purchase_date　: 入庫予定日
  * create_user_name : 入庫データ作成者名
  * created_at : 入庫データ作成日
  * updated_at : 入庫データ更新日
  * purchase_items : 入庫データに登録している在庫データ一覧
    * inventory_id : 在庫データID
    * title : 物品名
    * quantity : 入庫数量
    * unit : 単位
    * unit_price : 仕入単価
    * status : 状態
        * 以下の3つのいずれかが設定されています
        * not_ordered : 発注前
        * ordered : 発注済み
        * purchased : 入庫済み
    * purchase_date: 入庫日
    * estimated_purchase_date　: 入庫予定日

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
            + purchase_date: null (string) - 入庫日
            + estimated_purchase_date: `2020-01-01` (string) - 入庫予定日
            + create_user_name: 在庫太郎 (string) - 入庫データ作成者名
            + created_at: `2019-12-27T09:38:19+09:00`
            + updated_at: `2019-12-27T09:38:19+09:00`
            + purchase_items (array)
                + ()
                    + inventory_id: 1
                    + title: 掃除機 (string) - 物品名
                    + quantity: 3 (string) - 入庫数量
                    + unit: 台 (string) - 単位
                    + unit_price: 100 (string) - 仕入単価
                    + status: ordered (string)
                    + purchase_date: null (string)
                    + estimated_purchase_date: `2020-01-01` (string)
                + ()
                    + inventory_id: 1
                    + title: 掃除機 (string) - 物品名
                    + quantity: 3 (string) - 入庫数量
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
            + purchase_date: `2020-01-01` (string) - 入庫日
            + estimated_purchase_date: null (string) - 入庫予定日
            + create_user_name: 在庫太郎 (string) - 入庫データ作成者名
            + created_at: `2019-12-27T09:38:19+09:00`
            + updated_at: `2019-12-27T09:38:19+09:00`
            + purchase_items (array)
                + ()
                    + inventory_id: 5
                    + title: 掃除機 (string) - 物品名
                    + quantity: 3 (string) - 入庫数量
                    + unit: 台 (string) - 単位
                    + unit_price: 100 (string) - 仕入単価
                    + status: purchased
                    + purchase_date: `2020-01-01`
                    + estimated_purchase_date: null


## 入庫データ作成 [/api/v1/purchases/]
### 入庫データ作成 [POST]
#### 処理概要

* 入庫データを作成します
* パースできないJSONを送るとエラーを返します
* 登録できる項目について
    * num : 入庫データ番号（ユーザーが任意に設定できる番号）
    * customer_name : 取引先名
    * status : 入庫データの状態
        * 以下の2つのどちらかを指定してください
        * 仕入前の場合は not_ordered
        * 入庫済の場合は purchased
        * **入庫済を指定した場合は、対象の在庫データの数量を増加します**
    * purchase_date : 入庫日
        * statusによって必須かどうか変わります
        * status=purchased
            * purcahse_dateが必須
        * status=not_ordered
            * purchase_dateは不要
    * purchase_items : 対象となる在庫データの配列
        * 以下のパラメータを含むオブジェクトを配列の要素とします
            * inventory_id : 在庫データID
            * quantity : 入庫数量
            * unit_price : 仕入単価
            * estimated_purchase_date : 入庫予定日
            * etc : 摘要・備考

+ Request
    + Headers

            Authorization: Bearer YOUR_TOKEN
            Content-Type: application/json

    + Attributes
        + num: 100 (string, optional) - 入庫データ番号（ユーザーが任意に設定できる番号）
        + customer_name: 株式会社ZAICO (string, optional) - 取引先名
        + status: `purchased` (string, required) - 状態
        + purchase_date: `2019-09-01` (string) - 入庫日
        + purchase_items (array[CreatePurchaseItem], required)

+ Response 200 (application/json)
    + Attributes
        + code: 200 (number) - ステータスコード
        + status: success (string) - 状態
        + message: Data was successfully created. (string) - メッセージ
        + data_id: 12345 (number) - 作成した入庫データID

+ Response 422 (application/json)
    + Attributes
        + code: 422 (number) - ステータスコード
        + status: error (string) - 状態
        + message: Invalid data. (string) - メッセージ


## 入庫データ個別取得 [/api/v1/purchases/{id}]
### 入庫データ個別取得 [GET]
#### 処理概要

* 入庫データを1件のみ取得します
* 入庫データの項目について以下のようになります
  * id : 入庫データID
  * num : 入庫データ番号（ユーザーが任意に設定できる番号）
  * customer_name : 取引先名
  * status : 入庫データの状態
    * 以下の3つのいずれかが設定されています
    * not_ordered : 発注前
    * ordered : 発注済み
    * purchased : 入庫済
  * total_amount : 入庫データの合計金額
  * purchase_date : 入庫日
  * estimated_purchase_date : 入庫予定日
    * この入庫予定日は入庫データの物品のうち、最も早い入庫予定日を表示します
  * create_user_name : 入庫データ作成者名
  * created_at : 入庫データ作成日
  * updated_at : 入庫データ更新日
  * deliveries : 入庫データに登録している在庫データ一覧
    * inventory_id : 在庫データID
    * title : 物品名
    * quantity : 入庫数量
    * unit : 単位
    * unit_price : 仕入単価
    * status : 状態
        * 以下の3つのいずれかが設定されています
        * not_ordered : 発注前
        * ordered : 発注済み
        * purchased : 入庫済
    * purchase_date : 入庫日
    * estimated_purchase_date : 入庫予定日
    * etc: 摘要・備考

+ Parameters
    + id: 10 (number) - 入庫データのID

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
        + purchase_date: null (string) - 入庫日
        + estimated_purchase_date: `2020-01-01` (string) - 入庫予定日
        + create_user_name: 在庫太郎 (string) - 入庫データ作成者名
        + created_at: `2019-12-27T09:38:19+09:00`
        + updated_at: `2019-12-27T09:38:19+09:00`
        + purchase_items (array)
            + ()
                + inventory_id: 1
                + title: 掃除機 (string) - 物品名
                + quantity: 3 (string) - 入庫数量
                + unit: 台 (string) - 単位
                + unit_price: 100 (string) - 仕入単価
                + status: purchased (string)
                + purchase_date: null (string)
                + estimated_purchase_date: `2020-01-01` (string)
            + ()
                + inventory_id: 1
                + title: 掃除機 (string) - 物品名
                + quantity: 3 (string) - 入庫数量
                + unit: 台 (string) - 単位
                + unit_price: 100 (string) - 仕入単価
                + status: purchased (string)
                + purchase_date: null (string)
                + estimated_purchase_date: `2020-01-01` (string)

## 入庫データ更新 [/api/v1/purchases/{id}]
### 入庫データ更新 [PUT]
#### 処理概要

* 入庫データを更新します
* パースできないJSONを送るとエラーを返します
* 項目について
    * num : 入庫データ番号（ユーザーが任意に設定できる番号）
    * customer_name : 取引先名
    * purchase_items : 対象となる在庫データの配列
        * 以下のパラメータを含むオブジェクトを配列の要素とします
            * inventory_id : 在庫データID
                * 在庫データIDは対象の物品を特定するために指定するため、これを更新することはできません
            * quantity : 入庫数量
            * unit_price : 仕入単価
            * status : 状態
                * 仕入前在庫を更新するときは not_ordered, ordered, purchased を指定できます
                仕入前在庫を入庫済に更新すると **対象の在庫データの数量を増加します**
                * 入庫済在庫の状態を更新することはできません
            * purchase_date : 入庫日
            * estimated_purchase_date : 入庫予定日
            * etc : 摘要・備考

+ Parameters
    + id: 1 (number) - 入庫データのID

+ Request
    + Headers

            Authorization: Bearer YOUR_TOKEN
            Content-Type: application/json

    + Attributes
        + num: 100 (string, optional) - 入庫データ番号（ユーザーが任意に設定できる番号）
        + customer_name: 株式会社ZAICO (string, optional) - 取引先名
        + purchase_items (array[UpdatePurchaseItemToPurchased, UpdatePurchaseItemToOrdered, UpdatePurchaseItemToNotOrdered], required)

+ Response 200 (application/json)
    + Attributes
        + code: 200 (number) - ステータスコード
        + status: success (string) - 状態
        + message: Data was successfully created. (string) - メッセージ
        + data_id: 12345 (number) - 作成した入庫データID

+ Response 422 (application/json)
    + Attributes
        + code: 422 (number) - ステータスコード
        + status: error (string) - 状態
        + message: Invalid data. (string) - メッセージ



## 入庫データ削除 [/api/v1/purchases/{id}]
### 入庫データ削除 [DELETE]
#### 処理概要

* 特定の入庫データを削除します
* 入庫データの各物品の状態によって在庫データの取り扱いが変わります
    * 仕入前：変化なし
    * 入庫済：在庫データの数量を入庫数量分だけ戻します

+ Parameters
    + id: 1 (number) - 入庫データのID

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
+ quantity: 3 (number, required) - 出庫数量
+ unit_price: 100 (number, optional) - 納品単価
+ estimated_delivery_date: `2019-09-01` (string, optional, nullable)

## UpdateDeliveryToCompleted
+ inventory_id: 1 (number, required) - 在庫データID
+ quantity: 3 (number, required) - 出庫数量
+ unit_price: 100 (number, optional) - 納品単価
+ status: completed_delivery (string)
+ delivery_date: `2019-11-11` (string)
+ estimated_delivery_date: `2019-11-11` (string, optional, nullable)

## UpdateDeliveryToBefore
+ inventory_id: 2 (number, required) - 在庫データID
+ quantity: 5 (number, required) - 出庫数量
+ unit_price: 100 (number, optional, nullable) - 納品単価
+ status: before_delivery
+ estimated_delivery_date: `2019-11-11` (string, optional, nullable)

## ShippingInstructionView
+ to_name: `在庫商会` (string) - 宛名
+ to_name_postfix: `御中` (string) - 敬称
+ to_zip: `1000101` (string) - 郵便番号
+ to_address: `東京都大島町元町` (string) - 住所
+ building_name: `ザイコ工場` (string) - 建物名・部屋番号
+ to_phone_number: `0312341234` (string) - 電話番号
+ shipping_client_id: 123 (number) - 発送元ID
+ invoice_type_name: `宅急便（ヤマト）` (string) - 便指定
+ product_name_on_invoice: `化学薬品` (string) - 品名
+ freight_handling: `ワレ物注意` (string) - 荷扱い
+ freight_handling2: `下載厳禁` (string) - 荷扱い
+ arrival_date: `2023-10-31` (string) - 希望お届け日
+ arrival_hour: `14〜16時` (string) - 希望お届け時間帯

## CreatePurchaseItem (object)
+ inventory_id: 1 (number, required) - 在庫データID
+ quantity: 3 (number, required) - 入庫数量
+ unit_price: 100 (number, optional) - 仕入単価
+ estimated_purchase_date: `2019-09-01` (string, optional, nullable)

## UpdatePurchaseItemToPurchased
+ inventory_id: 1 (number, required) - 在庫データID
+ quantity: 3 (number, required) - 入庫数量
+ unit_price: 100 (number, optional) - 仕入単価
+ status: purchased (string)
+ purchase_date: `2019-11-11` (string)
+ estimated_purchase_date: `2019-11-11` (string, optional, nullable)

## UpdatePurchaseItemToOrdered
+ inventory_id: 1 (number, required) - 在庫データID
+ quantity: 3 (number, required) - 入庫数量
+ unit_price: 100 (number, optional) - 仕入単価
+ status: ordered (string)
+ purchase_date: `2019-11-11` (string)
+ estimated_purchase_date: `2019-11-11` (string, optional, nullable)

## UpdatePurchaseItemToNotOrdered
+ inventory_id: 2 (number, required) - 在庫データID
+ quantity: 5 (number, required) - 入庫数量
+ unit_price: 100 (number, optional, nullable) - 仕入単価
+ status: not_ordered
+ estimated_purchase_date: `2019-11-11` (string, optional, nullable)


# Group 取引先データ

## 取引先データ一覧取得 [/api/v1/customers/]
### GET
#### 処理概要
  * 自分のアカウントに登録されている取引先データのすべてを返します
  * 取引先データが1件も無い場合は、空の配列を返します
  * 取引先データが1000件以上ある場合はページネーションで分割され、1000件ごと取引先データを返します
  * 任意のページを取得するにはURLにクエリ「page=」をつけることで取得できます。
  * ページ情報はHTTPヘッダ"Link"に最初のページ、前のページ、次のページ、最後のページそれぞれ,(カンマ)で区切られ返されます。最初のページでは「前のページ」、最後のページでは「次のページ」項目は表示されません
  * Link, Total-Countヘッダは取引先一覧でのみ返されます
  ```http
  Ref：
  https://web.zaico.co.jp/api/v1/customers?page=1
  ```
  + Request
    + Headers
      Authorization: Bearer YOUR_TOKEN
      Content-Type: application/json
  + Response 200 (application/json)
    + Headers
      Link: <https://web.zaico.co.jp/api/v1/customers?page=1>; rel="first", <https://web.zaico.co.jp/api/v1/customers/api/v1/customers?page=1>; rel="last"
      Total-Count: 取引先データ件数
    + Attributes (CustomersView)

## 取引先データ作成 [/api/v1/customers/]
### POST
#### 処理概要
  * 取引先データを作成します
  * 名前のみあれば作成可能です
  * 敬称は 様 または 御中が指定可能です
  * パースできないJSONを送るとエラーを返します

+ Parameters
  + id: 1 (number, required) - 取引先データのID

+ Request
  + Headers
    Authorization: Bearer YOUR_TOKEN
    Content-Type: application/json

  + Params
    + Attributes (CustomerCreateParams)

+ Response 200 (application/json)
  + Attributes (CustomerCreateSuccessfully)

+ Response 400 (application/json)
  + Attributes (BadRequestNoData)

+ Response 422 (application/json)
  + Attributes (UnprocessableEntity)

## 取引先データ更新 [/api/v1/customers/{id}]
### PUT
#### 処理概要
  * 特定の取引先データを更新します
  * 名前のみあれば作成可能です
  * 敬称は 様 または 御中が指定可能です
  * 該当する取引先データが無い場合はエラーを返します
  * パースできないJSONを送るとエラーを返します

+ Parameters
  + id: 1 (number, required) - 取引先データのID

+ Params
    + Attributes (InventoryCreateParams)

+ Request
  + Headers
    Authorization: Bearer YOUR_TOKEN
    Content-Type: application/json

  + Params
    + Attributes (CustomerUpdateParams)

+ Response 200 (application/json)
  + Attributes (CustomerUpdateSuccessfully)

+ Response 400 (application/json)
  + Attributes (BadRequestNoData)

+ Response 404 (application/json)
  + Attributes (CustomerNotFound)

## 取引先データ削除 [/api/v1/customers/{id}]
### DELETE
#### 処理概要
* 特定の取引先データを削除します
* 該当する取引先データが無い場合はエラーを返します

+ Parameters
  + id: 1 (number, required) - 取引先データのID

+ Request
  + Headers
    Authorization: Bearer YOUR_TOKEN
    Content-Type: application/json

+ Response 200 (application/json)
  + Attributes (CustomerDeleteSuccessfully)

+ Response 404 (application/json)
  + Attributes (CustomerNotFound)

## Data Structures
### CustomersView
+ id: 1 (number) - レコードID
+ name: `取引先A` (string) - 取引先名
+ email: `zaico@example.com` (string) - メールアドレス
+ name_postfix: `様` (string) - 敬称
+ zip: `1234567` (string) - 郵便番号
+ address: `東京都港区` (string) - 住所
+ building_name: `港ビル` (string) - 建物名・部屋番号
+ phone_number: `08012345678` (string) - 電話番号
+ etc: `取引先` (string) - 備考

### CustomerCreateParams
+ name: `取引先A` (string) -  取引先名
+ email: `zaico@example.com` (string) - メールアドレス
+ name_postfix: `様` (string) - 敬称
+ zip: `1234567` (string) - 郵便番号
+ address: `東京都港区` (string) - 住所
+ building_name: `港ビル` (string) - 建物名・部屋番号
+ phone_number: `08012345678` (string) - 電話番号
+ etc: `取引先` (string) - 備考

### CustomerCreateSuccessfully
+ code: 200 (number) - コード
+ status: `success` (string) - ステータス
+ message: `Data was successfully created` (string) - メッセージ
+ data_id: 1 (number) - レコードID

### CustomerUpdateParams
+ name: `取引先A` (string) -  取引先名
+ email: `zaico@example.com` (string) - メールアドレス
+ name_postfix: `様` (string) - 敬称
+ zip: `1234567` (string) - 郵便番号
+ address: `東京都港区` (string) - 住所
+ building_name: `港ビル` (string) - 建物名・部屋番号
+ phone_number: `08012345678` (string) - 電話番号
+ etc: `取引先` (string) - 備考

### CustomerUpdateSuccessfully
+ code: 200 (number) - コード
+ status: `success` (string) - ステータス
+ message: `Data was successfully updated` (string) - メッセージ
+ data_id: 1 (number) - レコードID

### CustomerDeleteSuccessfully
+ code: 200 (number) - コード
+ status: `success` (string) - ステータス
+ message: `Data was successfully deleted` (string) - メッセージ
+ data_id: 1 (number) - レコードID

### CustomerNotFound
+ code: 404 (number) - コード
+ status: `error` (string) - ステータス
+ message: `Customer not found` (string) - メッセージ


# Group 発送元データ

## 発送元データ一覧取得 [/api/v1/shipping_clients/]

### GET

#### 処理概要

* フルプランのみ参照できます。
* 自分のアカウントに登録されている発送元データのすべてを返します
* 発送元データが1件も無い場合は、空の配列を返します
* 発送元データが1000件以上ある場合はページネーションで分割され、1000件ごと発送元データを返します
* 任意のページを取得するにはURLにクエリ「page=」をつけることで取得できます。
* ページ情報はHTTPヘッダ"Link"に最初のページ、前のページ、次のページ、最後のページそれぞれ,(カンマ)で区切られ返されます。最初のページでは「前のページ」、最後のページでは「次のページ」項目は表示されません
* Link, Total-Countヘッダは発送元一覧でのみ返されます

  ```http
  Ref：
  https://web.zaico.co.jp/api/v1/shipping_clients?page=1
  ```

* Request
  * Headers
      Authorization: Bearer YOUR_TOKEN
      Content-Type: application/json
* Response 200 (application/json)
  * Headers
      Link: <https://web.zaico.co.jp/api/v1/shipping_clients?page=1>; rel="first", <https://web.zaico.co.jp/api/v1/shipping_clients?page=1>; rel="last"
      Total-Count: 発送元データ件数
  * Attributes (array)
      * (ShippingClientsView)

## Data Structures

### ShippingClientsView

* id: 1 (number) - レコードID
* name: `発送元A` (string) - 名前/会社名
* zip: `1234567` (string) - 郵便番号
* address: `東京都港区` (string) - 住所
* building_name: `港ビル` (string) - 建物名・部屋番号
* phone_number: `08012345678` (string) - 電話番号
