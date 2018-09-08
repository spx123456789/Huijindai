//
//  HJDHomeTableViewCell.h
//  HuiJinDai
//
//  Created by SHANPX on 2018/9/6.
//  Copyright © 2018年 shanpx. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HJDButton.h"
#import "HJDHomeModel.h"



@interface HJDHomeTableViewCell : UITableViewCell

@property (nonatomic, strong) HJDButton *button1;

@property (nonatomic, strong) HJDButton *button2;

@property (nonatomic, strong) HJDButton *button3;

- (void)configCellWithArray:(NSArray*)array;

@end
