//  Speaker+Fetching.m
//  Innopolis
//
//  Created by Aleksey Novikov on 21/05/15.
//  Copyright (c) 2015 Aleksey Novikov. All rights reserved.
//

#import "Speaker.h"

@implementation Speaker(Fetching)
/*!
 * @discussion Find all speakers
 * @return An array of found users or nil
 */
+ (NSArray *) findAll{
    return [Speaker MR_findAll];
}

/*!
 * @discussion Find a speaker with a given ID
 * @param speakerID The ID of the speaker to be found
 * @return The found speaker(only one, even if there is several speakers)
 */
+ (Speaker *) findSpeakerByID:(NSNumber *)speakerID{
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"speakerID = %@", speakerID];
    NSArray *array = [Speaker MR_findAllWithPredicate:predicate];
    if (array && array.count > 0) {
        return array[0];
    }
    return nil;
}

+ (Speaker *) findSpeakerWithName: (NSString *)name{
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"name = %@", name];
    NSArray *array = [Speaker MR_findAllWithPredicate:predicate];
    if (array && array.count > 0) {
        return array[0];
    }
    return nil;
}

@end

