//
//  NetwokManager+Ask.h
//  Innopolis
//
//  Created by Aleksey Novikov on 21/05/15.
//  Copyright (c) 2015 Aleksey Novikov. All rights reserved.
//

#import "NetwokManager.h"

@interface NetwokManager (Ask)
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
             onError:(ErrorBlock)errorBlock;
@end
