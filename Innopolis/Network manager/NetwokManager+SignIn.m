//
//  NetwokManager+SignIn.m
//  ITOPK
//
//  Created by Aleksey Novikov on 23/05/15.
//  Copyright (c) 2015 Aleksey Novikov. All rights reserved.
//

#import "NetwokManager+SignIn.h"

@implementation NetwokManager (SignIn)
/*!
 * @discussion Sign in the user with a email and given password
 * @param completionBlock A block object to be executed when the task finishes successfully. It's executed on main thread.
 * @param errorBlock A block object to be executed when the task finishes unsuccessfully. It's executed on main thread.
 */
- (void) signInWithLogin:(NSString *)email
                password:(NSString *)password
            onCompletion:(CompletionBlock)completionBlock
                 onError:(ErrorBlock)errorBlock{
    
    NSMutableDictionary *parameters = [NSMutableDictionary dictionaryWithDictionary:@{
                                                                                      @"umail" : email,
                                                                                      @"upass" : password,
                                                                                      @"uname" : @"login"
                                                                                      }];

    
    [[NetwokManager sharedNetworkManager]
     POST:userURL
     parameters:[parameters copy]
     onSuccess:^(id json) {
         if ([json[@"success"] boolValue]) {
             if (completionBlock) {
                 completionBlock(NO);
             }
         }
         else{
             NSArray *response = json[@"data"];
             
             if ([response[0][@"code"] isEqualToString:@"existing_user_login"]) {
                 completionBlock(YES);
             }
             if (completionBlock) {
                 completionBlock(NO);
             }
             
             
         }
     } onFailure:^(NSError *error) {
         if (errorBlock) {
             errorBlock(error);
         }
     }];
}
@end
