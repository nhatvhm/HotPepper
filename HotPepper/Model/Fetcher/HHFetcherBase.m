//
//  HHFetcherBase.m
//  HotPepper
//
//

#import "HHFetcherBase.h"

@implementation HHFetcherBase

-(id)init
{
    self = [super init];
    _fetcherService = [[GTMHTTPFetcherService alloc] init];
    
    return self;
}

- (GTMHTTPFetcher *)managedFetcherWithRequest:(NSURLRequest *)request
{
    return [_fetcherService fetcherWithRequest:request];
}

- (GTMHTTPFetcher *)managedFetcherWithURL:(NSURL *)url
{
    return [_fetcherService fetcherWithURL:url];
}

- (GTMHTTPFetcher *)managedFetcherWithURLString:(NSString *)urlString
{
    return [_fetcherService fetcherWithURLString:urlString];
}

- (void)stopFetching
{
    if (_fetcherService) {
        [_fetcherService stopAllFetchers];
    }
    
}

@end
