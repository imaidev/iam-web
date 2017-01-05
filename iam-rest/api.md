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

**3. 查询单个组织**

```
GET /v1/organizations/$ORGAN_ID
```

curl查询单个组织

```
curl -u hygnzMy2F1K-5WMQ4aonew:CwBBiTtUV57Pxz7pwpMyGPiF6foHipYZy9us1MpoaxQ \
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
curl -u hygnzMy2F1K-5WMQ4aonew:CwBBiTtUV57Pxz7pwpMyGPiF6foHipYZy9us1MpoaxQ \
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
curl -u hygnzMy2F1K-5WMQ4aonew:CwBBiTtUV57Pxz7pwpMyGPiF6foHipYZy9us1MpoaxQ \
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

**5. 删除目录**

```
DELETE /v1/directories/$DIR_ID
```

curl删除目录

```
curl -u hygnzMy2F1K-5WMQ4aonew:CwBBiTtUV57Pxz7pwpMyGPiF6foHipYZy9us1MpoaxQ \
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
curl -u hygnzMy2F1K-5WMQ4aonew:CwBBiTtUV57Pxz7pwpMyGPiF6foHipYZy9us1MpoaxQ \
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
curl -u hygnzMy2F1K-5WMQ4aonew:CwBBiTtUV57Pxz7pwpMyGPiF6foHipYZy9us1MpoaxQ \
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
curl -u hygnzMy2F1K-5WMQ4aonew:CwBBiTtUV57Pxz7pwpMyGPiF6foHipYZy9us1MpoaxQ \
https://dev.imaicloud.com/iam/v1/groups
```

**3. 查询单个分组**

```
GET /v1/groups/$GROUP_ID
```

curl 查询单个分组

```
curl -u hygnzMy2F1K-5WMQ4aonew:CwBBiTtUV57Pxz7pwpMyGPiF6foHipYZy9us1MpoaxQ \
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
curl -u hygnzMy2F1K-5WMQ4aonew:CwBBiTtUV57Pxz7pwpMyGPiF6foHipYZy9us1MpoaxQ \
-H 'Content-Type: application/json' \
-X POST \
-d '{"name":"group001-a"}' \
https://dev.imaicloud.com/iam/v1/groups/LR8v0aDjS7ufDRhWchNyAw
```

**5. 查询分组的相关资源**

```
GET /v1/groups/$GROUP_ID/$RESOURCE_TYPE
```

分组可以查询的基本资源包括：accounts，applications

curl 查询分组相关的aplication

```
curl -u hygnzMy2F1K-5WMQ4aonew:CwBBiTtUV57Pxz7pwpMyGPiF6foHipYZy9us1MpoaxQ \
https://dev.imaicloud.com/iam/v1/groups/LR8v0aDjS7ufDRhWchNyAw/applications
```

**6. 删除分组**

```
 DELETE /v1/groups/$GROUP_ID
```

curl 删除分组

```
curl -u hygnzMy2F1K-5WMQ4aonew:CwBBiTtUV57Pxz7pwpMyGPiF6foHipYZy9us1MpoaxQ \
-X DELETE \
https://dev.imaicloud.com/iam/v1/groups/LR8v0aDjS7ufDRhWchNyAw
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
curl -u hygnzMy2F1K-5WMQ4aonew:CwBBiTtUV57Pxz7pwpMyGPiF6foHipYZy9us1MpoaxQ \
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
curl -u hygnzMy2F1K-5WMQ4aonew:CwBBiTtUV57Pxz7pwpMyGPiF6foHipYZy9us1MpoaxQ \
https://dev.imaicloud.com/iam/v1/accounts
```

**3. 查询单个账号**

```
GET /v1/accounts/$ACCOUNT_ID
```

curl 查询单个账号

```
curl -u hygnzMy2F1K-5WMQ4aonew:CwBBiTtUV57Pxz7pwpMyGPiF6foHipYZy9us1MpoaxQ \
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
curl -u hygnzMy2F1K-5WMQ4aonew:CwBBiTtUV57Pxz7pwpMyGPiF6foHipYZy9us1MpoaxQ \
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
curl -u hygnzMy2F1K-5WMQ4aonew:CwBBiTtUV57Pxz7pwpMyGPiF6foHipYZy9us1MpoaxQ \
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
curl -u hygnzMy2F1K-5WMQ4aonew:CwBBiTtUV57Pxz7pwpMyGPiF6foHipYZy9us1MpoaxQ \
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
curl -u hygnzMy2F1K-5WMQ4aonew:CwBBiTtUV57Pxz7pwpMyGPiF6foHipYZy9us1MpoaxQ \
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
curl -u hygnzMy2F1K-5WMQ4aonew:CwBBiTtUV57Pxz7pwpMyGPiF6foHipYZy9us1MpoaxQ \
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
curl -u hygnzMy2F1K-5WMQ4aonew:CwBBiTtUV57Pxz7pwpMyGPiF6foHipYZy9us1MpoaxQ \
-X DELETE \
https://dev.imaicloud.com/iam/v1/acccountLinks/yrJKhHOpQ8OG99eN04Amfg
```

# 9. 定制数据

CustomData资源表示IAM中资源的自定义数据。

在基本资源创建的同时，都会创建空的CustomData资源

**访问CustomData**

```
GET /v1/$RESOURCE_TYPE/$RESOURCE_ID/customData
```

curl 查询Account的CustomData

```
curl -u hygnzMy2F1K-5WMQ4aonew:CwBBiTtUV57Pxz7pwpMyGPiF6foHipYZy9us1MpoaxQ \
https://dev.imaicloud.com/iam/v1/accounts/jbrOIebARy2w1Apt1Uw8DA/customData
```

**自定义数据**

```
POST /v1/$RESOURCE_TYPE/$RESOURCE_ID/customData
```

curl 自定义数据

```
curl -u hygnzMy2F1K-5WMQ4aonew:CwBBiTtUV57Pxz7pwpMyGPiF6foHipYZy9us1MpoaxQ \
-H 'Content-Type: application/json' \
-X POST \
-d '{"Author":"pat bear"}' \
https://dev.imaicloud.com/iam/v1/accounts/jbrOIebARy2w1Apt1Uw8DA/customData
```


