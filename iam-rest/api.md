##iam scene-imaicloud 使用说明

###1. 租户注册

使用iam的注册页面，注册时用户需要提供邮箱和设置密码，注册成功后会得到一个租户key，请保存好这个key，以便在登录时使用。

###2. 生成apiKeys

**通过控制台**

登录后，在头像菜单中，点击“生成apiKeys”，将得到一个包含apiKey id和secret的文件。

**通过api**

Create An apiKeys

POST /api/v1/account/$ACCOUNT_ID/apiKeys

$ACCOUNT_ID为账号内码，可以在登录后从头像菜单中查看。

```
curl -H "Content-Type: application/json" \
-H "Authorization: Basic SkM4ano3NWNVU2syYXJYcEZsUWZHQTpjTVVsU25weDB4M2FFeUl6b29GWmhWMi8yRWQyTEdGMUpURUQ0YmRiUDhV" \
-X POST https://dev.imaicloud.com/iam/api/v1/accounts/sqHezdzpS_e_bPbmjV6zYw/apiKeys \
-d "{}"
```

###3. Retrieve A Tenant

GET /api/v1/tenants/current

```
curl -H "Authorization: Basic SkM4ano3NWNVU2syYXJYcEZsUWZHQTpjTVVsU25weDB4M2FFeUl6b29GWmhWMi8yRWQyTEdGMUpURUQ0YmRiUDhV" \
https://dev.imaicloud.com/iam/api/v1/tenants/current
```

###4. 查询租户下的目录

GET /api/v1/tenants/$TENANT_ID/directories

###5. 创建目录

POST /api/v1/directories

```
curl -H "Content-Type: application/json" -H "Authorization: Basic SkM4ano3NWNVU2syYXJYcEZsUWZHQTpjTVVsU25weDB4M2FFeUl6b29GWmhWMi8yRWQyTEdGMUpURUQ0YmRiUDhV" -X POST https://dev.imaicloud.com/iam/api/v1/directories -d "{\"description\": \"客户目录\", \"type\": \"cloud\", \"status\": \"enabled\", \"name\": \"customer\"}"
```

###6. 查询目录下的账号

GET /api/v1/directories/$DIRECTORY_ID/accounts

```
curl -H "Authorization: Basic SkM4ano3NWNVU2syYXJYcEZsUWZHQTpjTVVsU25weDB4M2FFeUl6b29GWmhWMi8yRWQyTEdGMUpURUQ0YmRiUDhV" \
https://dev.imaicloud.com/iam/api/v1/directories/AsSYqRLrTrWsrbJiSIzqmA/accounts
```

###7. 在目录下创建账号

POST api/v1/directories/$DIRECTORY_ID/accounts

```
curl -H 'Content-Type: application/json' \
-H "Authorization: Basic SkM4ano3NWNVU2syYXJYcEZsUWZHQTpjTVVsU25weDB4M2FFeUl6b29GWmhWMi8yRWQyTEdGMUpURUQ0YmRiUDhV" \
-X POST https://dev.imaicloud.com/iam/api/v1/directories/AsSYqRLrTrWsrbJiSIzqmA/accounts \
-d '{ \
"email": "demo@qq.com", \
"password": "$apr1$1Nc6ANA.$UjRKo27AQzrsWf7aEi5811", \
"status": "enabled", \
"username": "demo" \
}'
```


###8. 查询目录下的组

GET /api/v1/directories/$DIRECTORY_ID/groups

```
curl -H "Authorization: Basic SkM4ano3NWNVU2syYXJYcEZsUWZHQTpjTVVsU25weDB4M2FFeUl6b29GWmhWMi8yRWQyTEdGMUpURUQ0YmRiUDhV" \
https://dev.imaicloud.com/iam/api/v1/directories/AsSYqRLrTrWsrbJiSIzqmA/groups
```

###9. 在目录下创建组

```
curl -H 'Content-Type: application/json' \
-H "Authorization: Basic SkM4ano3NWNVU2syYXJYcEZsUWZHQTpjTVVsU25weDB4M2FFeUl6b29GWmhWMi8yRWQyTEdGMUpURUQ0YmRiUDhV" \
-X POST https://dev.imaicloud.com/iam/api/v1/directories/AsSYqRLrTrWsrbJiSIzqmA/groups \
-d '{"name": "demo group"}'
```

###10. 定制数据

GET /v1/$RESOURCE_TYPE/$RESOURCE_ID/customData

POST /v1/$RESOURCE_TYPE/$RESOURCE_ID/customData

**访问Account的customData**

GET /api/v1/accounts/$ACCOUNT_ID/customData

```
curl -H "Authorization: Basic SkM4ano3NWNVU2syYXJYcEZsUWZHQTpjTVVsU25weDB4M2FFeUl6b29GWmhWMi8yRWQyTEdGMUpURUQ0YmRiUDhV" \
https://dev.imaicloud.com/iam/api/v1/accounts/KySQo1c7TTKoFzniA3VLbA/customData
```

**设置定制数据**

POST /api/v1/accounts/$ACCOUNT_ID/customData

```
curl -H 'Content-Type: application/json' \
-H "Authorization: Basic SkM4ano3NWNVU2syYXJYcEZsUWZHQTpjTVVsU25weDB4M2FFeUl6b29GWmhWMi8yRWQyTEdGMUpURUQ0YmRiUDhV" \
-X POST https://dev.imaicloud.com/iam/api/v1/accounts/06xbdFbrSYug82YrA7hroQ/customData \
-d '{"domain": "demo.imaicloud.com"}'
```





