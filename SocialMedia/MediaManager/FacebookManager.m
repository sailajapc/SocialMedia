//
//  FacebookManager.m
//  SocialMedia
//
//  Created by Paradigm on 14/12/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "FacebookManager.h"
#import <FacebookSDK/FacebookSDK.h>
#import "Utilites.h"
#import "Reachability.h"

@implementation FacebookManager
static FacebookManager *shareFacebookSingleton;

#pragma mark - Singleton Methods

+ (FacebookManager *)shareFacebookSingleton
{
    @synchronized(self)
    {
        if (!shareFacebookSingleton)
        {
            shareFacebookSingleton = [[FacebookManager alloc] init];
        }
        return shareFacebookSingleton;
    }
}

+ (id)allocWithZone:(NSZone *)zone
{
    @synchronized(self)
    {
        if (shareFacebookSingleton == nil)
        {
            shareFacebookSingleton = [super allocWithZone:zone];
        }
    }
    return shareFacebookSingleton;
}

- (id)copyWithZone:(NSZone *)zone
{
    return self;
}

- (id)retain
{
    return self;
}

- (NSUInteger)retainCount
{
    return NSUIntegerMax;
}

- (id)autorelease
{
    return self;
}

- (oneway void)release
{
    // do nothing
}

- (id)init
{
    self = [super init];
    if (self)
    {
        // Custom initialization

    }
    return self;
}

#pragma mark -
#pragma mark  Facebook helper Class methods
- (BOOL)getFacebookLogin
{
    NetworkStatus netStatus = [[Reachability reachabilityForInternetConnection] currentReachabilityStatus];
    if (netStatus == NotReachable)
    {
        [Utilites showAlertWithTitle:@"Network Unavailable" message:@"This application requires an active Internet connection, but no connection is available. Please check your connectivity settings and signal." delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil];
        return NO;
    }
    else
    {
    if (FBSession.activeSession.isOpen) {
        return YES; 
    }
    else{        
        //Check the token is cached
        if (FBSession.activeSession.state == FBSessionStateCreatedTokenLoaded) {
            // To make the session usable we call login again
            [FBSession openActiveSessionWithPermissions:[NSArray arrayWithObject:@"publish_actions"] allowLoginUI:YES completionHandler:^(FBSession *session, FBSessionState status, NSError *error) {
            }];
            
        }
        return YES;
    }
    }
}
@end
