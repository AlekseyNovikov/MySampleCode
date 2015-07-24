//
//  SectionDetail+Fetching.m
//  Innopolis
//
//  Created by Aleksey Novikov on 20/05/15.
//  Copyright (c) 2015 Aleksey Novikov. All rights reserved.
//

#import "SectionDetail.h"


@implementation SectionDetail (Fetching)
/*!
 * @discussion Find all section details
 * @return An array of found sections details or nil
 */
+ (NSArray *) findAll{
    return [SectionDetail MR_findAll];
}

/*!
 * @discussion Get a detail of a section by section ID
 * @param sectionID The sectionID to be used
 */
+ (SectionDetail *) findDetailBySectionID:(NSNumber *)sectionID{
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"sectionID = %@", sectionID];
    NSArray *array = [SectionDetail MR_findAllWithPredicate:predicate];
    if (array && array.count > 0) {
        return array[0];
    }
    
    return nil;
}
@end
