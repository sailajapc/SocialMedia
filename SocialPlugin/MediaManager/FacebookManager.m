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
- (void)getFacebookLogin
{
    NetworkStatus netStatus = [[Reachability reachabilityForInternetConnection] currentReachabilityStatus];
    if (netStatus == NotReachable)
    {
        [Utilites showAlertWithTitle:@"Network Unavailable" message:@"This application requires an active Internet connection, but no connection is available. Please check your connectivity settings and signal." delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil];
    }
    else
    {
    if (!FBSession.activeSession.isOpen) 
    {
        //Create new FBSession with permissions
        [FBSession openActiveSessionWithPermissions:[NSArray arrayWithObject:@"publish_actions"] allowLoginUI:YES completionHandler:^(FBSession *session, FBSessionState status, NSError *error) {
            }];
    }
    }
}

- (void)postFeedOnFBWall
{
    // Ask for publish_actions permissions in context
    if ([FBSession.activeSession.permissions
         indexOfObject:@"publish_actions"] == NSNotFound) {
        // No permissions found in session, ask for it
        [FBSession.activeSession reauthorizeWithPermissions:[NSArray arrayWithObject:@"publish_actions"] behavior:FBSessionLoginBehaviorWithFallbackToWebView completionHandler:^(FBSession *session, NSError *error) {
            if (!error) {
                [self postFeed];
            }
        } ];
    }
    else {
        // If permissions present, publish the story
        [self postFeed];
    }

}

- (void)postFeed{
    NSDictionary *postParams = [[NSDictionary alloc]initWithObjectsAndKeys:@"Posting through Social Media App",@"message",nil];
    [ FBRequestConnection startWithGraphPath:@"me/feed" parameters:postParams HTTPMethod:@"POST" completionHandler:^(FBRequestConnection *connection, id result, NSError *error) {
        NSString *alertText;
        if (error) {
            alertText = [error description];
        }
        else{
            alertText = @"Successfully posted"; 
        }
        [Utilites showAlertWithTitle:@"Alert" message:alertText delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
    } ];
    
}

@end
