//
//  ChimpKit.h
//  ChimpKit2
//
//  Created by Amro Mousa on 11/19/10.
//  Copyright 2010 return7, LLC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ASIHTTPRequest.h"
#import "JSON.h"

@interface ChimpKit : NSObject {
    id  delegate;
    SEL onSuccess;
    SEL onFailure;

    NSString *apiUrl;
    NSString *apiKey;
}

@property (assign,readwrite)    id  delegate;
@property (nonatomic,readwrite) SEL onSuccess;
@property (nonatomic,readwrite) SEL onFailure;

@property (nonatomic,retain) NSString *apiUrl;
@property (nonatomic,retain) NSString *apiKey;


-(id)initWithDelegate:(id)aDelegate andApiKey:(NSString *)key;
-(void)callApiMethod:(NSString *)method withParams:(NSDictionary *)params;
-(void)callApiMethod:(NSString *)method withParams:(NSDictionary *)params andUserInfo:(NSDictionary *)userInfo;

//Begin API methods


@end