//
//  NetwokManager.m
//  Innopolis
//
//  Created by Aleksey Novikov on 15/05/15.
//  Copyright (c) 2015 Aleksey Novikov. All rights reserved.
//

#import "NetwokManager.h"



/// Constants
NSString * const ErrorDomain = @"ru.Innopolis";


@interface NetwokManager ()


@property (nonatomic, strong) NSURLSessionConfiguration *sessionConfiguration;
@property (nonatomic, strong) NSOperationQueue *operationQueue;
@property (readwrite, nonatomic, strong) NSURLSession *session;
@end



@implementation NetwokManager
{
    /// parameter responsible of network activity indicator
    __block NSUInteger _networkRequestNumber;
}


#pragma mark - Initialization
+(NetwokManager *)sharedNetworkManager {
    static id _sharedManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        NSURL *baseUrl = nil;
        baseUrl = [NSURL URLWithString:urlAPIBaseURL];        
        _sharedManager = [[NetwokManager alloc] initWithBaseURL:baseUrl];
    });
    
    return _sharedManager;
}



- (instancetype)initWithBaseURL:(NSURL *)url
{
    self = [super init];
    if (!self)
    {
        return nil;
    }
    _networkRequestNumber = 0;
    self.sessionConfiguration = [NSURLSessionConfiguration defaultSessionConfiguration];
    self.sessionConfiguration.timeoutIntervalForRequest = 30.0;
    self.sessionConfiguration.timeoutIntervalForResource = 60.0;
    self.sessionConfiguration.HTTPMaximumConnectionsPerHost = 1;
    self.operationQueue = [[NSOperationQueue alloc] init];
    self.operationQueue.maxConcurrentOperationCount = 1;
    self.session = [NSURLSession sessionWithConfiguration:self.sessionConfiguration
                                                 delegate:nil
                                            delegateQueue:self.operationQueue];
    self.baseURL = url;
    ///set caches directory
//    [self setupCache];
    
    return self;
}


/*!
 * @discussion Setup cache
 */
- (void) setupCache
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    if (paths.count > 0)
    {
        NSString *cacheDirectory = [paths  objectAtIndex:0];
        NSString* cacheDirPath = [cacheDirectory stringByAppendingPathComponent:@"CacheDirectory"];
        NSURLCache *cacheUrl = [[NSURLCache alloc] initWithMemoryCapacity:4 * 1024 * 1024
                                                             diskCapacity:100 * 1024 * 1024
                                                                 diskPath:cacheDirPath];
        [NSURLCache setSharedURLCache:cacheUrl];
    }
}


#pragma mark - Requests
/*!
 * @discussion Creates an HTTP GET request for the specified URL, then calls a handler upon completion.
 * @param urlString The http or https URL to be retrieved.
 * @param completionBlock A block object to be executed when the task finishes successfully. It's executed on main thread.
 * @param errorBlock A block object to be executed when the task finishes unsuccessfully. It's executed on main thread.
 */
- (void) performRequestToServer:(NSString *)urlString
                      onSuccess:(JsonCompletionBlock)completionBlock
                      onFailure:(ErrorBlock)errorBlock{
    /// show network indicator
    [self hideNetworkActivity:NO];
    
    NSURL *url = [NSURL URLWithString:urlString relativeToURL:self.baseURL];
    
    __weak NetwokManager *weakSelf = self;
    NSURLSessionDataTask *dataTask =
    [self.session
     dataTaskWithURL:url
     completionHandler:^(NSData *data, NSURLResponse *response, NSError *connectionError) {
         NetwokManager *strongSelf = weakSelf;
         /// check if there is a server/connection error
         if (connectionError)
         {
             DLog(@"error while perfoming request with url %@", urlString);
             if (errorBlock) {
                 dispatch_async(dispatch_get_main_queue(), ^{
                     errorBlock(connectionError);
                 });
             }
         }
         /// get the server response and parse it
         else{
             
             if (strongSelf) {
                 NSHTTPURLResponse* httpResponse = (NSHTTPURLResponse*)response;
                 id decodedResponse = [strongSelf responseFromServer:data
                                                        httpResponse:httpResponse
                                                          methodName:@"performRequestToServer"];
                 
                 if ([decodedResponse isKindOfClass:[NSError class]])
                 {
                     if (errorBlock) {
                         dispatch_async(dispatch_get_main_queue(), ^{
                             errorBlock(decodedResponse);
                         });
                     }
                 }
                 else if ([decodedResponse isKindOfClass:[NSDictionary class]] || [decodedResponse isKindOfClass:[NSArray class]] )
                 {
                     /// give outside the response
                     if (completionBlock) {
                         dispatch_async(dispatch_get_main_queue(), ^{
                             completionBlock(decodedResponse);
                         });
                     }
                 }
             }
             
         }
         
         /// stop the network activity indicator
         if (strongSelf)
         {
             [strongSelf hideNetworkActivity:YES];
         }
    }];
    [dataTask resume];
}


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
    onFailure:(ErrorBlock)errorBlock{
    [self hideNetworkActivity:NO];
    
    /// build the request
    NSURL *url = [NSURL URLWithString:urlString relativeToURL:self.baseURL];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:url];
    [request setHTTPMethod:@"POST"];
    [request setURL:url];
    [request setCachePolicy:NSURLRequestReloadIgnoringLocalCacheData];
    
    
    /// setup parameters
    NSString *charset = (NSString *)CFStringConvertEncodingToIANACharSetName(CFStringConvertNSStringEncodingToEncoding(NSUTF8StringEncoding));
    NSString *POSTBoundary = @"Innopolis_sf1536Ghs828h3vs";
    [request setValue:[NSString stringWithFormat:@"multipart/form-data; charset=%@; boundary=%@", charset, POSTBoundary]
   forHTTPHeaderField:@"Content-Type"];
    /// add HTTP body
    [request setHTTPBody:[self _buildMultipartFormDataPostBody:POSTBoundary
                                                    parameters:parameters]];
    
    
    /// perform a request to server
    __weak NetwokManager *weakSelf = self;
    NSURLSessionDataTask *dataTask =
    [self.session
     dataTaskWithRequest:request
     completionHandler:^(NSData *data, NSURLResponse *response, NSError *connectionError) {
         
         NetwokManager *strongSelf = weakSelf;
         
         /// error when sending request server
         if (connectionError)
         {
             DLog(@"error while sending with the url for the POST request: %@", connectionError);
             errorBlock(connectionError);
         }
         else{
             if (strongSelf) {
                 NSHTTPURLResponse* httpResponse = (NSHTTPURLResponse*)response;
                 id decodedResponse = [strongSelf responseFromServer:data
                                                        httpResponse:httpResponse
                                                          methodName:@"performRequestToServer"];
                 
                 if ([decodedResponse isKindOfClass:[NSError class]])
                 {
                     if (errorBlock) {
                         dispatch_async(dispatch_get_main_queue(), ^{
                             errorBlock(decodedResponse);
                         });
                     }
                 }
                 else if ([decodedResponse isKindOfClass:[NSDictionary class]] || [decodedResponse isKindOfClass:[NSArray class]] )
                 {
                     /// give outside the response
                     if (completionBlock) {
                         dispatch_async(dispatch_get_main_queue(), ^{
                             completionBlock(decodedResponse);
                         });
                     }
                 }
             }
         }

         /// stop the network activity indicator
         if (strongSelf)
         {
             [strongSelf hideNetworkActivity:YES];
         }
     }];
    
    [dataTask resume];
}


#pragma mark - Preload datas
- (void) preloadDatas{
    [self sections:^(BOOL success) {
        DLog("Succes sections");
    } onError:^(NSError *error) {
        DLog(@"Error: %@", error.localizedDescription);
    }];
    [self speakers:^(BOOL success) {
        DLog("Succes speakers");
    } onError:^(NSError *error) {
        DLog(@"Error: %@", error.localizedDescription);
    }];
    [self schedule:^(BOOL success) {
        DLog("Succes schedule");
    } onError:^(NSError *error) {
        DLog(@"Error: %@", error.localizedDescription);
    }];
}

#pragma mark - Helper methods
#pragma mark -
/*!
 * @discussion Show/hide the network  indicator
 * @param hidden If YES the indicator must be hidden
 */
- (void) hideNetworkActivity:(BOOL) hidden
{
    if (hidden)
    {
        _networkRequestNumber--;
        if (_networkRequestNumber <= 0)
        {
            _networkRequestNumber = 0;
            dispatch_async(dispatch_get_main_queue(), ^{
                [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
            });
        }
    }
    else
    {
        [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
        _networkRequestNumber++;
    }
}

/*!
 * @discussion build the multipart form data body for the post request
 * @param HTTPRequestBodyBoundary the boundary
 * @param parameters an array of dictionaries in form of:
 * Content-Disposition: form-data; name=”meta”
 * Content-Type: application/json
 * {
 *  _trackID”: “3B1B5C50-0332-4549-864F-954F2794947E”,
 *  “name”: “photo1”,
 * }
 */
- (NSData *) _buildMultipartFormDataPostBody: (NSString *) HTTPRequestBodyBoundary
                                parameters:(NSDictionary *) parameters
{
    
    NSMutableData *HTTPRequestBody = [NSMutableData data];
    [HTTPRequestBody appendData:[[NSString stringWithFormat:@"--%@\r\n",HTTPRequestBodyBoundary] dataUsingEncoding:NSUTF8StringEncoding]];
    NSMutableArray *HTTPRequestBodyParts = [NSMutableArray array];
    
    // Collecting HTTP Request body parts
    for (NSDictionary *key in parameters.allKeys)
    {
        NSMutableData *someData = [[NSMutableData alloc] init];
        [someData appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"%@\"\r\n\r\n", key] dataUsingEncoding:NSUTF8StringEncoding]];
        [someData appendData:[parameters[key] dataUsingEncoding:NSUTF8StringEncoding]];
        
        [HTTPRequestBodyParts addObject:someData];
    }
    NSMutableData *resultingData = [NSMutableData data];
    NSUInteger count = [HTTPRequestBodyParts count];
    [HTTPRequestBodyParts enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        [resultingData appendData:obj];
        if (idx != count - 1) {
            [resultingData appendData:[[NSString stringWithFormat:@"\r\n\r\n--%@\r\n", HTTPRequestBodyBoundary] dataUsingEncoding:NSUTF8StringEncoding]];
        }
    }];
    [HTTPRequestBody appendData:resultingData];
    
    // Add the closing -- to the POST Form
    [HTTPRequestBody appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n", HTTPRequestBodyBoundary] dataUsingEncoding:NSUTF8StringEncoding]];
    return HTTPRequestBody;
}
#pragma mark - Errors
/*!
 * @discussion Parse the response from server as a json returned file
 * @param data Data returned by the server
 * @param httpResponse the http response from server
 * @return the parsed answer
 */
- (id) responseFromServer:(NSData *)data
             httpResponse:(NSHTTPURLResponse*) httpResponse
               methodName:(NSString *)methodName
{
    NSError *jsonError = nil;
    NSDictionary *json = nil;
    /// if there is data return it as json
    if (data)
    {
        json = [NSJSONSerialization JSONObjectWithData:data
                                               options:NSJSONReadingMutableContainers
                                                 error:&jsonError];
    }
    /// error while converting response to json
    if (jsonError)
    {
        DLog(@"error while trying to convert response from server to json in %@ request", methodName);
        return jsonError;
    }
    /// error from server with a description of the error
    else if([httpResponse statusCode] > 400)
    {
        DLog(@"error from server(%@ request)", methodName);
        NSString *description = nil;
        if (json[@"error"])
        {
            description = json[@"error"];
        }
        else
        {
            description = [NSHTTPURLResponse
                           localizedStringForStatusCode:[httpResponse statusCode]];
        }
        NSError *serverError = [self errorWithCode:[httpResponse statusCode]
                                       description:description];
        return serverError;
    }
    /// success
    return json;
}

/*!
 * @discussion Build a NSError object (it's particulary
 * useful when the error is only present it the response header)
 * @param StatusCode the code of the error
 * @return Description the description of the error
 */
- (NSError *) errorWithCode:(NSUInteger) statusCode
                description:(NSString *) description
{
    NSError *error =  [NSError errorWithDomain:ErrorDomain
                                          code:statusCode
                                      userInfo:@
                       {
                           NSLocalizedDescriptionKey        : description,
                       }];
    
    return error;
    
}
@end
