//
//  ScheduleEvent.h
//  Innopolis
//
//  Created by Aleksey Novikov on 21/05/15.
//  Copyright (c) 2015 Aleksey Novikov. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface ScheduleEvent : NSManagedObject

@property (nonatomic, retain) NSDate * date;
@property (nonatomic, retain) NSNumber * notunicID;
@property (nonatomic, retain) NSNumber * eventID;
@property (nonatomic, retain) NSString * excerpt;
@property (nonatomic, retain) NSDate * timeEnd;
@property (nonatomic, retain) NSDate * timeStart;
@property (nonatomic, retain) NSString * title;
@property (nonatomic, retain) NSString * type;
@property (nonatomic, retain) id location;

@end


#pragma mark - CREATION
#pragma mark -
@interface ScheduleEvent (Creation)
/*!
 * @discussion Create Speakers with given array of speakers
 * @param scheduleEventArray The array of events to save in local DB
 * @param The date of the event
 */
+ (void) createScheduleEvent:(NSArray *)scheduleEventArray  withDate:(NSDate *)eventDate;
@end

#pragma mark - FETCHING
#pragma mark -
@interface ScheduleEvent (Fetching)
/*!
 * @discussion Find all schedule events
 * @return An array of found schedule events or nil
 */
+ (NSArray *) findAll;

+ (NSArray *) findAllSortetedBy:(NSString *)attribute;

+ (NSInteger) numberOfSheduleEventsWithPredicate:(NSPredicate *)predicate;

    
/*!
 * @discussion Find a schedule event with a given ID
 * @param eventID The ID of the event to be found
 * @return The found event(only one, even if there is several event)
 */
+ (ScheduleEvent *) findScheduleEventByID:(NSNumber *)eventID;
@end
