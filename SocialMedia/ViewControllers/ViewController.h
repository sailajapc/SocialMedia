//
//  ViewController.h
//  SocialMedia
//
//  Created by Paradigm on 12/7/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class TwitterManger;
@interface ViewController : UIViewController <FBFriendPickerDelegate>
{
    TwitterManger *sharedTwitterSingleton;
    IBOutlet UIButton *connectFB;
}
@property (nonatomic,retain)FBFriendPickerViewController *friendsView;

- (IBAction)connectFaceBook:(id)sender;
- (IBAction)postOnFBWall:(id)sender;
- (IBAction)loadFacebookFriends:(id)sender;
- (IBAction)normalTweetButtonAction:(id)sender;
- (IBAction)tweetWithImageButtonAction:(id)sender;
- (IBAction)tweetWithURLButtonAction:(id)sender;
- (IBAction)twitterFollowesActionMethod:(id)sender;

//iOS 6 methods for twitter
- (IBAction)normalTweetiOS6ButtonAction:(id)sender;
- (IBAction)tweetWithImageiOS6ButtonAction:(id)sender;
- (IBAction)tweetWithURLiOS6ButtonAction:(id)sender;

//iOS 6 methods for Facebook
- (IBAction)normalMessageiOS6ButtonAction:(id)sender;
- (IBAction)messageWithImageiOS6ButtonAction:(id)sender;
- (IBAction)messageWithURLiOS6ButtonAction:(id)sender;

@end
