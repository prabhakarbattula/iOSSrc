//
//  BusTickerNetworking.m
//  busticker
//
//  Created by Mrudul Pendharkar on 05/09/14.
//  Copyright (c) 2014 SimpleSoln. All rights reserved.
//

#import "BusTickerNetworking.h"
#import <AFNetworking/AFHTTPRequestOperationManager.h>

@interface BusTickerNetworking()

@end

@implementation BusTickerNetworking


+(instancetype) sharedNetworkManager
{
    static BusTickerNetworking* sharedManager = nil;
    static dispatch_once_t onceToken = 0;
    dispatch_once(&onceToken,^{
        NSURL* baseURL = [NSURL URLWithString:@"http://api.publictransport.tampere.fi/prod"];
        
        NSURLSessionConfiguration *config = [NSURLSessionConfiguration defaultSessionConfiguration];
        [config setHTTPAdditionalHeaders:@{ @"User-Agent" : @"BusTicker iOS 1.0"}];
        
        sharedManager = [[BusTickerNetworking alloc]initWithBaseURL:baseURL sessionConfiguration:config];

        sharedManager.responseSerializer = [AFJSONResponseSerializer serializer];
        //@"application/json", @"text/json", @"text/javascript", @"text/html",@text/plain
        sharedManager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/plain", @"text/html", @"application/json", nil];
    });
    return sharedManager;
}

-(NSURLSessionDataTask*) requestLine :(NSString*)lineNo completion:(void (^)(NSArray *results, NSError* error))completion{
//    NSString* requestURL = @"request=lines&user=mrudulpen&pass=@Metabusticker&query=3";
    NSDictionary *params = @{@"request":@"lines",@"user": @"mrudulpen",@"pass":@"@Metabusticker",@"query":lineNo};
    
    NSLog(@"%@",params);
  
    NSString* url = [self.baseURL absoluteString];
//    NSURLSessionDataTask* dataTask = [self GET: @"http://api.publictransport.tampere.fi/prod/?request=lines&user=mrudulpen&pass=@Metabusticker&query=3"  parameters:nil success:^(NSURLSessionDataTask *task, id responseObject) {
    NSURLSessionDataTask* dataTask = [self GET:url parameters:params
                                        success:^(NSURLSessionDataTask *task, id responseObject) {
        NSLog(@"Success");
        NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)task.response;
        if (httpResponse.statusCode == 200) {
            dispatch_async(dispatch_get_main_queue(), ^{
                completion(responseObject, nil);
            });
        } else {
            dispatch_async(dispatch_get_main_queue(), ^{
                completion(nil, nil);
            });
            NSLog(@"Received: %@", responseObject);
            NSLog(@"Received HTTP %d", httpResponse.statusCode);
        }
    }failure:^(NSURLSessionDataTask *task, NSError *error){
        NSLog(@"Failure");
        dispatch_async(dispatch_get_main_queue(), ^{
            completion(nil, error);
        });
    }];
    
    return dataTask;
    
}

-(NSURLSessionDataTask*) requestLocation :(NSString*)lat longitude:(NSString*)longi completion:(void (^)(NSArray *results, NSError* error))completion{
/*    NSString* stringURL = @"http://api.publictransport.tampere.fi/prod/?user=mrudulpen&pass=@Metabusticker&request=reverse_geocode&coordinate=3327335,6825367&limit=30&radius=100&result_contains=stop";
  */
    NSString* location =[[NSString alloc ]initWithFormat:@"%@,%@",lat,longi ];
    NSDictionary *params = @{@"request":@"reverse_geocode",@"user": @"mrudulpen",@"pass":@"@Metabusticker",@"coordinate":location, @"radius":@"100", @"result_contains":@"stop"};
    
    NSLog(@"%@",params);
    
    NSString* url = [self.baseURL absoluteString];
    //    NSURLSessionDataTask* dataTask = [self GET: @"http://api.publictransport.tampere.fi/prod/?request=lines&user=mrudulpen&pass=@Metabusticker&query=3"  parameters:nil success:^(NSURLSessionDataTask *task, id responseObject) {
    NSURLSessionDataTask* dataTask = [self GET:url parameters:params
                                       success:^(NSURLSessionDataTask *task, id responseObject) {
                                           NSLog(@"Success");
                                           NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)task.response;
                                           if (httpResponse.statusCode == 200) {
                                               dispatch_async(dispatch_get_main_queue(), ^{
                                                   completion(responseObject, nil);
                                               });
                                           } else {
                                               dispatch_async(dispatch_get_main_queue(), ^{
                                                   completion(nil, nil);
                                               });
                                               NSLog(@"Received: %@", responseObject);
                                               NSLog(@"Received HTTP %d", httpResponse.statusCode);
                                           }
                                       }failure:^(NSURLSessionDataTask *task, NSError *error){
                                           NSLog(@"Failure");
                                           dispatch_async(dispatch_get_main_queue(), ^{
                                               completion(nil, error);
                                           });
                                       }];
    
    return dataTask;
    
}

-(NSURLSessionDataTask*) requestSearch :(NSString*)lineNo completion:(void (^)(NSArray *results, NSError* error))completion{
    //    NSString* requestURL = @"request=lines&user=mrudulpen&pass=@Metabusticker&query=3";
    NSDictionary *params = @{@"request":@"lines",@"user": @"mrudulpen",@"pass":@"@Metabusticker",@"query":lineNo};
    
    NSLog(@"%@",params);
    
    NSString* url = [self.baseURL absoluteString];
    //    NSURLSessionDataTask* dataTask = [self GET: @"http://api.publictransport.tampere.fi/prod/?request=lines&user=mrudulpen&pass=@Metabusticker&query=3"  parameters:nil success:^(NSURLSessionDataTask *task, id responseObject) {
    NSURLSessionDataTask* dataTask = [self GET:url parameters:params
                                       success:^(NSURLSessionDataTask *task, id responseObject) {
                                           NSLog(@"Success");
                                           NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)task.response;
                                           if (httpResponse.statusCode == 200) {
                                               dispatch_async(dispatch_get_main_queue(), ^{
                                                   completion(responseObject, nil);
                                               });
                                           } else {
                                               dispatch_async(dispatch_get_main_queue(), ^{
                                                   completion(nil, nil);
                                               });
                                               NSLog(@"Received: %@", responseObject);
                                               NSLog(@"Received HTTP %d", httpResponse.statusCode);
                                           }
                                       }failure:^(NSURLSessionDataTask *task, NSError *error){
                                           NSLog(@"Failure");
                                           dispatch_async(dispatch_get_main_queue(), ^{
                                               completion(nil, error);
                                           });
                                       }];
    
    return dataTask;
    
}

//    http://api.publictransport.tampere.fi/prod/?request=stop&code=Vanha&format=xml
- (NSURLSessionDataTask*) requestStopInformation : (NSString*)stopShortCode completion:(void (^)(NSArray *results, NSError* error))completion{
    //    NSString* requestURL = @"request=lines&user=mrudulpen&pass=@Metabusticker&query=3";
    NSDictionary *params = @{@"request":@"stop",@"user": @"mrudulpen",@"pass":@"@Metabusticker",@"code":stopShortCode};
    
    NSLog(@"%@",params);
    
    NSString* url = [self.baseURL absoluteString];
    //    NSURLSessionDataTask* dataTask = [self GET: @"http://api.publictransport.tampere.fi/prod/?request=lines&user=mrudulpen&pass=@Metabusticker&query=3"  parameters:nil success:^(NSURLSessionDataTask *task, id responseObject) {
    NSURLSessionDataTask* dataTask = [self GET:url parameters:params
                                       success:^(NSURLSessionDataTask *task, id responseObject) {
                                           NSLog(@"Success");
                                           NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)task.response;
                                           if (httpResponse.statusCode == 200) {
                                               dispatch_async(dispatch_get_main_queue(), ^{
                                                   completion(responseObject, nil);
                                               });
                                           } else {
                                               dispatch_async(dispatch_get_main_queue(), ^{
                                                   completion(nil, nil);
                                               });
                                               NSLog(@"Received: %@", responseObject);
                                               NSLog(@"Received HTTP %ld", (long)httpResponse.statusCode);
                                           }
                                       }failure:^(NSURLSessionDataTask *task, NSError *error){
                                           NSLog(@"Failure");
                                           dispatch_async(dispatch_get_main_queue(), ^{
                                               completion(nil, error);
                                           });
                                       }];
    
    return dataTask;
}

- (NSURLSessionDataTask*) requestGeoCodeInformation : (NSString*)areaName completion:(void (^)(NSArray* results, NSError* error))completion
{
    NSDictionary *params = @{@"request":@"geocode",@"user": @"mrudulpen",@"pass":@"@Metabusticker",@"key":areaName,@"loc_types":@"stop"};
    
    NSLog(@"%@",params);
    
    NSString* url = [self.baseURL absoluteString];
    //    NSURLSessionDataTask* dataTask = [self GET: @"http://api.publictransport.tampere.fi/prod/?request=lines&user=mrudulpen&pass=@Metabusticker&query=3"  parameters:nil success:^(NSURLSessionDataTask *task, id responseObject) {
    NSURLSessionDataTask* dataTask = [self GET:url parameters:params
                                       success:^(NSURLSessionDataTask *task, id responseObject) {
                                           NSLog(@"Success");
                                           NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)task.response;
                                           if (httpResponse.statusCode == 200) {
                                               dispatch_async(dispatch_get_main_queue(), ^{
                                                   completion(responseObject, nil);
                                               });
                                           } else {
                                               dispatch_async(dispatch_get_main_queue(), ^{
                                                   completion(nil, nil);
                                               });
                                               NSLog(@"Received: %@", responseObject);
                                               NSLog(@"Received HTTP %ld", (long)httpResponse.statusCode);
                                           }
                                       }failure:^(NSURLSessionDataTask *task, NSError *error){
                                           NSLog(@"Failure");
                                           dispatch_async(dispatch_get_main_queue(), ^{
                                               completion(nil, error);
                                           });
                                       }];
    
    return dataTask;
}

- (NSURLSessionDataTask*) requestRoutingInformation : (NSString*)startStopCoordinates endStopCoordinates:(NSString*)endStopCoordinates Date:(NSString*)travelDate Time:(NSString*)travelTime completion:(void (^)(NSArray* results, NSError* error))completion{

    NSDictionary *params = @{@"request":@"route",@"user": @"mrudulpen",@"pass":@"@Metabusticker",@"from":startStopCoordinates,@"to":endStopCoordinates,@"date":travelDate,@"time":travelTime,@"loc_types":@"stop",@"transport_types":@"bus"};
    
    NSLog(@"%@",params);
    
    NSString* url = [self.baseURL absoluteString];
    NSURLSessionDataTask* dataTask = [self GET:url parameters:params
                                       success:^(NSURLSessionDataTask* task, id responseObject){
                                           NSHTTPURLResponse* httpResponse = (NSHTTPURLResponse *)task.response;
                                           if (httpResponse.statusCode == 200) {
                                               dispatch_async(dispatch_get_main_queue(), ^{
                                                   completion(responseObject, nil);
                                               });
                                           } else {
                                               dispatch_async(dispatch_get_main_queue(), ^{
                                                   completion(nil,nil);
                                               });
                                               NSLog(@"Received: %@", responseObject);
                                               NSLog(@"Received HTTP %ld", (long)httpResponse.statusCode);
                                           }
                                       } failure:^(NSURLSessionDataTask* task, NSError* error){
                                           NSLog(@"Failure/Error:%@",error);
                                           dispatch_async(dispatch_get_main_queue(),^{
                                               completion(nil,error);
                                           });
                                       }];
    
    return dataTask;
}
@end
/*
 AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
 manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/plain"];
 
 NSDictionary *parameters = @{@"user": @"mrudul",@"pass":@"@Metabusticker",@"query":lineNo};
 
 NSLog(@"%@",parameters);
 parameters = nil;
 
 // if you want to sent parameters you can use above code
 
 manager.requestSerializer = [AFJSONRequestSerializer serializer];
 
 [manager POST:_rootURL parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject)
 {
 
 [self callbackOnSuccess:responseObject];
 
 }failure:^(AFHTTPRequestOperation *operation, NSError *error)
 {
 NSLog(@"Error: %@", error);
 }];
 */