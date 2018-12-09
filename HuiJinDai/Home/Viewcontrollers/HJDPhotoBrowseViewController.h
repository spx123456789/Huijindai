//
//  HJDPhotoBrowseViewController.h
//  HuiJinDai
//
//  Created by GXW on 2018/11/3.
//  Copyright © 2018 shanpx. All rights reserved.
//

#import "HJDBaseViewController.h"

@interface HJDPhotoBrowseViewController : HJDBaseViewController
@property(nonatomic, strong) NSArray *dataSource;
@property(nonatomic, strong) NSIndexPath *currentIndexPath;
@end
