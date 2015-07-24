//
//  Section.h
//  Innopolis
//
//  Created by Aleksey Novikov on 19/05/15.
//  Copyright (c) 2015 Aleksey Novikov. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Section : NSManagedObject

@property (nonatomic, retain) NSString * excerpt;
@property (nonatomic, retain) NSNumber * sectionID;
@property (nonatomic, retain) NSString * title;

@end

#pragma mark - CREATION
#pragma mark -
/*!
 * @discussion Create Sections with given array of sections
 * @param sectionsArray The array of sections to save in local DB
 */
@interface Section (Creation)
+ (void) createSections:(NSArray *)sectionsArray;
@end

#pragma mark - FETCHING
#pragma mark -
@interface Section (Fetching)
/*!
 * @discussion Find all sections
 * @return An array of found users or nil
 */
+ (NSArray *) findAll;

/*!
 * @discussion Find a section by ID
 * @param sectionID The ID of the section to be search for
 * @return The found section or nil
 */
+ (Section *) findSectionByID:(NSNumber *)sectionID;
@end
