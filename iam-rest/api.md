1. 创建Account

POST /api/v1/accounts

{
    "email":"123456@163.com",
    "password":"123456",
    "status":"enabled",
    "username":"Lion"
}

2. 创建用户组Group

POST /api/v1/groups

{
    "name":"Group A",
    "description":"Test Group",
    "status":"enabled"
}

3. 将Account添加到Group

POST /api/v1/groupMemberships

{
    "account":"PYuMRmTSTvCltqHIHoAZ2A",
    "group":"7sY39nbxQpSGxFdt6Yeu2Q"
}

4. Account的附属资源customData

Account创建过程会同时创建customData，其中的定制数据为空

4.1 访问Account的customData

GET /api/v1/accounts/$ACCOUNT_ID/customData

4.2 定制cusotmData数据

POST /api/v1/accounts/$$ACCOUNT_ID/customData

{
	"permission":"A"
}
