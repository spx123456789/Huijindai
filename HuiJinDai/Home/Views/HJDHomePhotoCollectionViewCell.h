//
//  HJDHomePhotoCollectionViewCell.h
//  HuiJinDai
//
//  Created by 耿笑威 on 2018/10/13.
//  Copyright © 2018年 shanpx. All rights reserved.
//

#import <UIKit/UIKit.h>

@class HJDHomePhotoCollectionViewCell;
@protocol HJDHomePhotoCollectionViewCellDelegate<NSObject>
- (void)photoCollectionCell:(HJDHomePhotoCollectionViewCell *)photoCollectionCell deleteButton:(id)sender;
- (void)photoCollectionCell:(HJDHomePhotoCollectionViewCell *)photoCollectionCell clickImageView:(id)sender;
@end

@interface HJDHomePhotoCollectionViewCell : UICollectionViewCell
@property(nonatomic, strong) UIImageView *imageView;
@property(nonatomic, strong) UIButton *deleteButton;
@property(nonatomic, weak) id<HJDHomePhotoCollectionViewCellDelegate> delegate;
@end

@interface HJDHomeCollectionReusableView : UICollectionReusableView
@property(nonatomic, strong) UILabel *titleLabel;
@end
