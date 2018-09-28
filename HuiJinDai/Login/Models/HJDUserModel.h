//
//  HJDUserModel.h
//  HuiJinDai
//
//  Created by 耿笑威 on 2018/9/28.
//  Copyright © 2018年 shanpx. All rights reserved.
//

#import "HJDBaseModel.h"

@interface HJDUserModel : HJDBaseModel<NSCoding>
/*
 "id":"22",// 用户主编号
 "phone":"17610356577",// 用户手机
 "type":"1",// 用户类型，1-经纪人，2-渠道，3-客户经理
 "invitation":"",// 用户邀请码
 "status":"99",// 用户状态，95-已注销，96-申请注销，97-禁止登录，98-已删除[会直接返回错误]，99-正常
 "avatar":"",// 用户头像，前面需要拼接公共文件前缀
 "sex":"0",// 用户性别，0-保密，1-男，2-女
 "addr_office":"",// 用户工作地址ID[省市区接口列表中]
 "addr_office_tree":{
 "sheng": "1",// 省编号为1，代表北京市
 "shi": "2",// 市编号为2，代表市辖区
 "qu": "5",// 区编号为5，代表朝阳区
 },// 省市区目录树
 "token":"8456e969c5de25d385ca4b3a998d6c06",// 用户登录token标识
 "rename":"测试用户"// 用户真实姓名
 */
@property(nonatomic, copy) NSString *user_id;
@property(nonatomic, copy) NSString *phone;
@property(nonatomic, copy) NSString *type;
@property(nonatomic, copy) NSString *invitation;
@property(nonatomic, copy) NSString *status;
@property(nonatomic, copy) NSString *avatar;
@property(nonatomic, copy) NSString *sex;
@property(nonatomic, copy) NSString *addr_office;
@property(nonatomic, copy) NSString *token;
@property(nonatomic, copy) NSString *rename;
@end
