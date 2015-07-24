//
//  NavigineSDK.h
//  NavigineSDK
//
//  Created by Pavel Tychinin on 22.09.14.
//  Copyright (c) 2014 Navigine. All rights reserved.
//


#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>


/**
 *  Structure with results of Navigation
 */
typedef struct _NavigationResults
{
  int    outLocation;    // location id of your position
  int    outSubLocation; // sublocation id of your position
  double X;              // X coordinate of your position (m).
  double Y;              // Y coordinate of your position (m)
  double Yaw;            // yaw angle(radians)
  double R;              // Accuracy radius
  int    ErrorCode;      // Error code. If 0 - all is good.
}NavigationResults;

/**
 *  Struvture with vertex content
 */
@interface Vertex : NSObject

@property (assign, nonatomic) int subLocation;
@property (assign, nonatomic) double x;
@property (assign, nonatomic) double y;

@end


/**
 *  Structure with push content
 */
@interface Push : NSObject

@property(nonatomic, strong) NSString *pushTitle;   //title of push
@property(nonatomic, strong) NSString *pushContent; //content of push
@property(nonatomic, strong) NSString *pushImage;   //url path to image of push

@end


/**
 *  Structure with venues content
 */
@interface Venue : NSObject

@property(nonatomic, assign) NSInteger id;
@property(nonatomic, assign) NSInteger locationId;
@property(nonatomic, assign) NSInteger sublocationId;  // sublocation id of venue
@property(nonatomic, strong) NSString *name;      // name of venue
@property(nonatomic, assign) NSInteger coordX;
@property(nonatomic, assign) NSInteger coordY;
@property(nonatomic, strong) NSNumber *realX;     // X coordinate of venue (m)
@property(nonatomic, strong) NSNumber *realY;     // Y coordinate of venue (m)
@property(nonatomic, strong) NSNumber *kx;
@property(nonatomic, strong) NSNumber *ky;
@property(nonatomic, strong) NSString *image;     // url path to image of venue content
@property(nonatomic, strong) NSString *phone;     // phone number of venue
@property(nonatomic, strong) NSString *descript;  // other info about venue
@property(nonatomic, assign) NSInteger category;

@end


/**
 *  Structure with category content
 */
@interface Categories : NSObject

@property (nonatomic, assign) NSInteger id;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *image;
@property (nonatomic, strong) NSMutableSet *venues;

@end

/**
 *  Protocol is used for getting pushes in timeout
 */
@protocol NavigineCoreDelegate;

@interface NavigineCore : NSObject{
  BOOL STRICT_MODE;
}

@property (nonatomic, weak) NSObject <NavigineCoreDelegate> *delegate;

- (void) downloadContent :(NSString *)userHash
                location :(NSString *)location
             forceReload :(BOOL) forced
            processBlock :(void(^)(NSInteger loadProcess))processBlock
            successBlock :(void(^)(NSString *success))successBlock
               failBlock :(void(^)(NSString *error))failBlock;

/**
 *  Function is used for starting Navigine service.
 */
- (void) startNavigine;

/**
 *  Function is used for forced termination of Navigine service.
 */
- (void) stopNavigine;

/**
 *  Function is used for getting result of navigation
 *
 *  @return structure NavigationResults.
 */
- (NavigationResults) getNavigationResults;


/**
 *  Function is used for creating a content download process from the server.
 Download is done in a separate thread in the non-blocking mode.
 Function startLocationLoader doesn't wait until download is finished and returns immediately.
 *
 *  @param userHash   userID ID from web site.
 *
 *  @param location location location name from web site.
 *
 *  @param forced   the boolean flag.
 If set, the content data would be loaded even if the same version has been downloaded already earlier.
 If flag is not set, the download process compares the current downloaded version with the last version on the server.
 If server version equals to the current downloaded version, the re-downloading is not done.
 *
 *  @return the download process identifier. This number is used further for checking the download process state and for download process terminating.
 */
- (int)startLocationLoader :(NSString *)userHash :(NSString*) location :(BOOL) forced;

/**
 *  Function is used for checking the download process state and progress.
 *
 *  @param loaderId download process identifier.
 *
 *  @return Integer number — the download process state:
 •	values in interval [0, 99] mean that download is in progress.
 In that case the value shows the download progress percentage;
 •	value 100 means that download has been successfully finished;
 •	other values mean that download process is impossible for some reason.
 */
- (int) checkLocationLoader :(int)loaderId;

/**
 *  Function is used for forced termination of download process which has been started earlier.
 Function should be called when download process is finished (successfully or not) or by a timeout.
 *
 *  @param loaderId download process identifier.
 */
- (void) stopLocationLoader :(int)loaderId;

/**
 *  Function is used for checking the download process state and progress.
 *
 *  @param location - location location name from web site.
 *
 *  @return	true, if archive was loaded successfully;
 *         false, if archive can't be loaded (e.g. invalid archive file).
 */
- (BOOL) loadArchive: (NSString *)location;

/**
 *  Function is used for making route from one position to other.
 *
 *  @param id1 sublocation id of start point.
 *  @param x1  X coordinate of start point.
 *  @param y1  Y coordinate of start point.
 *  @param id2 sublocation id of finish point.
 *  @param x2  X coordinate of finish point.
 *  @param y2  Y coordinate of finish point.
 *
 *  @return NSArray object – array with Vertex structures.
 */
- (NSArray *) makeRoute:(int)id1 :(double)x1 :(double)y1 :(int)id2 :(double)x2 :(double)y2;

/**
 *  Function is used for cheking pushes from web site
 */
- (void) startRangePushes;

- (id) initWithUUIDString :(NSString *)uuid;

/**
 *  Function is used for getting image from zip (SVG, PNG)
 *
 *  @param index  the ordinal sublocation in admin panel
 *  @param imData image data
 *
 *  @return error (0 if ok)
 */
- (int) getSVGImageByIndex :(NSInteger)index :(NSData **)imData;
- (int) getPNGImageByIndex :(NSInteger)index :(NSData **)imData;

/**
 *  Function is used for getting image from zip (SVG, PNG)
 *
 *  @param index  sublocation id
 *  @param imData image data
 *
 *  @return error (0 if ok)
 */
- (int) getSVGImageById :(NSInteger)id :(NSData **)imData;
- (int) getPNGImageById :(NSInteger)id :(NSData **)imData;

- (int) getCurrentVersion:(NSInteger *)currentVersion;

- (int) getWidthAndHeight: (double*)width :(double*)height :(int)sublocId :(NSString*)zip_path;



- (NSString *) startSaveLogToFile;
- (void) stopSaveLogToFile;
- (void) deleteLogs;

- (void) setUserHash :(NSString *)userHash;
- (int) setNavigateByLog :(NSString *)logFile;

- (void) getVenues;

- (int) getSublocNum: (NSString *)zipPath :(NSDictionary **)sublocId;
- (int) getImageFromZip :(NSInteger) floor :(NSString *) zipPath :(NSData **) imData;
- (int) getLocationId :(NSString *)zipPath :(NSInteger *)locationId;


@end

@protocol NavigineCoreDelegate <NSObject>
@optional
/**
 *  Function is used for getting result of navigation when app in background or app not running.
 If application is in the background function is called once per second.
 If application not run function is called by OS signal.
 More info: http://developer.radiusnetworks.com/2013/11/13/ibeacon-monitoring-in-the-background-and-foreground.html
 
 *
 *  @param navigationResults structure NavigationResults.
 */
- (void) navigationResultsInBackground :(NavigationResults)navigationResults;

/**
 *  Tells the delegate that push in range. Function is called by the timeout of the web site.
 *
 *  @param title   title of push.
 *  @param content content of push.
 *  @param image   url path to image of push.
 */
- (void) didRangePushWithTitle :(NSString *)title
                       Content :(NSString *)content
                         Image :(NSString *)image;

/**
 *  Tells the delegate that push in range. Function is called by the timeout of the web site.
 *
 *  @param title   title of push.
 *  @param content content of push.
 *  @param image   url path to image of push.
 *  @param id      push id.
 */
- (void) didRangePushWithTitle :(NSString *)title
                       Content :(NSString *)content
                         Image :(NSString *)image
                            Id :(NSInteger) id;
/**
 *  Function is used for checking venues from web site.
 *
 *  @param venues     NSArray object – array with Venue structures.
 *  @param categories NSArray object – array with Categories structures.
 */
- (void) didRangeVenues :(NSArray *)venues :(NSArray *)categories;


- (void) didRangeBeacons:(NSArray *)beacons;
- (void) getLattitude: (double)lattitude Longitude:(double)longitude;
- (void) didRangeSensors:(NSArray *)sensors;
@end
