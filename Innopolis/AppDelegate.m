//
//  AppDelegate.m
//  Innopolis
//
//  Created by Aleksey Novikov on 13/05/15.
//  Copyright (c) 2015 Aleksey Novikov. All rights reserved.
//

#import "AppDelegate.h"

/// core data wrapper
#import <MagicalRecord/MagicalRecord.h>

/// network interaction
#import "NetwokManager.h"

// Push Notification
#import "AppboyKit.h"

/// keychain
#import "JNKeychain.h"

/// login
#import "LoginNavigationController.h"

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"

@interface AppDelegate() <loginNavigationControllerDelegate>
@property(nonatomic, strong) UIWindow *loginEntryWindow;
@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    [[UINavigationBar appearance] setTintColor:[UIColor whiteColor]];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    
    [Appboy startWithApiKey:@"1fd8ed01-30ce-455d-85b2-2bb149787c72"
              inApplication:application
          withLaunchOptions:launchOptions];
    
    
    if (floor(NSFoundationVersionNumber) <= NSFoundationVersionNumber_iOS_7_1) {
        [[UIApplication sharedApplication] registerForRemoteNotificationTypes:
         (UIRemoteNotificationTypeAlert |
          UIRemoteNotificationTypeBadge |
          UIRemoteNotificationTypeSound)];
    } else {
        UIUserNotificationSettings *settings = [UIUserNotificationSettings settingsForTypes:(UIUserNotificationTypeBadge|UIUserNotificationTypeAlert | UIUserNotificationTypeSound) categories:nil];
        [[UIApplication sharedApplication] registerForRemoteNotifications];
        [[UIApplication sharedApplication] registerUserNotificationSettings:settings];
    }
    
    /// setup core data
    [MagicalRecord setupAutoMigratingCoreDataStack];
    /// preload from server
    [[NetwokManager sharedNetworkManager] preloadDatas];
    
    

    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
        [MagicalRecord saveUsingCurrentThreadContextWithBlock:^(NSManagedObjectContext *localContext) {
        
    } completion:^(BOOL success, NSError *error) {
        
    }];
}



-(void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler   {
    [[Appboy sharedInstance] registerApplication:application didReceiveRemoteNotification:userInfo fetchCompletionHandler:completionHandler];
}

// Pass the deviceToken to Appboy as well
- (void) application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
    [[Appboy sharedInstance] registerPushToken:[NSString stringWithFormat:@"%@", deviceToken]];
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
    /// the user if not logged in
    if (![JNKeychain loadValueForKey:@"email"]) {
        if ( _loginEntryWindow == nil ) {
            _loginEntryWindow = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
            LoginNavigationController *navigationController = (LoginNavigationController *)[self.window.rootViewController.storyboard instantiateViewControllerWithIdentifier:@"loginNavigationViewController"];
            navigationController.loginDelegate = self;
            _loginEntryWindow.rootViewController = navigationController;            
        }
        
        [_loginEntryWindow makeKeyAndVisible];
    }
}



- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
//    [self saveContext];
}


#pragma mark - Login navigation controller delegate
- (void) loginNavigationControllerDidFinish:(LoginNavigationController *)controller{
    [self.window makeKeyWindow];
    [self.window.rootViewController setNeedsStatusBarAppearanceUpdate];
    
    [UIView animateWithDuration:0.2f delay:0.0f options:UIViewAnimationOptionCurveEaseIn
                     animations:^{
                         _loginEntryWindow.rootViewController.view.transform = CGAffineTransformMakeTranslation(0.0f, _loginEntryWindow.rootViewController.view.bounds.size.height);
                     } completion:^(BOOL finished) {
                         _loginEntryWindow = nil;
                         [self.window makeKeyAndVisible];
                         [self.window.rootViewController setNeedsStatusBarAppearanceUpdate];
                     }];
}


@end

