# Group 在庫データの写真・ファイル

## 写真・ファイル一覧取得 [/api/v1/inventory_attachments/{inventory_id}]
### GET
#### 処理概要
* 指定した在庫データに紐づくすべての写真・ファイルを取得します。
* 写真・ファイルが1件もない場合は、空の配列を返します。
* 削除された写真・ファイルは含まれません。

+ Parameters
    + inventory_id: `12345` (string, required) - 在庫データID

+ Request
    + Headers
            Authorization: Bearer YOUR_TOKEN
            Content-Type: application/json

+ Response 200 (application/json)
    + Attributes (array)
        + (object)
            + id: `1` (number) - 写真・ファイルのID
            + original_filename: `image1.jpg` (string) - ファイル名
            + url: `https://web.zaico.co.jp/files/image1.jpg` (string) - ファイルのURL
            + created_at: `2022-01-01 09:00:00` (string) - 作成日時

## 写真・ファイル追加 [/api/v1/inventory_attachments/{inventory_id}]
### POST
#### 処理概要
* 指定した在庫データに１つの新しい写真・ファイルを追加します。
* １つの在庫に添付できる写真・ファイルの数は合計10件までです。

+ Parameters
    + inventory_id: `12345` (string, required) - 在庫データID

+ Request
    + Headers
            Authorization: Bearer YOUR_TOKEN
            Content-Type: multipart/form-data

    + Attributes
       + inventory_attachment (object)  
           + item_file: `添付する写真またはファイルのバイナリデータ` (string, required) - 添付する写真またはファイルのバイナリデータ

+ Response 200 (application/json)
    + Attributes
        + id: `3` (number) - 追加された写真・ファイルのID
        + original_filename: `new_image.jpg` (string) - ファイル名
        + url: `https://web.zaico.co.jp/files/new_image.jpg` (string) - ファイルのURL
        + created_at: `2022-01-01 09:00:00` (string) - 作成日時

## 写真・ファイル削除 [/api/v1/inventory_attachments/{inventory_id}/{inventory_attachment_id}]
### DELETE
#### 処理概要
* 指定した在庫データから写真・ファイルを削除します。

+ Parameters
    + inventory_id: `12345` (string, required) - 在庫データID
    + inventory_attachment_id: `6789` (integer, required) - 削除する写真・ファイルのID

+ Request
    + Headers
            Authorization: Bearer YOUR_TOKEN
            Content-Type: application/json

+ Response 200
