---
description: 公開APIドキュメント（zaico_api_doc）とzaico_webの実装を比較し、スキーマ定義（型、最大文字列長、必須）の不整合を検出・修正する
---

# 公開APIドキュメント同期コマンド

## 概要

公開APIドキュメント（API Blueprint形式）とzaico_webの実装を比較し、以下の不整合を検出・修正します：

- maxLength（最大文字列長）の定義漏れ・不整合
- required（必須）の定義漏れ・不整合
- レスポンス項目の漏れ

## 実行手順

### 1. モデルバリデーションの確認

zaico_webの以下のモデルから`validates`を抽出：

- app/models/inventory.rb
- app/models/customer.rb
- app/models/packing_slip.rb
- app/models/purchase.rb
- app/models/delivery.rb
- app/models/purchase_item.rb
- app/models/inventories_set.rb
- app/models/inventories_set_item.rb
- app/models/shipping_client.rb
- app/models/inventory_attachment.rb

確認項目：
- `validates :field, presence: true` → required
- `validates :field, length: { maximum: N }` → maxLength

### 2. DBスキーマの確認

`zaico_web/db/schema.rb`から以下を確認：

- string型カラムの`limit`制約
- `null: false`制約（モデルバリデーションがない場合の補完）

### 3. jbuilderの確認

`zaico_web/app/views/api/v1/`配下のjbuilderファイルから出力項目を確認：

- inventories/index.json.jbuilder
- inventories/show.json.jbuilder
- customers/index.json.jbuilder
- packing_slips/index.json.jbuilder
- packing_slips/show.json.jbuilder
- purchases/index.json.jbuilder
- purchases/show.json.jbuilder
- inventories_sets/index.json.jbuilder
- inventories_sets/show.json.jbuilder
- inventory_attachments/index.json.jbuilder
- inventory_group_items/index.json.jbuilder
- shipping_clients/index.json.jbuilder

### 4. APIドキュメントとの比較

`zaico_api_doc/includes/api/`配下のAPIドキュメントと比較：

- inventories.md
- customers.md
- packing_slips.md
- purchases.md
- inventories_sets.md
- inventory_attachments.md
- inventory_group_items.md
- shipping_clients.md

### 5. 不整合のレポート

検出した不整合を以下の形式でレポート：

| ファイル | フィールド | 問題 | 現状 | 期待値 |
|----------|------------|------|------|--------|
| inventories.md | title | maxLength未定義 | - | 200 |
| customers.md | name | required未指定 | - | required |

### 6. 修正の実施

レポートに基づき、APIドキュメントを修正：

- maxLengthは説明文に「（最大N文字）」形式で追加
- requiredは`(string, required)`形式で追加
- 欠落しているレスポンス項目を追加

## 優先順位

モデルバリデーション > DBスキーマ制約

## 検証

修正後、以下を実行して確認：

```bash
cd zaico_api_doc && yarn build
```

## モデルバリデーション参照表

### Inventory
| フィールド | presence | maxLength | 備考 |
|------------|----------|-----------|------|
| user_group | true | 255 | |
| title | - | 200 | |
| state | - | 200 | |
| place | - | 200 | |
| quantity | - | - | decimal(15,4)：整数部11桁、小数部4桁 |
| logical_quantity | - | - | decimal(15,4)：整数部11桁、小数部4桁 |
| code | - | 200 | |
| category | - | 250 | |
| optional_attributes | - | 9000 | |
| group_tag | - | 250 | |

### Customer
| フィールド | presence | maxLength |
|------------|----------|-----------|
| name | true | 100 |
| zip | - | 7 |
| address | - | 1000 |
| building_name | - | 1000 |
| phone_number | - | 11 |
| etc | - | 500 |
| email | - | 200 |
| num | - | 200 |

### PackingSlip
| フィールド | presence | maxLength |
|------------|----------|-----------|
| num | - | 250 |
| delivery_date | true (if completed) | - |
| memo | - | 250 |
| note | - | 250 |
| user_group | - | 255 |

### Purchase
| フィールド | presence | maxLength |
|------------|----------|-----------|
| num | - | 250 |
| purchase_date | true (if purchased) | - |
| memo | - | 250 |
| etc | - | 250 |
| user_group | - | 255 |

### Delivery
| フィールド | presence | maxLength | 備考 |
|------------|----------|-----------|------|
| quantity | - | - | decimal(15,4)：整数部11桁、小数部4桁 |
| unit_price | - | - | decimal(15,4)：整数部11桁、小数部4桁 |
| etc | - | 250 | |
| delivery_date | true (if completed) | - | |

### PurchaseItem
| フィールド | presence | maxLength | 備考 |
|------------|----------|-----------|------|
| quantity | true | - | decimal(15,4)：整数部11桁、小数部4桁 |
| unit_price | - | - | decimal(15,4)：整数部11桁、小数部4桁 |
| etc | - | 250 | |
| purchase_date | true (if purchased) | - | |

### InventoriesSet
| フィールド | presence | maxLength | 備考 |
|------------|----------|-----------|------|
| title | true | 200 | |
| memo | - | 250 | |
| code | - | 200 | |
| price | - | - | decimal(15,4)：整数部11桁、小数部4桁 |

### InventoriesSetItem
| フィールド | presence | maxLength | 備考 |
|------------|----------|-----------|------|
| inventory_id | true | - | |
| quantity | true | - | decimal(15,4)：整数部11桁、小数部4桁、0より大きい |

### ShippingClient
| フィールド | presence | maxLength |
|------------|----------|-----------|
| name | true | 16 |
| zip | true | 7 |
| address | true | 32 |
| building_name | - | 16 |
| phone_number | true | 11 |

### InventoryAttachment
| フィールド | presence | maxLength |
|------------|----------|-----------|
| item_file | true | - |
