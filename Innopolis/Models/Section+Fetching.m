//
//  Section+Fetching.m
//  Innopolis
//
//  Created by Aleksey Novikov on 20/05/15.
//  Copyright (c) 2015 Aleksey Novikov. All rights reserved.
//

#import "Section.h"

@implementation Section (Fetching)
/*!
 * @discussion Fin all sections
 * @return An array of found sections or nil
 */
+ (NSArray *) findAll{
    return [Section MR_findAll];
}

/*!
 * @discussion Find a section by ID
 * @param sectionID The ID of the section to be search for
 * @return The found section or nil
 */
+ (Section *) findSectionByID:(NSNumber *)sectionID{
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"sectionID = %@", sectionID];
    NSArray *array = [Section MR_findAllWithPredicate:predicate];
    if (array && array.count > 0) {
        return array[0];
    }
    return nil;
}
@end
