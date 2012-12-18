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
@interface ViewController()

@end

@implementation ViewController

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
             [FBSession.activeSession openWithCompletionHandler:^(FBSession *session, FBSessionState status, NSError *error) {
                 [connectFB setHidden:YES];
             }];
         }
    }

    [super viewDidLoad];
}

- (void)viewDidUnload
{
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
   [[FacebookManager shareFacebookSingleton]getFacebookLogin];
    [connectFB setHidden:YES];
}

- (IBAction)postOnFBWall:(id)sender
{
    [[FacebookManager shareFacebookSingleton]postFeedOnFBWall]; 
}
         
- (IBAction)connectTwitter:(id)sender
{
    [sharedTwitterSingleton TweetwithImage:nil message:@"Hello" url:nil viewController:self];
}

- (IBAction)twitterFollowesActionMethod:(id)sender
{
    [sharedTwitterSingleton getTwitterFriendsList];
    
    TwitterFriendsTableView *tableViewController = [[TwitterFriendsTableView alloc] initWithStyle:UITableViewStylePlain];
    [self.navigationController pushViewController:tableViewController animated:YES];
    [tableViewController release];
    
}

@end
