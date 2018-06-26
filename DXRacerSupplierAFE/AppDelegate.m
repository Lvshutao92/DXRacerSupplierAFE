//
//  AppDelegate.m
//  DXRacerSupplierAFE
//
//  Created by ilovedxracer on 2017/10/13.
//  Copyright © 2017年 ilovedxracer. All rights reserved.
//

#import "AppDelegate.h"
//引入JPush功能所需头文件
#import <JPush/JPUSHService.h>
#import <AdSupport/ASIdentifierManager.h>
//iOS10注册APNs所需头文件
#ifdef NSFoundationVersionNumber_iOS_9_x_Max
#import <UserNotifications/UserNotifications.h>
#endif

static NSString * const jpushAppKey = @"ec2f8670dbc350aaa4aa9cc1";
static NSString * const channel = @"fc08084d0c5ba1c1ad1d638a";
static BOOL isProduction = true;

@interface AppDelegate ()<JPUSHRegisterDelegate>
{
    NSString *currentVersion;
}
@property(nonatomic, strong)LoginViewController *login;
@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    [IQKeyboardManager sharedManager].enable = YES;
    [IQKeyboardManager sharedManager].shouldResignOnTouchOutside = YES;
    
    
    //Required
    //notice: 3.0.0及以后版本注册可以这样写，也可以继续用之前的注册方式
    JPUSHRegisterEntity * entity = [[JPUSHRegisterEntity alloc] init];
    entity.types = JPAuthorizationOptionAlert|JPAuthorizationOptionBadge|JPAuthorizationOptionSound;
    if ([[UIDevice currentDevice].systemVersion floatValue] >= 8.0) {
        // 可以添加自定义categories
        // NSSet<UNNotificationCategory *> *categories for iOS10 or later
        // NSSet<UIUserNotificationCategory *> *categories for iOS8 and iOS9
    }
    [JPUSHService registerForRemoteNotificationConfig:entity delegate:self];
    
    
    // Optional
    // 获取IDFA
    // 如需使用IDFA功能请添加此代码并在初始化方法的advertisingIdentifier参数中填写对应值
    // NSString *advertisingId = [[[ASIdentifierManager sharedManager] advertisingIdentifier] UUIDString];
    
    // Required
    // init Push
    // notice: 2.1.5版本的SDK新增的注册方法，改成可上报IDFA，如果没有使用IDFA直接传nil
    // 如需继续使用pushConfig.plist文件声明appKey等配置内容，请依旧使用[JPUSHService setupWithOption:launchOptions]方式初始化。
    [JPUSHService setupWithOption:launchOptions appKey:jpushAppKey
                          channel:channel
                 apsForProduction:isProduction];
    
    
    //可以添加自定义categories
    [JPUSHService registerForRemoteNotificationTypes:(UIUserNotificationTypeBadge |
                                                          UIUserNotificationTypeSound |
                                                          UIUserNotificationTypeAlert)
                                              categories:nil];

    __weak typeof(self) weakSelf = self;
    [JPUSHService registrationIDCompletionHandler:^(int resCode, NSString *registrationID) {
        [JPUSHService setAlias:[Manager redingwenjianming:@"userId.text"] callbackSelector:@selector(tagsAliasCallback:tags:alias:) object:weakSelf];
    }];
    
    
    
    
    
    self.window = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
    self.window.backgroundColor = [UIColor whiteColor];
    self.login = [[LoginViewController alloc]init];
    self.window.rootViewController = self.login;
    [self.window makeKeyWindow];
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(clickHiddenlogin:) name:@"hiddenlogin" object:nil];
    
    [[UIApplication sharedApplication] setApplicationIconBadgeNumber:0];
    
    return YES;
}
-(void)tagsAliasCallback:(int)iResCode
                    tags:(NSSet*)tags
                   alias:(NSString*)alias
{
//NSLog(@"rescode: %d, \ntags: %@, \nalias: %@\n", iResCode, tags , alias);
}

- (void)clickHiddenlogin:(NSNotification *)text {
     __weak typeof(self) weakSelf = self;
    [JPUSHService registrationIDCompletionHandler:^(int resCode, NSString *registrationID) {
        NSSet *set1 = [[NSSet alloc] initWithObjects:registrationID,nil];
        [JPUSHService setTags:set1 alias:[Manager redingwenjianming:@"userId.text"] callbackSelector:@selector(tagsAliasCallback:tags:alias:) object:weakSelf];
    }];
    
    [[UIApplication sharedApplication] setApplicationIconBadgeNumber:0];
    
    MainTabbarViewController *mainVC = [[MainTabbarViewController alloc]init];
    self.window.rootViewController = mainVC;
    mainVC.selectedIndex = 0;
    [self.window makeKeyWindow];
}





-(UIInterfaceOrientationMask)application:(UIApplication *)application supportedInterfaceOrientationsForWindow:(UIWindow *)window {
    return UIInterfaceOrientationMaskPortrait;
}
- (void)applicationDidEnterBackground:(UIApplication *)application{
    double delayInSeconds = 1800.0;
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds *NSEC_PER_SEC);
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        //进入后台30分后杀掉该进程
        exit(0);
    });
}





- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler {
    [[UIApplication sharedApplication] setApplicationIconBadgeNumber:0];
    //NSLog(@"userInfo====%@",userInfo);
    //取得 APNs 标准信息内容
    NSDictionary *aps = [userInfo valueForKey:@"aps"];
    NSString *content = [aps valueForKey:@"alert"]; //推送显示的内容
//    NSInteger badge = [[aps valueForKey:@"badge"] integerValue]; //badge数量
//    NSString *sound = [aps valueForKey:@"sound"]; //播放的声音
    // 取得Extras字段内容
    //    NSString *customizeField1 = [userInfo valueForKey:@"extras"]; //服务端中Extras字段，key是自己定义的
//    NSLog(@"%@=======",content);
    
    MainTabbarViewController *tabBarController = (MainTabbarViewController *)self.window.rootViewController;
    MainNavigationViewController *nav = (MainNavigationViewController *)tabBarController.selectedViewController;
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:content message:@"温馨提示" preferredStyle:1];
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"关闭" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
    }];
    [alert addAction:cancel];
    [nav presentViewController:alert animated:YES completion:nil];
    
    [JPUSHService handleRemoteNotification:userInfo];
    completionHandler(UIBackgroundFetchResultNewData);
    [JPUSHService setBadge:0];
}








- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo {
    //    NSLog(@"----%@",userInfo);
    
    [JPUSHService handleRemoteNotification:userInfo];
}
-(BOOL)application:(UIApplication *)application openURL:(NSURL *)url options:(nonnull NSDictionary<NSString *,id> *)options{
    
    //    NSLog(@"url---%@",url);
    return YES;
    
}

//注册APNs成功并上报DeviceToken
- (void)application:(UIApplication *)application
didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
    /// Required - 注册 DeviceToken
    [JPUSHService registerDeviceToken:deviceToken];
}
//实现注册APNs失败接口（可选）
- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error {
    //Optional
     NSLog(@"did Fail To Register For Remote Notifications With Error: %@", error);
}
//添加处理APNs通知回调方法
// iOS 10 Support
- (void)jpushNotificationCenter:(UNUserNotificationCenter *)center willPresentNotification:(UNNotification *)notification withCompletionHandler:(void (^)(NSInteger))completionHandler {
    // Required
    NSDictionary * userInfo = notification.request.content.userInfo;
    if([notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]]) {
        [JPUSHService handleRemoteNotification:userInfo];
    }
    completionHandler(UNNotificationPresentationOptionAlert); // 需要执行这个方法，选择是否提醒用户，有Badge、Sound、Alert三种类型可以选择设置
}

// iOS 10 Support
- (void)jpushNotificationCenter:(UNUserNotificationCenter *)center didReceiveNotificationResponse:(UNNotificationResponse *)response withCompletionHandler:(void (^)())completionHandler {
    // Required
    NSDictionary * userInfo = response.notification.request.content.userInfo;
    if([response.notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]]) {
        [JPUSHService handleRemoteNotification:userInfo];
    }
    completionHandler();  // 系统要求执行这个方法
}




@end
