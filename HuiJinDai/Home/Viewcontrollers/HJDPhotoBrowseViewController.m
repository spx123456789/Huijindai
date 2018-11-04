//
//  HJDPhotoBrowseViewController.m
//  HuiJinDai
//
//  Created by 耿笑威 on 2018/11/3.
//  Copyright © 2018 shanpx. All rights reserved.
//

#import "HJDPhotoBrowseViewController.h"

@interface HJDPhotoBrowseCollectionCell : UICollectionViewCell
@property(nonatomic, strong) UIImageView *photoImgView;
@end

@implementation HJDPhotoBrowseCollectionCell
- (UIImageView *)photoImgView {
    if (!_photoImgView) {
        _photoImgView = [[UIImageView alloc] init];
        _photoImgView.contentMode = UIViewContentModeScaleAspectFit;
    }
    return _photoImgView;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self.contentView addSubview:self.photoImgView];
        @weakify(self);
        [self.photoImgView mas_makeConstraints:^(MASConstraintMaker *make) {
            @strongify(self);
            make.edges.equalTo(self.contentView).insets(UIEdgeInsetsMake(0, 0, 0, 0));
        }];
    }
    return self;
}
@end

@interface HJDPhotoBrowseViewController ()<UICollectionViewDelegate, UICollectionViewDataSource>
@property(nonatomic, strong) UICollectionView *collectionView;
@end

@implementation HJDPhotoBrowseViewController

- (UICollectionView *)collectionView {
    if (!_collectionView) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
        layout.minimumLineSpacing = 0.f;
        layout.minimumInteritemSpacing = 0.f;
        layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        layout.itemSize = CGSizeMake(kScreenWidth, kScreenHeight - kSafeAreaTopHeight - kSafeAreaBottomHeight);
        
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight - kSafeAreaTopHeight - kSafeAreaBottomHeight) collectionViewLayout:layout];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.pagingEnabled = YES;
        [_collectionView registerClass:[HJDPhotoBrowseCollectionCell class] forCellWithReuseIdentifier:@"HJDPhotoBrowseCollectionCell"];
    }
    return _collectionView;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        _currentIndexPath = nil;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view addSubview:self.collectionView];
    
    if (self.currentIndexPath != nil) {
        [self.collectionView scrollToItemAtIndexPath:self.currentIndexPath atScrollPosition:UICollectionViewScrollPositionLeft animated:NO];
    }
}

#pragma mark - UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    NSDictionary *sectionDic = self.dataSource[section];
    NSArray *sectionArray = sectionDic[@"list"];
    return sectionArray.count;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return self.dataSource.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIndentifer = @"HJDPhotoBrowseCollectionCell";
    HJDPhotoBrowseCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellIndentifer forIndexPath:indexPath];
    NSDictionary *sectionDic = self.dataSource[indexPath.section];
    NSArray *sectionArray = sectionDic[@"list"];
    NSDictionary *pictureDic = sectionArray[indexPath.item];
    [cell.photoImgView sd_setImageWithURL:[NSURL URLWithString:kHJDImage(pictureDic[@"thumb_200"])] placeholderImage:kImage(@"添加证件")];
    return cell;
}

#pragma mark - UICollectionViewDelegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
}
@end
