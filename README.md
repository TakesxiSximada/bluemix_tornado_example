起動の仕方

# pip をinstall

```
$ curl -kL https://raw.github.com/pypa/pip/master/contrib/get-pip.py | python
```

# virtualenvをinstall

```
$ pip install virtualenv
```

# virtualenv環境を作成

```
$ virtualenv env
```

# 依存packageをinstallする

```
$ env/bin/pip install -r requirements.txt
```

# 環境変数を設定


```
export merchant=XXXXX
export public_key=YYYYY
export private_key=ZZZZ
```

# サーバを起動


```
$ env/bin/python install -r requirements.txt
```