//
//  ScheduleEvent+Creation.m
//  Innopolis
//
//  Created by Aleksey Novikov on 21/05/15.
//  Copyright (c) 2015 Aleksey Novikov. All rights reserved.
//

#import "ScheduleEvent.h"
/// converting string to date
#import "NSDate+string.h"

@implementation ScheduleEvent (Creation)
/*!
 * @discussion Create Speakers with given array of speakers
 * @param scheduleEventArray The array of events to save in local DB
 * @param The date of the event
 */
+ (void) createScheduleEvent:(NSArray *)scheduleEventArray  withDate:(NSDate *)eventDate{
    for (NSDictionary *scheduleEventObj in scheduleEventArray) {
        ScheduleEvent *scheduleEvent = [ScheduleEvent findScheduleEventByID:scheduleEventObj[@"uniqid"]];
        if (!scheduleEvent) {
            scheduleEvent = [ScheduleEvent MR_createEntity];
            scheduleEvent.eventID   = scheduleEventObj[@"uniqid"];
        }
        scheduleEvent.notunicID = scheduleEventObj[@"id"];
        scheduleEvent.title     = scheduleEventObj[@"title"];
        scheduleEvent.timeStart = [NSDate dateFromTimeGivenAsString:scheduleEventObj[@"timestart"]];
        scheduleEvent.timeEnd   = [NSDate dateFromTimeGivenAsString:scheduleEventObj[@"timeend"]];
        scheduleEvent.date = eventDate;
        scheduleEvent.type = scheduleEventObj[@"type"];
        scheduleEvent.excerpt = scheduleEventObj[@"excerpt"];
        scheduleEvent.location = [NSKeyedArchiver archivedDataWithRootObject:scheduleEventObj[@"location"]];
    }
}
@end
