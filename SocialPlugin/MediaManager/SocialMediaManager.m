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
#import <Accounts/ACAccountType.h>
#import <Accounts/ACAccountCredential.h>
#import <Accounts/ACAccountStore.h>
#import "FacebookInfo.h"

#define FACEBOOK_APPID @"193319544145922"

@interface SocialMediaManager (Private)

- (void)getFacebookInformation;

@end

@implementation SocialMediaManager
@synthesize fbFriendsListArray;

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
        fbFriendsListArray = [[NSMutableArray alloc] init];
        
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

- (void)facebookFriendsList
{

  ACAccountStore  *accountStore = [[ACAccountStore alloc]init];
    ACAccountType *FBaccountType= [accountStore accountTypeWithAccountTypeIdentifier:ACAccountTypeIdentifierFacebook];
    
    NSString *key = FACEBOOK_APPID;
    NSDictionary *dictFB = [NSDictionary dictionaryWithObjectsAndKeys:key,ACFacebookAppIdKey,@[@"email"],ACFacebookPermissionsKey, nil];
    
    
    [accountStore requestAccessToAccountsWithType:FBaccountType options:dictFB completion:
     ^(BOOL granted, NSError *e) {
         if (granted) {
             NSArray *accounts = [accountStore accountsWithAccountType:FBaccountType];
             //it will always be the last object with single sign on
             facebookAccount = [accounts lastObject];
             NSLog(@"facebook account =%@",facebookAccount);
             [self getFacebookInformation];
         } else {
             //Fail gracefully...
             NSLog(@"error getting permission %@",e);
             
         }
     }];

}

- (void)getFacebookInformation
{
    NSURL *requestURL = [NSURL URLWithString:@"https://graph.facebook.com/me/friends"];
    SLRequest *request = [SLRequest requestForServiceType:SLServiceTypeFacebook
                                            requestMethod:SLRequestMethodGET
                                                      URL:requestURL
                                               parameters:nil];
    request.account = facebookAccount;
    [request performRequestWithHandler:^(NSData *data,
                                         NSHTTPURLResponse *response,
                                         NSError *error) {
        
        if(!error)
        {
            NSDictionary *freindsDictionary = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
            NSArray *freindsArray = [freindsDictionary valueForKey:@"data"];

            [fbFriendsListArray removeAllObjects];
            for (int i = 0; i < [freindsArray count]; i++)
            {
                FacebookInfo *facebookInfo = [[FacebookInfo alloc] init];
                [facebookInfo setUserName:[[freindsArray objectAtIndex:i] objectForKey:@"name"]];
                [facebookInfo setUserID:[[[freindsArray objectAtIndex:i] objectForKey:@"id"]integerValue]];
                [fbFriendsListArray addObject:facebookInfo];
            }
        }
        else{
            //handle error gracefully
            NSLog(@"error from get%@",error);
            //attempt to revalidate credentials
        }
    }];
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
