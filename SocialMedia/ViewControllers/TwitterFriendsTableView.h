//
//  TwitterFriendsTableView.h
//  SocialMedia
//
//  Created by Nagesh Kumar Mishra on 11/12/12.
//
//

#import <UIKit/UIKit.h>

@class TwitterManger;
@interface TwitterFriendsTableView : UITableViewController
{
    TwitterManger *sharedTwitterSingleton;
    BOOL isFacebook;
}
@property(nonatomic,assign) BOOL isFacebook;

@end
