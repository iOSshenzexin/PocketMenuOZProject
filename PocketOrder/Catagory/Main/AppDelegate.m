//
//  AppDelegate.m
//  PocketOrder
//
//  Created by 杨晓婧 on 16/7/5.
//  Copyright © 2016年 QingDaoShangTong. All rights reserved.
//

#import "AppDelegate.h"
#import "ZXTabBarController.h"
#import "GetAdTool.h"
#import <IQKeyboardManager.h>
#import <IQKeyboardReturnKeyHandler.h>
#define GoogleMap_API_KEY @"AIzaSyAmfHn43uoavyoWCfiN_l_IfIbH5nG5qSE"
@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    [GMSServices provideAPIKey:GoogleMap_API_KEY];
    [GMSPlacesClient provideAPIKey:GoogleMap_API_KEY];
    ZXLog(@"[GMSServices SDKVersion] %@", [GMSServices SDKVersion]);
    //设置tabBar的背景颜色
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    ZXTabBarController *tabbarVc = [[ZXTabBarController alloc] init];
    UIImage *img = [UIImage imageNamed:@"tabbar_background"];
    //tabbar_background navigation_bar_background
    img = [img stretchableImageWithLeftCapWidth:img.size.width * 0.5 topCapHeight:img.size.height * 0.5];
    tabbarVc.tabBar.backgroundImage = img;
    self.window.rootViewController = tabbarVc;
    [self.window makeKeyAndVisible];
    //设置启动广告
    /*
    // 1.判断沙盒中是否存在广告图片，如果存在，直接显示
    NSString *filePath = [GetAdTool getFilePathWithImageName:[kUserDefaults valueForKey:adImageName]];
    
    BOOL isExist = [GetAdTool isFileExistWithFilePath:filePath];
    if (isExist) {// 图片存在
        AdvertiseView *advertiseView = [[AdvertiseView alloc] initWithFrame:self.window.bounds];
        advertiseView.filePath = filePath;
        [advertiseView show];
    }
    // 2.无论沙盒中是否存在广告图片，都需要重新调用广告接口，判断广告是否更新
    [GetAdTool getAdvertisingImage];
     */
   // [[UINavigationBar appearance] setBarTintColor:AppThemeColor];
//    [[UINavigationBar appearance]  setBackgroundImage:[UIImage imageNamed:@"navigationbar_background"] forBarMetrics:UIBarMetricsDefault];
//    [UINavigationBar appearance].translucent = NO;
//    [[UINavigationBar appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]}];
    [self fixTextViewInitSlowly];
    return YES;
}


- (void)fixTextViewInitSlowly{
    UITextView *textView = [[UITextView alloc] init];
    [self.window addSubview:textView];
    [textView removeFromSuperview];
}

- (void)useIQKeyboardManager{
    IQKeyboardManager *manager = [IQKeyboardManager sharedManager];
    manager.enable = YES;
    manager.shouldResignOnTouchOutside = YES;
    manager.shouldToolbarUsesTextFieldTintColor = YES;
    manager.enableAutoToolbar = YES;
    manager.toolbarManageBehaviour =IQAutoToolbarByTag;
}





- (void)applicationWillResignActive:(UIApplication *)application {

}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    // Saves changes in the application's managed object context before the application terminates.
    [self saveContext];
}

#pragma mark - Core Data stack

@synthesize managedObjectContext = _managedObjectContext;
@synthesize managedObjectModel = _managedObjectModel;
@synthesize persistentStoreCoordinator = _persistentStoreCoordinator;

- (NSURL *)applicationDocumentsDirectory {
    // The directory the application uses to store the Core Data store file. This code uses a directory named "vshoutao.com.PocketOrder" in the application's documents directory.
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}

- (NSManagedObjectModel *)managedObjectModel {
    // The managed object model for the application. It is a fatal error for the application not to be able to find and load its model.
    if (_managedObjectModel != nil) {
        return _managedObjectModel;
    }
    NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"PocketOrder" withExtension:@"momd"];
    _managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
    return _managedObjectModel;
}

- (NSPersistentStoreCoordinator *)persistentStoreCoordinator {
    // The persistent store coordinator for the application. This implementation creates and returns a coordinator, having added the store for the application to it.
    if (_persistentStoreCoordinator != nil) {
        return _persistentStoreCoordinator;
    }
    
    // Create the coordinator and store
    
    _persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[self managedObjectModel]];
    NSURL *storeURL = [[self applicationDocumentsDirectory] URLByAppendingPathComponent:@"PocketOrder.sqlite"];
    NSError *error = nil;
    NSString *failureReason = @"There was an error creating or loading the application's saved data.";
    if (![_persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:nil error:&error]) {
        // Report any error we got.
        NSMutableDictionary *dict = [NSMutableDictionary dictionary];
        dict[NSLocalizedDescriptionKey] = @"Failed to initialize the application's saved data";
        dict[NSLocalizedFailureReasonErrorKey] = failureReason;
        dict[NSUnderlyingErrorKey] = error;
        error = [NSError errorWithDomain:@"YOUR_ERROR_DOMAIN" code:9999 userInfo:dict];
        // Replace this with code to handle the error appropriately.
        // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }
    
    return _persistentStoreCoordinator;
}


- (NSManagedObjectContext *)managedObjectContext {
    // Returns the managed object context for the application (which is already bound to the persistent store coordinator for the application.)
    if (_managedObjectContext != nil) {
        return _managedObjectContext;
    }
    
    NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
    if (!coordinator) {
        return nil;
    }
    _managedObjectContext = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSMainQueueConcurrencyType];
    [_managedObjectContext setPersistentStoreCoordinator:coordinator];
    return _managedObjectContext;
}

#pragma mark - Core Data Saving support

- (void)saveContext {
    NSManagedObjectContext *managedObjectContext = self.managedObjectContext;
    if (managedObjectContext != nil) {
        NSError *error = nil;
        if ([managedObjectContext hasChanges] && ![managedObjectContext save:&error]) {
            // Replace this implementation with code to handle the error appropriately.
            // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            abort();
        }
    }
}

@end
