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
