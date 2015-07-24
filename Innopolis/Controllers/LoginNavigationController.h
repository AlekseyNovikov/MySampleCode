//
//  LoginNavigationController.h
//  ITOPK
//
//  Created by Aleksey Novikov on 23/05/15.
//  Copyright (c) 2015 Aleksey Novikov. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol loginNavigationControllerDelegate;


@interface LoginNavigationController : UINavigationController
@property (nonatomic, strong) id <loginNavigationControllerDelegate> loginDelegate;
- (void) closeEntrance;
@end


@protocol loginNavigationControllerDelegate <NSObject>
- (void) loginNavigationControllerDidFinish:(LoginNavigationController *)controller;
@end