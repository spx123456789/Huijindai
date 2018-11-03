//
//  HJDHomeDeclarationViewController.m
//  HuiJinDai
//
//  Created by GXW on 2018/9/27.
//  Copyright © 2018年 shanpx. All rights reserved.
//

#import "HJDHomeDeclarationViewController.h"
#import "HJDHomeRoomDiDaiTableViewCell.h"
#import "HJDCustomerServiceView.h"
#import "HJDDeclarationModel.h"
#import <MobileCoreServices/UTCoreTypes.h>
#import "HJDHomeRoomDiDaiManager.h"
#import "HJDHomeSelectToastView.h"
#import <TPKeyboardAvoidingTableView.h>
#import "QBImagePickerController.h"
#import "UIImage+HJD.h"

@interface HJDHomeDeclarationViewController ()<UITableViewDelegate, UITableViewDataSource, HJDHomeSelectToastViewDelegate, UINavigationControllerDelegate, UIImagePickerControllerDelegate, HJDHomeRoomDiDaiPhotoTableViewCellDelegate, UIScrollViewDelegate, QBImagePickerControllerDelegate>
@property(nonatomic, strong) TPKeyboardAvoidingTableView *tableView;
@property(nonatomic, strong) HJDCustomerServiceView *customServiceView;
@property(nonatomic, strong) UIButton *submitButton;
@property(nonatomic, strong) QBImagePickerController *imgPickerController;
@property(nonatomic, strong) HJDDeclarationModel *declarationModel;
@property(nonatomic, strong) NSArray *pickerArray;
@property(nonatomic, assign) NSInteger selectShowIndex;
@end

@implementation HJDHomeDeclarationViewController

- (TPKeyboardAvoidingTableView *)tableView {
    if (!_tableView) {
        _tableView = [[TPKeyboardAvoidingTableView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight - kSafeAreaTopHeight - kSafeAreaBottomHeight) style:UITableViewStylePlain];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _tableView.backgroundColor = [UIColor clearColor];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.showsVerticalScrollIndicator = NO;
    }
    return _tableView;
}

- (HJDCustomerServiceView *)customServiceView {
    if (!_customServiceView) {
        _customServiceView = [[HJDCustomerServiceView alloc] initWithFrame:CGRectMake(kScreenWidth/2 - 70, 0, 140, 30)];
        _customServiceView.backgroundColor = kRGB_Color(0xf4, 0xf4, 0xf4);
    }
    return _customServiceView;
}

- (UIButton *)submitButton {
    if (!_submitButton) {
        _submitButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_submitButton setTitle:@"提交" forState:UIControlStateNormal];
        [_submitButton setTitleColor:kRGB_Color(0xff, 0xff, 0xff) forState:UIControlStateNormal];
        [_submitButton setBackgroundColor:kMainColor];
        _submitButton.titleLabel.font = kFont15;
        _submitButton.layer.masksToBounds = YES;
        _submitButton.layer.cornerRadius = 4.f;
        [_submitButton addTarget:self action:@selector(submitButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _submitButton;
}

- (QBImagePickerController *)imgPickerController {
    if (!_imgPickerController) {
        _imgPickerController = [[QBImagePickerController alloc] init];
        _imgPickerController.prompt = @"请选择图片";
        _imgPickerController.mediaType = QBImagePickerMediaTypeImage;
        _imgPickerController.maximumNumberOfSelection = 9;
        _imgPickerController.delegate = self;
        _imgPickerController.allowsMultipleSelection = YES;
        _imgPickerController.showsNumberOfSelectedAssets = YES;
    }
    return _imgPickerController;
}

- (void)submitButtonClick:(id)sender {
    if (self.declarationModel.loan_variety == 0) {
        [self showToast:@"请选择贷款品种"];
        return;
    }
    
    if ([NSString hjd_isBlankString:self.declarationModel.loan_money]) {
        [self showToast:@"请填写申请金额"];
        return;
    }
    
    if (self.declarationModel.loan_time_type == 0) {
        [self showToast:@"请选择申请期限"];
        return;
    }
    
    if ([NSString hjd_isBlankString:self.declarationModel.loan_time]) {
        [self showToast:@"请填写贷款时长"];
        return;
    }
    
    if (self.declarationModel.loan_variety == HJDLoanVarietyHouse_2) {
        if ([NSString hjd_isBlankString:self.declarationModel.loan_first]) {
            [self showToast:@"请填写一抵余额"];
            return;
        }
    }
    [MBProgressHUD showMessage:@"正在提交..."];
    @weakify(self);
    [HJDHomeRoomDiDaiManager getOrderIdWithCallBack:^(NSDictionary *data, BOOL result) {
        @strongify(self);
        self.declarationModel.loan_id = data[@"loan_id"];
        self.declarationModel.evaluation_id = self.xun_id;
        NSLog(@"====%@", self.declarationModel.loan_id);
        [HJDHomeRoomDiDaiManager postRoomDeclarationWithModel:self.declarationModel callBack:^(NSDictionary *data, BOOL result) {
            [MBProgressHUD hideHUD];
            if (result) {
                [MBProgressHUD showSuccess:@"提交成功"];
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.8 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    @strongify(self);
                    //退回首页
                    [self.navigationController popToRootViewControllerAnimated:YES];
                });
            } else {
                [MBProgressHUD showError:@"提交失败"];
            }
        }];
    }];
}

- (instancetype)init {
    self = [super init];
    if (self) {
        _declarationModel = [[HJDDeclarationModel alloc] init];
        _selectShowIndex = NSNotFound;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setNavTitle:@"报单"];
    self.view.backgroundColor = kRGB_Color(0xf4, 0xf4, 0xf4);
    
    @weakify(self);
    [MBProgressHUD showMessage:@"正在加载..."];
    [HJDHomeRoomDiDaiManager getOrderFileWithCallBack:^(NSArray *dataArray, BOOL result) {
        @strongify(self);
        [MBProgressHUD hideHUD];
        if (result) {
            NSMutableArray *tempMutArray = [NSMutableArray array];
            for (int k = 0; k < dataArray.count; k++) {
                NSDictionary *dic = dataArray[k];
                NSMutableArray *mutArray = [NSMutableArray array];
                NSDictionary *tempDic = @{ kDeclarationLoanFileType : dic[@"type_id"], kDeclarationLoanFileTitle : dic[@"file_name"], kDeclarationLoanFileImage : mutArray };
                [tempMutArray addObject:tempDic];
            }
            self.declarationModel.fileMutArray = [NSMutableArray arrayWithArray:tempMutArray];
            [self setUpUI];
        } else {
            [MBProgressHUD showError:@"加载失败"];
        }
    }];
}

- (void)setUpUI {
    [self.view addSubview:self.tableView];
    
    UIView *footerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 60 + 44 + 25)];
    
    self.submitButton.frame = CGRectMake(16, 20, kScreenWidth - 32, 44);
    [footerView addSubview:self.submitButton];
    
    self.customServiceView.frame = CGRectMake(kScreenWidth/2 - 70, 40 + 44, 140, 25);
    [footerView addSubview:self.customServiceView];
    
    self.tableView.tableFooterView = footerView;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)showPickerView {
    [self.view endEditing:YES];
    HJDHomeSelectToastView *picker = [[HJDHomeSelectToastView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
    picker.delegate = self;
    //先赋值selectIndexpath
    NSInteger modelInterger = 0;
    if (self.selectShowIndex == 0) {
        modelInterger = self.declarationModel.loan_variety;
    } else if (self.selectShowIndex == 2) {
        modelInterger = self.declarationModel.certificate_type;
    } else if (self.selectShowIndex == 4) {
        modelInterger = self.declarationModel.indiv_marital;
    } else if (self.selectShowIndex == 6) {
        modelInterger = self.declarationModel.loan_time_type;
    }
    
    if (modelInterger == 0) {
        picker.selectIndexPath = nil;
    } else {
        picker.selectIndexPath = [NSIndexPath indexPathForRow:modelInterger - 1 inSection:0];
    }
    picker.dataSource = self.pickerArray;
    [picker showView];
}

#pragma mark - HJDHomeSelectToastViewDelegate
- (void)selectToastView:(HJDHomeSelectToastView *)selectToastView didSelecIndex:(NSInteger)index {
    if (self.selectShowIndex == 0) {
        self.declarationModel.loan_variety = index + 1;
        [self.tableView reloadData];
    } else if (self.selectShowIndex == 2) {
        self.declarationModel.certificate_type = index + 1;
        [self.tableView reloadData];
    } else if (self.selectShowIndex == 4) {
        self.declarationModel.indiv_marital = index + 1;
        [self.tableView reloadData];
    } else if (self.selectShowIndex == 6) {
        self.declarationModel.loan_time_type = index + 1;
        [self.tableView reloadData];
    }
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    switch (indexPath.row) {
        case 0: {
            self.selectShowIndex = indexPath.row;
            self.pickerArray = @[ @"房屋抵押贷款", @"房屋抵押贷款（加案）" ];
            [self showPickerView];
            break;
        }
        case 2: {
            self.selectShowIndex = indexPath.row;
            self.pickerArray = @[ @"身份证", @"营业执照", @"护照", @"军官证", @"士兵证", @"港澳居民来往内地通行证", @"台湾居民来往大陆通行证", @"其他证件" ];
            [self showPickerView];
            break;
        }
        case 4: {
            self.selectShowIndex = indexPath.row;
            self.pickerArray = @[ @"未婚", @"已婚有子女", @"已婚无子女", @"丧偶", @"离异", @"再婚" ];
            [self showPickerView];
            break;
        }
        case 6: {
            self.selectShowIndex = indexPath.row;
            self.pickerArray = @[ @"月", @"天" ];
            [self showPickerView];
            break;
        }
        default:
            break;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0 || indexPath.row == 1 || indexPath.row == 5) {
        return 44 + 4;
    }
    
    NSInteger cellCount = 8;
    if (self.declarationModel.loan_variety == HJDLoanVarietyHouse_2) {
        cellCount = 9;
    }
    if (indexPath.row < cellCount) {
        return 44;
    } else {
        NSMutableDictionary *tempDic = self.declarationModel.fileMutArray[indexPath.row - cellCount];
        NSMutableArray *tempImageArr = tempDic[kDeclarationLoanFileImage];
        NSInteger pictureCount = tempImageArr.count;
        return 4 + 44 + 1 + 16 + kPhotoHeight * (pictureCount/3 + 1) + 8 * (pictureCount/3) + 16;
    }
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (self.declarationModel.loan_variety == HJDLoanVarietyHouse_2) {
        return 9 + self.declarationModel.fileMutArray.count;
    }
    return 8 + self.declarationModel.fileMutArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIdentifier = @"HJDHomeRoomDiDaiTableViewCell";
    static NSString *cellPhotoIdentifier = @"HJDHomeRoomDiDaiPhotoTableViewCell";
    
    NSInteger cellCount = 8;
    if (self.declarationModel.loan_variety == HJDLoanVarietyHouse_2) {
        cellCount = 9;
    }
    
    if (indexPath.row < cellCount) {
        HJDHomeRoomDiDaiTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
        if (cell == nil) {
            cell = [[HJDHomeRoomDiDaiTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        [self setCellValue:cell indexPath:indexPath];
        return cell;
    } else {
        HJDHomeRoomDiDaiPhotoTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellPhotoIdentifier];
        if (cell == nil) {
            cell = [[HJDHomeRoomDiDaiPhotoTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellPhotoIdentifier];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        NSMutableDictionary *tempDic = self.declarationModel.fileMutArray[indexPath.row - cellCount];
        NSMutableArray *tempImageArr = tempDic[kDeclarationLoanFileImage];
        cell.title = tempDic[kDeclarationLoanFileTitle];
        cell.imageArray = tempImageArr;
        cell.delegate  = self;
        return cell;
    }
    
}

- (void)setCellValue:(HJDHomeRoomDiDaiTableViewCell *)cell indexPath:(NSIndexPath *)indexPath {
    switch (indexPath.row) {
        case 0: {
            cell.leftLabel.text = @"贷款品种";
            cell.placeholderString = @"请选择";
            cell.rightImgView.hidden = NO;
            cell.rightLabel.hidden = YES;
            cell.lineView.hidden = YES;
            cell.fieldCanEdit = NO;
            if (self.declarationModel.loan_variety == HJDLoanVarietyHouse) {
                cell.textField.text = @"房屋抵押贷款";
            } else if (self.declarationModel.loan_variety == HJDLoanVarietyHouse_2) {
                cell.textField.text = @"房屋抵押贷款（加案）";
            } else if (self.declarationModel.loan_variety == HJDLoanVarietyCar) {
                cell.textField.text = @"车辆抵押贷款";
            }
            break;
        }
        case 1: {
            cell.leftLabel.text = @"客户名称";
            cell.placeholderString = @"请填写";
            cell.rightImgView.hidden = YES;
            cell.rightLabel.hidden = YES;
            cell.lineView.hidden = NO;
            @weakify(self);
            [cell.textField.rac_textSignal subscribeNext:^(NSString *x) {
                @strongify(self);
                self.declarationModel.name = x;
            }];
            break;
        }
        case 2: {
            cell.leftLabel.text = @"证件类型";
            cell.placeholderString = @"请选择";
            cell.rightImgView.hidden = NO;
            cell.rightLabel.hidden = YES;
            cell.lineView.hidden = NO;
            cell.fieldCanEdit = NO;
            switch (self.declarationModel.certificate_type) {
                case HJDLoanCertificate_idCard:
                    cell.textField.text = @"身份证";
                    break;
                case HJDLoanCertificate_businessLicense:
                    cell.textField.text = @"营业执照";
                    break;
                case HJDLoanCertificate_passport:
                    cell.textField.text = @"护照";
                    break;
                case HJDLoanCertificate_officer:
                    cell.textField.text = @"军官证";
                    break;
                case HJDLoanCertificate_soldiers:
                    cell.textField.text = @"士兵证";
                    break;
                case HJDLoanCertificate_HongKong:
                    cell.textField.text = @"港澳居民来往内地通行证";
                    break;
                case HJDLoanCertificate_Taiwan:
                    cell.textField.text = @"台湾居民来往大陆通行证";
                    break;
                case HJDLoanCertificate_other:
                    cell.textField.text = @"其他证件";
                    break;
                default:
                    break;
            }
            break;
        }
        case 3: {
            cell.leftLabel.text = @"证件号码";
            cell.placeholderString = @"请填写";
            cell.rightImgView.hidden = YES;
            cell.rightLabel.hidden = YES;
            cell.lineView.hidden = NO;
            @weakify(self);
            [cell.textField.rac_textSignal subscribeNext:^(NSString *x) {
                @strongify(self);
                self.declarationModel.certificate_number = x;
            }];
            break;
        }
        case 4: {
            cell.leftLabel.text = @"婚姻状况";
            cell.placeholderString = @"请选择";
            cell.rightImgView.hidden = NO;
            cell.rightLabel.hidden = YES;
            cell.lineView.hidden = YES;
            cell.fieldCanEdit = NO;
            switch (self.declarationModel.indiv_marital) {
                case HJDLoanMarriage_unmarried:
                    cell.textField.text = @"未婚";
                    break;
                case HJDLoanMarriage_hasChildren:
                    cell.textField.text = @"已婚有子女";
                    break;
                case HJDLoanMarriage_noChildren:
                    cell.textField.text = @"已婚无子女";
                    break;
                case HJDLoanMarriage_no:
                    cell.textField.text = @"丧偶";
                    break;
                case HJDLoanMarriage_divorced:
                    cell.textField.text = @"离异";
                    break;
                case HJDLoanMarriage_remarried:
                    cell.textField.text = @"再婚";
                    break;
                default:
                    break;
            }
            break;
        }
        case 5: {
            cell.leftLabel.text = @"申请金额";
            cell.placeholderString = @"请填写";
            cell.rightImgView.hidden = YES;
            cell.rightLabel.hidden = NO;
            cell.rightLabel.text = @"元";
            cell.lineView.hidden = NO;
            @weakify(self);
            [cell.textField.rac_textSignal subscribeNext:^(NSString *x) {
                @strongify(self);
                self.declarationModel.loan_money = x;
            }];
            break;
        }
        case 6: {
            cell.leftLabel.text = @"申请期限";
            cell.placeholderString = @"请选择";
            cell.rightImgView.hidden = NO;
            cell.rightLabel.hidden = YES;
            cell.lineView.hidden = NO;
            cell.fieldCanEdit = NO;
            if (self.declarationModel.loan_time_type == HJDLoanTimeDay) {
                cell.textField.text = @"天";
            } else if (self.declarationModel.loan_time_type == HJDLoanTimeMonth) {
                cell.textField.text = @"月";
            }
            break;
        }
        case 7: {
            if (self.declarationModel.loan_time_type == HJDLoanTimeDay) {
                cell.leftLabel.text = @"天数";
                cell.rightLabel.text = @"天";
            } else {
                cell.leftLabel.text = @"月份";
                cell.rightLabel.text = @"月";
            }
            cell.placeholderString = @"请填写";
            cell.rightImgView.hidden = YES;
            cell.rightLabel.hidden = NO;
            cell.lineView.hidden = NO;
            @weakify(self);
            [cell.textField.rac_textSignal subscribeNext:^(NSString *x) {
                @strongify(self);
                self.declarationModel.loan_time = x;
            }];
            break;
        }
        case 8: {
            cell.leftLabel.text = @"一抵余额";
            cell.placeholderString = @"请填写";
            cell.rightImgView.hidden = YES;
            cell.rightLabel.hidden = NO;
            cell.rightLabel.text = @"元";
            cell.lineView.hidden = YES;
            @weakify(self);
            [cell.textField.rac_textSignal subscribeNext:^(NSString *x) {
                @strongify(self);
                self.declarationModel.loan_first = x;
            }];
            break;
        }
        default:
            break;
    }
}

#pragma mark - HJDHomeRoomDiDaiPhotoTableViewCellDelegate
- (void)photoCell:(HJDHomeRoomDiDaiPhotoTableViewCell *)photoCell clickDeleteButtonAtIndex:(NSInteger)index {
    NSIndexPath *indexPath = [self.tableView indexPathForCell:photoCell];
    
    NSInteger cellCount = 8;
    if (self.declarationModel.loan_variety == HJDLoanVarietyHouse_2) {
        cellCount = 9;
    }
    
    NSMutableDictionary *tempDic = self.declarationModel.fileMutArray[indexPath.row - cellCount];
    NSMutableArray *tempImageArr = tempDic[kDeclarationLoanFileImage];
    
    if (tempImageArr != nil && index < tempImageArr.count) {
        [tempImageArr removeObjectAtIndex:index];
        [self.tableView reloadRowsAtIndexPaths:@[ indexPath ] withRowAnimation:UITableViewRowAnimationFade];
    }
}

- (void)photoCell:(HJDHomeRoomDiDaiPhotoTableViewCell *)photoCell clickAddButton:(id)sender {
    NSIndexPath *indexPath = [self.tableView indexPathForCell:photoCell];
    self.selectShowIndex = indexPath.row;
    [self.view endEditing:YES];
    [self showImagePickerController];
}

#pragma mark - 相册
- (void)showImagePickerController {
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    
    UIAlertAction *photoAction = [UIAlertAction actionWithTitle:@"拍照" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
            UIImagePickerController *imgController = [[UIImagePickerController alloc] init];
            imgController.delegate = self;
            imgController.allowsEditing = YES;
            imgController.sourceType = UIImagePickerControllerSourceTypeCamera;
            [self presentViewController:imgController animated:YES completion:nil];
        } else {
            UIAlertController *aler = [UIAlertController alertControllerWithTitle:@"提示" message:@"请在设置-->隐私-->相机，中开启本应用的相机访问权限！" preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) { }];
            [aler addAction:okAction];
            [self presentViewController:aler animated:YES completion:nil];
        }
    }];
    
    UIAlertAction *albumAction = [UIAlertAction actionWithTitle:@"从手机相册选择" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeSavedPhotosAlbum]) {
            //UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:self.imgPickerController];
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

#pragma mark - UIImagePickerControllerDelegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(nonnull NSDictionary<NSString *,id> *)info {
    [picker dismissViewControllerAnimated:YES completion:NULL];
    
    NSString *mediaType = info[UIImagePickerControllerMediaType];
    if ([mediaType isEqualToString:(NSString *)kUTTypeImage]) {
        [self saveImage:info reloadTableView:YES];
    }
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [picker dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - QBImagePickerControllerDelegate
- (void)qb_imagePickerController:(QBImagePickerController *)imagePickerController didFinishPickingAssets:(NSArray *)assets {
    __block NSInteger imgCount = assets.count;
    for (PHAsset *asset in assets) {
        if (asset.mediaType == PHAssetMediaTypeImage) {
            @weakify(self);
            [[PHImageManager defaultManager] requestImageDataForAsset:asset options:nil resultHandler:^(NSData * _Nullable imageData, NSString * _Nullable dataUTI, UIImageOrientation orientation, NSDictionary * _Nullable info) {
                @strongify(self);
                UIImage *image = [UIImage imageWithData:imageData];
                UIImage *new_image = [UIImage fixOrientation:image];
                NSDictionary *imageInfo = @{ UIImagePickerControllerEditedImage : new_image };
                
                imgCount -= 1;
                [self saveImage:imageInfo reloadTableView:(imgCount == 0)];
            }];
        }
    }
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)qb_imagePickerControllerDidCancel:(QBImagePickerController *)imagePickerController {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)saveImage:(NSDictionary *)imageInfo reloadTableView:(BOOL)reload {
    NSInteger cellCount = 8;
    if (self.declarationModel.loan_variety == HJDLoanVarietyHouse_2) {
        cellCount = 9;
    }
    
    NSMutableDictionary *tempDic = self.declarationModel.fileMutArray[self.selectShowIndex - cellCount];
    NSMutableArray *tempImageArr = tempDic[kDeclarationLoanFileImage];
    [tempImageArr addObject:imageInfo];
    
    if (reload) {
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:self.selectShowIndex inSection:0];
        [self.tableView reloadRowsAtIndexPaths:@[ indexPath ] withRowAnimation:UITableViewRowAnimationFade];
    }
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    [self.view endEditing:YES];
}
@end
