//
//  NetwokManager+Speakers.m
//  Innopolis
//
//  Created by Aleksey Novikov on 20/05/15.
//  Copyright (c) 2015 Aleksey Novikov. All rights reserved.
//

#import "NetwokManager.h"
#import "Speaker.h"

@implementation NetwokManager (Speakers)
/*!
 * @discussion Get all speakers.
 * @param completion  A block object to be executed when the task finishes successfully.
 * @param errorBlock A block object to be executed when the task finishes unsuccessfully.
 */
- (void) speakers:(CompletionBlock)completionBlock
          onError:(ErrorBlock)errorBlock{
    [self performRequestToServer:allSpeakersURL
                       onSuccess:^(id json) {
                           if (json && [json[@"speakers"] count] > 0) {
                               /// update BD
                               [Speaker createSpeakers:json[@"speakers"]];
                               
                               if (completionBlock) {
                                   completionBlock(YES);
                               }
                           }
                           else{
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
