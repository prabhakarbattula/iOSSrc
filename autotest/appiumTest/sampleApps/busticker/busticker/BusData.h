//
//  BusData.h
//  busticker
//
//  Created by Mrudul Pendharkar on 17/09/14.
//  Copyright (c) 2014 SimpleSoln. All rights reserved.
//

#import <Foundation/Foundation.h>
/*
@protocol ResultSetChanged <NSObject>

-(void)resultSetChanged;

@end
*/

@interface BusData : NSObject

//@property (strong, atomic)NSMutableArray* observers;
@property (strong, atomic) NSArray* lineQueryResults; // Results for given Line No.
@property (strong, atomic) NSArray* stopQueryResults; // Results for given Stop Code
@property (strong, atomic) NSArray* locationQueryResults;
@property (strong, atomic) NSArray* reverseGeoCodeResults;
@property (strong, atomic) NSArray* geoCodeResults;
@property (strong, atomic) NSArray* routeQueryResults;

+(instancetype)sharedBusDataManager;
-(NSString*)lineNameFromLineQueryResults:(NSUInteger)index;
-(NSDictionary*)lineDataFromLineQueryResults:(NSUInteger)index;
-(BOOL)belongsToLine :(NSString*)name;
-(NSArray*)stopDataFromGeoCodedResult;
-(NSString*)stopNameFromGeoCodedResult:(NSUInteger)index;

-(NSArray*) routeLegsAtIndex :(NSUInteger)index;

@end
