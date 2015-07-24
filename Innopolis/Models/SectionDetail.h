//
//  SectionDetail.h
//  Innopolis
//
//  Created by Aleksey Novikov on 20/05/15.
//  Copyright (c) 2015 Aleksey Novikov. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface SectionDetail : NSManagedObject

@property (nonatomic, retain) NSString * content;
@property (nonatomic, retain) NSNumber * sectionID;
@property (nonatomic, retain) NSDate * dateStart;
@property (nonatomic, retain) NSString * title;
@property (nonatomic, retain) NSNumber * duration;
@property (nonatomic, retain) NSDate * dateEnd;
@property (nonatomic, retain) id speakers;
@property (nonatomic, retain) id location;

@end


#pragma mark - CREATION
#pragma mark -
@interface SectionDetail (Creation)
/*!
 * @discussion Create SectionsDeatils with given dictionary
 * @param sectionsArray The info of section to save in local DB
 */
+ (void) createSectionDetail:(NSDictionary *)dic;
@end



#pragma mark - FETCHING
#pragma mark
@interface SectionDetail (Fetching)
/*!
 * @discussion Fin all section details
 * @return An array of found sections details or nil
 */
+ (NSArray *) findAll;

/*!
 * @discussion Get a detail of a section by section ID
 * @param sectionID The sectionID to be used
 */
+ (SectionDetail *) findDetailBySectionID:(NSNumber *)sectionID;
@end
