//
//  ViewController.m
//  SocialMedia
//
//  Created by Paradigm on 12/7/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "AppDelegate.h"
#import "TwitterManger.h"
#import "TwitterInfo.h"
#import "TwitterFriendsTableView.h"
#import "Utilites.h"
#import "ViewController.h"
#import "FacebookManager.h"
#import "SocialMediaManager.h"


@interface ViewController()

@end

@implementation ViewController
@synthesize friendsView;

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    self.title = @"Social Media";
    sharedTwitterSingleton = [TwitterManger shareTwitterSingleton];
    if (FBSession.activeSession.isOpen)
    {
        [connectFB setHidden:YES];
    }
    else
    {
        if (FBSession.activeSession.state == FBSessionStateCreatedTokenLoaded) {
            //Make the session Usable
            [FBSession.activeSession openWithCompletionHandler:^(FBSession *session, FBSessionState status, NSError *error) {
                switch (status) {
                    case FBSessionStateClosedLoginFailed:
                    {
                        [Utilites showAlertWithTitle:@"Alert" message:@"An Error while trying to login" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
                    }
                        break;
                    case FBSessionStateOpen:
                    {
                        [connectFB setHidden:YES];
                    }
                        break;
                    default:
                        break;
                }
            }];
        }
    }
    
    [super viewDidLoad];
}

- (void)viewDidUnload
{
    friendsView = nil;
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
	[super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
	[super viewDidDisappear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}


#pragma mark -
#pragma mark IBAction methods

- (IBAction)connectFaceBook:(id)sender
{
    [[FacebookManager shareFacebookSingleton] getFacebookLogin];
    [connectFB setHidden:YES];
}

- (IBAction)postOnFBWall:(id)sender
{
    [[FacebookManager shareFacebookSingleton] postFeedOnFBWall];
}

- (IBAction)loadFacebookFriends:(id)sender{
    if (friendsView == nil) {
        friendsView = [[FBFriendPickerViewController alloc]init];
        [friendsView setDelegate:self];
        [friendsView setTitle:@"My Friends" ];
    }
    [friendsView loadData];
    [friendsView clearSelection];
    [self presentModalViewController:friendsView animated:YES];
}

- (IBAction)normalTweetButtonAction:(id)sender
{
    [sharedTwitterSingleton TweetwithImage:nil message:@"Hello" url:nil viewController:self];
}

- (IBAction)tweetWithImageButtonAction:(id)sender
{
    [sharedTwitterSingleton TweetwithImage:[UIImage imageNamed:@"Apple-logo.jpg"] message:@"Hello" url:nil viewController:self];
}

- (IBAction)tweetWithURLButtonAction:(id)sender
{
    NSURL *url = [NSURL URLWithString:@"www.paradigmcreatives.com"];
    [sharedTwitterSingleton TweetwithImage:nil message:@"Hello" url:url viewController:self];
}

- (IBAction)twitterFollowesActionMethod:(id)sender
{
    [sharedTwitterSingleton getTwitterFriendsList];
    
    TwitterFriendsTableView *tableViewController = [[TwitterFriendsTableView alloc] initWithStyle:UITableViewStylePlain];
    [self.navigationController pushViewController:tableViewController animated:YES];
    [tableViewController release];
}

#pragma mark -
#pragma mark iOS 6 Twitter methods

- (IBAction)normalTweetiOS6ButtonAction:(id)sender;
{
    [[SocialMediaManager shareSocialMediaManager] messageComposerForTwitter:nil message:@"Good Morning " url:nil viewController:self];
}

- (IBAction)tweetWithImageiOS6ButtonAction:(id)sender
{
    [[SocialMediaManager shareSocialMediaManager] messageComposerForTwitter:[UIImage imageNamed:@"Apple-logo.jpg"] message:@"Apple" url:nil viewController:self];
}

- (IBAction)tweetWithURLiOS6ButtonAction:(id)sender
{
    NSURL *addURL = [NSURL URLWithString:@"www.paradigmcreatives.com"];
    [[SocialMediaManager shareSocialMediaManager] messageComposerForTwitter:[UIImage imageNamed:@"Apple-logo.jpg"] message:@"Apple" url:addURL viewController:self];
}


#pragma mark -
#pragma mark iOS 6 Facebook methods


- (IBAction)normalMessageiOS6ButtonAction:(id)sender
{
    [[SocialMediaManager shareSocialMediaManager] messageComposerForFacebook:nil message:@"Hello" url:nil viewController:self];
}

- (IBAction)messageWithImageiOS6ButtonAction:(id)sender
{
    [[SocialMediaManager shareSocialMediaManager] messageComposerForFacebook:[UIImage imageNamed:@"Apple-logo.jpg"] message:@"hello" url:nil viewController:self];
}

- (IBAction)messageWithURLiOS6ButtonAction:(id)sender
{
    NSURL *addURL = [NSURL URLWithString:@"www.paradigmcreatives.com"];
    [[SocialMediaManager shareSocialMediaManager] messageComposerForFacebook:[UIImage imageNamed:@"Apple-logo.jpg"] message:@"Hello" url:addURL viewController:self];
}


#pragma mark -
#pragma mark Friends Picker Delegate methods

- (void)facebookViewControllerDoneWasPressed:(id)sender{
    NSMutableArray *ids = [[NSMutableArray alloc]init];
    NSMutableArray *names = [[NSMutableArray alloc]init];
    for (id<FBGraphUser> user in self.friendsView.selection) {
        [ids addObject:user.id];
        [names addObject:user.name];
    }
    [self dismissModalViewControllerAnimated:YES];
}

- (void)facebookViewControllerCancelWasPressed:(id)sender{
    [friendsView clearSelection];
    [self dismissModalViewControllerAnimated:YES];
}
@end
