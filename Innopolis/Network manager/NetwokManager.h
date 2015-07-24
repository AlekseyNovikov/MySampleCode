//
//  NetwokManager.h
//  Innopolis
//
//  Created by Aleksey Novikov on 15/05/15.
//  Copyright (c) 2015 Aleksey Novikov. All rights reserved.
//

#import <Foundation/Foundation.h>
/// All Urls
#import "Urls.h"
/// Blocks
#import "Blocks.h"

@interface NetwokManager : NSObject

+ (instancetype) sharedNetworkManager;


@property (nonatomic, strong) NSURL *baseURL;
@property (readonly, nonatomic, strong) NSURLSession *session;
#pragma mark - Requests
/*!
 * @discussion Creates an HTTP GET request for the specified URL, then calls a handler upon completion.
 * @param urlString The http or https URL to be retrieved.
 * @param completionBlock A block object to be executed when the task finishes successfully. It's executed on main thread.
 * @param errorBlock A block object to be executed when the task finishes unsuccessfully. It's executed on main thread.
 */
- (void) performRequestToServer:(NSString *)urlString
                      onSuccess:(JsonCompletionBlock)completionBlock
                      onFailure:(ErrorBlock)errorBlock;

/*!
 * @discussion Creates and runs an `NSURLSessionDataTask` with a `POST` request.
 * @param URLString The URL string used to create the request URL.
 * @param parameters The parameters to be encoded according to the serialization method.
 * @param onSuccess A block object to be executed when the task finishes successfully.
 * This block has no return value and takes two arguments: the data task,
 * and the response object created by the client response serializer.
 * @param onFailure A block object to be executed when the task finishes unsuccessfully,
 * or that finishes successfully, but encountered an error while parsing
 * the response data. This block has no return value and takes a two arguments:
 * the data task and the error describing the network or parsing error that occurred.
 */
- (void) POST:(NSString *)urlString
   parameters:(NSDictionary *)parameters
    onSuccess:(JsonCompletionBlock)completionBlock
    onFailure:(ErrorBlock)errorBlock;

- (void) preloadDatas;
@end




#pragma mark - Section
@interface NetwokManager (Sections)
/*!
 * @discussion Get all sections.
 * @param completion  A block object to be executed when the task finishes successfully.
 * @param errorBlock A block object to be executed when the task finishes unsuccessfully.
 */
- (void) sections:(CompletionBlock)completionBlock
          onError:(ErrorBlock)errorBlock;


/*!
 * @discussion Get section's info by section's ID.
 * @param sectionID The ID of the section ID to retrieve info for.
 * @param completion A block object to be executed when the task finishes successfully.
 * @param errorBlock A block object to be executed when the task finishes unsuccessfully.
 */
- (void) sectionDetails:(NSNumber *)sectionID
           onCompletion:(CompletionBlock)completionBlock
                onError:(ErrorBlock)errorBlock;
@end

#pragma mark - Speakers
@interface NetwokManager (Speakers)
/*!
 * @discussion Get all speakers.
 * @param completion  A block object to be executed when the task finishes successfully.
 * @param errorBlock A block object to be executed when the task finishes unsuccessfully.
 */
- (void) speakers:(CompletionBlock)completionBlock
          onError:(ErrorBlock)errorBlock;
@end

#pragma mark - Schedule
@interface NetwokManager (Schedule)
/*!
 * @discussion Get the schedule table.
 * @param completion  A block object to be executed when the task finishes successfully.
 * @param errorBlock A block object to be executed when the task finishes unsuccessfully.
 */
- (void) schedule:(CompletionBlock)completionBlock
          onError:(ErrorBlock)errorBlock;
@end

#pragma mark - Navigine
@interface NetwokManager (Navigine)

- (void) navigine:(CompletionBlock)completionBlock
          onError:(ErrorBlock)errorBlock;
@end

