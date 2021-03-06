//
//  AppDelegate.m
//  HuiJinDai
//
//  Created by GXW on 2018/8/30.
//  Copyright © 2018年 shanpx. All rights reserved.
//

#import "AppDelegate.h"
#import "HJDLoginViewController.h"
#import "HJDHomeViewController.h"
#import "HJDMyViewController.h"
#import <GTSDK/GeTuiSdk.h>
// iOS10 及以上需导⼊入 UserNotifications.framework
#if __IPHONE_OS_VERSION_MAX_ALLOWED >= __IPHONE_10_0
#import <UserNotifications/UserNotifications.h>
#endif

#define kGtAppId @"5cU1C08CCCAeZei6qpZ2a3"
#define kGtAppKey @"Is4r9CsCg69gq0mUIle023"
#define kGtAppSecret @"BvQ6TcyHGA6LwVSeGIpU28"

#define kWeiXinAppId @"wxd930ea5d5a258f4f"

#import "HJDNetAPIManager.h"
#import "HJDMyManager.h"
#import "WXApi.h"

@interface AppDelegate ()<GeTuiSdkDelegate, UNUserNotificationCenterDelegate, WXApiDelegate>

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for cu/Users/gengxiaowei/Desktop/HuiJinDai/HuiJinDai/Supporting Files/AppDelegate.mstomization after application launch.
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = kWithe;
    [self.window makeKeyAndVisible];
    
    [self registerWeiXin];
    [self registerGeTui];
    
    NSNumber *isLogin = [[NSUserDefaults standardUserDefaults] objectForKey:HJDLoginSuccess];
    //判断是否登录
    if (isLogin.integerValue == 1) {
        HJDUserModel *userModel = (HJDUserModel *)[[HJDUserDefaultsManager shareInstance] loadObject:kUserModelKey];
        [[HJDNetAPIManager sharedManager] setAuthorization:userModel.token];
        [self enterHomeController];
        [HJDMyManager reUpdateMyInfo:NULL];
    } else {
        UINavigationController *navi = [[UINavigationController alloc] initWithRootViewController:[[HJDLoginViewController alloc] init]];
        self.window.rootViewController = navi;
    }

    return YES;
}

- (void)enterHomeController {
    HJDHomeViewController *homeController = [[HJDHomeViewController alloc] init];
    [self controller:homeController title:@"首页" tabBarItemImage:@"首页底部导航未选中" tabBarItemSelectedImage:@"底部导航首页选中"];
    UINavigationController *nav1 = [[UINavigationController alloc] initWithRootViewController:homeController];
    
    HJDMyViewController *myController = [[HJDMyViewController alloc] init];
    [self controller:myController title:@"个人中心" tabBarItemImage:@"底部导航我的未选中" tabBarItemSelectedImage:@"底部导航我的选中"];
    UINavigationController *nav2 = [[UINavigationController alloc] initWithRootViewController:myController];
    
    UITabBarController *tabBarController = [[UITabBarController alloc] init];
    [[UITabBar appearance] setTranslucent:NO];
    tabBarController.viewControllers = @[ nav1, nav2 ];
    
    self.window.rootViewController = tabBarController;
}

- (void)controller:(UIViewController *)controller title:(NSString *)title tabBarItemImage:(NSString *)image tabBarItemSelectedImage:(NSString *)selectedImage {
    controller.title = title;
    controller.tabBarItem.image = [UIImage imageNamed:image];
    // 设置 tabbarItem 选中状态的图片(不被系统默认渲染,显示图像原始颜色)
    UIImage *imageHome = [UIImage imageNamed:selectedImage];
    imageHome = [imageHome imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    [controller.tabBarItem setSelectedImage:imageHome];
    // 设置 tabbarItem 选中状态下的文字颜色(不被系统默认渲染,显示文字自定义颜色)
    NSDictionary *dictHome = [NSDictionary dictionaryWithObject:[UIColor orangeColor] forKey:NSForegroundColorAttributeName];
    [controller.tabBarItem setTitleTextAttributes:dictHome forState:UIControlStateSelected];
}

#pragma mark - 微信分享
- (void)registerWeiXin {
    [WXApi registerApp:kWeiXinAppId];
}

- (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<UIApplicationOpenURLOptionsKey,id> *)options {
    return [WXApi handleOpenURL:url delegate:self];
}

- (void)shareInviteCode:(NSDictionary *)shareDic scene:(int)scene {
    WXMediaMessage *message = [WXMediaMessage message];
    [message setThumbImage:[UIImage imageNamed:@"邀请码头像@2x.png"]];
    
    WXImageObject *ext = [WXImageObject object];
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"邀请码头像@2x" ofType:@"png"];
    NSLog(@"filepath :%@",filePath);
    ext.imageData = [NSData dataWithContentsOfFile:filePath];
    
    //UIImage* image = [UIImage imageWithContentsOfFile:filePath];
    UIImage *image = [UIImage imageWithData:ext.imageData];
    ext.imageData = UIImagePNGRepresentation(image);
    
    //    UIImage* image = [UIImage imageNamed:@"res5thumb.png"];
    //    ext.imageData = UIImagePNGRepresentation(image);
    
    message.mediaObject = ext;
    
    SendMessageToWXReq *req = [[SendMessageToWXReq alloc] init];
    req.bText = NO;
    req.message = message;
    //会话(WXSceneSession = 0)或者朋友圈(WXSceneTimeline = 1)
    req.scene = scene;
    [WXApi sendReq:req];
}

#pragma mark - WXApiDelegate
- (void)onReq:(BaseReq *)req {
    
}
//如果第三方程序向微信发送了sendReq的请求，那么onResp会被回调。sendReq请求调用后，会切到微信终端程序界面。
- (void)onResp:(BaseResp *)resp {
    
}

#pragma mark - 个推注册
- (void)registerGeTui {
    // 通过个推平台分配的appId、 appKey 、appSecret 启动SDK，注:该⽅方法需要在主线程中调⽤用
    [GeTuiSdk startSdkWithAppId:kGtAppId appKey:kGtAppKey appSecret:kGtAppSecret delegate:self];
    // 注册 APNs
    [self registerRemoteNotification];
}

- (void)registerRemoteNotification {
    if ([[UIDevice currentDevice].systemVersion floatValue] >= 10.0) {
#if __IPHONE_OS_VERSION_MAX_ALLOWED >= __IPHONE_10_0 // Xcode 8编译会调⽤
        UNUserNotificationCenter *center = [UNUserNotificationCenter currentNotificationCenter];
        center.delegate = self;
        [center requestAuthorizationWithOptions:(UNAuthorizationOptionBadge | UNAuthorizationOptionSound | UNAuthorizationOptionAlert | UNAuthorizationOptionCarPlay) completionHandler:^(BOOL granted, NSError *_Nullable error) {
            if (!error) {
                NSLog(@"request authorization succeeded!");
            }
        }];
        [[UIApplication sharedApplication] registerForRemoteNotifications];
#else // Xcode 7编译会调⽤
        UIUserNotificationType types = (UIUserNotificationTypeAlert | UIUserNotificationTypeSound |  UIUserNotificationTypeBadge);
        UIUserNotificationSettings *settings = [UIUserNotificationSettings settingsForTypes:types categories:nil];
        [[UIApplication sharedApplication] registerForRemoteNotifications];
        [[UIApplication sharedApplication] registerUserNotificationSettings:settings];
#endif
    } else if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0) {
        UIUserNotificationType types = (UIUserNotificationTypeAlert | UIUserNotificationTypeSound | UIUserNotificationTypeBadge);
        UIUserNotificationSettings *settings = [UIUserNotificationSettings settingsForTypes:types categories:nil];
        [[UIApplication sharedApplication] registerForRemoteNotifications];
        [[UIApplication sharedApplication] registerUserNotificationSettings:settings];
    } else {
        UIRemoteNotificationType apn_type = (UIRemoteNotificationType)(UIRemoteNotificationTypeAlert |
                                                                       UIRemoteNotificationTypeSound |
                                                                       UIUserNotificationTypeBadge);
        [[UIApplication sharedApplication] registerForRemoteNotificationTypes:apn_type];
    }
    
}
- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

#pragma mark - 推送
- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
    NSString *token = [[deviceToken description] stringByTrimmingCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@"<>"]];
    token = [token stringByReplacingOccurrencesOfString:@" " withString:@""];
    NSLog(@"\n>>>[DeviceToken Success]:%@\n\n", token);
    // 向个推服务器器注册deviceToken
    [GeTuiSdk registerDeviceToken:token];
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler {
    // 处理理APNs代码，通过userInfo可以取到推送的信息(包括内容，⻆角标，⾃自定义参数等)。如果需要弹 窗等其他操作，则需要⾃自⾏行行编码。
    NSLog(@"\n>>>[Receive RemoteNotification - Background Fetch]:%@\n\n",userInfo);
    //静默推送收到消息后也需要将APNs信息传给个推统计
    [GeTuiSdk handleRemoteNotification:userInfo];
    
    completionHandler(UIBackgroundFetchResultNewData);
}

#pragma mark - GeTuiSdkDelegate
- (void)GeTuiSdkDidRegisterClient:(NSString *)clientId {
    //个推SDK已注册，返回clientId
    NSLog(@"\n>>>[GeTuiSdk RegisterClient]:%@\n\n", clientId);
    [HJDMyManager postGeTuiCid:clientId callback:^(BOOL result) {
        
    }];
}

/** SDK收到透传消息回调 */
- (void)GeTuiSdkDidReceivePayloadData:(NSData *)payloadData andTaskId:(NSString *) taskId andMsgId:(NSString *)msgId andOffLine:(BOOL)offLine fromGtAppId:(NSString * )appId {
    //收到个推消息
    NSString *payloadMsg = nil;
    if (payloadData) {
        payloadMsg = [[NSString alloc] initWithBytes:payloadData.bytes length:payloadData.length encoding:NSUTF8StringEncoding];
    }
    NSString *msg = [NSString stringWithFormat:@"taskId=%@,messageId:%@,payloadMsg :%@%@",taskId,msgId, payloadMsg,offLine ? @"<离线消息>" : @""];
    NSLog(@"\n>>>[GexinSdk ReceivePayload]:%@\n\n", msg);
}
@end
