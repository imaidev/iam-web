[TOC]


## iam scene-imaicloud 使用说明

本文档简单介绍如何通过curl获取iam的rest资源。虽然像登录，注册等动作行为并不是rest资源，但iam也提供类似的restful服务，以方便做到前后端的分离。

下面简单介绍下iam。iam全称Identity Authentication Management，就是身份认证管理。iam仿照stormpath，同时做了一定的简化。iam中的主要资源包括租户Tenant，账号Account，目录Directory，分组Group，自定义数据CustomData等。下面简单介绍iam的操作流程。
iam的API测试，参照pyresttest，相应的[yaml文件地址](https://github.com/imaidev/iam-web/edit/gh-pages/iam-rest/iam.yaml)

# 1. iam注册

iam注册需要用户提供邮箱，用户名，密码。iam为用户分配租户Tenant，并创建初始的账号Account，目录Directory等。

```
{
	"email":"test01@163.com",
	"username":"test01",
	"password":"123456",
	"password2":"123456"
}
```

curl访问

```
curl -H 'Content-Type:application/json' \
-X POST \
-d '{"email":"test01@163.com","username":"test01","password":"123456","password2":"123456"}' \
https://dev.imaicloud.com/iam/admin/register
```
# 2. iam登录

iam注册完毕之后，会返回登录需要的租户Key，会在登录iam时用到。

```
{
	"type":"Basic",
	"value":"dGVzdDAxQDE2My5jb206MTIzNDU2",
	"tenantKey":$TENANT_KEY,
	"token":"true"
}
```

$TENANT_KEY是注册时返回的值。value是email:password的Base64编码。

```
curl -H 'Content-Type:application/json' \
-X POST \
-d '{"type":"Basic","value":"dGVzdDAxQDE2My5jb206MTIzNDU2","tenantKey":"nufjlf-slzvnr","token":"true"}' \
https://dev.imaicloud.com/iam/admin/login
```
iam登录成功后会获得两个很重要的凭据：
1. API KEY
2. token

API KEY与token是在后面用curl访问iam的rest资源必不可缺的凭据。其中API KEY主要用于请求的基本认证，token则包含更为丰富的信息，现阶段的token是为imai平台的nginx的安全认证设定的token。

# 3. 租户

当在后面访问iam的rest资源时，可以采用两种方式，下面以获取当前租户Tenant为例。

## 3.1 API KEY方式

```
curl -u $APIKEY_ID:$APIKEY_SECRET   \
https://dev.imaicloud.com/iam/v1/tenants/current
```


```
curl -u e___yeKU7IlkZ5JASXbEow:6q+HuckmOaNgSGsrQWBydhfKFepTOqq5eK+6V87mCgE  \
https://dev.imaicloud.com/iam/v1/tenants/current
```

## 3.2 token方式

```
curl -H "X-Auth-Token:$token" \
https://dev.imaicloud.com/iam/v1/tenants/current
```

```
curl -H "X-Auth-Token:eyJhbGciOiJOR0lOWE1ENSIsInR5cCI6IkpXVCJ9.eyJhdWQiOiJ3d3cuaW1haWNsb3VkLmNvbSIsImlzcyI6ImlhbS5pbnNwdXIuY29tIiwiZXhwIjoxNDg2MTI0MTQ4MTc2LCJpYXQiOjE0ODYxMjIzNDgxNzYsImFjY291bnRJZCI6IjhTdUIycU5NUnpLOEZvSmxnenp5dnciLCJlbWFpbCI6InRlc3QwMUAxNjMuY29tIiwidXNlcm5hbWUiOiJ0ZXN0MDEiLCJncm91cCI6ImFkbWluIn0.N_bB5pouZcx8MJ3UlTP-wg" \
https://dev.imaicloud.com/iam/v1/tenants/current
```
在直接使用curl访问iam的rest资源时，API KEY与token方式都可以，但token方式其实更多的是为了前端开发，访问rest资源的考虑。
iam登录返回的token仿照jwt构造，分为：header,payload,signature。
imai的nginx的验证模块所需要的参数包含在token中，由于nginx支持cookie的方式传递验证参数，因此可以在前端通过js对token解析，这里不做过多介绍。

## 3.3 Tenant
上面主要在介绍访问iam的rest资源的两个凭据API KEY与token的使用，并以当前tenant举例。实际上，tenant有众多的rest资源可以访问。
租户是IAM用于区分资源所属的容器，可以直接通过租户的ID获取租户。（当然我们只能获取自己的租户，这由API KEY，或token决定）

$TENANT_ID可以在上节获取当前租户的返回信息中获得。
```
GET /v1/tenants/$TENANT_ID
```


```
curl -u $APIKEY_ID:$APIKEY_SECRET \
https://dev.imaicloud.com/iam/v1/tenants/ULvrPudaQfqBhZWV2uqvLQ
```
+ ULvrPudaQfqBhZWV2uqvLQ是iam注册时创建的Tenant租户资源的ID


tenant包含所有的资源，如账号Account，目录Directory等。查看方式如下所示。

```
GET /v1/tenants/$TENANT_ID/$RESOURCE_TYPE
```
+ RESOURCE_TYPE可以是applications,organizations.directories,groups,accounts


```
curl -u $APIKEY_ID:$APIKEY_SECRET  \
https://dev.imaicloud.com/iam/v1/tenants/ULvrPudaQfqBhZWV2uqvLQ/accounts
```

# 4. 应用 Application

Application是IAM关联、管理外部应用的资源形式。
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
创建应用后，返回应用的id与href信息。


**2. 获取单个应用**

```
GET /v1/applications/$APP_ID
```

```
curl -u $APIKEY_ID:$APIKEY_SECRET \
https://dev.imaicloud.com/iam/v1/applications/3wylhfo6RDm-OGRAUQj45Q
```
+ 3wylhfo6RDm-OGRAUQj45Q是创建Application应用资源获得的ID

**3. 更新应用**

```
POST /v1/applications/$APP_ID

{
 "appStatus":"disabled"
}
```

```
curl -u $APIKEY_ID:$APIKEY_SECRET \
-H 'Content-Type:application/json' \
-X POST \
-d '{"appStatus":"enabled"}' \
https://dev.imaicloud.com/iam/v1/applications/3wylhfo6RDm-OGRAUQj45Q
```



**4. 删除应用**

```
DELETE /v1/applications/$APP_ID
```

```
curl -u $APIKEY_ID:$APIKEY_SECRET \
-X DELETE \
https://dev.imaicloud.com/iam/v1/applications/3wylhfo6RDm-OGRAUQj45Q
```


**5. 应用相关资源查询**

```
GET /v1/applications/$APP_ID/$RESOURCE_TYPE
```

可以查询的Resource可以是accounts，groups


**6. 应用登录**

应用的登录与iam的登录不同。

iam中的应用Application资源，假定每个应用都有一批属于自己的用户，比如App01有user11，user12等，App02有user21,user22等。
不同应用对应不同的用户体系。而所有的用户，无论是App01对应的用户，还是App02对应的用户都是iam的Account资源。
而iam正是因为Application资源的存在，才能够面向多应用提供认证服务。

iam的登录是属于更为高级的登录，它不具体于任何应用，而仅仅是为了用户体系的创建而做的准备。

由于新创建的app01的应用中并不存在账号Account，因此可以使用在iam注册时默认创建的应用进行验证。
首先是要获取默认的应用，可以通过如下的REST请求获取

```
GET /v1/tenants/$TENANT_ID/applications
```
+ 默认创建的应用资源的名称为IAM Admin，在Tenant中应用名是唯一的。
默认的IAM Admin资源有账号test01@163.com与之关联，登录方式与iam登录类似，但不提供tenantKey。

```
POST /v1/applications/$APP_ID/loginAttempts

{
 "type":"Basic",
 "value":$VALUE,
 "token":"true"
}
```

```
curl -u $APIKEY_ID:$APIKEY_SECRET \
-H 'Content-Type:application/json' \
-X POST \
-d '{"type":"Basic","value":"dGVzdDAxQDE2My5jb206MTIzNDU2","token":"true"}' \
https://dev.imaicloud.com/iam/v1/applications/3wylhfo6RDm-OGRAUQj45Q/loginAttempts
```

# 5. 目录 Direcctory

上一节对于Application资源进行crud操作，在接下来操作iam的rest资源时将不对curl进行描述，只是描述rest请求模型。


**1. 创建目录**

```
POST /v1/directories

{
 "name":$DIR_NAME
}
```


**2. 查询全部目录**

```
GET /v1/directories
```


**3. 查询单个目录**

```
GET /v1/directories/$DIR_ID
```


**4. 更新目录**

```
POST /v1/directories/$DIR_ID

{
 "directoryStatus":"disabled"
}
```

**5. 删除目录**

```
DELETE /v1/directories/$DIR_ID
```

**6. 查询目录下相关资源**

```
GET /v1/directories/$DIR_ID/$RESOURCE_TYPE
```

可以查询的相关资源有：group，account


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


**2. 查询单个分组**

```
GET /v1/groups/$GROUP_ID
```

**3. 更新分组**

```
POST /v1/groups/$GROUP_ID

{
 "groupStatus":"disabled"
}
```


**4. 删除分组**

```
 DELETE /v1/groups/$GROUP_ID
```

**5. 查询分组的相关资源**

```
GET /v1/groups/$GROUP_ID/$RESOURCE_TYPE
```

分组可以查询的基本资源包括：accounts，applications


# 7. 账号 Account

账号是IAM的核心资源，属于目录。
通过与其他资源相互关联，形成灵活的账号体系。

**1. 创建账号**

```
POST /v1/directoires/$DIR_ID/accounts
POST /v1/applications/$APP_ID/accounts
POST /v1/organizations/$ORGAN_ID/accounts

{
 "email":"test02@163.com",
 "password":"123456"
}
```
+ 账号可以在目录，应用，组织下创建。
+ 账号的本质是在目录下创建，在应用或组织下创建，是因为应用，组织都可以与目录关联
+ 必选字段：email,password
+ 可选字段：username,status,description


**2. 查询单个账号**

```
GET /v1/accounts/$ACCOUNT_ID
```

**3. 更新账号**

```
POST /v1/accounts/$ACCOUNT_ID

{
 "userName":"test03"
 ...
}
```

**4. 查看关联资源**

```
GET /v1/accounts/$ACCOUNT_ID/$RESOURCE_TYPE
```

账号可以查看的资源主要是：groups

**5. 关联分组与账号**

GroupMembership在IAM表示分组Group与账号Account的关联关系，可以解释为将账号添加入分组；或者将某角色赋予账号

```
POST /v1/groupMemberships

{
 "account":...,
 "group":...
}
```
+ 必选字段：group,account


**6. 解除账号与分组的关联**

```
DELETE /v1/groupshipMemberships/$GM_ID
```

**7. 关联账号**

AccountLink资源用于关联位于不同目录的账号。

```
POST /v1/accountLinks

{
 "leftAccount":...,
 "rightAccount":...
}
```
+ 必选字段：leftAccount,rightAccount

**8. 解除账号关联**

```
DELETE /v1/accountLinks/$LINK_ID
```

# 8. 定制数据

CustomData资源表示IAM中资源的自定义数据。

在基本资源创建的同时，都会创建空的CustomData资源

**1. 访问CustomData**

```
GET /v1/$RESOURCE_TYPE/$RESOURCE_ID/customData
```

**2. 自定义数据**

```
POST /v1/$RESOURCE_TYPE/$RESOURCE_ID/customData

{
	"address":"inspur"
}
```



