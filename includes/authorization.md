# Group 認証
## 認証について
### GET
#### 概要
ZAICO APIは認証にBearerトークン認証を採用しています。
リクエストを送る際、HTTPヘッダにAuthorization: Bearerをつけてください。

```http
Authorization: Bearer YOUR_TOKEN_HERE
```
