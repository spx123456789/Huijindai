//
//  UITableView+HJD.m
//  HJD
//
//  Created by SHANPX on 15/12/14.
//  Copyright © 2015年 Oradt. All rights reserved.
//

#import "UITableView+HJD.h"

@implementation UITableView (HJD)
- (void)setExtraCellLineHidden:(BOOL)isHiden {
    if (isHiden) {
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, kSafeAreaBottomHeight)];
        view.backgroundColor = [UIColor clearColor];
        [self setTableFooterView:view];
    } else {
        [self setTableFooterView:nil];
    }
}
@end
