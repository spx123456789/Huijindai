//
//  AppDelegate.m
//  HuiJinDai
//
//  Created by 耿笑威 on 2018/8/30.
//  Copyright © 2018年 shanpx. All rights reserved.
//

#import "AppDelegate.h"
#import "HJDLoginViewController.h"
#import "HJDHomeViewController.h"
#import "HJDMyViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = kWithe;
    
    UINavigationController *navi = [[UINavigationController alloc] initWithRootViewController:[[HJDLoginViewController alloc] init]];
    self.window.rootViewController = navi;
    
    [self.window makeKeyAndVisible];
    
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


@end
