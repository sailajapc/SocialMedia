//
//  TwitterManger.m
//  SocialMedia
//
//  Created by Nagesh Kumar Mishra on 10/12/12.
//
//

#import "TwitterManger.h"
#import <Twitter/Twitter.h>
#import <Accounts/Accounts.h>
#import "Utilites.h"

@implementation TwitterManger
static TwitterManger *shareTwitterSingleton;

#pragma mark - Singleton Methods

+ (TwitterManger *)shareTwitterSingleton
{
    @synchronized(self)
    {
        if (!shareTwitterSingleton)
        {
            shareTwitterSingleton = [[TwitterManger alloc] init];
        }
        return shareTwitterSingleton;
    }
}

+ (id)allocWithZone:(NSZone *)zone
{
    @synchronized(self)
    {
        if (shareTwitterSingleton == nil)
        {
            shareTwitterSingleton = [super allocWithZone:zone];
        }
    }
    return shareTwitterSingleton;
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
#pragma mark Class methods

#pragma mark -
#pragma mark twitter Helper Class method

- (void)TweetwithImage:(UIImage *)attachYourImage message:(NSString *)addMessage viewController:(UIViewController *)viewController
{
    TWTweetComposeViewController *twitter = [[TWTweetComposeViewController alloc] init];
    
    if([TWTweetComposeViewController canSendTweet])
    {
        // Check for tweet with image 
        if (attachYourImage != nil)
        {
            [twitter addImage:attachYourImage];
        }
        // Check for tweet meassage
        if (addMessage != nil)
        {
            [twitter setInitialText:addMessage];
        }
        [viewController presentViewController:twitter animated:YES completion:nil];
    }
    else {
        
        [Utilites showAlertWithTitle:@"Unable to tweet" message:@"Go to settings and add twitter account" delegate:nil cancelButtonTitle:@"Dismiss" otherButtonTitles: nil];
        return;
    }
    
    // This handler will check for the tweet successful are not 
    twitter.completionHandler = ^(TWTweetComposeViewControllerResult res){
        if (res == TWTweetComposeViewControllerResultDone) {
            
            [Utilites showAlertWithTitle:@"Tweet Successful!" message:@"You successfully tweeted" delegate:nil cancelButtonTitle:@"Dismiss" otherButtonTitles: nil];
            
        } else if (res == TWTweetComposeViewControllerResultCancelled) {
            
            
            [Utilites showAlertWithTitle:@"Tweet UnSuccessful!" message:@"Tweet was Unsuccessfully, try again later" delegate:nil cancelButtonTitle:@"Dismiss" otherButtonTitles: nil];
            
        }
        [viewController dismissModalViewControllerAnimated:YES];
        [twitter release];
    };
}

@end
