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
* Link, Total-Countヘッダは入庫物品一覧でのみ返されます
* 各入庫データの項目について以下のようになります
    * id : 入庫データID
    * num : 入庫データ番号（ユーザーが任意に設定できる番号）
    * customer_name : 取引先名
    * status : 入庫データの状態
        * 以下の5つのいずれかが設定されています
        * none : なし
        * not_ordered : 発注前
        * ordered : 発注済み
        * purchased : 入庫済
        * quotation_requested : 見積依頼済み
    * total_amount : 入庫データの合計金額
    * purchase_date: 入庫日
    * estimated_purchase_date　: 入庫予定日
    * create_user_name : 入庫データ作成者名
    * memo : 入庫メモ
    * etc : 発注書備考
    * created_at : 入庫データ作成日
    * updated_at : 入庫データ更新日
    * purchase_items : 入庫データに登録している在庫データ一覧
        * id : 入庫物品データID
        * inventory_id : 在庫データID
        * title : 物品名
        * quantity : 入庫数量
        * box_quantity: まとめ換算数量（基本単位で登録された場合はquantityと同じ値）
        * unit : 単位
        * box_unit : まとめ単位（基本単位で登録された場合はunitと同じ値）
        * unit_snapshot : 単位自動換算情報
            * piece_name : 基本単位名
            * box_name : まとめ単位名
            * factor : 換算値
        * unit_price : 仕入単価
        * subtotal_amount : 小計（box_quantity x box_unit）
        * status : 状態
            * 以下の3つのいずれかが設定されています
            * not_ordered : 発注前
            * ordered : 発注済み
            * purchased : 入庫済
        * purchase_date: 入庫日
        * estimated_purchase_date : 入庫予定日
        * etc : 入庫物品メモ

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
                    + id: 1 (number)
                    + inventory_id: 1 (number)
                    + title: 掃除機 (string) - 物品名
                    + quantity: 3 (string) - 入庫数量
                    + box_quantity: 3 (string) - まとめ換算の入庫数量
                    + unit: 台 (string) - 単位
                    + box_unit: 台 (string) - まとめ単位
                    + unit_price: 100 (string) - 仕入単価
                    + status: ordered (string)
                    + purchase_date: null (string)
                    + estimated_purchase_date: `2020-01-01` (string)
                + ()
                    + id: 2 (number)
                    + inventory_id: 1 (number)
                    + title: 掃除機 (string) - 物品名
                    + quantity: 3 (string) - 入庫数量
                    + box_quantity: 3 (string) - まとめ換算の入庫数量
                    + unit: 台 (string) - 単位
                    + box_unit: 台 (string) - まとめ単位
                    + unit_price: 100 (string) - 仕入単価
                    + status: ordered (string)
                    + purchase_date: null (string)
                    + estimated_purchase_date: `2020-01-01` (string)
                + ()
                    + id: 3 (number)
                    + inventory_id: 2 (number)
                    + title: ビール (string) - 物品名
                    + quantity: 12 (string) - 入庫数量
                    + box_quantity: 1 (string) - まとめ換算の入庫数量
                    + unit: 瓶 (string) - 単位
                    + box_unit: 箱 (string) - まとめ単位
                    + unit_price: 100 (string) - 仕入単価
                    + unit_snapshot:
                        + piece_name: 瓶 (string) - 基本単位名称
                        + box_name: 箱 (string) - まとめ単位名称
                        + factor : 12 (string) - 換算値
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
        * 以下の5つのいずれかを指定してください
        * なしの場合は none
        * 発注前の場合は not_ordered
        * 発注済みの場合は ordered
        * 入庫済の場合は purchased
        * 見積依頼済みの場合は quotation_requested
        * **入庫済を指定した場合は、対象の在庫データの数量を増加します**
    * purchase_date : 入庫日
        * statusによって必須かどうか変わります
        * status=purchased
            * purcahse_dateが必須
        * status=not_ordered
            * purchase_dateは不要
    * memo : 入庫メモ
    * purchase_items : 対象となる在庫データの配列
        * 以下のパラメータを含むオブジェクトを配列の要素とします
            * inventory_id : 在庫データID
            * quantity : 入庫数量
            * unit_price : 仕入単価
            * estimated_purchase_date : 入庫予定日
            * etc : 摘要・備考
            * variants : バリエーションデータ
                * 以下のパラメータを含むオブジェクトを配列の要素とします
                    * items : 以下のパラメータを含むオブジェクトを配列の要素とします
                        * label : バリエーションの項目名
                        * value : バリエーションの値
                    * quantity : バリエーション毎の入庫数量
                    * unit_price : バリエーション毎の仕入単価
                    * code : バーコードの値

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
        * 以下の5つのいずれかが設定されています
        * none : なし
        * not_ordered : 発注前
        * ordered : 発注済み
        * purchased : 入庫済
        * quotation_requested : 見積依頼済み
    * total_amount : 入庫データの合計金額
    * purchase_date : 入庫日
    * estimated_purchase_date : 入庫予定日
        * この入庫予定日は入庫データの物品のうち、最も早い入庫予定日を表示します
    * create_user_name : 入庫データ作成者名
    * memo : 入庫メモ
    * created_at : 入庫データ作成日
    * updated_at : 入庫データ更新日
    * deliveries : 入庫データに登録している在庫データ一覧
        * inventory_id : 在庫データID
        * title : 物品名
        * quantity : 入庫数量
        * box_quantity: まとめ換算数量（基本単位で登録された場合はquantityと同じ値）
        * unit : 単位
        * box_unit : まとめ単位（基本単位で登録された場合はunitと同じ値）
        * unit_snapshot : 単位自動換算情報（まとめ単位で登録された場合のみ）
            * piece_name : 基本単位名
            * box_name : まとめ単位名
            * factor : 換算値
        * unit_price : 仕入単価
        * subtotal_amount : 小計（box_quantity x box_unit）
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
            + ()
                + inventory_id: 2
                + title: ビール (string) - 物品名
                + quantity: 12 (string) - 入庫数量
                + box_quantity: 1 (string) - まとめ換算の入庫数量
                + unit: 瓶 (string) - 単位
                + box_unit: 箱 (string) - まとめ単位
                + unit_price: 100 (string) - 仕入単価
                + unit_snapshot:
                    + piece_name: 瓶 (string) - 基本単位名称
                    + box_name: 箱 (string) - まとめ単位名称
                    + factor : 12 (string) - 換算値
                + status: ordered (string)
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
    * memo : 入庫メモ
    * purchase_items : 対象となる在庫データの配列
        * 以下のパラメータを含むオブジェクトを配列の要素とします
            * inventory_id : 在庫データID
                * 在庫データIDは対象の物品を特定するために指定するため、これを更新することはできません
            * quantity : 入庫数量
            * unit_price : 仕入単価
            * status : 状態
                * 入庫前在庫を更新するときは none, not_ordered, ordered, purchased, quotation_requested を指定できます
                  入庫前在庫を入庫済に更新すると **対象の在庫データの数量を増加します**
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
    * 入庫前：変化なし
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
+ quantity: 25 (number, required) - 出庫数量
+ unit_price: 100 (number, optional) - 納品単価
+ estimated_delivery_date: `2019-09-01` (string, optional, nullable)
+ variants: (array)
    + ()
        + items: (array)
            + ()
                + label: `ロット番号` (string)
                + value: `100` (string)
            + ()
                + label: `拠点` (string)
                + value: `第一倉庫` (string)
            + ()
                + label: `利用期限` (string)
                + value: `2025/12/31` (string)
        + quantity: `10` (number)
        + unit_price: `800` (number)
    + ()
        + items: (array)
            + ()
                + label: `ロット番号` (string)
                + value: `200` (string)
            + ()
                + label: `拠点` (string)
                + value: `第二倉庫` (string)
            + ()
                + label: `利用期限` (string)
                + value: `2026/01/31` (string)
        + quantity: `15` (number)
        + unit_price: `700` (number)

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
* shipping_client (ShippingClientsView) - 発送元
* invoice_type_name: `ヤマト 発払い` (string) - 便指定
+ product_name_on_invoice: `化学薬品` (string) - 品名
+ freight_handling: `ワレ物注意` (string) - 荷扱い
+ freight_handling2: `下載厳禁` (string) - 荷扱い
+ arrival_date: `2023-10-31` (string) - 希望お届け日
+ arrival_hour: `14〜16時` (string) - 希望お届け時間帯

## ShippingInstructionParams

+ to_name: `在庫商会` (string) - 宛名
* to_name_postfix: `御中` (string) - 敬称
* to_zip: `1000101` (string) - 郵便番号
* to_address: `東京都大島町元町` (string) - 住所
* building_name: `ザイコ工場` (string) - 建物名・部屋番号
* to_phone_number: `0312341234` (string) - 電話番号
* shipping_client_id: 123 (number) - 発送元ID
* invoice_type_name: `ヤマト 発払い` (string) - 便指定
+ product_name_on_invoice: `化学薬品` (string) - 品名
* freight_handling: `ワレ物注意` (string) - 荷扱い
* freight_handling2: `下載厳禁` (string) - 荷扱い
* arrival_date: `2023-10-31` (string) - 希望お届け日
* arrival_hour: `14〜16時` (string) - 希望お届け時間帯

## CreatePurchaseItem (object)
+ inventory_id: 1 (number, required) - 在庫データID
+ quantity: 25 (number, required) - 入庫数量
+ unit_price: 100 (number, optional) - 仕入単価
+ estimated_purchase_date: `2019-09-01` (string, optional, nullable)
+ variants: (array)
    + ()
        + items: (array)
            + ()
                + label: `ロット番号` (string)
                + value: `100` (string)
            + ()
                + label: `拠点` (string)
                + value: `第一倉庫` (string)
            + ()
                + label: `利用期限` (string)
                + value: `2025/12/31` (string)
        + quantity: `10` (number)
        + unit_price: `800` (number)
    + ()
        + items: (array)
            + ()
                + label: `ロット番号` (string)
                + value: `200` (string)
            + ()
                + label: `拠点` (string)
                + value: `第二倉庫` (string)
            + ()
                + label: `利用期限` (string)
                + value: `2026/01/31` (string)
        + quantity: `15` (number)
        + unit_price: `700` (number)

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

# Group 入庫物品データ

## 入庫物品データ一覧取得 [/api/v1/purchases/items]
### 入庫物品データ一覧取得 [GET]
#### 処理概要

* 自分のアカウントに登録されている入庫物品データを返します
* 入庫物品データが1件も無い場合は、空の配列を返します
* 入庫物品データが1000件以上ある場合はページネーションで分割され、1000件ごと入庫物品データを返します
* 任意のページを取得するにはURLにクエリ「page=」をつけることで取得できます
* ページ情報はHTTPヘッダ"Link"に最初のページ、前のページ、次のページ、最後のページそれぞれ,(カンマ)で区切られ返されます。最初のページでは「前のページ」、最後のページでは「次のページ」項目は表示されません
* Link, Total-Countヘッダは入庫物品一覧でのみ返されます
* 各入庫物品データの項目について以下のようになります
    * purchase_id: 入庫データID,
    * inventory_id: 在庫データID,
    * title: 物品名,
    * quantity: 入庫数量,
    * unit: 単位,
    * unit_price: 仕入単価,
    * status: ステータス,
    * purchase_date: 入庫日,
    * estimated_purchase_date: 入庫予定日,
    * etc: 摘要・備考
    * created_at: 登録日時
    * updated_at: 更新日時
    * variants : バリエーションデータ
        * 以下のパラメータを含むオブジェクトを配列の要素とします
            * data_key : 在庫毎にバリエーションデータを一意に識別するキー
            * quantity : バリエーション明細の入庫数量
            * unit_price : バリエーション明細の仕入単価
            * amount : バリエーション明細の入庫金額
            * unit_snapshot : 単位情報のスナップショット
                * 以下のパラメータを含むオブジェクトとします
                    * factor : まとめ単位の換算係数
                    * piece_name : 基本単位の名称
                    * box_name : まとめ単位の名称
            * box_quantity : まとめ単位での入庫数量
            * box_unit : まとめ単位の名称
            * items : 以下のパラメータを含むオブジェクトとします
                * id : 以下のパラメータを含むオブジェクトとします
                    * id : バリエーションの項目ID
                    * value : バリエーションの値

+ Parameters
    + status: `none, not_ordered, ordered, purchased, quotation_requested` (string, optional) - ステータス
    + start_date: `2019-09-01` (string, optional) - 入庫日がこの日以降
    + end_date: `2019-09-01` (string, optional) - 入庫日がこの日以前
    + page: 1 (number, optional) - ページ番号
+ Request
    + Headers
      Authorization: Bearer YOUR_TOKEN
      Content-Type: application/json
+ Response 200 (application/json)
    + Attributes (array)
        + ()
            + purchase_id: 10 (number)
            + inventory_id: 1 (number)
            + title: 掃除機 (string)
            + quantity: 3 (string)
            + unit: 台 (string)
            + unit_price: 100 (string)
            + status: purchased (string)
            + purchase_date: 2021-11-17 (string)
            + estimated_purchase_date: (string, nullable)
            + etc: (string)
            + created_at: `2023-11-16 11:27:24` (string)
            + updated_at: `2023-11-16 11:27:24` (string)
        + ()
            + purchase_id: 10 (number)
            + inventory_id: 2 (number)
            + title: りんご (string)
            + quantity: 10 (string)
            + unit: 個 (string)
            + unit_price: 200 (string)
            + status: purchased (string)
            + purchase_date: 2021-11-17 (string)
            + estimated_purchase_date: (string, nullable)
            + etc: (string)
            + created_at: `2023-11-16 11:27:24` (string)
            + updated_at: `2023-11-16 11:27:24` (string)
            + variants: (array)
                + ()
                    + data_key: 347554bad83fd5dc1624af2c97895e279eef35f8e252231169172d0fd96757df (string)
                    + quantity: 10.0 (number)
                    + unit_price: 200.0 (number)
                    + amount: 2000.0 (number)
                    + box_quantity: 10.0 (number)
                    + box_unit: 個 (string)
                    + items: ()
                        + 2: ()
                            + id: 2 (number)
                            + value: 第一倉庫 (string)
                        + 3: ()
                            + id: 3 (number)
                            + value: 2023/11/30 (string)

## 入庫物品データ削除 [/api/v1/purchases/items/{id}]
### 入庫物品データ削除 [DELETE]
#### 処理概要

* 特定の入庫物品データを削除します
* 入庫物品データの状態によって在庫データの取り扱いが変わります
    * 入庫前：変化なし
    * 入庫済：在庫データの数量を入庫数量分だけ戻します

* Parameters
    * id: 1 (number) - 入庫物品データのID

* Request
    * Headers

            Authorization: Bearer YOUR_TOKEN
            Content-Type: application/json

* Response 200 (application/json)
    * Attributes
        * code: 200 (number) - ステータスコード
        * status: success (string) - 状態
        * message: Data was successfully deleted (string) - メッセージ

* Response 404 (application/json)
    * Attributes
        * code: 404 (number) - ステータスコード
        * status: error (string) - 状態
        * message: Purchase item not found (string) - メッセージ

