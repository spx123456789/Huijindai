//
//  HJDHomeOrderDetailPhotoCell.h
//  HuiJinDai
//
//  Created by 耿笑威 on 2018/9/16.
//  Copyright © 2018年 shanpx. All rights reserved.
//

#import "HJDHomeOrderDetailTableViewCell.h"

#define kDetailPhotoWidth (kScreenWidth - 16 * 2 - 8 * 2)/3.0
#define kDetailPhotoHeight (83.0 / 110.0 * kDetailPhotoWidth)

@interface HJDHomeOrderDetailPhotoCell : HJDHomeOrderDetailTableViewCell
@property(nonatomic, strong) NSArray *imgDataArray;
@end
