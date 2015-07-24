//
//  NetwokManager+Schedule.m
//  Innopolis
//
//  Created by Aleksey Novikov on 21/05/15.
//  Copyright (c) 2015 Aleksey Novikov. All rights reserved.
//

#import "NetwokManager.h"
/// Schedule event
#import "ScheduleEvent.h"
/// Date conversion
#import "NSDate+string.h"


@implementation NetwokManager (Schedule)
/*!
 * @discussion Get the schedule table.
 * @param completion  A block object to be executed when the task finishes successfully.
 * @param errorBlock A block object to be executed when the task finishes unsuccessfully.
 */
- (void) schedule:(CompletionBlock)completionBlock
          onError:(ErrorBlock)errorBlock{
    [self performRequestToServer:scheduleURL
                       onSuccess:^(NSArray *jsonArray) {
                           if(jsonArray){
                               for (NSDictionary *sheduleObj in jsonArray) {
                                       NSDate *eventDate = [NSDate dateFromCalendarDateGivenAsString:sheduleObj[@"date"]];
                                       [ScheduleEvent createScheduleEvent:sheduleObj[@"data"] withDate:eventDate];
                               }
                               
                               if (completionBlock) {
                                   completionBlock(YES);
                               }
                           }
                           else{
                               if (completionBlock) {
                                   completionBlock(NO);
                               }
                           }                       } onFailure:^(NSError *error) {
                           if (errorBlock) {
                               errorBlock(error);
                           }
                       }];
}
@end
