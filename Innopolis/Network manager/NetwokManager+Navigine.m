//
//  NetwokManager+Navigine.m
//  ITOPK
//
//  Created by Aleksey Novikov on 27/05/15.
//  Copyright (c) 2015 Aleksey Novikov. All rights reserved.
//

#import "NetwokManager.h"

@implementation NetwokManager (Navigine)

- (void) navigine:(CompletionBlock)completionBlock
          onError:(ErrorBlock)errorBlock{
    NSURL *url = [NSURL URLWithString:archive relativeToURL:self.baseURL];
    
    __weak NetwokManager *weakSelf = self;
    NSURLSessionDownloadTask *downloadTask =
    [self.session
     downloadTaskWithURL:url
     completionHandler:^(NSURL *location, NSURLResponse *response, NSError *error) {
         NetwokManager *strongSelf = weakSelf;
         /// check if there is a server/connection error
         if (error)
         {
             DLog(@"error while perfoming request with url %@", archive);
             if (errorBlock) {
                 dispatch_async(dispatch_get_main_queue(), ^{
                     errorBlock(error);
                 });
             }
         }
         /// get the archive and save in documents dirrectory
         else{
             if (strongSelf) {
                 NSString *documentsPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
                 NSString *documentsDirectoryURL = [documentsPath stringByAppendingPathComponent:@"/Innopolis"];
                 NSString *documentURL = [documentsDirectoryURL stringByAppendingString:@"/Innopolis.zip"];
                 NSError *error;
                 if (![[NSFileManager defaultManager] fileExistsAtPath:documentsDirectoryURL]) {
                     [[NSFileManager defaultManager] createDirectoryAtPath:documentsDirectoryURL withIntermediateDirectories:NO attributes:nil error:&error];
                 }
                 NSData *archiveData = [NSData dataWithContentsOfURL:location];
                 [archiveData writeToFile:documentURL atomically:YES];
                 if ([[NSFileManager defaultManager] fileExistsAtPath:documentURL]){
                     completionBlock(YES);
                 }else {
                     completionBlock(NO);
                 }

             }
         }

     }];
    
    [downloadTask resume];
}

@end
