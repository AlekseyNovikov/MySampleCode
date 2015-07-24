//
//  NetwokManager+Ask.m
//  Innopolis
//
//  Created by Aleksey Novikov on 21/05/15.
//  Copyright (c) 2015 Aleksey Novikov. All rights reserved.
//

#import "NetwokManager+Ask.h"

@implementation NetwokManager (Ask)
/*!
 * @discussion Send a question to server related to section
 * @param question The question to be asked
 * @param sectionID The id of the section to which the question is related
 * @param speakerID The ID of the speaker to whom the question is attended
 * @param completion A block object to be executed when the task finishes successfully.
 * @param errorBlock A block object to be executed when the task finishes unsuccessfully.
 */
- (void) askQuestion:(NSString *)question
    relatedToSection:(NSNumber *)sectionID
           toSpeaker:(NSNumber *)speakerID
        onCompletion:(CompletionBlock)completionBlock
             onError:(ErrorBlock)errorBlock
{    
    NSDictionary *parameters = @{
                                   @"section" : [NSString stringWithFormat:@"%@",sectionID],
                                   @"speaker" : [NSString stringWithFormat:@"%@",speakerID],
                                   @"data"    : question
                                 };
    
    [[NetwokManager sharedNetworkManager]
     POST:questionURL
     parameters:parameters
     onSuccess:^(id json) {
         if (json[@"succes"]) {
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
