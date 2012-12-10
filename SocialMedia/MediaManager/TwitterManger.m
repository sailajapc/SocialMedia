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
#import "Reachability.h"
#import "TwitterInfo.h"

#define FriendsName @"name"
#define FriendsImage @"profile_image_url_https"
#define FriendsID @"id"

@implementation TwitterManger
@synthesize twitterFriendsListArray;

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

- (void)destroy
{
    [operationQueueStatus release];
    [twitterFriendsListArray release];
}

- (id)init
{
    self = [super init];
    if (self)
    {
        // Custom initialization
        
        operationQueueStatus = [[NSOperationQueue alloc] init];
        twitterFriendsListArray = [[NSMutableArray alloc] init];
    }
    return self;
}

#pragma mark -
#pragma mark Class methods

#pragma mark -
#pragma mark twitter Helper Class method

- (void)TweetwithImage:(UIImage *)attachYourImage message:(NSString *)addMessage viewController:(UIViewController *)viewController
{
    NetworkStatus netStatus = [[Reachability reachabilityForInternetConnection] currentReachabilityStatus];
    if (netStatus == NotReachable)
    {
        [Utilites showAlertWithTitle:@"Network Unavailable" message:@"This application requires an active Internet connection, but no connection is available. Please check your connectivity settings and signal." delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil];
    }
    else
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
        
        // This handler will check for the tweet successfull are not
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
}

- (void)getTwitterFriendsList
{
    NSInvocationOperation *operation = [[NSInvocationOperation alloc] initWithTarget:self selector:@selector(loadTwitterFriendsList) object:nil];
    [operationQueueStatus addOperation:operation];
    [operation release];
}

- (void)loadTwitterFriendsList
{
    if(![TWTweetComposeViewController canSendTweet])
    {
        [Utilites showAlertWithTitle:@"Unable to login" message:@"You haven't logged in to your Twitter account." delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil];
        return ;
    }
    
    ACAccountStore *accountStore = [[ACAccountStore alloc] init];
    ACAccountType *accountType = [accountStore accountTypeWithAccountTypeIdentifier:ACAccountTypeIdentifierTwitter];
    [accountStore requestAccessToAccountsWithType:accountType withCompletionHandler:^(BOOL granted, NSError *error)
     {
         NSLog(@"error account store %@",error);
         
         if(granted)
         {
             // Get the list of Twitter accounts.
             NSArray *accountsInfoArray = [accountStore accountsWithAccountType:accountType];
             
             if ([accountsInfoArray count] > 0)
             {
                 ACAccount *twitterAccount = [accountsInfoArray objectAtIndex:0];
                 NSLog(@"description %@",twitterAccount.description);
                 NSLog(@"username:- %@",twitterAccount.username);
                 NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"http://api.twitter.com/1/statuses/followers/%@.json",twitterAccount.username]];
                 
                 TWRequest *request = [[TWRequest alloc] initWithURL:url parameters:[NSDictionary dictionaryWithObjectsAndKeys:twitterAccount.username, @"screen_name", nil] requestMethod:TWRequestMethodGET];
                 [request setAccount:twitterAccount];
                 [request performRequestWithHandler:^(NSData *responseData, NSHTTPURLResponse *urlResponse, NSError *error)
                  {
                      if (!responseData)
                      {
                          NSLog(@"error %@", error);
                      }
                      else
                      {
                          NSError *jsonError;
                          
                          NSArray *userInfoArray = [NSJSONSerialization JSONObjectWithData:responseData
                                                                                   options:NSJSONReadingMutableLeaves
                                                                                     error:&jsonError];
                          
                          if ([userInfoArray count] == [twitterFriendsListArray count]) {
                              return ;
                          }
                          
                          [twitterFriendsListArray removeAllObjects];
                          for(int i = 0; i < [userInfoArray count]; i++)
                          {
                              TwitterInfo *twitterInfo = [[TwitterInfo alloc] init];
                              [twitterInfo setUserName:[[userInfoArray objectAtIndex:i] objectForKey:@"name"]];
                              [twitterInfo setImageUrl:[[userInfoArray objectAtIndex:i] objectForKey:@"profile_image_url_https"]];
                              [twitterInfo setUserID:[[[userInfoArray objectAtIndex:i] objectForKey:@"id"]integerValue]];
                              
                              if (![operationQueueStatus isSuspended]) {
                                  [twitterFriendsListArray addObject:twitterInfo];
                                  [twitterInfo release];
                              }
                              else
                              {
                                  [twitterInfo release];

                              }
                          }
                      }
                  }];
                 
                 [request release];
             }
         }
         else
         {
             NSLog(@"the account was NOT saved");
         }
     }];
    
    NSLog(@"==============twitterFriendsListArray===============%@",twitterFriendsListArray);
}


@end
