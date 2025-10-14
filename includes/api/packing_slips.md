# Group 出庫データ

## 出庫データ一覧取得 [/api/v1/packing_slips/]
### 出庫データ一覧取得 [GET]
#### 処理概要
* 自分のアカウントに登録されている出庫データのすべてを返します
* 出庫データが1件も無い場合は、空の配列を返します
* 出庫データが100件以上ある場合はページネーションで分割され、100件ごと出庫データを返します
* 任意のページを取得するにはURLにクエリ「page=」をつけることで取得できます。
* ページ情報はHTTPヘッダ"Link"に最初のページ、前のページ、次のページ、最後のページそれぞれ,(カンマ)で区切られ返されます。最初のページでは「前のページ」、最後のページでは「次のページ」項目は表示されません
* Link, Total-Countヘッダは納品一覧でのみ返されます
* 各出庫データの項目について以下のようになります
    * id : 出庫データID
    * num : 出庫データ番号（ユーザーが任意に設定できる番号）
    * customer_name : 取引先名
    * status : 出庫データの状態
        * 以下の3つのいずれかが設定されています
        * before_delivery : 出庫前
        * during_delivery : 出庫中
        * completed_delivery : 出庫済
    * total_amount : 出庫データの合計金額
    * delivery_date : 出庫日
    * estimated_delivery_date : 出庫予定日
        * この出庫予定日は出庫データの物品のうち、最も早い出庫予定日を表示します
    * memo : 出庫メモ
    * note: 納品書備考
    * created_at : 出庫データ作成日
    * updated_at : 出庫データ更新日
    * deliveries : 出庫データに登録している在庫データ一覧
        * id : 出庫物品データID
        * inventory_id : 在庫データID
        * title : 物品名
        * quantity : 出庫数量
        * box_quantity: まとめ換算数量（基本単位で登録された場合はquantityと同じ値）
        * unit : 単位
        * box_unit : まとめ単位（基本単位で登録された場合はunitと同じ値）
        * unit_snapshot : 単位自動換算情報（まとめ単位で登録された場合のみ）
            * piece_name : 基本単位名
            * box_name : まとめ単位名
            * factor : 換算値
        * unit_price : 納品単価
        * subtotal_amount : 小計（box_quantity x box_unit）
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
        * shipping_client : 発送元
            * id : 発送元ID
            * name : 名前/会社名
            * zip : 郵便番号
            * address : 住所
            * building_name : 建物名・部屋番号
            * phone_number : 電話番号
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
                    + id: 1 (number)
                    + inventory_id: 1 (number)
                    + title: 掃除機 (string) - 物品名
                    + quantity: 3 (string) - 出庫数量
                    + unit: 台 (string) - 単位
                    + unit_price: 100 (string) - 納品単価
                    + status: completed_delivery (string)
                    + delivery_date: `2019-09-01` (string)
                    + estimated_delivery_date (string, optional, nullable)
                    + etc: 黒色 (string) - 摘要・備考
                + (object)
                    + id: 2 (number)
                    + inventory_id: 2 (number)
                    + title: テレビ (string) - 物品名
                    + quantity: 3 (string) - 出庫数量
                    + unit: 台 (string) - 単位
                    + unit_price: 100 (string) - 納品単価
                    + status: completed_delivery (string)
                    + delivery_date: `2019-09-01` (string)
                    + estimated_delivery_date (string, optional, nullable)
                    + etc: (string) - 摘要・備考
                + (object)
                    + id: 3 (number)
                    + inventory_id: 3 (number)
                    + title: ビール (string) - 物品名
                    + quantity: 12 (string) - 出庫数量
                    + box_quantity: 1 (string) - まとめ換算の入庫数量
                    + unit: 瓶 (string) - 単位
                    + box_unit: 箱 (string) - まとめ単位
                    + unit_price: 100 (string) - 納品単価
                    + unit_snapshot:
                        + piece_name: 瓶 (string) - 基本単位名称
                        + box_name: 箱 (string) - まとめ単位名称
                        + factor : 12 (string) - 換算値
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
                    + quantity: 3 (string) - 出庫数量
                    + unit: 台 (string) - 単位
                    + unit_price: 100 (string) - 納品単価
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
        * 以下の3つのいずれかを指定してください
        * 出庫前の場合は before_delivery
        * 出庫中の場合は during_delivery
        * 出庫済の場合は completed_delivery
        * **出庫済みを指定した場合は、対象の在庫データの数量を減少します**
    * delivery_date : 出庫日
        * statusによって必須かどうか変わります
        * status=completed_delivery
            * delivery_dateが必須
        * status=before_delivery
            * delivery_dateは不要
    * memo : 出庫メモ
    * note: 納品書備考
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
            * 指定可能な値 : `ヤマト 発払い` `ヤマト DM便` `ヤマト 着払い` `ヤマト ネコポス` `佐川 元払` `佐川 着払` `ゆうパケット` `クリックポスト` `その他`
        * product_name_on_invoice : 品名
        * freight_handling : 荷扱い
            * 指定可能な値 : `指定なし` `ワレ物注意` `下載厳禁` `天地無用` `精密機器` `ナマモノ` `水濡厳禁` `取扱注意` （※「取扱注意」は佐川のみ）
        * freight_handling2 : 荷扱い
            * 指定可能な値 : `指定なし` `ワレ物注意` `下載厳禁` `天地無用` `精密機器` `ナマモノ` `水濡厳禁` `取扱注意` （※「取扱注意」は佐川のみ）
        * arrival_date : 希望お届け日
        * arrival_hour : 希望お届け時間帯
            * 指定可能な値 : `指定なし` `午前中` `14〜16時` `16〜18時` `18〜20時` `19〜21時`

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
        + shipping_instruction (ShippingInstructionParams)

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
        * 以下の3つのいずれかが設定されています
        * before_delivery : 出庫前
        * during_delivery : 出庫中
        * completed_delivery : 出庫済み
    * total_amount : 出庫データの合計金額
    * delivery_date : 出庫日
    * estimated_delivery_date : 出庫予定日
        * この出庫予定日は出庫データの物品のうち、最も早い出庫予定日を表示します
    * memo : 出庫メモ
    * note: 納品書備考
    * created_at : 出庫データ作成日
    * updated_at : 出庫データ更新日
    * deliveries : 出庫データに登録している在庫データ一覧
        * inventory_id : 在庫データID
        * title : 物品名
        * quantity : 出庫数量
        * box_quantity: まとめ換算数量（基本単位で登録された場合はquantityと同じ値）
        * unit : 単位
        * box_unit : まとめ単位（基本単位で登録された場合はunitと同じ値）
        * unit_snapshot : 単位自動換算情報（まとめ単位で登録された場合のみ）
            * piece_name : 基本単位名
            * box_name : まとめ単位名
            * factor : 換算値
        * unit_price : 納品単価
        * subtotal_amount : 小計（box_quantity x box_unit）
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
        * shipping_client : 発送元
            * id : 発送元ID
            * name : 名前/会社名
            * zip : 郵便番号
            * address : 住所
            * building_name : 建物名・部屋番号
            * phone_number : 電話番号
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
                + quantity: 3 (string) - 出庫数量
                + unit: 台 (string) - 単位
                + unit_price: 100 (string) - 納品単価
                + status: completed_delivery (string)
                + delivery_date: `2019-09-01` (string)
                + estimated_delivery_date (string, optional, nullable)
                + etc: 白色 (string) - 摘要・備考
            + (object)
                + inventory_id: 2 (number)
                + title: テレビ (string) - 物品名
                + quantity: 3 (string) - 出庫数量
                + unit: 台 (string) - 単位
                + unit_price: 100 (string) - 納品単価
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
    * memo : 出庫メモ
    * note: 納品書備考
    * deliveries : 対象となる在庫データの配列
        * 以下のパラメータを含むオブジェクトを配列の要素とします
            * inventory_id : 在庫データID
                * 在庫データIDは対象の物品を特定するために指定するため、これを更新することはできません
            * quantity : 出庫数量
            * unit_price : 納品単価
            * status : 状態
                * 出庫前在庫を更新するときは before_delivery, during_delivery, completed_delivery を指定できます
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
            * 指定可能な値 : `ヤマト 発払い` `ヤマト DM便` `ヤマト 着払い` `ヤマト ネコポス` `佐川 元払` `佐川 着払` `ゆうパケット` `クリックポスト` `その他`
        * product_name_on_invoice : 品名
        * freight_handling : 荷扱い
            * 指定可能な値 : `指定なし` `ワレ物注意` `下載厳禁` `天地無用` `精密機器` `ナマモノ` `水濡厳禁` `取扱注意` （※「取扱注意」は佐川のみ）
        * freight_handling2 : 荷扱い
            * 指定可能な値 : `指定なし` `ワレ物注意` `下載厳禁` `天地無用` `精密機器` `ナマモノ` `水濡厳禁` `取扱注意` （※「取扱注意」は佐川のみ）
        * arrival_date : 希望お届け日
        * arrival_hour : 希望お届け時間帯
            * 指定可能な値 : `指定なし` `午前中` `14〜16時` `16〜18時` `18〜20時` `19〜21時`

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
        + shipping_instruction (ShippingInstructionParams)

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

# Group 出庫物品データ

## 出庫物品データ一覧取得 [/api/v1/deliveries]
### 出庫物品データ一覧取得 [GET]
#### 処理概要

* 自分のアカウントに登録されている出庫物品データを返します
* 出庫物品データが1件も無い場合は、空の配列を返します
* 出庫物品データが1000件以上ある場合はページネーションで分割され、1000件ごと出庫物品データを返します
* 任意のページを取得するにはURLにクエリ「page=」をつけることで取得できます
* ページ情報はHTTPヘッダ"Link"に最初のページ、前のページ、次のページ、最後のページそれぞれ,(カンマ)で区切られ返されます。最初のページでは「前のページ」、最後のページでは「次のページ」項目は表示されません
* Link, Total-Countヘッダは出庫物品一覧でのみ返されます
* 各出庫物品データの項目について以下のようになります
    * packing_slip_id: 出庫データID,
    * inventory_id: 在庫データID,
    * title: 物品名,
    * quantity: 出庫数量,
    * unit: 単位,
    * unit_price: 出庫単価,
    * status: ステータス,
    * delivery_date: 出庫日,
    * estimated_delivery_date: 出庫予定日,
    * etc: 摘要・備考
    * date_of_issue: 納品書に記載される出庫日,
    * created_at: 登録日時
    * updated_at: 更新日時

+ Parameters
    + status: `before_delivery, during_delivery, completed_delivery`, `completed_delivery` (string, optional) - ステータス
        + start_date: `2019-09-01` (string, optional) - 出庫日がこの日以降
        + end_date: `2019-09-01` (string, optional) - 出庫日がこの日以前
        + page: 1 (number, optional) - ページ番号
+ Request
    + Headers
      Authorization: Bearer YOUR_TOKEN
      Content-Type: application/json
+ Response 200 (application/json)
    + Attributes (array)
        + ()
            + packing_slip_id: 10 (number)
            + inventory_id: 1 (number)
            + title: 掃除機 (string)
            + quantity: 3 (string)
            + unit: 台 (string)
            + unit_price: 100 (string)
            + status: completed_delivery (string)
            + delivery_date: 2021-11-17 (string)
            + estimated_delivery_date: (string, nullable)
            + etc: (string)
            + date_of_issue: 2021-11-17 (string)
            + created_at: `2023-11-16 11:27:24` (string)
            + updated_at: `2023-11-16 11:27:24` (string)
        + ()
            + packing_slip_id: 10 (number)
            + inventory_id: 1 (number)
            + title: 掃除機 (string)
            + quantity: 3 (string)
            + unit: 台 (string)
            + unit_price: 100 (string)
            + status: completed_delivery (string)
            + delivery_date: 2021-11-17 (string)
            + estimated_delivery_date: (string, nullable)
            + etc: (string)
            + date_of_issue: 2021-11-17 (string)
            + created_at: `2023-11-16 11:27:24` (string)
            + updated_at: `2023-11-16 11:27:24` (string)
