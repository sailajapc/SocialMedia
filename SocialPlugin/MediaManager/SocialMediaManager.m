//
//  SocialMediaManager.m
//  SocialMedia
//
//  Created by Nagesh Kumar Mishra on 27/12/12.
//
//

#import "SocialMediaManager.h"

@implementation SocialMediaManager

static SocialMediaManager *shareSocialMediaManager;

#pragma mark - Singleton Methods

+ (SocialMediaManager *)shareSocialMediaManager
{
    @synchronized(self)
    {
        if (!shareSocialMediaManager)
        {
            shareSocialMediaManager = [[SocialMediaManager alloc] init];
        }
        return shareSocialMediaManager;
    }
}

+ (id)allocWithZone:(NSZone *)zone
{
    @synchronized(self)
    {
        if (shareSocialMediaManager == nil)
        {
            shareSocialMediaManager = [super allocWithZone:zone];
        }
    }
    return shareSocialMediaManager;
}

- (id)copyWithZone:(NSZone *)zone
{
    return self;
}

- (id)retain
{
    return self;
}

- (NSUInteger)retainCount
{
    return NSUIntegerMax;
}

- (id)autorelease
{
    return self;
}

- (oneway void)release
{
    // do nothing
}

- (void)destroy
{
}

- (id)init
{
    self = [super init];
    if (self)
    {
        // Custom initialization
        
    }
    return self;
}

@end
