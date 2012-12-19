//
//  TwitterManger.h
//  SocialMedia
//
//  Created by Nagesh Kumar Mishra on 10/12/12.
//
//

#import <Foundation/Foundation.h>

@interface TwitterManger : NSObject
{
    NSOperationQueue *operationQueueStatus;
    NSMutableArray *twitterFriendsListArray;
}

@property(nonatomic,retain) NSMutableArray *twitterFriendsListArray;

+ (TwitterManger *)shareTwitterSingleton;

- (void)TweetwithImage:(UIImage *)attachYourImage message:(NSString *)addMessage url:(NSURL *)addUrl viewController:(UIViewController *)viewController;

- (void)getTwitterFriendsList;

@end
