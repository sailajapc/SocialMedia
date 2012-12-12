//
//  ViewController.m
//  SocialMedia
//
//  Created by Paradigm on 12/7/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ViewController.h"
<<<<<<< HEAD
#import "AppDelegate.h"
=======
#import "TwitterManger.h"
#import "TwitterInfo.h"
#import "TwitterFriendsTableView.h"
>>>>>>> bbee87d60e1965a917f0a32685a19a1a693e7929

@implementation ViewController

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    sharedTwitterSingleton = [TwitterManger shareTwitterSingleton];

    [super viewDidLoad];
    AppDelegate *appDelegate = [[UIApplication sharedApplication]delegate];
    if (!appDelegate.fbSession.isOpen) {
        //Create a new FB session
        appDelegate.fbSession = [[FBSession alloc] init];
        
        //Check the token is cached
        if (appDelegate.fbSession.state == FBSessionStateCreatedTokenLoaded) {
            // To make the session usable we call login again
            [appDelegate.fbSession openWithCompletionHandler:^(FBSession *session, 
                                                             FBSessionState status, 
                                                             NSError *error) {
            }];
        }

    }
	// Do any additional setup after loading the view, typically from a nib.
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
    AppDelegate *appDelegate = [[UIApplication sharedApplication]delegate];
    if (appDelegate.fbSession.isOpen) {
        [appDelegate.fbSession closeAndClearTokenInformation];
    }
    else {
        if (appDelegate.fbSession.state != FBSessionStateCreated) {
        //Create a new FB session
        appDelegate.fbSession = [[FBSession alloc] init];
        }
    // Open a session & show the FB login
    [appDelegate.fbSession openWithCompletionHandler:^(FBSession *session, 
                                                               FBSessionState status, 
                                                               NSError *error) {
            }];
    }

}

- (IBAction)connectTwitter:(id)sender
{
    [sharedTwitterSingleton TweetwithImage:nil message:@"Hello" viewController:self];
}

- (IBAction)twitterFollowesActionMethod:(id)sender
{
    [sharedTwitterSingleton getTwitterFriendsList];
    
    TwitterFriendsTableView *tableViewController = [[TwitterFriendsTableView alloc] initWithStyle:UITableViewStylePlain];
    [self.navigationController pushViewController:tableViewController animated:YES];
    [tableViewController release];
    
}

@end
