//
//  HJDHomeTableViewCell.m
//  HuiJinDai
//
//  Created by SHANPX on 2018/9/6.
//  Copyright © 2018年 shanpx. All rights reserved.
//

#import "HJDHomeTableViewCell.h"

@interface HJDHomeTableViewCell()

@end


@implementation HJDHomeTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        CGFloat buttonWidth = kScreenWidth/3;
        CGFloat buttonHeight = 100;
        self.button1 = [[HJDButton alloc]initWithFrame:CGRectMake(0, 0, buttonWidth, buttonHeight)];
        [self.contentView addSubview:self.button1];
        self.button2 = [[HJDButton alloc]initWithFrame:CGRectMake(buttonWidth, 0, buttonWidth, buttonHeight)];
        [self.contentView addSubview:self.button2];
        self.button3 = [[HJDButton alloc]initWithFrame:CGRectMake(2*buttonWidth, 0, buttonWidth, buttonHeight)];
        [self.contentView addSubview:self.button3];
    }
    return self;
}

- (void)configCellWithArray:(NSArray*)array {
    
    HJDHomeModel * model1 = [array objectAtIndex:0];
    if (model1) {
        self.button1.titleLabel.text = model1.title;
        self.button1.userInteractionEnabled = YES;

    }else {
        self.button1.titleLabel.text = nil;
        self.button1.userInteractionEnabled = NO;

    }
    HJDHomeModel * model2 = [array objectAtIndex:1];
    if (model2) {
        self.button2.titleLabel.text = model2.title;
        self.button2.userInteractionEnabled = YES;
        
    }else {
        self.button2.titleLabel.text = nil;
        self.button2.userInteractionEnabled = NO;
        
    }
    if (array.count>2){
        HJDHomeModel * model3 = [array objectAtIndex:2];
        if (model3) {
            self.button3.titleLabel.text = model3.title;
            self.button3.userInteractionEnabled = YES;
            
        }else {
            self.button3.titleLabel.text = nil;
            self.button3.userInteractionEnabled = NO;
            
        }
    }
    
        
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
