//
//  SectionDetail+Creation.m
//  Innopolis
//
//  Created by Aleksey Novikov on 20/05/15.
//  Copyright (c) 2015 Aleksey Novikov. All rights reserved.
//

#import "SectionDetail.h"
#import "NSDate+string.h"

@implementation SectionDetail (Creation)
/*!
 * @discussion Create SectionsDeatils with given dictionary
 * @param sectionsArray The info of section to save in local DB
 */
+ (void) createSectionDetail:(NSDictionary *)dic{
    SectionDetail *sectionDetail = [SectionDetail findDetailBySectionID:dic[@"section"][@"id"]];
    
    if (!sectionDetail) {
        sectionDetail = [SectionDetail MR_createEntity];
        sectionDetail.sectionID = dic[@"section"][@"id"];
    }    
    sectionDetail.title = dic[@"section"][@"title"];
    sectionDetail.content = dic[@"section"][@"content"];
    NSArray *datesArray = dic[@"dates"];
    NSDictionary *startDateDic = datesArray.firstObject;
    NSDictionary *endDateDic = datesArray.lastObject;
    sectionDetail.dateStart = [NSDate dateAsISO8601FromString:startDateDic[@"datetime"]];
    sectionDetail.duration = [NSNumber numberWithDouble:[endDateDic[@"duration"] doubleValue]];
    sectionDetail.dateEnd = [NSDate dateAsISO8601FromString:endDateDic[@"datetime"]];
    sectionDetail.dateEnd = [sectionDetail.dateEnd dateByAddingTimeInterval:(sectionDetail.duration.intValue * 60)];
    sectionDetail.speakers = [NSKeyedArchiver archivedDataWithRootObject:dic[@"speakers"]];
    sectionDetail.location = [NSKeyedArchiver archivedDataWithRootObject:dic[@"location"]];
}
@end
