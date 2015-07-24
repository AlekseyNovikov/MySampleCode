//
//  NetwokManager+SignIn.h
//  ITOPK
//
//  Created by Aleksey Novikov on 23/05/15.
//  Copyright (c) 2015 Aleksey Novikov. All rights reserved.
//

#import "NetwokManager.h"

@interface NetwokManager (SignIn)

/*!
 * @discussion Sign in the user with a email and given password
 * @param completionBlock A block object to be executed when the task finishes successfully. It's executed on main thread.
 * @param errorBlock A block object to be executed when the task finishes unsuccessfully. It's executed on main thread.
 */
- (void) signInWithLogin:(NSString *)email
                password:(NSString *)password
            onCompletion:(CompletionBlock)completionBlock
            onError:(ErrorBlock)errorBlock;
@end
