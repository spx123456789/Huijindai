//
//  HJDPhotoBrowseViewController.h
//  HuiJinDai
//
//  Created by 耿笑威 on 2018/11/3.
//  Copyright © 2018 shanpx. All rights reserved.
//

#import "HJDBaseViewController.h"

@interface HJDPhotoBrowseViewController : HJDBaseViewController
@property(nonatomic, strong) NSArray *dataSource;
@property(nonatomic, assign) NSInteger currentIndex;
@end
