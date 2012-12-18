//
//  FacebookManager.h
//  SocialMedia
//
//  Created by Paradigm on 14/12/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FacebookManager : NSObject

+ (FacebookManager *)shareFacebookSingleton;
- (void)getFacebookLogin;
- (void)postFeedOnFBWall;
- (void)postFeed;
@end
