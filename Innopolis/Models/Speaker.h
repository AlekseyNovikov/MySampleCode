//
//  Speaker.h
//  Innopolis
//
//  Created by Aleksey Novikov on 21/05/15.
//  Copyright (c) 2015 Aleksey Novikov. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Speaker : NSManagedObject

@property (nonatomic, retain) NSString * content;
@property (nonatomic, retain) NSString * photoURL;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSNumber * speakerID;
@property (nonatomic, retain) NSString * excerpt;

@end


#pragma mark - CREATION
#pragma mark
@interface Speaker (Creation)
/*!
 * @discussion Create Speakers with given array of speakers
 * @param speakersArray The array of speakers to save in local DB
 */
+ (void) createSpeakers:(NSArray *)speakersArray;
@end

#pragma mark - FETCHING
#pragma mark
@interface Speaker (Fetching)
/*!
 * @discussion Find all spaekers
 * @return An array of found users or nil
 */
+ (NSArray *) findAll;
/*!
 * @discussion Find a speaker with a given ID
 * @param speakerID The ID of the speaker to be found
 * @return The found speaker(only one, even if there is several speakers)
 */
+ (Speaker *) findSpeakerByID:(NSNumber *)speakerID;


+ (Speaker *) findSpeakerWithName: (NSString *)name;
@end
