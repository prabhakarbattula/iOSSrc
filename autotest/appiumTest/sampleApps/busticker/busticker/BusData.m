//
//  BusData.m
//  busticker
//
//  Created by Mrudul Pendharkar on 17/09/14.
//  Copyright (c) 2014 SimpleSoln. All rights reserved.
//

#import "BusData.h"

@interface BusData()

@end

@implementation BusData

+(instancetype)sharedBusDataManager
{
    static BusData* sharedBusData = nil;
    static dispatch_once_t onceToken = 0;
    dispatch_once(&onceToken,^{
        sharedBusData = [[BusData alloc]init];
    });
    return sharedBusData;
}

-(NSString*)lineNameFromLineQueryResults:(NSUInteger)index
{
    if (self.lineQueryResults) {
        NSDictionary* data = [self.lineQueryResults objectAtIndex:index];
        return [data objectForKey:@"name"];
    }
    return nil;
}

-(NSDictionary*)lineDataFromLineQueryResults:(NSUInteger)index
{
    if (self.lineQueryResults) {
        NSDictionary* data = [self.lineQueryResults objectAtIndex:index];
        return data;
    }
    return nil;
}

-(BOOL)belongsToLine :(NSString*)name
{
    BOOL flag = false;
    for (NSDictionary* lineDict in self.lineQueryResults) {
        if ([name isEqualToString:[lineDict objectForKey:@"name"]] ) {
            flag = true;
            break;
        }
    }    return flag;
}

-(NSArray*)stopDataFromGeoCodedResult
{
  /*  NSMutableArray* stopList = [[NSMutableArray alloc]init];
    if (self.geoCodeResults) {
        for (NSDictionary* geoCodeDict in self.geoCodeResults) {
            NSString* stopName = [geoCodeDict objectForKey:@"matchedName"];
            NSString* stopCoordinates = [geoCodeDict objectForKey:@"coords"];
            NSDictionary* stopData = [[NSDictionary alloc]initWithObjects:@[stopName,stopCoordinates,nil] forKeys:@[@"stopName",@"stopCoordinates"]];
            [stopList addObject:];
        }
        return stopList;
    }
    */return nil;
}

-(NSString*)stopNameFromGeoCodedResult:(NSUInteger)index
{
    if (self.geoCodeResults) {
        NSDictionary* data = [self.geoCodeResults objectAtIndex:index];
        return [data objectForKey:@"matchedName"];
    }
    return nil;
}

-(NSArray*) routeLegsAtIndex :(NSUInteger)index
{
    NSArray* route = [self.routeQueryResults objectAtIndex:index];
    NSDictionary* routeDict = route[0];
    return [routeDict objectForKey:@"legs"];
}

/*
-(NSDictionary*) routesAtIndex :(NSUInteger)index
{
    return [self.routeQueryResults objectAtIndex:index];
}
*/

@end
