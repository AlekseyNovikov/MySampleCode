//
//  Speaker+Creation.m
//  Innopolis
//
//  Created by Aleksey Novikov on 21/05/15.
//  Copyright (c) 2015 Aleksey Novikov. All rights reserved.
//

#import "Speaker.h"


@implementation Speaker (Creation)
/*!
 * @discussion Create Speakers with given array of speakers
 * @param speakersArray The array of speakers to save in local DB
 */
+ (void) createSpeakers:(NSArray *)speakersArray{
    for (NSDictionary *speakerObj in speakersArray) {
         NSDictionary *speakerDic = speakerObj[@"speaker"];
        Speaker *speaker = [Speaker findSpeakerByID:speakerDic[@"id"]];
        if (!speaker) {
            speaker = [Speaker MR_createEntity];
            speaker.speakerID = speakerDic[@"id"];
        }        
        speaker.name = speakerDic[@"title"];
        speaker.content = speakerDic[@"content"];
        speaker.excerpt = speakerDic[@"excerpt"];
        speaker.photoURL = speakerDic[@"photo"];
    }
}

@end
