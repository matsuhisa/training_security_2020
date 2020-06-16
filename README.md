## 準備

```
rails new ./
rails generate scaffold bookmark site:string url:string
rails db:migrate
```

- http://localhost:3000/bookmarks

## site を link_to にする

```erb:
-        <td><%= bookmark.site %></td>
-        <td><%= bookmark.url %></td>
+        <td><%= link_to bookmark.site, bookmark.url %></td>
```

## 🙆🏻‍♀️防いでくれる

```
<script>alert(1)</script>
```

良さそう！
でもダメ

## 🙅🏻‍♀️ 防いでくれない

```
javascript:alert(1)
```

JavaScript スキームは防いでくれない

## validation で防ごう！

```
if /^https?:\/\// !~ params[:bookmark][:url]
  render html: "ダメ"
  return
end
```

よさそう！

```
javascript:alert(1)/*改行
http://www.mwed.jp/*/
```

通ってしまった！ダメでした

## validation で防ごう！

Rails っぽく実装してみましょう

```
class Bookmark < ApplicationRecord
  validates :url, format: { with: /^https?:\/\//, message: "http始まりであること" }
end
```

## 怒られる

```
The provided regular expression is using multiline anchors (^ or $), which may present a security risk. Did you mean to use \A and \z, or forgot to add the :multiline => true option?
```

## 何これ？

正規表現の ^ と $ は行の先頭末尾を示します
PHP とかは、複数行も1行にして処理してしまうため問題にならない
Ruby では、複数行として認識するので問題になる

## まとめ

- Rails には基本的なセキュリティ対策はされていた
- しかし、JavaScriptスキームは防いでくれない
- 独自で正規表現を使った実装をする場合、脆弱性が残る場合がある

- Rails way に乗ると気づくことができ、対応することもできた