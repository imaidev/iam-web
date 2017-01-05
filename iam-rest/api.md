[TOC]


## iam scene-imaicloud 使用说明

# 1. IAM-REST/IAM-Admin

## 1.1 IAM-REST与IAM-Admin简单说明

**IAM-REST**

IAM-REST是提供REST API的后台服务。
IAM-REST是无状态的，不存在会话管理。

IAM-REST提供的REST API分为两类：
1. 面向开发者的REST API:以/v1开头
2. 面向IAM-Admin的REST API：以/admin开头

面向开发者的REST API一般需要使用API Key保护；但面向IAM-Admin的REST API则不需要API Key保护。


**IAM-Admin**

IAM-Admin需要调用IAM-REST的服务，从而完成管理控制台功能。
注意：在IAM-Admin中，可以调用面向IAM-Admin的REST API和面向开发者的REST API。

IAM-Admin的主要功能点包括两大点：
+ 注册/登录
+ 资源管理

IAM-Admin是IAM-REST的REST API调用的可视化展示。
IAM-Admin作为一个管理控制台，存在会话管理，但IAM-REST并不提供对IAM-Admin的会话管理（是否可以提供）。
这样，IAM-Admin与IAM-REST形成了:纯前端+REST-API的应用架构。
而IAM-Admin要实现会话管理，则需要以客户端的方式保持会话状态。具体方式可以是cookie，token，URL参数等。


## 1.2 面向IAM-Admin的REST API

面向控制台的REST API现阶段主要包括两个功能：注册与登录。

**1. 注册**

IAM-Admin注册，在提供邮箱,用户名，密码之后，即可创建IAM-Admin的一个租户，同时创建所需要的账号。

REST API访问如下

```
POST /admin/register

{
 "email":$EMAIL,
 "username":$USER_NAME,
 "password":$PWD,
 "password2":$PWD2
}
```

通过curl访问如下

```
curl -H 'Content-Type: application/json' \
-X POST \
-d '{"email":"test00@163.com","username":"test00","password":"test00","password2":"test00"}' \
https://dev.imaicloud.com/iam/admin/register
```

**2. 登录**

登录时，需要使用租户名（不要忘记），同时需要提供邮箱与密码。

REST API访问如下

```
POST /admin/login

{
 "tenantKey":$TENENT_KEY,
 "type":"basic",
 "value":$VALUE
}
```

通过curl访问如下所示

```
curl -H 'Content-Type: application/json' \
-X POST \
-d '{"tenantKey":"vdaggr-ypyyyy","type":"basic","value":"dGVzdDAxQDE2My5jb206dGVzdA=="}' \
https://dev.imaicloud.com/iam/admin/login
```
+ tenantKey：vdaggr-ypyyyy
+ type：basic（暂时只提供基本认证）
+ value是email：password的base64编码值,实际的邮箱和密码是test01@163.com和test

**3. API Key**

租户账号登录后，在头像菜单中，点击“生成apiKeys”，将得到一个包含apiKey id和secret的文件。
请妥善保管API Key文件，后面使用的所有REST API访问都需要通过api key。

REST API的认证使用Authorization请求头，值为apiKey的id和secret的base64编码base64($ID:$SECRET)。
使用linux curl测试，可设置变量$IAM_APIKEY_ID、$IAM_APIKEY_SECRET，值分别apiKeys的id和secret。

注意：当在IAM-Admin中调用面向开发者的REST API时，可以不用API Key保护。
这考虑到IAM-Admin的特殊性，但是由于API Key除了可以完成API保护之外，还隐式提供tenant信息。

为满足上述情况，IAM-REST同样允许，在API Key保护之后，以下面方式的保护：
1. 调用面向开发者REST API的URL带有tenant参数
2. 调用面向开发者REST API的URL带有tenant的cookie
3. 调用面向开发者REST API的URL含有tenant的Header。

下面内容针对面向开发者的REST API，主要以API Key方式进行保护。

# 2. 租户 Tenant

租户是IAM用于区分资源所属的容器。

**获取当前Tenant**

```
GET /v1/tenants/current
```

curl获取当前tenant:

```
curl -u hygnzMy2F1K-5WMQ4aonew:CwBBiTtUV57Pxz7pwpMyGPiF6foHipYZy9us1MpoaxQ  \
https://dev.imaicloud.com/iam/v1/tenants/current
```

**获取单个Tenant**

```
GET /v1/tenants/$TENANT_ID
```

curl获取单个Tenant

```
curl -u hygnzMy2F1K-5WMQ4aonew:CwBBiTtUV57Pxz7pwpMyGPiF6foHipYZy9us1MpoaxQ  \
https://dev.imaicloud.com/iam/v1/tenants/vKVLdcpWT9iT8mUiVV3cew
```

**查看某Tenant下的资源**

```
GET /v1/tenants/$TENANT_ID/$RESOURCE_TYPE
```
+ RESOURCE_TYPE可以是applications,organizations.directories,groups,accounts

curl以accounts为例

```
curl -u hygnzMy2F1K-5WMQ4aonew:CwBBiTtUV57Pxz7pwpMyGPiF6foHipYZy9us1MpoaxQ  \
https://dev.imaicloud.com/iam/v1/tenants/vKVLdcpWT9iT8mUiVV3cew/accounts
```


# 3. 应用 Application

Application是IAM关联，管理外部应用的资源形式。
通过Application资源与账号库资源的映射，可以灵活的改变应用的账号组织。

**获取全部应用**

```
GET /v1/applications
```

curl获取全部应用

```
curl -u hygnzMy2F1K-5WMQ4aonew:CwBBiTtUV57Pxz7pwpMyGPiF6foHipYZy9us1MpoaxQ  \
https://dev.imaicloud.com/iam/v1/applications
```

**获取单个应用**

```
GET /v1/applications/$APP_ID
```

curl获取单个应用

```
curl -u hygnzMy2F1K-5WMQ4aonew:CwBBiTtUV57Pxz7pwpMyGPiF6foHipYZy9us1MpoaxQ  \
https://dev.imaicloud.com/iam/v1/applications/AorQEPNjTQS1NfWUUh4b1A
```

**创建应用**

```
POST /v1/applications

{
 "name":$APP_NAME
}
```

curl创建Application

```
curl -u hygnzMy2F1K-5WMQ4aonew:CwBBiTtUV57Pxz7pwpMyGPiF6foHipYZy9us1MpoaxQ \
-H 'Content-Type: application/json' \
-X POST \
-d '{"name":"app001"}' \
https://dev.imaicloud.com/iam/v1/applications
```

**更新应用**

```
POST /v1/applications/$APP_ID

{
 "status":"disable"
 ...
}
```

curl更新应用的状态与描述

```
curl -u hygnzMy2F1K-5WMQ4aonew:CwBBiTtUV57Pxz7pwpMyGPiF6foHipYZy9us1MpoaxQ \
-H 'Content-Type: application/json' \
-X POST \
-d '{"description":"app001","status":"disabled"}' \
https://dev.imaicloud.com/iam/v1/applications/PQz3_G79S4-4DeXotVF6YA
```
+ 更新应用的description为app001,status为disabled

**删除应用**

```
DELETE /v1/applications/$APP_ID
```

curl删除应用

```
curl -u hygnzMy2F1K-5WMQ4aonew:CwBBiTtUV57Pxz7pwpMyGPiF6foHipYZy9us1MpoaxQ \
-X DELETE \
https://dev.imaicloud.com/iam/v1/applications/PQz3_G79S4-4DeXotVF6YA
```

**应用相关资源查询**

```
GET /v1/applications/$APP_ID/$RESOURCE_TYPE
```

可以查询的Resource可以是accounts，groups
下面以curl查询accounts

```
curl -u hygnzMy2F1K-5WMQ4aonew:CwBBiTtUV57Pxz7pwpMyGPiF6foHipYZy9us1MpoaxQ \
https://dev.imaicloud.com/iam/v1/applications/PQz3_G79S4-4DeXotVF6YA/accounts
```

**应用登录**

```
POST /v1/applications/$APP_ID/loginAttempts

{
 "type":"basic",
 "value":$VALUE
}
```

curl登录应用

```
curl -u hygnzMy2F1K-5WMQ4aonew:CwBBiTtUV57Pxz7pwpMyGPiF6foHipYZy9us1MpoaxQ \
-H 'Content-Type: application/json' \
-X POST \
-d '{"type":"basic","value":"dGVzdDAxQDE2My5jb206dGVzdA=="}' \
https://dev.imaicloud.com/iam/v1/applications/nnwpouLzSLCZQhd4rY86Wg/loginAttempts
```

# 3. 组织 Oranization

组织Organization是专门为多租户应用提供的资源。
Organization是虚拟的账号库。

**1. 创建组织**

```
POST /v1/organizations

{
 "name":$ORGAN_NAME,
 "nameKey":$ORGAN_KEY
}
```
+ name是组织Organization的名字
+ nameKey是针对多租户应用是，每个Organization对应不同的DNS名字

curl创建Organization

```
curl -u hygnzMy2F1K-5WMQ4aonew:CwBBiTtUV57Pxz7pwpMyGPiF6foHipYZy9us1MpoaxQ \
-H 'Content-Type: application/json' \
-X POST \
-d '{"name":"organ001","nameKey":"oran001.demo.org"}' \
https://dev.imaicloud.com/iam/v1/organizations
```

**2. 查询全部组织**

```
GET /v1/organizations
```

curl查询全部组织

```
curl -u hygnzMy2F1K-5WMQ4aonew:CwBBiTtUV57Pxz7pwpMyGPiF6foHipYZy9us1MpoaxQ \
https://dev.imaicloud.com/iam/v1/organizations
```

# 4. 目录 Direcctory

**1. 创建目录**

```
POST /v1/directories

{
 "name":$DIR_NAME
}
```

curl 创建目录

```
curl -u hygnzMy2F1K-5WMQ4aonew:CwBBiTtUV57Pxz7pwpMyGPiF6foHipYZy9us1MpoaxQ \
-H 'Content-Type: application/json' \
-X POST \
-d '{"name":"dir000"}' \
https://dev.imaicloud.com/iam/v1/directories
```

**2. 查询全部目录**

```
GET /v1/directories
```

curl获取全部目录

```
curl -u hygnzMy2F1K-5WMQ4aonew:CwBBiTtUV57Pxz7pwpMyGPiF6foHipYZy9us1MpoaxQ \
https://dev.imaicloud.com/iam/v1/directories
```

**3. 查询单个目录**

```
GET /v1/directories/$DIR_ID
```

curl查询单个目录

```
curl -u hygnzMy2F1K-5WMQ4aonew:CwBBiTtUV57Pxz7pwpMyGPiF6foHipYZy9us1MpoaxQ \
https://dev.imaicloud.com/iam/v1/directories/OjKmSBzWREmBapqKHtgZEg
```

**4. 更新目录**

```
POST /v1/directories/$DIR_ID

{
 "description":...
 "status":...
}
```

curl更新目录

```
curl -u hygnzMy2F1K-5WMQ4aonew:CwBBiTtUV57Pxz7pwpMyGPiF6foHipYZy9us1MpoaxQ \
-H 'Content-Type: application/json' \
-X POST \
-d '{"description":"dir000","status":"disabled"}' \
https://dev.imaicloud.com/iam/v1/directories/OjKmSBzWREmBapqKHtgZEg
```

**5. 查询目录下相关资源**

```
GET /v1/directories/$DIR_ID/$RESOURCE_TYPE
```

可以查询的相关资源有：group，account

curl查询accounts

```
curl -u hygnzMy2F1K-5WMQ4aonew:CwBBiTtUV57Pxz7pwpMyGPiF6foHipYZy9us1MpoaxQ \
https://dev.imaicloud.com/iam/v1/directories/OjKmSBzWREmBapqKHtgZEg/accounts
```

**6. 删除目录**

```
DELETE /v1/directories/$DIR_ID
```

curl删除目录

```
curl -u hygnzMy2F1K-5WMQ4aonew:CwBBiTtUV57Pxz7pwpMyGPiF6foHipYZy9us1MpoaxQ \
-X DELETE \
https://dev.imaicloud.com/iam/v1/directories/OjKmSBzWREmBapqKHtgZEg
```





###6. 查询目录下的账号

GET /api/v1/directories/$DIRECTORY_ID/accounts

```
curl -u $IAM_APIKEY_ID:$IAM_APIKEY_SECRET \
https://dev.imaicloud.com/iam/api/v1/directories/AsSYqRLrTrWsrbJiSIzqmA/accounts
```

###7. 在目录下创建账号

POST api/v1/directories/$DIRECTORY_ID/accounts

```
curl -H 'Content-Type: application/json' \
-u $IAM_APIKEY_ID:$IAM_APIKEY_SECRET \
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
curl -u $IAM_APIKEY_ID:$IAM_APIKEY_SECRET \
https://dev.imaicloud.com/iam/api/v1/directories/AsSYqRLrTrWsrbJiSIzqmA/groups
```

###9. 在目录下创建组

```
curl -H 'Content-Type: application/json' \
-u $IAM_APIKEY_ID:$IAM_APIKEY_SECRET \
-X POST https://dev.imaicloud.com/iam/api/v1/directories/AsSYqRLrTrWsrbJiSIzqmA/groups \
-d '{"name": "demo group"}'
```

###10. 组成员

账号和组通过组成员连接。

**创建组成员**

POST /api/v1/groupMemberships

```
curl -H 'Content-Type: application/json' \
-u $IAM_APIKEY_ID:$IAM_APIKEY_SECRET \
-X POST https://dev.imaicloud.com/iam/api/v1/groupMemberships \
-d "{\"account\": \"HVVhTp-uTQSdrLKRN2-y8A\", \"group\":\"M39wjYP-ToOkpkrULL2LZg\"}"
```

**查询账号所在的组**

GET /api/v1/accounts/$ACCOUNT_ID/groups

```
curl -u $IAM_APIKEY_ID:$IAM_APIKEY_SECRET \
https://dev.imaicloud.com/iam/api/v1/accounts/HVVhTp-uTQSdrLKRN2-y8A/groups
```

###11. 定制数据

GET /v1/$RESOURCE_TYPE/$RESOURCE_ID/customData

POST /v1/$RESOURCE_TYPE/$RESOURCE_ID/customData

**访问Account的customData**

GET /api/v1/accounts/$ACCOUNT_ID/customData

```
curl -u $IAM_APIKEY_ID:$IAM_APIKEY_SECRET \
https://dev.imaicloud.com/iam/api/v1/accounts/KySQo1c7TTKoFzniA3VLbA/customData
```

**设置定制数据**

POST /api/v1/accounts/$ACCOUNT_ID/customData

```
curl -H 'Content-Type: application/json' \
-u $IAM_APIKEY_ID:$IAM_APIKEY_SECRET \
-X POST https://dev.imaicloud.com/iam/api/v1/accounts/06xbdFbrSYug82YrA7hroQ/customData \
-d '{"domain": "demo.imaicloud.com"}'
```





