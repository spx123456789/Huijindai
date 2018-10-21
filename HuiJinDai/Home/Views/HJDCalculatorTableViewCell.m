//
//  HJDCalculatorTableViewCell.m
//  HuiJinDai
//
//  Created by SHANPX on 2018/9/9.
//  Copyright © 2018年 shanpx. All rights reserved.
//

#import "HJDCalculatorTableViewCell.h"

@implementation HJDCalculatorTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        [self.contentView addSubview:self.titleLabel];
        [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(15);
            make.centerY.mas_equalTo(self.contentView.mas_centerY);
            make.width.mas_equalTo(65);
            make.left.mas_equalTo(self.contentView.mas_left).offset(15);
        }];
        
        [self.contentView addSubview:self.textField];
        [self.textField mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(15);
            make.centerY.mas_equalTo(self.contentView.mas_centerY);
            make.right.mas_equalTo(self.contentView.mas_right).offset(-45);
            make.left.mas_equalTo(self.titleLabel.mas_right).offset(16);
        }];
        
        [self.contentView addSubview:self.moreImageView];
        [self.moreImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(self.contentView.mas_right).offset(-15);
            make.height.mas_equalTo(15);
            make.width.mas_equalTo(10);
            make.centerY.mas_equalTo(self.contentView.mas_centerY);
        }];
        
        [self.contentView addSubview:self.subLabel];
        [self.subLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(self.contentView.mas_right).offset(-15);
            make.height.mas_equalTo(15);
            make.width.mas_equalTo(15);
            make.centerY.mas_equalTo(self.contentView.mas_centerY);
        }];
        
    }

    return self;
}

//自绘分割线
-(void) drawRect:(CGRect)rect
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [UIColor whiteColor].CGColor);
    CGContextFillRect(context, rect);
    CGContextSetStrokeColorWithColor(context, HMRGBHex(@"#EBEBEB").CGColor);
    CGContextStrokeRect(context, CGRectMake(15, rect.size.height, rect.size.width-30, 1));
}

- (UILabel *)subLabel {
    if (!_subLabel) {
        UILabel *label = [[UILabel alloc] init];
        label.backgroundColor = [UIColor clearColor];
        label.font = [UIFont systemFontOfSize:15];
        label.textColor = HMRGBHex(@"#333333");
        _subLabel = label;
    }
    return _subLabel;
}

- (UIImageView *)moreImageView {
    if (!_moreImageView) {
        _moreImageView = [UIImageView new];
        _moreImageView.image = [UIImage imageNamed:@"进入"];
    }
    return _moreImageView;
}

- (UITextField *)textField {
    if (!_textField) {
        UITextField *textField = [[UITextField alloc]initWithFrame:CGRectZero];
        textField.font = [UIFont systemFontOfSize:15];
        textField.textColor = HMRGBHex(@"#333333");
        _textField = textField;
    }
    return _textField;
}

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        UILabel *label = [[UILabel alloc] init];
        label.backgroundColor = [UIColor clearColor];
        label.font = [UIFont systemFontOfSize:15];
        label.textColor = HMRGBHex(@"#333333");
        _titleLabel = label;
    }
    return _titleLabel;
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
