//
//  ChimpKit.m
//  ChimpKit2
//
//  Created by Amro Mousa on 11/19/10.
//  Copyright 2010 return7, LLC. All rights reserved.
//

#import "ChimpKit.h"

@interface ChimpKit()

@end


@implementation ChimpKit

@synthesize apiUrl, apiKey, delegate, onSuccess, onFailure;

#pragma mark -
#pragma mark Initialization

-(void)setApiKey:(NSString*)key {
    apiKey = key;
    if (apiKey) {
        //Parse out the datacenter and template it into the URL.
        NSArray *apiKeyParts = [apiKey componentsSeparatedByString:@"-"];
        if ([apiKeyParts count] > 1) {
            self.apiUrl = [NSString stringWithFormat:@"https://%@.api.mailchimp.com/1.3/?method=", [apiKeyParts objectAtIndex:1]];
        }
    }
}

-(id)initWithDelegate:(id)aDelegate andApiKey:(NSString *)key {
	self = [super init];
	if (self != nil) {
        self.apiUrl  = @"https://api.mailchimp.com/1.3/?method=";
        [self setApiKey:key];
        self.delegate = aDelegate;
	}
	return self;
}

-(void)callApiMethod:(NSString *)method withParams:(NSDictionary *)params {
    [self callApiMethod:method withParams:params andUserInfo:nil];
}

-(void)callApiMethod:(NSString *)method withParams:(NSDictionary *)params andUserInfo:(NSDictionary *)userInfo {
    NSString *urlString = [NSString stringWithFormat:@"%@%@", self.apiUrl, method];

    ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:[NSURL URLWithString:urlString]];
    [request setDelegate:self.delegate];
    [request setUserInfo:userInfo];
    [request setDidFinishSelector:self.onSuccess];
    [request setDidFailSelector:self.onFailure];
    [request setRequestMethod:@"POST"];
    [request setShouldContinueWhenAppEntersBackground:YES];

    NSMutableDictionary *postBodyParams = [NSMutableDictionary dictionary];
    if (self.apiKey) {
        [postBodyParams setValue:self.apiKey forKey:@"apikey"];
    }
    
    if (params) {
        [postBodyParams setValuesForKeysWithDictionary:params];
    }
    
    NSMutableData *postData = [NSMutableData dataWithData:[[postBodyParams JSONRepresentation] dataUsingEncoding:NSUTF8StringEncoding]];
    [request setPostBody:postData];
    [request startAsynchronous];
}

//TODO: Stub out all version 1.3 API methods w/ required params and optional params in a single dictionary

- (void)dealloc {
    self.apiKey = nil;
    self.apiUrl = nil;
    [super dealloc];
}

@end
