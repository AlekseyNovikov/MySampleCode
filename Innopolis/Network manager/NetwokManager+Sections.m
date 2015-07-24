//
//  NetwokManager+Sections.m
//  Innopolis
//
//  Created by Aleksey Novikov on 19/05/15.
//  Copyright (c) 2015 Aleksey Novikov. All rights reserved.
//

#import "NetwokManager.h"
#import "Section.h"
#import "SectionDetail.h"

@implementation NetwokManager (Sections)
/*!
 * @discussion Get all sections.
 * @param completion  A block object to be executed when the task finishes successfully.
 * @param errorBlock A block object to be executed when the task finishes unsuccessfully.
 */
- (void) sections:(CompletionBlock)completionBlock
          onError:(ErrorBlock)errorBlock{
    
    [self performRequestToServer:allSectionsURL
                       onSuccess:^(id json) {
                           if (json && [json[@"sections"] count] > 0) {
                               /// update BD
                               [Section createSections:json[@"sections"]];
                               
                               if (completionBlock) {
                                   completionBlock(YES);
                               }
                           }
                           else{
                               if (completionBlock) {
                                   completionBlock(NO);
                               }
                           }
                       } onFailure:^(NSError *error) {
                           if (errorBlock) {
                               errorBlock(error);
                           }
                       }];
}


/*!
 * @discussion Get section's info by section's ID.
 * @param sectionID The ID of the section ID to retrieve info for.
 * @param completion A block object to be executed when the task finishes successfully.
 * @param errorBlock A block object to be executed when the task finishes unsuccessfully.
 */
- (void) sectionDetails:(NSNumber *)sectionID
           onCompletion:(CompletionBlock)completionBlock
                onError:(ErrorBlock)errorBlock{
    
    NSString *urlString = [NSString stringWithFormat:@"%@%@", sectionInfoURL, sectionID];
    [self performRequestToServer:urlString
                       onSuccess:^(id json) {
                           if (json) {
                               /// update BD
                               [SectionDetail createSectionDetail:json];
                               completionBlock(YES);
                           }
                           else{
                               if (completionBlock) {
                                   completionBlock(NO);
                               };
                           }
                       } onFailure:^(NSError *error) {
                           if (errorBlock) {
                               errorBlock(error);
                           }
                       }];
}
@end
