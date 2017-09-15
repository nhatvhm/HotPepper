//
//  HHManagerBase.m
//  HotPepper
//
//

#import "HHManagerBase.h"

@implementation HHManagerBase


+ (HHManagerBase*)sharedInstance {
    
    [NSException raise:NSInternalInconsistencyException
                format:@"Error: You must override %@ in a subclass", NSStringFromSelector(_cmd)];
    
    return nil;
}


@end
