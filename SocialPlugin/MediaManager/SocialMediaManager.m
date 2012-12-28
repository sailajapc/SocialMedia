//
//  SocialMediaManager.m
//  SocialMedia
//
//  Created by Nagesh Kumar Mishra on 27/12/12.
//
//

#import "SocialMediaManager.h"
#import "Utilites.h"
#import "Reachability.h"
#import <Social/Social.h>
#import <Accounts/ACAccountStore.h>
#import <Accounts/ACAccount.h>
#import <Accounts/ACAccountType.h>
#import <Accounts/ACAccountCredential.h>

@implementation SocialMediaManager

static SocialMediaManager *shareSocialMediaManager;

#pragma mark - Singleton Methods

+ (SocialMediaManager *)shareSocialMediaManager
{
    @synchronized(self)
    {
        if (!shareSocialMediaManager)
        {
            shareSocialMediaManager = [[SocialMediaManager alloc] init];
        }
        return shareSocialMediaManager;
    }
}

+ (id)allocWithZone:(NSZone *)zone
{
    @synchronized(self)
    {
        if (shareSocialMediaManager == nil)
        {
            shareSocialMediaManager = [super allocWithZone:zone];
        }
    }
    return shareSocialMediaManager;
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

- (void)destroy
{
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
#pragma mark Social Media Facebook methods


- (void)messageComposerForFacebook:(UIImage *)attachYourImage message:(NSString *)addMessage url:(NSURL *)addUrl viewController:(UIViewController *)viewController
{
    NetworkStatus netStatus = [[Reachability reachabilityForInternetConnection] currentReachabilityStatus];
    if (netStatus == NotReachable)
    {
        [Utilites showAlertWithTitle:@"Network Unavailable" message:@"This application requires an active Internet connection, but no connection is available. Please check your connectivity settings and signal." delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil];
    }
    else
    {
        SLComposeViewController *composerViewController;
        
        if ([SLComposeViewController isAvailableForServiceType:SLServiceTypeFacebook])
        {
            if (composerViewController != nil)
            {
                composerViewController = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeFacebook];
            }
            
            if (addMessage != nil) {
                [composerViewController setInitialText:addMessage];
            }
            if (attachYourImage != nil){
                [composerViewController addImage:attachYourImage];
            }
            if (addUrl != nil) {
                [composerViewController addURL:addUrl];
            }
            [viewController presentViewController:composerViewController animated:YES completion:nil];
        }
        else {
            
            [Utilites showAlertWithTitle:@"Unable to post message" message:@"Go to settings and add Facebook account" delegate:nil cancelButtonTitle:@"Dismiss" otherButtonTitles: nil];
            return;
        }
        
        // This handler will check for the wall Post successfull are not
        [composerViewController setCompletionHandler:^(SLComposeViewControllerResult result) {
            if (result == SLComposeViewControllerResultDone) {
                
                [Utilites showAlertWithTitle:@"Message Successful!" message:@"You successfully posted message" delegate:nil cancelButtonTitle:@"Dismiss" otherButtonTitles: nil];
                
            } else if (result == SLComposeViewControllerResultCancelled) {
                
                [Utilites showAlertWithTitle:@"Message UnSuccessful!" message:@"Message was Unsuccessfully, try again later" delegate:nil cancelButtonTitle:@"Dismiss" otherButtonTitles: nil];
            }
            [viewController dismissViewControllerAnimated:YES completion:nil];
        }];
    }
}


#pragma mark -
#pragma mark Social Media Twitter methods

- (void)messageComposerForTwitter:(UIImage *)attachYourImage message:(NSString *)addMessage url:(NSURL *)addUrl viewController:(UIViewController *)viewController
{
    NetworkStatus netStatus = [[Reachability reachabilityForInternetConnection] currentReachabilityStatus];
    if (netStatus == NotReachable)
    {
        [Utilites showAlertWithTitle:@"Network Unavailable" message:@"This application requires an active Internet connection, but no connection is available. Please check your connectivity settings and signal." delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil];
    }
    else
    {
        SLComposeViewController *composerViewController;
        
        if ([SLComposeViewController composeViewControllerForServiceType:SLServiceTypeTwitter])
        {
            if (composerViewController != nil) {
                composerViewController = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeTwitter];
            }
            
            if (addMessage != nil) {
                [composerViewController setInitialText:addMessage];
            }
            if (attachYourImage != nil){
                [composerViewController addImage:attachYourImage];
            }
            if (addUrl != nil) {
                [composerViewController addURL:addUrl];
            }
            [viewController presentViewController:composerViewController animated:YES completion:nil];
        }
        else {
            
            [Utilites showAlertWithTitle:@"Unable to tweet" message:@"Go to settings and add twitter account" delegate:nil cancelButtonTitle:@"Dismiss" otherButtonTitles: nil];
            return;
        }
        
        // This handler will check for the tweet successfull are not
        [composerViewController setCompletionHandler:^(SLComposeViewControllerResult result) {
            if (result == SLComposeViewControllerResultDone) {
                
                [Utilites showAlertWithTitle:@"Tweet Successful!" message:@"You successfully tweeted" delegate:nil cancelButtonTitle:@"Dismiss" otherButtonTitles: nil];
                
            } else if (result == SLComposeViewControllerResultCancelled) {
                
                [Utilites showAlertWithTitle:@"Tweet UnSuccessful!" message:@"Tweet was Unsuccessfully, try again later" delegate:nil cancelButtonTitle:@"Dismiss" otherButtonTitles: nil];
            }
            [viewController dismissViewControllerAnimated:YES completion:nil];
        }];
        
    }
}


@end
