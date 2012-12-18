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
- (IBAction)connectTwitter:(id)sender;
- (IBAction)twitterFollowesActionMethod:(id)sender;
@end
