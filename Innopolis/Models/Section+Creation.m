//
//  Section+Creation.m
//  Innopolis
//
//  Created by Aleksey Novikov on 19/05/15.
//  Copyright (c) 2015 Aleksey Novikov. All rights reserved.
//

#import "Section.h"

@implementation Section (Creation)
/*!
 * @discussion Create Sections with given array of sections
 * @param sectionsArray The array of sections to save in local DB
 */
+ (void) createSections:(NSArray *)sectionsArray{
    for (NSDictionary *sectionObj in sectionsArray) {
        NSDictionary *sectionDic = sectionObj[@"section"];
        Section *section = [Section findSectionByID:sectionDic[@"id"]];
        if (!section) {
            section = [Section MR_createEntity];
            section.sectionID  = sectionDic[@"id"];
        }        
        section.excerpt    = sectionDic[@"excerpt"];
        section.title      = sectionDic[@"title"];
    }
}
@end
