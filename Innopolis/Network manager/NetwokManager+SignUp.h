//
//  NetwokManager+SignUp.h
//  Innopolis
//
//  Created by Aleksey Novikov on 21/05/15.
//  Copyright (c) 2015 Aleksey Novikov. All rights reserved.
//

#import "NetwokManager.h"

@interface NetwokManager (SignUp)
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
                     onError:(ErrorBlock)errorBlock;
@end
