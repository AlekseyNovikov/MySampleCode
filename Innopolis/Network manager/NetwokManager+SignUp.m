//
//  NetwokManager+SignUp.m
//  Innopolis
//
//  Created by Aleksey Novikov on 21/05/15.
//  Copyright (c) 2015 Aleksey Novikov. All rights reserved.
//

#import "NetwokManager+SignUp.h"



@implementation NetwokManager (SignUp)
/*!
 * @discussion Sign up the user
 * @param completionBlock A block object to be executed when the task finishes successfully. It's executed on main thread.
 * @param errorBlock A block object to be executed when the task finishes unsuccessfully. It's executed on main thread.
 */
- (void) signUpUserWithEmail:(NSString *)email
                    password:(NSString *)password
                        name:(NSString *)name
                     surname:(NSString *)surname
                       phone:(NSString *)phone
                onCompletion:(CompletionBlock)completionBlock
                     onError:(ErrorBlock)errorBlock{
    
    NSMutableDictionary *parameters = [NSMutableDictionary dictionaryWithDictionary:@{
                                @"umail" : email,
                                @"upass" : password,
                                @"uname" : name
                               }];
    

    if (surname) {
        [parameters setObject:surname forKey:@"usurname"];
    }

    if (phone) {
        [parameters setObject:phone forKey:@"uphone"];
    }
    
    
    [[NetwokManager sharedNetworkManager]
     POST:userURL
     parameters:[parameters copy]
     onSuccess:^(id json) {
         if ([json[@"success"] boolValue]) {
             if (completionBlock) {
                 completionBlock(YES);
             }
         }
         else{
             if (completionBlock) {
                 completionBlock(NO);
             }
             
             DLog(@"Error while sign up the user:::%@", json[@"data"]);
         }
    } onFailure:^(NSError *error) {
        if (errorBlock) {
            errorBlock(error);
        }
    }];
}


@end
