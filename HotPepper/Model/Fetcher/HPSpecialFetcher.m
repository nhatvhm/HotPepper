//
//  HPSpecialEntity.m
//  HotPepper
//
//

#import "HPSpecialFetcher.h"
#import "HPUserDefaultsUtility.h"
#import "HPSpecialEntity.h"
#import "PrefixHeader.pch"


@interface HPSpecialFetcher() {
    NSMutableArray* _dataArray;
}

@end

@implementation HPSpecialFetcher

- (id) init {
    if (self = [super init]) {
        _dataArray = [[NSMutableArray alloc] init];
    }
    
    return self;
}

- (void) beginFetchWithSuccessTask:(void (^)())successTask errorTask:(void (^)(NSError*))errorTask
{
    //
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    
    //
    NSInteger numFetches = [[HPUserDefaultsUtility sharedInstance] numFetches];
    
    NSString *urlString = [NSString stringWithFormat:[HPPropertyListUtility
                                 valueForKeyOfMaster:@"kSpecialSearchBaseURL"
                                              master:@"masterData"],
                           numFetches];
    
    GTMHTTPFetcher *fetcher = [self managedFetcherWithURLString:urlString];
    
    //
    [_dataArray removeAllObjects];
    
    //
    [fetcher beginFetchWithCompletionHandler:^(NSData *retrievedData, NSError *error)  {
        
        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
        
        if (!error) {
            //
            NSError *error = nil;
            GDataXMLDocument *doc = [[GDataXMLDocument alloc] initWithData: retrievedData
                                                                   options: 0
                                                                     error: &error];
            if (error != nil) {
                HHDebugPrint(@"***Error*** receivedData: %@", [[NSString alloc] initWithData:retrievedData
                                                                                    encoding:NSUTF8StringEncoding] );
                errorTask(error);
                return;
            }
            
            //
            NSArray* largeArea = [doc.rootElement elementsForName:@"special"];
            for (GDataXMLElement *area in largeArea) {
                
                //
                NSArray *codes = [area elementsForName:@"code"];
                GDataXMLElement *codeNode = [codes objectAtIndex:0];
                
                NSArray *names = [area elementsForName:@"name"];
                GDataXMLElement *nameNode = [names objectAtIndex:0];
                
                HHDebugPrint(@"codeNode: %@, nameNode: %@", codeNode.stringValue, nameNode.stringValue);
                
                //
                HPSpecialEntity* specialEntity = [[HPSpecialEntity alloc] init];
                specialEntity.code = codeNode.stringValue;
                specialEntity.name = nameNode.stringValue;
                
                [_dataArray addObject: specialEntity];
            }
            
            //
            successTask();
            
        }else{
            //Error
            HHDebugPrint(@"***Error*** %@::%@, %@", NSStringFromClass([self class]), NSStringFromSelector(_cmd), [error localizedDescription]);
            errorTask(error);
        }
        
    }];
    
}

- (HPSpecialEntity *)specialEntityAtIndex:(NSInteger)idx {
    return [_dataArray objectAtIndex:idx];
}

- (NSInteger)numberOfSpecial {
    return [_dataArray count];
}


@end
