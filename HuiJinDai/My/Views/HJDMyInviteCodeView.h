//
//  HJDMyInviteCodeView.h
//  HuiJinDai
//
//  Created by GXW on 2018/9/6.
//  Copyright © 2018年 shanpx. All rights reserved.
//

#import <UIKit/UIKit.h>

@class HJDMyInviteCodeView;
@protocol HJDMyInviteCodeViewDelegate <NSObject>
//会话 0 朋友圈 1
- (void)myInviteCodeView:(HJDMyInviteCodeView *)codeView didSelectIndex:(NSInteger)index;

@end

@interface HJDMyInviteCodeView : UIView
@property(nonatomic, strong) UIImageView *headImgView;
@property(nonatomic, strong) UILabel *nameLabel;
@property(nonatomic, strong) UILabel *cityLabel;
@property(nonatomic, copy) NSString *inviteCode;

@property(nonatomic, weak) id<HJDMyInviteCodeViewDelegate> delegate;

@property(nonatomic, strong) NSDictionary *shareDictionary;
@end
