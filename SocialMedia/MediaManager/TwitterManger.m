//
//  TwitterManger.m
//  SocialMedia
//
//  Created by Nagesh Kumar Mishra on 10/12/12.
//
//

#import "TwitterManger.h"

@implementation TwitterManger
static TwitterManger *shareTwitterSingleton;

#pragma mark - Singleton Methods

+ (TwitterManger *)shareTwitterSingleton
{
    @synchronized(self)
    {
        if (!shareTwitterSingleton)
        {
            shareTwitterSingleton = [[TwitterManger alloc] init];
        }
        return shareTwitterSingleton;
    }
}

+ (id)allocWithZone:(NSZone *)zone
{
    @synchronized(self)
    {
        if (shareTwitterSingleton == nil)
        {
            shareTwitterSingleton = [super allocWithZone:zone];
        }
    }
    return shareTwitterSingleton;
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

- (id)init
{
    self = [super init];
    if (self)
    {
        // Custom initialization
    }
    return self;
}

#pragma mark -
#pragma mark Class methods


@end
