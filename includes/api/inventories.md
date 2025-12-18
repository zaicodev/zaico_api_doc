# Group 在庫データ

## 在庫データ一覧取得 [/api/v1/inventories]
### GET
<span class="label-variation">バリエーション対応</span>

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
* バリエーションが利用可能なプランの場合、URLにクエリ「include_variant_setting=true」をつけるとバリエーションの設定項目が取得できます。

+ Request
  + Headers
    Authorization: Bearer YOUR_TOKEN
    Content-Type: application/json

+ Response 200 (application/json)
  + Headers
    Link: <https://web.zaico.co.jp/api/v1/inventories?page=1>; rel="first", <https://web.zaico.co.jp/api/v1/inventories?page=前のページ>; rel="prev", <https://web.zaico.co.jp/api/v1/inventories?page=次のページ>; rel="next", <https://web.zaico.co.jp/api/v1/inventories?page=最後のページ>; rel="last"
    Total-Count: 在庫データ件数
  + Attributes (InventoriesIndexViews)



## 在庫データ作成 [/api/v1/inventories]
### POST
<span class="label-variation">バリエーション対応</span>

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
* バリエーションが利用可能なプランの場合、在庫データ作成時にバリエーション項目を設定することも可能です

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
<span class="label-variation">バリエーション対応</span>

#### 処理概要
* 在庫データを1件のみ取得します
* 棚卸日は設定されている場合のみ表示されます
* 発注点は設定されている場合のみ表示されます
* バリエーションが利用可能なプランの場合、URLにクエリ「include_variants=true」をつけるとバリエーションの情報が取得できます。バリエーションのデータが1000件以上ある場合は「variants_page=」でページネーションして取得できます。

### 注意事項
* 在庫データが無い場合は404を返します

+ Parameters
  + id: 1 (number, required) - 在庫データのID

+ Request
  + Headers
    Authorization: Bearer YOUR_TOKEN
    Content-Type: application/json

+ Response 200 (application/json)
  + Attributes (InventoriesShowViews)

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
  + Attributes (InventoryUpdateParams)

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

### InventoryUpdateParams
+ title: `在庫データ` (string, required) - 在庫データタイトル
+ quantity: 10 (string) - 数量
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
+ optional_attributes (array[object], fixed-type)
    + (object)
        + name: `追加項目名` (string) - 追加項目名
        + value: `追加項目値` (string) - 追加項目値
+ quantity_management_attributes
  + order_point_quantity: 5 (string) - 発注点
+ inventory_history
  + memo: `変更履歴メモ` (string) - 変更履歴のメモ
+ is_quantity_auto_conversion_by_unit: `1` (string) - 単位換算するかどうか。"1"なら単位換算する、"0"なら単位換算しない
+ quantity_auto_conversion_by_unit_name: `箱` (string) - 単位換算後の単位名
+ quantity_auto_conversion_by_unit_factor: `12` (string) - 単位換算係数

### InventoryCreateParams(InventoryUpdateParams)
+ variant_setting: (object)
    + enabled: true (boolean) - バリエーション設定を有効化するかどうか
    + items: (array) - バリエーション項目
        + ()
            + label: `ロット番号` (string) - バリエーションの項目名
            + item_type: `number` (string) - バリエーションのデータ型
        + ()
            + label: `拠点` (string) - バリエーションの項目名
            + item_type: `text` (string) - バリエーションのデータ型
        + ()
            + label: `利用期限` (string) - バリエーションの項目名
            + item_type: `date` (string) - バリエーションのデータ型
            + enabled_deadline_alert: true (boolean) - 期限アラートを有効化するかどうか
            + deadline_alert_day: `10` (number) - 期限アラートを何日前に通知するか

### InventoriesViews
+ id: 1 (number) - ID
+ title: `在庫データ` (string) - 在庫データタイトル
+ quantity: 10 (string) - 数量
+ logical_quantity: 10 (string) - 予定フリー在庫数（フルプランのみ）
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
  + order_point_quantity: 5 (string) - 発注点
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
+ variant_setting_enabled: true (boolean) - バリエーション設定が有効かどうか
+ variant_setting: (array) - バリエーション設定情報
    + ()
        + variant_setting_item_id: `1` (number) - バリエーション項目ID
        + label: `ロット番号` (string) - バリエーションの項目名
        + item_type: `number` (string) - バリエーションのデータ型
        + enabled_deadline_alert: false (boolean) - 期限アラートが有効かどうか
    + ()
        + variant_setting_item_id: `2` (number) - バリエーション項目ID
        + label: `拠点` (string) - バリエーションの項目名
        + item_type: `text` (string) - バリエーションのデータ型
        + enabled_deadline_alert: false (boolean) - 期限アラートが有効かどうか
    + ()
        + variant_setting_item_id: `3` (number) - バリエーション項目ID
        + label: `利用期限` (string) - バリエーションの項目名
        + item_type: `date` (string) - バリエーションのデータ型
        + enabled_deadline_alert: true (boolean) - 期限アラートが有効かどうか
        + deadline_alert_day: `10` (number) - 期限アラートを何日前に通知するか

### InventoriesIndexViews(InventoriesViews)

### InventoriesShowViews(InventoriesViews)
+ variants: - バリエーション情報
    + data: (array) - バリエーション情報
        + ()
            + items: (array)
                + ()
                    + variant_setting_item_id: `1` (number) - バリエーション項目ID
                    + label: `ロット番号` (string) - バリエーションの項目名
                    + value: `100` (string) - バリエーションの値
                + ()
                    + variant_setting_item_id: `2` (number) - バリエーション項目ID
                    + label: `拠点` (string) - バリエーションの項目名
                    + value: `第一倉庫` (string) - バリエーションの値
                + ()
                    + variant_setting_item_id: `3` (number) - バリエーション項目ID
                    + label: `利用期限` (string) - バリエーションの項目名
                    + value: `2025/12/31` - バリエーションの値
            + quantity: `10.0` (number) - 数量
            + logical_quantity: `20.0` (number) - 予定フリー在庫数
            + code: `tw202500000001` (string) - バーコードの値
            + purchase_unit_price: `800.0` (number) - 仕入単価
            + packing_slip_unit_price: `1000.0` (number) - 納品単価
            + created_at: `2025-10-10T15:02:01+09:00` (string) - 作成日
            + updated_at: `2025-10-10T15:02:40+09:00` (string) - 更新日
            + create_user_name: `田村 太郎` (string) - 作成者
        + ()
            + items: (array)
                + ()
                    + variant_setting_item_id: `1` (number) - バリエーション項目ID
                    + label: `ロット番号` (string) - バリエーションの項目名
                    + value: `200` (string) - バリエーションの値
                + ()
                    + variant_setting_item_id: `2` (number) - バリエーション項目ID
                    + label: `拠点` (string) - バリエーションの項目名
                    + value: `第二倉庫` (string) - バリエーションの値
                + ()
                    + variant_setting_item_id: `3` (number) - バリエーション項目ID
                    + label: `利用期限` (string) - バリエーションの項目名
                    + value: `2026/01/31` - バリエーションの値
            + quantity: `15.0` (number) - 数量
            + logical_quantity: `30.0` (number) - 予定フリー在庫数
            + code: `tw202500000002` (string) - バーコードの値
            + purchase_unit_price: `700.0` (number) - 仕入単価
            + packing_slip_unit_price: `900.0` (number) - 納品単価
            + created_at: `2025-10-10T15:05:06+09:00` (string) - 作成日
            + updated_at: `2025-10-10T15:06:12+09:00` (string) - 更新日
            + create_user_name: `田村 太郎` (string) - 作成者
    + total_count: `2` (number) - バリエーションデータの件数

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

