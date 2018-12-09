//
//  UIImage+HJD.h
//  HuiJinDai
//
//  Created by GXW on 2018/10/31.
//  Copyright © 2018年 shanpx. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (HJD)

- (NSData *)compressedImage;

+ (UIImage *)fixOrientation:(UIImage *)aImage;
@end
