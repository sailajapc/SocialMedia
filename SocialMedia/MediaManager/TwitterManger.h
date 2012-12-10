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
}

+ (TwitterManger *)shareTwitterSingleton;

- (void)TweetwithImage:(UIImage *)attachYourImage message:(NSString *)addMessage viewController:(UIViewController *)viewController;

@end
