//
//  SocialMediaManager.h
//  SocialMedia
//
//  Created by Nagesh Kumar Mishra on 27/12/12.
//
//

#import <Foundation/Foundation.h>
#import <Accounts/ACAccount.h>


@interface SocialMediaManager : NSObject
{
    ACAccount *facebookAccount;
    NSMutableArray *fbFriendsListArray;
}
@property(nonatomic,retain)NSMutableArray *fbFriendsListArray;

+ (SocialMediaManager *)shareSocialMediaManager;

- (void)messageComposerForTwitter:(UIImage *)attachYourImage message:(NSString *)addMessage url:(NSURL *)addUrl viewController:(UIViewController *)viewController;

- (void)messageComposerForFacebook:(UIImage *)attachYourImage message:(NSString *)addMessage url:(NSURL *)addUrl viewController:(UIViewController *)viewController;

- (void)facebookFriendsList;

@end
