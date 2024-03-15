# Group 在庫グループビューデータ
## 一覧取得 [/api/v1/inventory_group_items]
### GET
#### 処理概要
* フルプランの方のみ利用可能です
* 自分のアカウントに登録されている在庫グループビューデータのすべてを返します
* 在庫データが1件も無い場合は、空の配列を返します
* 発注点は機能を有効にしている場合のみ表示されます
* 在庫データが1000件以上ある場合はページネーションで分割され、1000件ごと在庫データを返します
* 任意のページを取得するにはURLにクエリ「page=」をつけることで取得できます。サンプルプログラムなど詳しくはこちらのページをご覧ください( https://www.zaico.co.jp/2019/03/29/zaico-api-update-get-inventories/ )
* ページ情報はHTTPヘッダ"Link"に最初のページ、前のページ、次のページ、最後のページそれぞれ,(カンマ)で区切られ返されます。最初のページでは「前のページ」、最後のページでは「次のページ」項目は表示されません
* Link, Total-Countヘッダは在庫一覧でのみ返されます
* 条件を指定して検索できます。検索できる項目は「group_value」、「title」の2つです。検索する場合は以下のようにリクエストを送ってください。（下記の例は全部の項目に該当する在庫グループビューデータを検索するものです。必要な項目のクエリを発行ください。）
    * 1つの項目に複数の値をいれて検索することはできません。

  ```http
  Ref：
  https://web.zaico.co.jp/api/v1/inventory_group_items/?group_value={GROUP_VALUE}&title={TITLE}
  例：
  https://web.zaico.co.jp/api/v1/inventory_group_items/?group_value=SKU-1&title=在庫データ
  ``` 

+ Request
  + Headers
    Authorization: Bearer YOUR_TOKEN
    Content-Type: application/json

+ Response 200 (application/json)
  + Headers
    Link: <https://web.zaico.co.jp/api/v1/inventory_group_items?page=1>; rel="first", <https://web.zaico.co.jp/api/v1/inventory_group_items?page=前のページ>; rel="prev", <https://web.zaico.co.jp/api/v1/inventory_group_items?page=次のページ>; rel="next", <https://web.zaico.co.jp/api/v1/inventory_group_items?page=最後のページ>; rel="last"
    Total-Count: 在庫グループビューデータ件数
  + Attributes (InventoryGroupItemsViews)

## 個別取得 [/api/v1/inventory_group_items/{id}]
### GET
#### 処理概要
* 在庫グループビューデータを1件のみ取得します
* 発注点は機能を有効にしている場合のみ表示されます

### 注意事項
* 在庫グループビューデータが無い場合は404を返します

+ Parameters
  + id: 1 (number, required) - 在庫グループビューデータのID

+ Request
  + Headers
    Authorization: Bearer YOUR_TOKEN
    Content-Type: application/json

+ Response 200 (application/json)
  + Attributes (InventoryGroupItemsViews)

+ Response 404 (application/json)
  + Attributes (InventoryGroupItemNotFound)


## 発注点の設定 [/api/v1/inventory_group_items/{id}/order_points]
### PUT 
#### 処理概要
* 在庫グループビューデータに対して発注点を設定します
* 発注点機能を有効にしている場合のみ利用可能です

### 注意事項
* 在庫グループビューデータが無い場合は404を返します

+ Parameters
  + id: 1 (number, required) - 在庫グループビューデータのID

+ Request
  + Headers
    Authorization: Bearer YOUR_TOKEN
    Content-Type: application/json

  + Params
    + Attributes (InventoryGroupItemsOrderPointsUpdateParams)

+ Response 200 (application/json)
  + Attributes (InventoryGroupItemsViews)

+ Response 404 (application/json)
  + Attributes (InventoryGroupItemNotFound)

## 発注点の警告ON [/api/v1/inventory_group_items/{id}/order_points/warning_on]
### POST 
#### 処理概要
* 在庫グループビューデータの数量が発注点以下の場合の警告表示状態をONにします。
* 発注点機能を有効にしている場合のみ利用可能です

### 注意事項
* 在庫グループビューデータが無い場合は404を返します

+ Parameters
  + id: 1 (number, required) - 在庫グループビューデータのID

+ Request
  + Headers
    Authorization: Bearer YOUR_TOKEN
    Content-Type: application/json

+ Response 200 (application/json)
  + Attributes (InventoryGroupItemsViews)

+ Response 404 (application/json)
  + Attributes (InventoryGroupItemNotFound)

## 発注点の警告OFF [/api/v1/inventory_group_items/{id}/order_points/warning_off]
### POST
#### 処理概要
* 在庫グループビューデータの数量が発注点以下の場合の警告表示状態をOFFにします。
* 発注点機能を有効にしている場合のみ利用可能です

### 注意事項
* 在庫グループビューデータが無い場合は404を返します

+ Parameters
  + id: 1 (number, required) - 在庫グループビューデータのID

+ Request
  + Headers
    Authorization: Bearer YOUR_TOKEN
    Content-Type: application/json

+ Response 200 (application/json)
  + Attributes (InventoryGroupItemsViews)

+ Response 404 (application/json)
  + Attributes (InventoryGroupItemNotFound)

## Data Structures

### InventoryGroupItemsViews
+ id: 1 (number) - ID
+ title: `在庫データ` (string) - タイトル
+ quantity: 10 (number) - 数量
+ logical_quantity: 10 (number) - 予定フリー在庫数
+ order_point_quantity: 10 (number) - 発注点（発注点機能がONの場合のみ）
+ order_point_warning: false (boolean) - 発注点の警告ON/OFF（発注点機能がONの場合のみ）
+ group_value: `グループタグ` (string) - グループタグ
+ created_at: `2018-03-27T09:38:19+09:00` (string) - 作成日
+ updated_at `2018-03-27T09:38:19+09:00` (string) - 更新日

### InventoryGroupItemsOrderPointsUpdateParams
+ order_point_quantity: 10 (string) - 発注点

### InventoryGroupItemNotFound
+ code: 404 ( number ) - ステータスコード
+ status: `error` ( string ) - ステータス
+ message: `InventoryGroupItem not found` ( string ) - エラー内容
