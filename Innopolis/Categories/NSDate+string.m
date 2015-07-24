//
//  NSDate+string.m
//  Innopolis
//
//  Created by Aleksey Novikov on 20/05/15.
//  Copyright (c) 2015 Aleksey Novikov. All rights reserved.
//

#import "NSDate+string.h"

@implementation NSDate (string)
+ (NSDate *) dateAsISO8601FromString:(NSString *)date{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setLocale:[NSLocale localeWithLocaleIdentifier:@"en_US"]];
    [dateFormatter setDateFormat: @"dd/MM/yyyy HH:mm"];
    [dateFormatter setTimeZone:[NSTimeZone localTimeZone]];
    return [dateFormatter dateFromString:date];
}

+ (NSDate *) dateFromTimeGivenAsString:(NSString *) timeString{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setLocale:[NSLocale localeWithLocaleIdentifier:@"en_US"]];
    [dateFormatter setDateFormat: @"HH:mm"];
    [dateFormatter setTimeZone:[NSTimeZone localTimeZone]];
    return [dateFormatter dateFromString:timeString];
}

+ (NSDate *) dateFromCalendarDateGivenAsString:(NSString *)timeString{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setLocale:[NSLocale localeWithLocaleIdentifier:@"en_US"]];
    [dateFormatter setDateFormat: @"dd.MM.yyyy"];
    [dateFormatter setTimeZone:[NSTimeZone localTimeZone]];
    return [dateFormatter dateFromString:timeString];
}


@end
