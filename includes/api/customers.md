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
* 入出庫区分は「packing_slip」または「purchase」が指定可能です
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
* 入出庫区分は「packing_slip」または「purchase」が指定可能です
* 該当する取引先データが無い場合はエラーを返します
* パースできないJSONを送るとエラーを返します

+ Parameters
  + id: 1 (number, required) - 取引先データのID

+ Params
  + Attributes (CustomerCreateParams)

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
+ name: `取引先A` (string) - 取引先名（最大100文字）
+ email: `zaico@example.com` (string) - メールアドレス（最大200文字）
+ name_postfix: `様` (string) - 敬称（最大10文字）
+ zip: `1234567` (string) - 郵便番号（最大7文字）
+ address: `東京都港区` (string) - 住所（最大1000文字）
+ building_name: `港ビル` (string) - 建物名・部屋番号（最大1000文字）
+ phone_number: `08012345678` (string) - 電話番号（最大11文字）
+ etc: `取引先` (string) - 備考（最大500文字）
+ fax_number: `5678` (string) - FAX番号
+ category: `東京` (string) - カテゴリ
+ `customer_type`: `packing_slip` (string) - 入出庫区分
+ num: `1` (string) - 取引先No.（最大200文字）

### CustomerCreateParams
+ name: `取引先A` (string, required) - 取引先名（最大100文字）
+ email: `zaico@example.com` (string) - メールアドレス（最大200文字）
+ name_postfix: `様` (string) - 敬称（最大10文字）
+ zip: `1234567` (string) - 郵便番号（最大7文字）
+ address: `東京都港区` (string) - 住所（最大1000文字）
+ building_name: `港ビル` (string) - 建物名・部屋番号（最大1000文字）
+ phone_number: `08012345678` (string) - 電話番号（最大11文字）
+ etc: `取引先` (string) - 備考（最大500文字）
+ fax_number: `5678` (string) - FAX番号
+ category: `東京` (string) - カテゴリ
+ `customer_type`: `purchase` (string) - 入出庫区分
+ num: `1` (string) - 取引先No.（最大200文字）

### CustomerCreateSuccessfully
+ code: 200 (number) - コード
+ status: `success` (string) - ステータス
+ message: `Data was successfully created` (string) - メッセージ
+ data_id: 1 (number) - レコードID

### CustomerUpdateParams
+ name: `取引先A` (string) - 取引先名（最大100文字）
+ email: `zaico@example.com` (string) - メールアドレス（最大200文字）
+ name_postfix: `様` (string) - 敬称（最大10文字）
+ zip: `1234567` (string) - 郵便番号（最大7文字）
+ address: `東京都港区` (string) - 住所（最大1000文字）
+ building_name: `港ビル` (string) - 建物名・部屋番号（最大1000文字）
+ phone_number: `08012345678` (string) - 電話番号（最大11文字）
+ etc: `取引先` (string) - 備考（最大500文字）
+ fax_number: `5678` (string) - FAX番号
+ category: `東京` (string) - カテゴリ
+ `customer_type`: `packing_slip` (string) - 入出庫区分
+ num: `1` (string) - 取引先No.（最大200文字）

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
