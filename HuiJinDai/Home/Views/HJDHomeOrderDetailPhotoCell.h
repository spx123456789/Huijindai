//
//  HJDHomeOrderDetailPhotoCell.h
//  HuiJinDai
//
//  Created by GXW on 2018/9/16.
//  Copyright © 2018年 shanpx. All rights reserved.
//

#import "HJDHomeOrderDetailTableViewCell.h"

#define kDetailPhotoWidth (kScreenWidth - 16 * 2 - 8 * 2)/3.0
#define kDetailPhotoHeight (83.0 / 110.0 * kDetailPhotoWidth)

@class HJDHomeOrderDetailPhotoCell;
@protocol HJDHomeOrderDetailPhotoCellDelegate <NSObject>
- (void)detailPhotoCell:(HJDHomeOrderDetailPhotoCell *)detailPhotoCell didSelectIndexPath:(NSIndexPath *)indexPath;
@end

@interface HJDHomeOrderDetailPhotoCell : HJDHomeOrderDetailTableViewCell
@property(nonatomic, weak) id<HJDHomeOrderDetailPhotoCellDelegate> delegate;
@property(nonatomic, strong) NSMutableArray *imgDataArray;
@end
