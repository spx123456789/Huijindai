//
//  HJDHomeRoomDiDaiTableViewCell.h
//  HuiJinDai
//
//  Created by 耿笑威 on 2018/9/24.
//  Copyright © 2018年 shanpx. All rights reserved.
//

#import <UIKit/UIKit.h>

#define kPhotoWidth (kScreenWidth - 16 * 2 - 8 * 2)/3.0
#define kPhotoHeight (83.0 / 110.0 * kPhotoWidth)

@class HJDHomeRoomDiDaiTableViewCell;
@protocol HJDHomeRoomDiDaiTableViewCellDelegate<NSObject>
- (void)roomDiDaiCellDidClick:(HJDHomeRoomDiDaiTableViewCell *)cell;
@end

@interface HJDHomeRoomDiDaiTableViewCell : UITableViewCell
@property(nonatomic, strong) UITextField *textField;
@property(nonatomic, strong) UILabel *leftLabel;
@property(nonatomic, strong) UIImageView *rightImgView;
@property(nonatomic, strong) UILabel *rightLabel;
@property(nonatomic, strong) UIView *lineView;
@property(nonatomic, copy) NSString *placeholderString;

@property(nonatomic, weak) id<HJDHomeRoomDiDaiTableViewCellDelegate> delegate;
@property(nonatomic, assign) BOOL fieldCanEdit;
@end

//报单 照片上传cell
@class HJDHomeRoomDiDaiPhotoTableViewCell;
@protocol HJDHomeRoomDiDaiPhotoTableViewCellDelegate
- (void)photoCell:(HJDHomeRoomDiDaiPhotoTableViewCell *)photoCell clickDeleteButtonAtIndex:(NSInteger)index;
- (void)photoCell:(HJDHomeRoomDiDaiPhotoTableViewCell *)photoCell clickAddButton:(id)sender;
@end

@interface HJDHomeRoomDiDaiPhotoTableViewCell : UITableViewCell
@property(nonatomic, copy) NSString *title;
@property(nonatomic, weak) id<HJDHomeRoomDiDaiPhotoTableViewCellDelegate> delegate;

- (void)addCellImageWithImageArray:(NSArray *)imgArray;
@end
