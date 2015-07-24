//
//  APITests.m
//  Innopolis
//
//  Created by Aleksey Novikov on 19/05/15.
//  Copyright (c) 2015 Aleksey Novikov. All rights reserved.
//
//
// We use TestSemaphor here that is a class developed by fellow
// author Marin Todorov that makes testing asynchronous block-based
// API calls much easier.
// Note: Here is Marin’s blog post about TestSemaphor – you will go over
// it below during the unit test discussion:
// http://www.touch-code-magazine.com/unit-testing-for-blocks-based-apis/

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>

/// To test asynchronous requests
#import "TestSemaphor.h"

/// network
#import "NetwokManager.h"

#pragma mark -
@interface APITests : XCTestCase

@end


@implementation APITests
- (void)setUp
{
    [super setUp];
}

- (void)tearDown
{
    [super tearDown];
}
#pragma mark - Testing API methods
/*!
 * @discussion Test that a request can return a nil json and no any error,
 * just a  response header. Avoiding a regression bug in future.
 *  this request is the first sent to server.
 */
- (void) testPerformRequestToServer
{
    __block NSError *_error = nil;
    __block NSDictionary *_json = nil;
    NSString *semaphoreKey = @"PerformRequestToServer";
    
    [[NetwokManager sharedNetworkManager]
    performRequestToServer:allSectionsURL onSuccess:^(id json) {
        _json = json;
        [[TestSemaphor sharedInstance] lift:semaphoreKey];

    } onFailure:^(NSError *error) {
        _error = error;
        [[TestSemaphor sharedInstance] lift:semaphoreKey];
    }];
    
    [[TestSemaphor sharedInstance] waitForKey:semaphoreKey];
    
    NSString *errorMsg = [NSString stringWithFormat:@"The error while testing the main request to server\
                          must be nil, that would mean that there isn't any error:::%@", [_error localizedDescription]];
    XCTAssertNil(_error, @"%@", errorMsg);
    XCTAssertNotNil(_json, @"Fetching sections fails");
}

/*!
 * @discussion Test fetching all sections from server
 */
- (void) testSectionsRequest{
    __block NSError *_error = nil;
    __block BOOL _success = NO;
    NSString *semaphoreKey = @"sectionRequest";
    
    [[NetwokManager sharedNetworkManager] sections:^(BOOL success) {
        _success = success;
        [[TestSemaphor sharedInstance] lift:semaphoreKey];
    } onError:^(NSError *error) {
        _error = error;
        [[TestSemaphor sharedInstance] lift:semaphoreKey];
    }];
    
    [[TestSemaphor sharedInstance] waitForKey:semaphoreKey];
    
    NSString *errorMsg = [NSString stringWithFormat:@"The error while getting sections from server\
                          must be nil, that would mean that there isn't any error:::%@", [_error localizedDescription]];
    XCTAssertNil(_error, @"%@", errorMsg);
    XCTAssertTrue(_success, @"%@", errorMsg);
}




/*!
 * @discussion Test fetching info for one section from server
 */
- (void) testSectionInfoRequest{
    __block NSError *_error = nil;
    __block BOOL _success = NO;
    NSString *semaphoreKey = @"sectionInfoRequest";
    
    [[NetwokManager sharedNetworkManager]
     sectionDetails:@40
     onCompletion:^(BOOL success) {
         _success = success;
         [[TestSemaphor sharedInstance] lift:semaphoreKey];
     } onError:^(NSError *error) {
         _error = error;
         [[TestSemaphor sharedInstance] lift:semaphoreKey];
     }];
    
    [[TestSemaphor sharedInstance] waitForKey:semaphoreKey];
    
    NSString *errorMsg = [NSString stringWithFormat:@"The error while getting section's info from server\
                          must be nil, that would mean that there isn't any error:::%@", [_error localizedDescription]];
    XCTAssertNil(_error, @"%@", errorMsg);
    XCTAssertTrue(_success, @"%@", errorMsg);
}


/*!
 * @discussion Test fetching all speakers from server
 */
- (void) testSpeakersRequest{
    __block NSError *_error = nil;
    __block BOOL _success = NO;
    NSString *semaphoreKey = @"speakersRequest";
    
    [[NetwokManager sharedNetworkManager] speakers:^(BOOL success) {
        _success = success;
        [[TestSemaphor sharedInstance] lift:semaphoreKey];
    } onError:^(NSError *error) {
        _error = error;
        [[TestSemaphor sharedInstance] lift:semaphoreKey];
    }];
    
    [[TestSemaphor sharedInstance] waitForKey:semaphoreKey];
    
    NSString *errorMsg = [NSString stringWithFormat:@"The error while getting speakers from server\
                          must be nil, that would mean that there isn't any error:::%@", [_error localizedDescription]];
    XCTAssertNil(_error, @"%@", errorMsg);
    XCTAssertTrue(_success, @"%@", errorMsg);
}
@end
