//
//  HJDHomeOrderDetailPhotoCell.m
//  HuiJinDai
//
//  Created by 耿笑威 on 2018/9/16.
//  Copyright © 2018年 shanpx. All rights reserved.
//

#import "HJDHomeOrderDetailPhotoCell.h"
#import "HJDHomePhotoCollectionViewCell.h"

@interface HJDHomeOrderDetailPhotoCell()<UICollectionViewDelegate, UICollectionViewDataSource>
@property(nonatomic, strong) UIView *photoView;
@property(nonatomic, strong) UICollectionView *collectionView;
@end

@implementation HJDHomeOrderDetailPhotoCell

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
        layout.itemSize = CGSizeMake(kDetailPhotoWidth, kDetailPhotoHeight);
        //设置每个分区的上左下右的内边距
        layout.sectionInset = UIEdgeInsetsMake(12, 16, 0, 16);
        //设置区头和区尾的大小
        layout.headerReferenceSize = CGSizeMake(kScreenWidth, 30);
        //设置分区的头视图和尾视图是否始终固定在屏幕上边和下边
        layout.sectionHeadersPinToVisibleBounds = NO;
        
        _collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 100) collectionViewLayout:layout];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.backgroundColor = [UIColor cyanColor];
        [_collectionView registerClass:[HJDHomePhotoCollectionViewCell class] forCellWithReuseIdentifier:@"HJDHomePhotoCollectionViewCell"];
        [_collectionView registerClass:[HJDHomeCollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"HJDHomeCollectionReusableView"];
    }
    return _collectionView;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self.bgView addSubview:self.photoView];
        [self.photoView addSubview:self.collectionView];
        
        [self.photoView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.bottom.equalTo(self.bgView);
            make.top.equalTo(self.lineView.mas_bottom);
        }];
    }
    return self;
}

- (void)setImgDataArray:(NSArray *)imgDataArray {
    _imgDataArray = imgDataArray;
    CGFloat collectionHeight = 0;
    for (NSArray *sectionArray in imgDataArray) {
        collectionHeight += 30;
        collectionHeight += (12 + kDetailPhotoHeight * (sectionArray.count/3 + 1) + 8 * (sectionArray.count/3));
    }
    self.collectionView.frame = CGRectMake(0, 0, kScreenWidth, collectionHeight);
}

#pragma mark - UICollectionViewDelegate,UICollectionViewDataSource
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return self.imgDataArray.count;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    NSArray *sectionArray = self.imgDataArray[section];
    return sectionArray.count;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellIndentifer = @"HJDHomePhotoCollectionViewCell";
    HJDHomePhotoCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellIndentifer forIndexPath:indexPath];
    cell.backgroundColor = [UIColor cyanColor];
    //cell.imageStr = _imagesArray[indexPath.item];
    cell.imageView.image = kImage(@"添加证件");
    cell.deleteButton.hidden = YES;
    return cell;
}
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    if (kind == UICollectionElementKindSectionHeader){
        HJDHomeCollectionReusableView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"HJDHomeCollectionReusableView" forIndexPath:indexPath];
        headerView.backgroundColor = kWithe;
        //NSArray *sectionArray = self.imgDataArray[indexPath.section];
        NSString *title = @"";
        switch (indexPath.section) {
            case 0:
                title = @"借款人身份证";
                break;
            case 1:
                title = @"借款人户口本";
                break;
            case 2:
                title = @"借款人征信报告";
                break;
            case 3:
                title = @"借款人婚姻证明";
                break;
            default:
                title = @"房产证";
                break;
        }
        headerView.titleLabel.text = title;
        return headerView;
    }
    return nil;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"点击了第%ld分item",(long)indexPath.item);
}

@end
