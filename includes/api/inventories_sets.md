# Group セット品データ

## セット品データ一覧取得 [/api/v1/inventories_sets]
### GET
#### 処理概要
* 自分のアカウントに登録されているセット品データのすべてを返します
* セット品データが1件も無い場合は、空の配列を返します  
* セット品データが100件以上ある場合はページネーションで分割され、100件ごとセット品データを返します
* 任意のページを取得するにはURLにクエリ「page=」をつけることで取得できます
* ページ情報はHTTPヘッダ"Link"に最初のページ、前のページ、次のページ、最後のページそれぞれ,(カンマ)で区切られ返されます。最初のページでは「前のページ」、最後のページでは「次のページ」項目は表示されません
* Link, Total-Countヘッダはセット品一覧でのみ返されます
* 各セット品データの項目について以下のようになります
   * id : セット品データID 
   * title : セット品名
   * price : 価格
   * code : コード
   * memo : メモ
   * update_user_id : 更新ユーザーID
   * available_delivery_quantity : 出庫可能数量
   * created_at : 作成日時
   * updated_at : 更新日時
   * inventories_set_items : セット品構成品目
       * inventory_id : 在庫ID
       * quantity : 数量
       * created_at : 作成日時 
       * updated_at : 更新日時
       * inventory_title : 在庫名
       * inventory_quantity : 在庫数量
       * inventory_del_flg : 在庫削除フラグ

+ Request
   + Headers
       Authorization: Bearer YOUR_TOKEN
       Content-Type: application/json

+ Response 200 (application/json)
   + Headers
       Link: <https://web.zaico.co.jp/api/v1/inventories_sets?page=1>; rel="first", <https://web.zaico.co.jp/api/v1/inventories_sets?page=前のページ>; rel="prev", <https://web.zaico.co.jp/api/v1/inventories_sets?page=次のページ>; rel="next", <https://web.zaico.co.jp/api/v1/inventories_sets?page=最後のページ>; rel="last"
       Total-Count: セット品データ件数
   + Attributes (array)
       + (object)
           + id: 123 (number) - ID
           + title: `セット品A` (string) - セット品名 
           + price: 1000 (number) - 価格
           + code: `123456` (string) - コード
           + memo: `メモ` (string) - メモ  
           + update_user_id: 1 (number) - 更新ユーザーID
           + available_delivery_quantity: 5 (number) - 出庫可能数量
           + created_at: `2022-01-01 09:00:00` (string) - 作成日時
           + updated_at: `2022-01-02 10:00:00` (string) - 更新日時
           + inventories_set_items (array[object], fixed-type)
               + (object)
                   + inventory_id: 1 (number) - 在庫ID
                   + quantity: 1 (number) - 数量
                   + created_at: `2022-01-01 09:00:00` (string) - 作成日時
                   + updated_at: `2022-01-02 10:00:00` (string) - 更新日時
                   + inventory_title: `構成部品A` (string) - 在庫名
                   + inventory_quantity: 10 (number) - 在庫数量
                   + inventory_del_flg: false (boolean) - 在庫削除フラグ   
               + (object)
                   + inventory_id: 2 (number)
                   + quantity: 2 (number)
                   + created_at: `2022-01-01 09:00:00` (string)
                   + updated_at: `2022-01-02 10:00:00` (string)
                   + inventory_title: `構成部品B` (string)
                   + inventory_quantity: 20 (number)
                   + inventory_del_flg: false (boolean)
      
## セット品データ作成 [/api/v1/inventories_sets] 
### POST
#### 処理概要
* セット品データを作成します
* 送られたパラメータにタイトルが無い場合やデータが無い場合はエラーを返します

+ Request
   + Headers
       Authorization: Bearer YOUR_TOKEN
       Content-Type: application/json
   + Attributes
       + title: `セット品A` (string, required) - セット品名
       + price: 1000 (number, optional) - 価格 
       + code: `123456` (string, optional) - コード
       + inventories_set_items_attributes (array[object], fixed-type)  
           + (object)
               + inventory_id: 1 (number, required) - 在庫ID
               + quantity: 1 (number, required) - 数量
           + (object)
               + inventory_id: 2 (number, required)
               + quantity: 2 (number, required)
       
+ Response 200 (application/json)
   + Attributes
       + code: 200 (number) - ステータスコード
       + status: success (string) - 状態
       + message: `Data was successfully created` (string) - メッセージ
       + data_id: 123 (number) - 作成したセット品のID

+ Response 422 (application/json)
   + Attributes
       + code: 422 (number) - ステータスコード
       + status: error (string) - 状態
       + message: `Invalid data` (string) - メッセージ
       
## セット品データ個別取得 [/api/v1/inventories_sets/{id}]
### GET
#### 処理概要 
* セット品データを1件のみ取得します
* パラメータに指定したIDのセット品が存在しない場合は404を返します
* 各セット品データの項目について以下のようになります
   * id : セット品データID
   * title : セット品名
   * price : 価格
   * code : コード
   * memo : メモ
   * update_user_id : 更新ユーザーID
   * available_delivery_quantity : 出庫可能数量
   * available_delivery_logical_quantity : 予定フリー出庫可能数量 （フルプランでlogical_quantity機能を利用している場合のみ）
   * created_at : 作成日時
   * updated_at : 更新日時
   * inventories_set_items : セット品構成品目
       * inventory_id : 在庫ID
       * quantity : 数量
       * created_at : 作成日時
       * updated_at : 更新日時
       * inventory_title : 在庫名
       * inventory_quantity : 在庫数量
       * inventory_logical_quantity: 予定フリー在庫数（フルプランでlogical_quantity機能を利用している場合のみ）
       * inventory_del_flg : 在庫削除フラグ

+ Parameters  
   + id: 123 (number, required) - セット品ID

+ Request
   + Headers
       Authorization: Bearer YOUR_TOKEN
       Content-Type: application/json

+ Response 200 (application/json)
   + Attributes
       + id: 123 (number) - セット品ID
       + title: `セット品A` (string) - セット品名
       + price: 1000 (number) - 価格
       + code: `123456` (string) - コード
       + memo: `メモ` (string) - メモ
       + update_user_id: 1 (number) - 更新ユーザーID
       + available_delivery_quantity: 5 (number) - 出庫可能数量 
       + available_delivery_logical_quantity: 3 (number) - 予定フリー出庫可能数量
       + created_at: `2022-01-01 09:00:00` (string) - 作成日時
       + updated_at: `2022-01-02 10:00:00` (string) - 更新日時
       + inventories_set_items (array[object], fixed-type)
           + (object) 
               + inventory_id: 1 (number) - 在庫ID
               + quantity: 1 (number) - 数量
               + created_at: `2022-01-01 09:00:00` (string) - 作成日時
               + updated_at: `2022-01-02 10:00:00` (string) - 更新日時
               + inventory_title: `構成部品A` (string) - 在庫名
               + inventory_quantity: 10 (number) - 在庫数量 
               + inventory_logical_quantity: 8 (number) - 予定フリー在庫数
               + inventory_del_flg: false (boolean) - 在庫削除フラグ
           + (object)
               + inventory_id: 2 (number)
               + quantity: 2 (number)
               + created_at: `2022-01-01 09:00:00` (string)
               + updated_at: `2022-01-02 10:00:00` (string)
               + inventory_title: `構成部品B` (string)
               + inventory_quantity: 20 (number)
               + inventory_logical_quantity: 18 (number)
               + inventory_del_flg: false (boolean)
     
+ Response 404 (application/json)
   + Attributes
       + code: 404 (number) - ステータスコード
       + status: error (string) - 状態
       + message: Data not found (string) - メッセージ

## セット品データ更新 [/api/v1/inventories_sets/{id}]
### PUT
#### 処理概要
* 特定のセット品データを更新します
* パラメータに指定したIDのセット品が存在しない場合は404を返します

+ Parameters
   + id: 123 (number, required) - セット品ID

+ Request
   + Headers  
       Authorization: Bearer YOUR_TOKEN
       Content-Type: application/json
   + Attributes
       + title: `セット品A` (string) - セット品名
       + price: 1000 (number) - 価格
       + code: `123456` (string) - コード
       + inventories_set_items_attributes (array[object], fixed-type)
           + (object)
               + inventory_id: 1 (number, required) - 在庫ID
               + quantity: 1 (number, required) - 数量
           + (object) 
               + inventory_id: 2 (number, required)
               + quantity: 2 (number, required)
       
+ Response 200 (application/json)
   + Attributes
       + code: 200 (number) - ステータスコード
       + status: success (string) - 状態
       + message: `Data was successfully updated` (string) - メッセージ

+ Response 422 (application/json) 
   + Attributes
       + code: 422 (number) - ステータスコード
       + status: error (string) - 状態 
       + message: `Invalid data` (string) - メッセージ

+ Response 404 (application/json)
   + Attributes
       + code: 404 (number) - ステータスコード
       + status: error (string) - 状態
       + message: Data not found (string) - メッセージ
       
## セット品データ削除 [/api/v1/inventories_sets/{id}]
### DELETE
#### 処理概要
* 特定のセット品データを削除します
* パラメータに指定したIDのセット品が存在しない場合は404を返します

+ Parameters
   + id: 123 (number, required) - セット品ID

+ Request
   + Headers
       Authorization: Bearer YOUR_TOKEN
       Content-Type: application/json

+ Response 200 (application/json)
   + Attributes  
       + code: 200 (number) - ステータスコード
       + status: success (string) - 状態
       + message: `Data was successfully deleted` (string) - メッセージ

+ Response 422 (application/json)
   + Attributes
       + code: 422 (number) - ステータスコード
       + status: error (string) - 状態
       + message: `Invalid data` (string) - メッセージ

+ Response 404 (application/json)
   + Attributes
       + code: 404 (number) - ステータスコード 
       + status: error (string) - 状態
       + message: Data not found (string) - メッセージ
