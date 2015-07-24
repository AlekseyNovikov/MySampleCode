//
//  NSDate+string.h
//  Innopolis
//
//  Created by Aleksey Novikov on 20/05/15.
//  Copyright (c) 2015 Aleksey Novikov. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (string)
+ (NSDate *) dateAsISO8601FromString:(NSString *)date;
+ (NSDate *) dateFromTimeGivenAsString:(NSString *) timeString;
+ (NSDate *) dateFromCalendarDateGivenAsString:(NSString *)timeString;
@end
