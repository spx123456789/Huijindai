//
//  HJDMyViewController.m
//  HuiJinDai
//
//  Created by GXW on 2018/9/1.
//  Copyright © 2018年 shanpx. All rights reserved.
//

#import "HJDMyViewController.h"
#import "HJDMyTableViewCell.h"
#import "HJDMyRelationViewController.h"
#import "HJDMyInviteCodeView.h"
#import "HJDMySettingViewController.h"
#import "HJDMyManager.h"
#import "HJDUserDefaultsManager.h"
#import <MobileCoreServices/UTCoreTypes.h>
#import "AppDelegate.h"

@interface HJDMyViewController ()<UITableViewDelegate, UITableViewDataSource, UINavigationControllerDelegate, UIImagePickerControllerDelegate, HJDMyInviteCodeViewDelegate>
@property(nonatomic, strong) UITableView *tableView;
@property(nonatomic, strong) NSArray *dataSource;
@property(nonatomic, strong) HJDMyTableHeaderView *headerView;
@property(nonatomic, strong) HJDUserModel *userModel;
@property(nonatomic, strong) UIImagePickerController *imgPickerController;
@property(nonatomic, copy) NSString *inviteString;
@end

@implementation HJDMyViewController

static NSString *key1 = @"image";
static NSString *key2 = @"title";

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight - kSafeAreaTopHeight - kSafeAreaBottomHeight) style:UITableViewStylePlain];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _tableView.backgroundColor = [UIColor clearColor];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.showsVerticalScrollIndicator = NO;
    }
    return _tableView;
}

- (UIImagePickerController *)imgPickerController {
    if (!_imgPickerController) {
        _imgPickerController = [[UIImagePickerController alloc] init];
        _imgPickerController.delegate = self;
        _imgPickerController.allowsEditing = YES;
    }
    return _imgPickerController;
}

- (HJDMyTableHeaderView *)headerView {
    if (!_headerView) {
        _headerView = [[HJDMyTableHeaderView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 340)];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapGesture:)];
        [_headerView.headImgView addGestureRecognizer:tap];
    }
    return _headerView;
}

- (void)tapGesture:(UITapGestureRecognizer *)tap {
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    
    UIAlertAction *photoAction = [UIAlertAction actionWithTitle:@"拍照" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
            self.imgPickerController.sourceType = UIImagePickerControllerSourceTypeCamera;
            [self presentViewController:self.imgPickerController animated:YES completion:nil];
        } else {
            UIAlertController *aler = [UIAlertController alertControllerWithTitle:@"提示" message:@"请在设置-->隐私-->相机，中开启本应用的相机访问权限！" preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) { }];
            [aler addAction:okAction];
            [self presentViewController:aler animated:YES completion:nil];
        }
    }];
    
    UIAlertAction *albumAction = [UIAlertAction actionWithTitle:@"从手机相册选择" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeSavedPhotosAlbum]) {
            self.imgPickerController.sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
            [self presentViewController:self.imgPickerController animated:YES completion:nil];
        } else {
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"请在设置-->隐私-->相机，中开启本应用的相册访问权限！" preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) { }];
            [alert addAction:okAction];
            [self presentViewController:alert animated:YES completion:nil];
        }
    }];
    
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        NSLog(@"Cancel Action");
    }];
    
    [alertController addAction:photoAction];
    [alertController addAction:albumAction];
    [alertController addAction:cancelAction];
    
    [self presentViewController:alertController animated:YES completion:nil];
}

- (instancetype)init {
    self = [super init];
    if (self) {
        
    }
    return self;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self hideNavigationBar];
    [self updateMyInfo];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self showNavigationBar];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.userModel = (HJDUserModel *)[[HJDUserDefaultsManager shareInstance] loadObject:kUserModelKey];
    if (self.userModel.type.integerValue == HJDUserTypeChannel) {
        self.dataSource = @[ @{ key1 : kImage(@"我的页客户经理"), key2 : @"我的客户经理" }, @{ key1 : kImage(@"我的页经纪人"), key2 : @"我的经纪人" }, @{ key1 : kImage(@"我的页邀请码"), key2 : @"我的邀请码" }, @{ key1 : kImage(@"我的页设置"), key2 : @"设置" } ];
    } else if (self.userModel.type.integerValue == HJDUserTypeManager) {
        self.dataSource = @[ @{ key1 : kImage(@"我的页客户经理"), key2 : @"我的渠道" }, @{ key1 : kImage(@"我的页设置"), key2 : @"设置" } ];
    } else {
        self.dataSource = @[ @{ key1 : kImage(@"我的页客户经理"), key2 : @"我的渠道" }, @{ key1 : kImage(@"我的页设置"), key2 : @"设置" } ];
    }
    
    [self.view addSubview:self.tableView];
    self.tableView.tableHeaderView = self.headerView;
    
    if (@available(iOS 11.0, *)) {
        self.tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    } else {
        //self.automaticallyAdjustsScrollViewInsets = NO;
    }
}

- (void)updateMyInfo {
    self.userModel = (HJDUserModel *)[[HJDUserDefaultsManager shareInstance] loadObject:kUserModelKey];
    NSString *avatar = kHJDImage(self.userModel.avatar);
    if (self.userModel.avatar == nil || self.userModel.avatar.length == 0) {
        avatar = @"";
    }
    [_headerView.headImgView sd_setImageWithURL:[NSURL URLWithString:avatar]
                               placeholderImage:kImage(@"我的默认头像")];
    _headerView.nameLabel.text = self.userModel.rename;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIdentifier = @"HJDMyTableViewCell";
    HJDMyTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        cell = [[HJDMyTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    NSDictionary *dic = self.dataSource[indexPath.row];
    cell.imgView.image = dic[key1];
    cell.titleLabel.text = dic[key2];
    return cell;
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    HJDMyTableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    NSString *cellTitle = cell.titleLabel.text;
    if ([cellTitle isEqualToString:@"我的客户经理"]) {
        HJDMyRelationViewController *customerController = [[HJDMyRelationViewController alloc] init];
        customerController.hidesBottomBarWhenPushed = YES;
        customerController.searchType = HJDUserTypeManager;
        [self.navigationController pushViewController:customerController animated:YES];
    } else if ([cellTitle isEqualToString:@"我的经纪人"]) {
        HJDMyRelationViewController *agentController = [[HJDMyRelationViewController alloc] init];
        agentController.hidesBottomBarWhenPushed = YES;
        agentController.searchType = HJDUserTypeAgent;
        [self.navigationController pushViewController:agentController animated:YES];
    } else if ([cellTitle isEqualToString:@"我的渠道"]) {
        HJDMyRelationViewController *channelController = [[HJDMyRelationViewController alloc] init];
        channelController.hidesBottomBarWhenPushed = YES;
        channelController.searchType = HJDUserTypeChannel;
        [self.navigationController pushViewController:channelController animated:YES];
    } else if ([cellTitle isEqualToString:@"我的邀请码"]) {
        [MBProgressHUD showMessage:@""];
        @weakify(self);
        [HJDMyManager getUserInviteCodeWithCallBack:^(NSDictionary *dic, BOOL result) {
            [MBProgressHUD hideHUD];
            @strongify(self);
            if (result) {
                HJDMyInviteCodeView *inviteView = [[HJDMyInviteCodeView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
                inviteView.delegate = self;
                [inviteView.headImgView sd_setImageWithURL:[NSURL URLWithString:kHJDImage(self.userModel.avatar)] placeholderImage:kImage(@"邀请码头像")];
                inviteView.nameLabel.text = dic[@"rename"];
                inviteView.cityLabel.text = dic[@"city"];
                inviteView.inviteCode = [NSString stringWithFormat:@"邀请码：%@", dic[@"code"]];
                //域名/wap/User/reg/邀请码
                self.inviteString = [NSString stringWithFormat:@"%@wap/User/reg/%@", kAPIMainURL, dic[@"code"]];
                UIWindow *window = [UIApplication sharedApplication].keyWindow;
                [window addSubview:inviteView];
            } else {
                [MBProgressHUD showError:@"请求失败"];
            }
        }];
    } else if ([cellTitle isEqualToString:@"设置"]) {
        HJDMySettingViewController *settingController = [[HJDMySettingViewController alloc] init];
        settingController.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:settingController animated:YES];
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (self.dataSource.count == 4) {
        if (indexPath.row == 0) {
            return 51.f;
        } else {
            return 58.f;
        }
    }
    return 58.f;
}

#pragma mark - HJDMyInviteCodeViewDelegate
- (void)myInviteCodeView:(HJDMyInviteCodeView *)codeView didSelectIndex:(NSInteger)index {
//    AppDelegate *appDelagate = (AppDelegate *)[UIApplication sharedApplication].delegate;
//    [appDelagate shareInviteCode:codeView.shareDictionary scene:(int)index];
    
    //复制分享链接
    if ([NSString hjd_isBlankString:self.inviteString]) {
        [MBProgressHUD showError:@"复制分享链接失败"];
        return;
    }
    UIPasteboard *pab = [UIPasteboard generalPasteboard];
    if (pab == nil) {
        [self showToast:@"复制分享链接失败"];
    } else {
        [pab setString:self.inviteString];
        [self showToast:@"复制分享链接成功"];
    }
}

#pragma mark - UIImagePickerControllerDelegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(nonnull NSDictionary<NSString *,id> *)info {
    [picker dismissViewControllerAnimated:YES completion:^{
        NSString *mediaType = info[UIImagePickerControllerMediaType];
        if ([mediaType isEqualToString:(NSString *)kUTTypeImage]) {
            UIImage *theImage = info[UIImagePickerControllerEditedImage];
            //NSURL *imageUrl = info[UIImagePickerControllerImageURL];
            [self uploadImage:theImage];
        }
    }];
}

- (void)uploadImage:(UIImage *)head {
    [MBProgressHUD showMessage:@"正在修改..."];
    [HJDMyManager setMyAvatarWithImage:head callBack:^(NSString *path, BOOL result) {
        [MBProgressHUD hideHUD];
        if (result) {
            self.userModel.avatar = path;
            [[HJDUserDefaultsManager shareInstance] saveObject:self.userModel key:kUserModelKey];
            [self updateMyInfo];
            [MBProgressHUD showError:@"修改成功"];
        } else {
            [MBProgressHUD showError:@"修改失败"];
        }
    }];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [picker dismissViewControllerAnimated:YES completion:nil];
}

@end
