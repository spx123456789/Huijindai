//
//  HJDHomeRoomDiDaiTableViewCell.m
//  HuiJinDai
//
//  Created by 耿笑威 on 2018/9/24.
//  Copyright © 2018年 shanpx. All rights reserved.
//

#import "HJDHomeRoomDiDaiTableViewCell.h"
#import "HJDHomePhotoCollectionViewCell.h"

@interface HJDHomeRoomDiDaiTableViewCell()<UITextFieldDelegate>
@property(nonatomic, strong) UIView *bgView;
@property(nonatomic, strong) UIView *redView;
@end

@implementation HJDHomeRoomDiDaiTableViewCell

- (UIView *)bgView {
    if (!_bgView) {
        _bgView = [[UIView alloc] init];
        _bgView.backgroundColor = kWithe;
    }
    return _bgView;
}

- (UIView *)lineView {
    if (!_lineView) {
        _lineView = [[UIView alloc] init];
        _lineView.backgroundColor = kLineColor;
    }
    return _lineView;
}

- (UIView *)redView {
    if (!_redView) {
        _redView = [[UIView alloc] init];
        _redView.layer.masksToBounds = YES;
        _redView.layer.cornerRadius = 2.f;
        _redView.backgroundColor = kRGB_Color(0xff, 0x52, 0x52);
    }
    return _redView;
}

- (UILabel *)leftLabel {
    if (!_leftLabel) {
        _leftLabel = [[UILabel alloc] init];
        _leftLabel.textColor = kRGB_Color(0x66, 0x66, 0x66);
        _leftLabel.font = kFont15;
    }
    return _leftLabel;
}

- (UITextField *)textField {
    if (!_textField) {
        _textField = [[UITextField alloc] init];
        _textField.returnKeyType = UIReturnKeyDone;
        _textField.textColor = kRGB_Color(0x33, 0x33, 0x33);
        _textField.font = kFont15;
        _textField.delegate = self;
    }
    return _textField;
}

- (UIImageView *)rightImgView {
    if (!_rightImgView) {
        _rightImgView = [[UIImageView alloc] initWithImage:kImage(@"进入")];
        _rightImgView.userInteractionEnabled = YES;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapGesture:)];
        [_rightImgView addGestureRecognizer:tap];
    }
    return _rightImgView;
}

- (void)tapGesture:(id)sender {
    if (self.delegate && [self.delegate respondsToSelector:@selector(roomDiDaiCellDidClick:)]) {
        [self.delegate roomDiDaiCellDidClick:self];
    }
}

- (UILabel *)rightLabel {
    if (!_rightLabel) {
        _rightLabel = [[UILabel alloc] init];
        _rightLabel.textColor = kRGB_Color(33, 0x33, 0x33);
        _rightLabel.font = kFont15;
        _rightLabel.textAlignment = NSTextAlignmentRight;
    }
    return _rightLabel;
}

- (void)setUpUI {
    [self.contentView addSubview:self.bgView];
    [self.bgView addSubview:self.redView];
    [self.bgView addSubview:self.leftLabel];
    [self.bgView addSubview:self.textField];
    [self.bgView addSubview:self.rightImgView];
    [self.bgView addSubview:self.rightLabel];
    [self.bgView addSubview:self.lineView];
    
    [self.bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.contentView);
        make.bottom.equalTo(self.contentView);
        make.height.equalTo(@44);
    }];
    
    [self.redView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.bgView).offset(16);
        make.size.mas_equalTo(CGSizeMake(4, 4));
        make.centerY.equalTo(self.bgView);
    }];
    
    [self.leftLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.redView.mas_right).offset(5);
        make.size.mas_equalTo(CGSizeMake(65, 16));
        make.centerY.equalTo(self.bgView);
    }];
    
    [self.textField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.leftLabel.mas_right).offset(24);
        make.right.equalTo(self.bgView).offset(-(16 + 40));
        make.height.equalTo(@36);
        make.centerY.equalTo(self.bgView);
    }];
    
    [self.rightLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.bgView).offset(-16);
        make.size.mas_equalTo(CGSizeMake(35, 16));
        make.centerY.equalTo(self.bgView);
    }];
    
    [self.rightImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.bgView).offset(-16);
        make.size.mas_equalTo(CGSizeMake(9, 16));
        make.centerY.equalTo(self.bgView);
    }];
    
    [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.bgView).offset(16);
        make.right.equalTo(self.bgView).offset(-16);
        make.height.equalTo(@1);
        make.bottom.equalTo(self.bgView.mas_bottom);
    }];
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.contentView.backgroundColor = kRGB_Color(0xf4, 0xf4, 0xf4);
        self.fieldCanEdit = YES;
        [self setUpUI];
    }
    return self;
}

- (void)setPlaceholderString:(NSString *)placeholderString {
    _placeholderString = placeholderString;
    self.textField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:placeholderString attributes:@{ NSForegroundColorAttributeName : kRGB_Color(0xd4, 0xd4, 0xd4), NSFontAttributeName : kFont15 }];
}

#pragma mark - UITextFieldDelegate
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    return self.fieldCanEdit;
}
@end

#pragma mark - 报单 照片上传cell
@interface HJDHomeRoomDiDaiPhotoTableViewCell()<UICollectionViewDelegate, UICollectionViewDataSource, HJDHomePhotoCollectionViewCellDelegate>
@property(nonatomic, strong) UILabel *titleLabel;
@property(nonatomic, strong) UIView *lineView;
@property(nonatomic, strong) UIView *bgView;
@property(nonatomic, strong) UIView *photoView;
@property(nonatomic, strong) UICollectionView *collectionView;
@end

@implementation HJDHomeRoomDiDaiPhotoTableViewCell

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
    }
    return _titleLabel;
}

- (UIView *)lineView {
    if (!_lineView) {
        _lineView = [[UIView alloc] init];
        _lineView.backgroundColor = kLineColor;
    }
    return _lineView;
}

- (UIView *)bgView {
    if (!_bgView) {
        _bgView = [[UIView alloc] init];
        _bgView.backgroundColor = kWithe;
    }
    return _bgView;
}

- (UIView *)photoView {
    if (!_photoView) {
        _photoView = [[UIView alloc] init];
        _photoView.backgroundColor = kWithe;
    }
    return _photoView;
}

- (UICollectionView *)collectionView {
    if (!_collectionView) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        //设置item的行间距和列间距
        layout.minimumInteritemSpacing = 8;
        layout.minimumLineSpacing = 8;
        //设置item的大小
        layout.itemSize = CGSizeMake(kPhotoWidth, kPhotoHeight);
        //设置每个分区的上左下右的内边距
        layout.sectionInset = UIEdgeInsetsMake(16, 16, 16, 16);
        
        _collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 16 + kPhotoHeight + 16) collectionViewLayout:layout];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.backgroundColor = kWithe;
        [_collectionView registerClass:[HJDHomePhotoCollectionViewCell class] forCellWithReuseIdentifier:@"HJDHomePhotoCollectionViewCell"];
    }
    return _collectionView;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.contentView.backgroundColor = kRGB_Color(0xf4, 0xf4, 0xf4);
        [self.contentView addSubview:self.bgView];
        [self.bgView addSubview:self.titleLabel];
        [self.bgView addSubview:self.lineView];
        [self.bgView addSubview:self.photoView];
        [self.photoView addSubview:self.collectionView];
        
        [self.bgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.bottom.equalTo(self.contentView);
            make.top.equalTo(self.contentView).offset(4);
        }];
        
        [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.bgView).offset(16);
            make.right.equalTo(self.bgView).offset(-16);
            make.top.equalTo(self.bgView);
            make.height.equalTo(@44);
        }];
        
        [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(self.titleLabel);
            make.height.equalTo(@1);
            make.top.equalTo(self.titleLabel.mas_bottom);
        }];
        
        [self.photoView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.bottom.equalTo(self.bgView);
            make.top.equalTo(self.lineView.mas_bottom).offset(0);
        }];
    }
    return self;
}

- (void)setTitle:(NSString *)title {
    _title = title;
    NSString *str = [NSString stringWithFormat:@"%@（不限制上传）", title];
    NSMutableAttributedString *attributeStr = [[NSMutableAttributedString alloc] initWithString:str attributes:@{ NSFontAttributeName : kFont15, NSForegroundColorAttributeName : kRGB_Color(0x66, 0x66, 0x66) }];
    [attributeStr setAttributes:@{ NSFontAttributeName : kFont15, NSForegroundColorAttributeName : kRGB_Color(0x99, 0x99, 0x99)} range:NSMakeRange(str.length - 7, 7)];
    self.titleLabel.attributedText = attributeStr;
}

- (void)setImageArray:(NSArray *)imageArray {
    _imageArray = imageArray;
    CGFloat height = 16 + kPhotoHeight * (imageArray.count/3 + 1) + 8 * (imageArray.count/3) + 16;
    self.collectionView.frame = CGRectMake(0, 0, kScreenWidth, height);
    [self.collectionView reloadData];
}

#pragma mark - HJDHomePhotoCollectionViewCellDelegate
- (void)photoCollectionCell:(HJDHomePhotoCollectionViewCell *)photoCollectionCell deleteButton:(id)sender {
    NSIndexPath *indexPath = [self.collectionView indexPathForCell:photoCollectionCell];
    if (self.delegate && [self.delegate respondsToSelector:@selector(photoCell:clickDeleteButtonAtIndex:)]) {
        [self.delegate photoCell:self clickDeleteButtonAtIndex:indexPath.row - 1];
    }
}

- (void)photoCollectionCell:(HJDHomePhotoCollectionViewCell *)photoCollectionCell clickImageView:(id)sender {
    NSIndexPath *indexPath = [self.collectionView indexPathForCell:photoCollectionCell];
    if (indexPath.item == 0 && self.delegate && [self.delegate respondsToSelector:@selector(photoCell:clickAddButton:)]) {
        [self.delegate photoCell:self clickAddButton:sender];
    }
}

#pragma mark - UICollectionViewDelegate
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.imageArray.count + 1;
}

#pragma mark - UICollectionViewDataSource
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIndentifer = @"HJDHomePhotoCollectionViewCell";
    HJDHomePhotoCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellIndentifer forIndexPath:indexPath];
    cell.delegate = self;
    if (indexPath.item == 0) {
        cell.imageView.image = kImage(@"添加证件");
        cell.deleteButton.hidden = YES;
    } else {
        NSDictionary *pictureInfo = self.imageArray[indexPath.item - 1];
        cell.imageView.image = pictureInfo[UIImagePickerControllerEditedImage];
        cell.deleteButton.hidden = NO;
    }
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {

}

@end
