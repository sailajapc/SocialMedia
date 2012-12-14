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

@interface ViewController()

- (void)setButton;
- (void)postFeed;
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
    sharedTwitterSingleton = [TwitterManger shareTwitterSingleton];
    [self setButton];
    [super viewDidLoad];
    
    if (FBSession.activeSession.isOpen) {
        [self setButton];
    }
    else{        
        //Check the token is cached
        if (FBSession.activeSession.state == FBSessionStateCreatedTokenLoaded) {
            // To make the session usable we call login again
            [FBSession openActiveSessionWithPermissions:[NSArray arrayWithObject:@"publish_actions"] allowLoginUI:YES completionHandler:^(FBSession *session, FBSessionState status, NSError *error) {
                [self setButton];
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
#pragma mark Facebook methods

- (void)setButton{
   
    if (FBSession.activeSession.isOpen) {
        [connectFB setHidden:YES];
        [postToWall setHidden:NO];
    }
    else
    {
        [connectFB setHidden:NO];
        [postToWall setHidden:YES];  
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

#pragma mark -
#pragma mark IBAction methods

- (IBAction)connectFaceBook:(id)sender
{
    
    if (FBSession.activeSession.isOpen) {
        [FBSession.activeSession closeAndClearTokenInformation];
    }
    else {
        // Open a session & show the FB login
        [FBSession openActiveSessionWithPermissions:[NSArray arrayWithObject:@"publish_actions"] allowLoginUI:YES completionHandler:^(FBSession *session, FBSessionState status, NSError *error) {
            [self setButton];
        }];
//    [appDelegate.fbSession openWithCompletionHandler:^(FBSession *session, 
//                                                               FBSessionState status, 
//                                                               NSError *error) {
//               [self setButton];
//            }];
    }

}

- (IBAction)postOnFBWall:(id)sender{
    
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
