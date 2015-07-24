//
//  ScheduleEvent+Fetching.m
//  Innopolis
//
//  Created by Aleksey Novikov on 21/05/15.
//  Copyright (c) 2015 Aleksey Novikov. All rights reserved.
//


#import "ScheduleEvent.h"

@implementation ScheduleEvent (Fetching)
/*!
 * @discussion Find all schedule events
 * @return An array of found schedule events or nil
 */
+ (NSArray *) findAll{
    return [ScheduleEvent MR_findAll];
}

+ (NSArray *) findAllSortetedBy:(NSString *)attribute;
 {
    return [ScheduleEvent MR_findAllSortedBy:attribute ascending:YES];
}

+ (NSInteger) numberOfSheduleEventsWithPredicate:(NSPredicate *)predicate {
    return [ScheduleEvent MR_numberOfEntitiesWithPredicate:predicate].intValue;
}
/*!
 * @discussion Find a schedule event with a given ID
 * @param eventID The ID of the event to be found
 * @return The found event(only one, even if there is several event)
 */
+ (ScheduleEvent *) findScheduleEventByID:(NSNumber *)eventID{
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"eventID = %@", eventID];
    NSArray *array = [ScheduleEvent MR_findAllWithPredicate:predicate];
    if (array && array.count > 0) {
        return array[0];
    }
    return nil;
}

@end


