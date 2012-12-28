//
//  SocialMediaManager.h
//  SocialMedia
//
//  Created by Nagesh Kumar Mishra on 27/12/12.
//
//

#import <Foundation/Foundation.h>

@interface SocialMediaManager : NSObject


+ (SocialMediaManager *)shareSocialMediaManager;

- (void)messageComposerForTwitter:(UIImage *)attachYourImage message:(NSString *)addMessage url:(NSURL *)addUrl viewController:(UIViewController *)viewController;

- (void)messageComposerForFacebook:(UIImage *)attachYourImage message:(NSString *)addMessage url:(NSURL *)addUrl viewController:(UIViewController *)viewController;

@end
