//
//  BusTickerNetworking.h
//  busticker
//
//  Created by Mrudul Pendharkar on 05/09/14.
//  Copyright (c) 2014 SimpleSoln. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AFNetworking/AFHTTPSessionManager.h>

@interface BusTickerNetworking : AFHTTPSessionManager

+ (instancetype)sharedNetworkManager;
- (NSURLSessionDataTask*) requestLine :(NSString*)lineNo completion:(void (^)(NSArray *results, NSError* error))completion;
- (NSURLSessionDataTask*) requestStopInformation : (NSString*)stopShortCode completion:(void (^)(NSArray *results, NSError* error))completion;
- (NSURLSessionDataTask*) requestGeoCodeInformation : (NSString*)areaName completion:(void (^)(NSArray* results, NSError* error))completion;
- (NSURLSessionDataTask*) requestRoutingInformation : (NSString*)startStopCoordinates endStopCoordinates:(NSString*)endStopCoordinates Date:(NSString*)travelDate Time:(NSString*)travelTime completion:(void (^)(NSArray* results, NSError* error))completion;
@property (nonatomic, strong) NSString* rootURL;

@end
