//
//  HJDHomeRoomSelectViewController.h
//  HuiJinDai
//
//  Created by 耿笑威 on 2018/9/30.
//  Copyright © 2018年 shanpx. All rights reserved.
//

#import "HJDBaseViewController.h"
#import "HJDHomeRoomDiDaiModel.h"

typedef enum : NSUInteger {
    HJDRoomSearchCommunity, //小区
    HJDRoomSearchBuilding,  //楼栋
    HJDRoomSearchUnit,      //单元
    HJDRoomSearchHouse,     //房间
} HJDRoomSearchType;

typedef void (^DetailInfo)(NSDictionary *dic);

@interface HJDHomeRoomSelectViewController : HJDBaseViewController
@property(nonatomic, assign) HJDRoomSearchType searchType;
@property(nonatomic, strong) HJDHomeRoomDiDaiModel *diDaiModel;
@property(nonatomic, copy) DetailInfo callback;
@end
