//
//  HJDMyViewController.m
//  HuiJinDai
//
//  Created by 耿笑威 on 2018/9/1.
//  Copyright © 2018年 shanpx. All rights reserved.
//

#import "HJDMyViewController.h"
#import "HJDMyTableViewCell.h"
#import "HJDMyCustomerManagerViewController.h"
#import "HJDMyAgentViewController.h"
#import "HJDMyInviteCodeView.h"
#import "HJDMySettingViewController.h"
#import "HJDMyManager.h"
#import "HJDUserDefaultsManager.h"
#import <MobileCoreServices/UTCoreTypes.h>

@interface HJDMyViewController ()<UITableViewDelegate, UITableViewDataSource, UINavigationControllerDelegate, UIImagePickerControllerDelegate>
@property(nonatomic, strong) UITableView *tableView;
@property(nonatomic, strong) NSArray *dataSource;
@property(nonatomic, strong) HJDMyTableHeaderView *headerView;
@property(nonatomic, strong) HJDUserModel *userModel;
@property(nonatomic, strong) UIImagePickerController *imgPickerController;
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
        NSString *avatar = kHJDImage(self.userModel.avatar);
        if (self.userModel.avatar == nil || self.userModel.avatar.length == 0) {
            avatar = @"";
        }
        [_headerView.headImgView sd_setImageWithURL:[NSURL URLWithString:avatar]
                                   placeholderImage:kImage(@"我的默认头像")];
        _headerView.nameLabel.text = self.userModel.rename;
        
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
        _userModel = (HJDUserModel *)[[HJDUserDefaultsManager shareInstance] loadObject:kUserModelKey];
        _dataSource = @[ @{ key1 : kImage(@"我的页客户经理"), key2 : @"我的客户经理" }, @{ key1 : kImage(@"我的页经纪人"), key2 : @"我的经纪人" }, @{ key1 : kImage(@"我的页邀请码"), key2 : @"我的邀请码" }, @{ key1 : kImage(@"我的页设置"), key2 : @"设置" } ];
    }
    return self;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self hideNavigationBar];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self showNavigationBar];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view addSubview:self.tableView];
    self.tableView.tableHeaderView = self.headerView;
    
    if (@available(iOS 11.0, *)) {
        self.tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    } else {
        //self.automaticallyAdjustsScrollViewInsets = NO;
    }
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
    NSInteger userType = self.userModel.type.integerValue;
    switch (indexPath.row) {
        case 0: {
            if (userType == HJDUserTypeChannel) {
                HJDMyCustomerManagerViewController *customerController = [[HJDMyCustomerManagerViewController alloc] init];
                customerController.hidesBottomBarWhenPushed = YES;
                [self.navigationController pushViewController:customerController animated:YES];
            } else {
                [MBProgressHUD showError:@"无访问权限"];
            }
            break;
        }
        case 1: {
            if (userType == HJDUserTypeChannel) {
                HJDMyAgentViewController *agentController = [[HJDMyAgentViewController alloc] init];
                agentController.hidesBottomBarWhenPushed = YES;
                [self.navigationController pushViewController:agentController animated:YES];
            } else {
                [MBProgressHUD showError:@"无访问权限"];
            }
            break;
        }
        case 2: {
            if (userType == HJDUserTypeChannel) {
                [MBProgressHUD showMessage:@"正在加载..."];
                [HJDMyManager getUserInviteCodeWithCallBack:^(NSDictionary *dic, BOOL result) {
                    [MBProgressHUD hideHUD];
                    if (result) {
                        HJDMyInviteCodeView *inviteView = [[HJDMyInviteCodeView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
                        [inviteView.headImgView sd_setImageWithURL:[NSURL URLWithString:kHJDImage(dic[@"images"])] placeholderImage:kImage(@"邀请码头像")];
                        inviteView.nameLabel.text = dic[@"rename"];
                        inviteView.cityLabel.text = dic[@"city"];
                        inviteView.inviteCode = [NSString stringWithFormat:@"邀请码：%@", dic[@"code"]];
                        UIWindow *window = [UIApplication sharedApplication].keyWindow;
                        [window addSubview:inviteView];
                    } else {
                        [MBProgressHUD showError:@"请求失败"];
                    }
                }];
                
            } else {
                [MBProgressHUD showError:@"无访问权限"];
            }
            break;
        }
        case 3: {
            HJDMySettingViewController *settingController = [[HJDMySettingViewController alloc] init];
            settingController.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:settingController animated:YES];
            break;
        }
        default:
            break;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        return 51.f;
    }
    return 58.f;
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
    dispatch_async(dispatch_get_main_queue(), ^{
        [MBProgressHUD showMessage:@"正在上传..."];
        [HJDMyManager setMyAvatarWithImage:head callBack:^(NSString *path, BOOL result) {
            [MBProgressHUD hideHUD];
            if (result) {
                self.userModel.avatar = path;
                [[HJDUserDefaultsManager shareInstance] saveObject:self.userModel key:kUserModelKey];
            } else {
                [MBProgressHUD showError:@"上传失败"];
            }
        }];
    });
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [picker dismissViewControllerAnimated:YES completion:nil];
}

@end
