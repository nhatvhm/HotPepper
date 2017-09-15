//
//  HHFetcherBase.h
//  HotPepper
//
//

#import <Foundation/Foundation.h>
#import "GTMHTTPFetcherService.h"

#import "HPPropertyListUtility.h"
#import "GDataXMLNode.h"

/*!
 * @class HHFetcherBase
 * @abstract It is the base class of ModelFetcher.
 * @dependency We will use GTMHTTPFetcher.
 * @discussion ModelFetcher performs API communication from request information specified from Controller,
 * Entity is generated from the response content.
 * Controller, by querying ModelFetcher,
 * Entity reference becomes possible.
 * Sub classes can generate multiple GTMHTTPFetcher internally.
 * In that case, by using the managedFetcherWith: method to generate GTMHTTPFetcher,
 * Unified management of request processing becomes possible, simultaneous stop etc. become possible. 
 * Reference API from HotPepper URL: http://webservice.recruit.co.jp/hotpepper/reference.html
 */
@interface HHFetcherBase : NSObject
{
    GTMHTTPFetcherService *_fetcherService;
}
/*!
 * @abstract Abort all APIs of GTMHTTPFetcher created using mangedFetcherWith: method
 */
- (void)stopFetching;


#pragma mark Protected Methods

/*!
 * @abstract Generate ModelFetcher instance
 * @param url API request URL (NSURL)
 * @result ModelFetcher instance
 */
- (GTMHTTPFetcher *)managedFetcherWithURL:(NSURL *)url;

/*!
 * @abstract Generate ModelFetcher instance
 * @param request API request (NSURLRequest)
 * @result ModelFetcher instance
 */
- (GTMHTTPFetcher *)managedFetcherWithRequest:(NSURLRequest *)request;


/*!
 * @abstract Generate ModelFetcher instance
 * @param urlString API request URL (NSString)
 * @result ModelFetcher instance
 */
- (GTMHTTPFetcher *)managedFetcherWithURLString:(NSString *)urlString;


@end
