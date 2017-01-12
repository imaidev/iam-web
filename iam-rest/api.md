[TOC]


## iam scene-imaicloud 使用说明

本文档是IAM-REST的入门文档，目的是能够帮助开发者利用IAM-REST提供的REST API，完成注册、认证、用户管理的基本功能。

开发者在调用REST API之前，需要使用API Key。
IAM-REST通过对API Key的验证，保护被访问的REST API。
这里提供默认的API Key：

```
API_KEY=hygnzMy2F1K-5WMQ4aonew
API_SECRET=CwBBiTtUV57Pxz7pwpMyGPiF6foHipYZy9us1MpoaxQ
```

# 1. 注册/登录
## 1.1 注册
注册IAM的账号，需要提供邮箱、密码、用户名。

```
POST /v1/applications/$APP_ID/accounts

{
 "email":$EMAIL,
 "username":$USER_NAME,
 "password":$PWD,
 "password2":$PWD2
}
```
+ $APP_ID：应用id

IAM会为使用IAM进行认证的应用，提供ID。应用（Application）是IAM中的一种资源，用于对接使用IAM的各种应用。

IMAI平台使用的ID为nnwpouLzSLCZQhd4rY86Wg

curl注册账号

```
curl -u $APIKEY_ID:$APIKEY_SECRET \
-H 'Content-Type: application/json' \
-X POST \
-d '{"email":"account01@me.com","username":"account01","password":"123456"}' \
https://dev.imaicloud.com/iam/applications/nnwpouLzSLCZQhd4rY86Wg/accounts
```

## 1.2 登录

登录账号，最基本的需要是提供邮箱与密码，调用API之后，返回账号的基本信息。

最基本的形式如下所示

```
POST /v1/applications/$APP_ID/loginAttempts

{
 "type":"Basic",
 "value":$VALUE
}
```
+ type：Basic，确定认证方式是基本认证
+ value：Basic认证时传入的值Base64($email:$password)

按照上面的形式，返回的结果是登录账号的信息。

curl登录应用

```
curl -u $APIKEY_ID:$APIKEY_SECRET \
-H 'Content-Type: application/json' \
-X POST \
-d '{"type":"Basic","value":"YWNjb3VudDAzQG1lLmNvbToxMjM0NTY="}' \
https://dev.imaicloud.com/iam/admin/login
```
+ value是account03@me.com:123456的Base64编码

**IMAI**

针对IMAI的需求，可以生成专门定制的token。此时的请求参数会增加token选项，如下所示。

```
POST /v1/applications/$APP_ID/loginAttempts

{
 "type":"Basic",
 "value":$VALUE,
 "token":"true"
}
```
+ token参数：是可选参数，表明是否生成token。

（现阶段的token是按照IMAI的格式写成的token，没有提供面向开发者的灵活的定制方案。）

curl请求返回token

```
curl -u $APIKEY_ID:$APIKEY_SECRET \
-H 'Content-Type: application/json' \
-X POST \
-d '{"type":"Basic","value":"YWNjb3VudDAzQG1lLmNvbToxMjM0NTY=","token":"true"}' \
https://dev.imaicloud.com/iam/admin/login
```

返回的json结果如下所示

```
{
  "id": "T0Hf91e4QfiSaRQnTRqTpA",
  "href": "https://dev.imaicloud.com/iam/admin/v1/accounts/T0Hf91e4QfiSaRQnTRqTpA",
  "username": "account03",
  "email": "account03@me.com",
 ...,
  "itoken": "eyJhbGciOiJOR0lOWE1ENSIsInR5cCI6IkpXVCJ9.eyJhdWQiOiJ3d3cuaW1haWNsb3VkLmNvbSIsImlzcyI6ImlhbS5pbnNwdXIuY29tIiwiZXhwIjoxNDg0MjEwODU2MTYwLCJpYXQiOjE0ODQyMDkwNTYxNjAsImFjY291bnRJZCI6IlQwSGY5MWU0UWZpU2FSUW5UUnFUcEEiLCJlbWFpbCI6ImFjY291bnQwM0BtZS5jb20iLCJ1c2VybmFtZSI6ImFjY291bnQwMyIsImdyb3VwIjoiYWRtaW4ifQ.u5AksCbLacAQSBOCJAdl-Q"
}
```

返回结果比正常返回多itoken项。itoken是参照JWT实现的token。

JWT以点号(.)分为三部分：Header，payload，signature

*Header*

```
eyJhbGciOiJOR0lOWE1ENSIsInR5cCI6IkpXVCJ9
```

Base64解码后

```
{"alg":"NGINXMD5","typ":"JWT"}
```

*payload*

```
eyJhdWQiOiJ3d3cuaW1haWNsb3VkLmNvbSIsImlzcyI6ImlhbS5pbnNwdXIuY29tIiwiZXhwIjoxNDg0MjEwODU2MTYwLCJpYXQiOjE0ODQyMDkwNTYxNjAsImFjY291bnRJZCI6IlQwSGY5MWU0UWZpU2FSUW5UUnFUcEEiLCJlbWFpbCI6ImFjY291bnQwM0BtZS5jb20iLCJ1c2VybmFtZSI6ImFjY291bnQwMyIsImdyb3VwIjoiYWRtaW4ifQ
```

Base64解码后

```
{
"aud":"www.imaicloud.com",
"iss":"iam.inspur.com",
"exp":1484210856160,
"iat":1484209056160,
"accountId":"T0Hf91e4QfiSaRQnTRqTpA",
"email":"account03@me.com",
"username":"account03",
"group":"admin"
}
```

payload是包含所需要的主要信息。
+ aud：接收Token的应用
+ iss：签发Token的应用
+ exp：超时时间
+ iat：签发Token的时间
+ accountId：可定制，账号ID
+ email：可选，账号邮箱
+ username：可选，账号用户名
+ group：角色

*signature*

```
u5AksCbLacAQSBOCJAdl-Q
```

按照IMAI的nginx配置所需token认证的md5签名。

**Secret**

IMAI中nginx需要IAM能够提供secret，完成对于返回的itoken的认证。

IAM为满足IMAI的需求，将secret写入登录账号的自定义数据customData中。
IMAI可以通过获取账号的customData获取secret。

```
GET /v1/accounts/$ACCOUNT_ID/customData
```

curl访问账号的自定义数据

```
curl -u $APIKEY_ID:$APIKEY_SECRET  \
https://dev.imaicloud.com/iam/v1/accounts/T0Hf91e4QfiSaRQnTRqTpA/customData
```
+ T0Hf91e4QfiSaRQnTRqTpA是在登录时获取的账号ID。

返回结果

```
{
  ...
  "data": {
    "secret": "p7cpVH6j2eyaqrOCjTAZXbwnmBEo9mAaubfZa/3H8LI"
  }
}
```

# 2. 租户 Tenant

租户是IAM用于区分资源所属的容器。

**1. 获取当前Tenant**

```
GET /v1/tenants/current
```

curl获取当前tenant:

```
curl -u $APIKEY_ID:$APIKEY_SECRET  \
https://dev.imaicloud.com/iam/v1/tenants/current
```

**2. 获取单个Tenant**

```
GET /v1/tenants/$TENANT_ID
```

curl获取单个Tenant

```
curl -u $APIKEY_ID:$APIKEY_SECRET \
https://dev.imaicloud.com/iam/v1/tenants/vKVLdcpWT9iT8mUiVV3cew
```

**3. 查看某Tenant下的资源**

```
GET /v1/tenants/$TENANT_ID/$RESOURCE_TYPE
```
+ RESOURCE_TYPE可以是applications,organizations.directories,groups,accounts

curl以accounts为例

```
curl -u $APIKEY_ID:$APIKEY_SECRET  \
https://dev.imaicloud.com/iam/v1/tenants/vKVLdcpWT9iT8mUiVV3cew/accounts
```


# 3. 应用 Application

Application是IAM关联，管理外部应用的资源形式。
通过Application资源与账号库资源的映射，可以灵活的改变应用的账号组织。

**1. 创建应用**

```
POST /v1/applications

{
 "name":$APP_NAME
}
```

curl创建Application

```
curl -u $APIKEY_ID:$APIKEY_SECRET \
-H 'Content-Type: application/json' \
-X POST \
-d '{"name":"app001"}' \
https://dev.imaicloud.com/iam/v1/applications
```

**2. 获取全部应用**

```
GET /v1/applications
```

curl获取全部应用

```
curl -u $APIKEY_ID:$APIKEY_SECRET  \
https://dev.imaicloud.com/iam/v1/applications
```

**3. 获取单个应用**

```
GET /v1/applications/$APP_ID
```

curl获取单个应用

```
curl -u $APIKEY_ID:$APIKEY_SECRET  \
https://dev.imaicloud.com/iam/v1/applications/AorQEPNjTQS1NfWUUh4b1A
```

**4. 更新应用**

```
POST /v1/applications/$APP_ID

{
 "status":"disable"
 ...
}
```

curl更新应用的状态与描述

```
curl -u $APIKEY_ID:$APIKEY_SECRET \
-H 'Content-Type: application/json' \
-X POST \
-d '{"description":"app001","status":"disabled"}' \
https://dev.imaicloud.com/iam/v1/applications/PQz3_G79S4-4DeXotVF6YA
```
+ 更新应用的description为app001,status为disabled

**5. 删除应用**

```
DELETE /v1/applications/$APP_ID
```

curl删除应用

```
curl -u $APIKEY_ID:$APIKEY_SECRET \
-X DELETE \
https://dev.imaicloud.com/iam/v1/applications/PQz3_G79S4-4DeXotVF6YA
```

**6. 应用相关资源查询**

```
GET /v1/applications/$APP_ID/$RESOURCE_TYPE
```

可以查询的Resource可以是accounts，groups
下面以curl查询accounts

```
curl -u $APIKEY_ID:$APIKEY_SECRET \
https://dev.imaicloud.com/iam/v1/applications/PQz3_G79S4-4DeXotVF6YA/accounts
```

**7. 应用登录**

```
POST /v1/applications/$APP_ID/loginAttempts

{
 "type":"basic",
 "value":$VALUE
}
```

curl登录应用

```
curl -u $APIKEY_ID:$APIKEY_SECRET \
-H 'Content-Type: application/json' \
-X POST \
-d '{"type":"basic","value":"dGVzdDAxQDE2My5jb206dGVzdA=="}' \
https://dev.imaicloud.com/iam/v1/applications/nnwpouLzSLCZQhd4rY86Wg/loginAttempts
```

# 4. 组织 Oranization

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
curl -u $APIKEY_ID:$APIKEY_SECRET \
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
curl -u $APIKEY_ID:$APIKEY_SECRET \
https://dev.imaicloud.com/iam/v1/organizations
```

**3. 查询单个组织**

```
GET /v1/organizations/$ORGAN_ID
```

curl查询单个组织

```
curl -u $APIKEY_ID:$APIKEY_SECRET \
https://dev.imaicloud.com/iam/v1/organizations/LV9EBZS1RlWr70kZJnfvMw
```

**4. 更新组织**

```
POST /v1/organizations/$ORGAN_ID

{
 "status":...,
 "description":...
}
```

curl更新组织

```
curl -u $APIKEY_ID:$APIKEY_SECRET \
-H 'Content-Type: application/json' \
-X POST \
-d '{"description":"organ001"}' \
https://dev.imaicloud.com/iam/v1/organizations/LV9EBZS1RlWr70kZJnfvMw
```

**5. 删除组织**

```
DELETE /v1/organizations/$ORGAN_ID
```

curl删除组织

```
curl -u $APIKEY_ID:$APIKEY_SECRET \
-X DELETE \
https://dev.imaicloud.com/iam/v1/organizations/LV9EBZS1RlWr70kZJnfvMw
```

# 5. 目录 Direcctory

**1. 创建目录**

```
POST /v1/directories

{
 "name":$DIR_NAME
}
```

curl 创建目录

```
curl -u $APIKEY_ID:$APIKEY_SECRET \
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
curl -u $APIKEY_ID:$APIKEY_SECRET \
https://dev.imaicloud.com/iam/v1/directories
```

**3. 查询单个目录**

```
GET /v1/directories/$DIR_ID
```

curl查询单个目录

```
curl -u $APIKEY_ID:$APIKEY_SECRET \
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
curl -u $APIKEY_ID:$APIKEY_SECRET \
-H 'Content-Type: application/json' \
-X POST \
-d '{"description":"dir000","status":"disabled"}' \
https://dev.imaicloud.com/iam/v1/directories/OjKmSBzWREmBapqKHtgZEg
```

**5. 删除目录**

```
DELETE /v1/directories/$DIR_ID
```

curl删除目录

```
curl -u $APIKEY_ID:$APIKEY_SECRET \
-X DELETE \
https://dev.imaicloud.com/iam/v1/directories/OjKmSBzWREmBapqKHtgZEg
```

**6. 查询目录下相关资源**

```
GET /v1/directories/$DIR_ID/$RESOURCE_TYPE
```

可以查询的相关资源有：group，account

curl查询accounts

```
curl -u $APIKEY_ID:$APIKEY_SECRET \
https://dev.imaicloud.com/iam/v1/directories/OjKmSBzWREmBapqKHtgZEg/accounts
```

# 6. 分组 Group

分组，是对目录中的账号增加分类，相当于给予账号不同的角色。
Group必须在指定目录下创建。

**1. 创建账号**

```
POST /v1/directories/$DIR_ID/groups

{
 "name":$GROUP_NAME,
 ...
}
```
+ 必选参数：name
+ 可选参数：description,status

curl创建分组

```
curl -u $APIKEY_ID:$APIKEY_SECRET \
-H 'Content-Type: application/json' \
-X POST \
-d '{"name":"group001"}' \
https://dev.imaicloud.com/iam/v1/directories/EyQcwlW0Sgu5PPJ8Pji29A/groups
```

**2. 查询全部分组**

```
GET /v1/groups
```

curl 查询全部分组

```
curl -u $APIKEY_ID:$APIKEY_SECRET \
https://dev.imaicloud.com/iam/v1/groups
```

**3. 查询单个分组**

```
GET /v1/groups/$GROUP_ID
```

curl 查询单个分组

```
curl -u $APIKEY_ID:$APIKEY_SECRET \
https://dev.imaicloud.com/iam/v1/groups/LR8v0aDjS7ufDRhWchNyAw
```

**4. 更新分组**

```
POST /v1/groups/$GROUP_ID

{
 "name":...,
 ...
}
```
+ 可用于更新的Group字段：name,description,status

curl 更新分组

```
curl -u $APIKEY_ID:$APIKEY_SECRET \
-H 'Content-Type: application/json' \
-X POST \
-d '{"name":"group001-a"}' \
https://dev.imaicloud.com/iam/v1/groups/LR8v0aDjS7ufDRhWchNyAw
```

**5. 删除分组**

```
 DELETE /v1/groups/$GROUP_ID
```

curl 删除分组

```
curl -u $APIKEY_ID:$APIKEY_SECRET \
-X DELETE \
https://dev.imaicloud.com/iam/v1/groups/LR8v0aDjS7ufDRhWchNyAw
```

**6. 查询分组的相关资源**

```
GET /v1/groups/$GROUP_ID/$RESOURCE_TYPE
```

分组可以查询的基本资源包括：accounts，applications

curl 查询分组相关的aplication

```
curl -u $APIKEY_ID:$APIKEY_SECRE \
https://dev.imaicloud.com/iam/v1/groups/LR8v0aDjS7ufDRhWchNyAw/applications
```

# 7. 账号 Account

账号是IAM的核心资源，属于目录。
通过与其他资源相互关联，形成灵活的账号体系。

**1. 创建账号**

```
POST /v1/directoires/$DIR_ID/accounts
POST /v1/applications/$APP_ID/accounts
POST /v1/organizations/$ORGAN_ID/accounts

{
 "email":...,
 "password":...,
 ...
}
```
+ 账号可以在目录，应用，组织下创建。
+ 账号的本质是在目录下创建，在应用或组织下创建，是因为应用，组织都可以与目录关联
+ 必选字段：email,password
+ 可选字段：username,status,description

curl 在目录下创建账号

```
curl -u $APIKEY_ID:$APIKEY_SECRE \
-H 'Content-Type: application/json' \
-X POST \
-d '{"email":"account001@163.com","password":"accout001"}' \
https://dev.imaicloud.com/iam/v1/directories/EyQcwlW0Sgu5PPJ8Pji29A/accounts
```

**2. 查询全部账号**

```
GET /v1/accounts
```

curl 查询全部账号

```
curl -u $APIKEY_ID:$APIKEY_SECRE \
https://dev.imaicloud.com/iam/v1/accounts
```

**3. 查询单个账号**

```
GET /v1/accounts/$ACCOUNT_ID
```

curl 查询单个账号

```
curl -u $APIKEY_ID:$APIKEY_SECRE \
https://dev.imaicloud.com/iam/v1/accounts/jbrOIebARy2w1Apt1Uw8DA
```

**4. 更新账号**

```
POST /v1/accounts/$ACCOUNT_ID

{
 "username":...,
 ...
}
```
+ account可以更新的字段包括：email,username,password,status

curl 更新status

```
curl -u $APIKEY_ID:$APIKEY_SECRE \
-H 'Content-Type: application/json' \
-X POST \
-d '{"status":"unverified"}' \
https://dev.imaicloud.com/iam/v1/accounts/jbrOIebARy2w1Apt1Uw8DA
```

**5. 查看关联资源**

```
GET /v1/accounts/$ACCOUNT_ID/$RESOURCE_TYPE
```

账号可以查看的资源主要是：group

curl 查看groups

```
curl -u $APIKEY_ID:$APIKEY_SECRE \
https://dev.imaicloud.com/iam/v1/accounts/jbrOIebARy2w1Apt1Uw8DA/groups
```

**6. 关联分组与账号**

GroupMembership在IAM表示分组Group与账号Account的关联关系，可以解释为将账号添加入分组；或者将某角色赋予账号

```
POST /v1/groupMemberships

{
 "account":...,
 "group":...
}
```
+ 必选字段：group,account

curl 创建GroupMembership

```
curl -u $APIKEY_ID:$APIKEY_SECRE \
-H 'Content-Type: application/json' \
-X POST \
-d '{"group":"SfGQSQtEQym9YWZq5txUcg","account":"2YO9-INGSx-rabcvmtKemA"}' \
https://dev.imaicloud.com/iam/v1/groupMemberships
```

**7. 解除账号与分组的关联**

```
DELETE /v1/groupshipMemberships/$GM_ID
```

curl 解除账号与分组的关联：

```
curl -u $APIKEY_ID:$APIKEY_SECRE \
-X DELETE \
https://dev.imaicloud.com/iam/v1/groupMemberships/8e24otZ2S0SPSaYvSgfwPA
```

**8. 关联账号**

AccountLink资源用于关联位于不同目录的账号。

```
POST /v1/accountLinks

{
 "leftAccount":...,
 "rightAccount":...
}
```
+ 必选字段：leftAccount,rightAccount

curl 关联账号

```
curl -u $APIKEY_ID:$APIKEY_SECRE \
-H 'Content-Type: application/json' \
-X POST \
-d '{"leftAccount":"0jxyzoXNS4SjMCDBuPQPrQ","rightAccount":"2YO9-INGSx-rabcvmtKemA"}' \
https://dev.imaicloud.com/iam/v1/accountLinks
```

**9. 解除账号关联**

```
DELETE /v1/accountLinks/$LINK_ID
```

curl 解除账号关联

```
curl -u $APIKEY_ID:$APIKEY_SECRE \
-X DELETE \
https://dev.imaicloud.com/iam/v1/acccountLinks/yrJKhHOpQ8OG99eN04Amfg
```

# 8. 定制数据

CustomData资源表示IAM中资源的自定义数据。

在基本资源创建的同时，都会创建空的CustomData资源

**1. 访问CustomData**

```
GET /v1/$RESOURCE_TYPE/$RESOURCE_ID/customData
```

curl 查询Account的CustomData

```
curl -u $APIKEY_ID:$APIKEY_SECRE \
https://dev.imaicloud.com/iam/v1/accounts/jbrOIebARy2w1Apt1Uw8DA/customData
```

**2. 自定义数据**

```
POST /v1/$RESOURCE_TYPE/$RESOURCE_ID/customData
```

curl 自定义数据

```
curl -u $APIKEY_ID:$APIKEY_SECRE \
-H 'Content-Type: application/json' \
-X POST \
-d '{"Author":"pat bear"}' \
https://dev.imaicloud.com/iam/v1/accounts/jbrOIebARy2w1Apt1Uw8DA/customData
```


