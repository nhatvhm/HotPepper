//
//  HPAreaFetcher.m
//  HotPepper
//
//

#import "HPAreaFetcher.h"
#import "PrefixHeader.pch"

@interface HPAreaFetcher() {
    NSMutableArray* _dataArray;
}

@end


@implementation HPAreaFetcher

- (id) init {
    if (self = [super init]) {
        _dataArray = [[NSMutableArray alloc] init];
    }
    
    return self;
}

- (void) beginFetchWithSuccessTask:(void (^)())successTask
                         errorTask:(void (^)(NSError*))errorTask
{
    //
    [_dataArray removeAllObjects];
    
    //
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    
    //
    NSString *urlString = [HPPropertyListUtility valueForKeyOfMaster:@"kAreaSearchBaseURL"
                                                              master:@"masterData"];
    GTMHTTPFetcher *fetcher = [self managedFetcherWithURLString:urlString];
    
    
    //
    [fetcher beginFetchWithCompletionHandler:^(NSData *retrievedData, NSError *error) {
        
        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
        
        if (!error) {
            
            //
            NSError *error;
            GDataXMLDocument *doc = [[GDataXMLDocument alloc] initWithData:retrievedData
                                                                   options:0
                                                                     error:&error];
            if (error != nil) {
                HHDebugPrint(@"***Error*** receivedData: %@", [[NSString alloc] initWithData:retrievedData
                                                                                    encoding:NSUTF8StringEncoding] );
                errorTask(error);
                return;
            }
            
            //
            NSArray* largeArea = [doc.rootElement elementsForName:@"large_area"];
            for (GDataXMLElement *area in largeArea) {
                
                //
                GDataXMLElement *codeNode = [[area elementsForName:@"code"] objectAtIndex:0];
                GDataXMLElement *nameNode = [[area elementsForName:@"name"] objectAtIndex:0];
                
                //
                HPAreaEntity *areaEntity = [[HPAreaEntity alloc] init];
                areaEntity.code = codeNode.stringValue;
                areaEntity.name = nameNode.stringValue;
                
                [_dataArray addObject: areaEntity];
            }
            
            //
            successTask();
            
            
        }else{
            //TODO: Google Toolkit for Mac API が制御したError...
            HHDebugPrint(@"***Error*** %@::%@, %@", NSStringFromClass([self class]), NSStringFromSelector(_cmd), [error localizedDescription]);
            errorTask(error);
        }
        
    }];
    
}

- (HPAreaEntity *)areaEntityAtIndex:(NSInteger)idx {
    return [_dataArray objectAtIndex:idx];
}

- (NSInteger)numberOfArea {
    return [_dataArray count];
}

@end
