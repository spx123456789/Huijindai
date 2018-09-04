//
//  HJDOrderAuditViewController.m
//  HuiJinDai
//
//  Created by 耿笑威 on 2018/9/2.
//  Copyright © 2018年 shanpx. All rights reserved.
//

#import "HJDOrderAuditViewController.h"
#import "HJDOrderCollectionViewCell.h"
#import "HJDHomeOrderListViewController.h"

@interface HJDOrderAuditViewController ()<UICollectionViewDelegate, UICollectionViewDataSource, UITextFieldDelegate>
@property(nonatomic, strong) UICollectionView *collectionView;
@property(nonatomic, strong) NSMutableArray *dataSource;
@property(nonatomic, strong) UITextField *searchField;
@property(nonatomic, strong) UISegmentedControl *segmentControl;
@end

@implementation HJDOrderAuditViewController

- (UICollectionView *)collectionView {
    if (!_collectionView) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.minimumLineSpacing = 0; //item垂直距离
        layout.minimumInteritemSpacing = 0; //item水平距离
        layout.itemSize = CGSizeMake(kScreenWidth/3, 10 + kScreenWidth/3 - 20 + 8 + 20 + 10);
    
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 55, kScreenWidth, kScreenHeight) collectionViewLayout:layout];
        _collectionView.backgroundColor = [UIColor clearColor];
        [_collectionView registerClass:[HJDOrderCollectionViewCell class] forCellWithReuseIdentifier:@"cellId"];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
    }
    return _collectionView;
}

- (UITextField *)searchField {
    if (!_searchField) {
        _searchField = [[UITextField alloc] initWithFrame:CGRectMake(10, 10, kScreenWidth - 20, 35)];
        _searchField.borderStyle = UITextBorderStyleRoundedRect;
        _searchField.returnKeyType = UIReturnKeySearch;
        _searchField.placeholder = @"请输入姓名搜索";
        _searchField.font = kFont14;
        _searchField.delegate = self;
        _searchField.backgroundColor = kWithe;
    }
    return _searchField;
}

- (UISegmentedControl *)segmentControl {
    if (!_segmentControl) {
        _segmentControl = [[UISegmentedControl alloc] initWithItems:@[ @"业务经理权限", @"渠道权限"]];
        [_segmentControl setWidth:85 forSegmentAtIndex:0];
        [_segmentControl setWidth:85 forSegmentAtIndex:1];
        _segmentControl.tintColor = kRGB_Color(0, 194, 157);//设置边框和选中颜色；
        [_segmentControl addTarget:self action:@selector(segmentControlChangeValue:) forControlEvents:UIControlEventValueChanged];
        _segmentControl.selectedSegmentIndex = 0;
    }
    return _segmentControl;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.dataSource = [NSMutableArray arrayWithArray:@[ @"", @"", @"", @"", @"" ]];

    [self.view addSubview:self.searchField];
    [self.view addSubview:self.collectionView];
    
    self.navigationItem.titleView = self.segmentControl;
    
}
    
- (void)segmentControlChangeValue:(id)sender {
    [self.dataSource removeAllObjects];
    if (self.segmentControl.selectedSegmentIndex == 0) {
        [self.dataSource addObjectsFromArray:@[ @"", @"", @"", @"", @"" ]];
    } else {
        [self.dataSource addObjectsFromArray:@[ @"", @"", @"" ]];
    }
    [self.collectionView reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UICollectionViewDataSource
//返回section个数
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

//每个section的item个数
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.dataSource.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    HJDOrderCollectionViewCell *cell = (HJDOrderCollectionViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:@"cellId" forIndexPath:indexPath];
    [cell.headImgView sd_setImageWithURL:[NSURL URLWithString:@""] placeholderImage:kImage(@"qr.png")];
    if (self.segmentControl.selectedSegmentIndex == 0) {
        cell.nameLabel.text = [NSString stringWithFormat:@"经纪人%ld", indexPath.row + 1];
    } else {
        cell.nameLabel.text = [NSString stringWithFormat:@"渠道%ld", indexPath.row + 1];
    }
    cell.unreadLabel.text = @"3";
    cell.backgroundColor = kWithe;
    return cell;
}

//设置每个item的UIEdgeInsets
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsMake(0, 0, 0, 0);
}

#pragma mark - UICollectionViewDelegate
//点击item方法
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    NSString *str = @"";
    if (self.segmentControl.selectedSegmentIndex == 0) {
        str = [NSString stringWithFormat:@"经纪人%ld", indexPath.row + 1];
    } else {
        str = [NSString stringWithFormat:@"渠道%ld", indexPath.row + 1];
    }
    HJDHomeOrderListViewController *listController = [[HJDHomeOrderListViewController alloc] init];
    listController.title = [NSString stringWithFormat:@"%@工单列表", str];
    [self.navigationController pushViewController:listController animated:YES];
}

#pragma mark - UITextFieldDelegate
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    return YES;
}
@end
