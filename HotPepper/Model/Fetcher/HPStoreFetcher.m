//
//  HPStoreFetcher.m
//  HotPepper
//
//

#import "HPStoreFetcher.h"
#import "HPUserDefaultsUtility.h"
#import "HPStoreEntity.h"
#import "PrefixHeader.pch"

@interface HPStoreFetcher() {
    NSMutableArray* _dataArray;
}

@end

@implementation HPStoreFetcher

- (id) init {
    if (self = [super init]) {
        _dataArray = [[NSMutableArray alloc] init];
    }
    
    return self;
}


- (void) beginFetchWithTypeNumber:(NSNumber*)typeNumber
                        codeValue:(NSString*)code
                      successTask:(void (^)())successTask
                          rowTask:(void (^)(HPStoreEntity*))rowTask
                        errorTask:(void (^)(NSError*))errorTask
{
    //
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    
    //
    NSInteger numFetches = [[HPUserDefaultsUtility sharedInstance] numFetches];
    
    NSString *urlString = @"";
    if (typeNumber == [HPPropertyListUtility valueForKeyOfMaster:@"kSearchTypeNumberArea"
                                                          master:@"masterData"]) {
        urlString = [NSString stringWithFormat:[HPPropertyListUtility valueForKeyOfMaster:@"kAreaTypeBaseURL"
                                                                                   master:@"masterData"], code, numFetches];
    } else {
        urlString = [NSString stringWithFormat:[HPPropertyListUtility valueForKeyOfMaster:@"kSpecialTypeBaseURL"
                                                                                   master:@"masterData"], code, numFetches];
    }
    
    //
    if ([[HPUserDefaultsUtility sharedInstance] useMobileCoupon]) {
        urlString = [NSString stringWithFormat:@"%@%@", urlString, [HPPropertyListUtility valueForKeyOfMaster:@"kDetaiCouponFlag"
                                                                                                       master:@"masterData"]];
    }
    
    //
    if ([[HPUserDefaultsUtility sharedInstance] openStoreNow]) {
        urlString = [NSString stringWithFormat:@"%@%@", urlString, [HPPropertyListUtility valueForKeyOfMaster:@"kStoreOpenFlag"
                                                                                                       master:@"masterData"]];
    }
    
    HHDebugPrint(@"url: %@", urlString);
    
    //
    GTMHTTPFetcher *fetcher= [self managedFetcherWithURLString:urlString];
    
    //
    [_dataArray removeAllObjects];
    
    //
    [fetcher beginFetchWithCompletionHandler:^(NSData *retrievedData, NSError *error) {
        
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
            NSArray *elements = [doc.rootElement elementsForName:@"shop"];
            for (GDataXMLElement *element in elements) {
                
                //
                NSArray *ids = [element elementsForName:@"id"];
                GDataXMLElement *idNode = [ids objectAtIndex:0];
                
                NSArray *names = [element elementsForName:@"name"];
                GDataXMLElement *nameNode = [names objectAtIndex:0];
                
                NSArray *logoImages = [element elementsForName:@"logo_image"];
                GDataXMLElement *logoImageNode = [logoImages objectAtIndex:0];
                
                NSArray *nameKanas = [element elementsForName:@"name_kana"];
                GDataXMLElement *nameKanaNode = [nameKanas objectAtIndex:0];
                
                NSArray *address = [element elementsForName:@"address"];
                GDataXMLElement *addressNode = [address objectAtIndex:0];
                
                NSArray* kDetaiCoupons = [element elementsForName:@"ktai_coupon"];
                GDataXMLElement *kDetaiCouponNode = [kDetaiCoupons objectAtIndex:0];
                
                //
                HPStoreEntity *storeEntity = [[HPStoreEntity alloc] init];
                storeEntity.storeId = idNode.stringValue;
                storeEntity.name = nameNode.stringValue;
                storeEntity.imageURL = logoImageNode.stringValue;
                storeEntity.nameKana = nameKanaNode.stringValue;
                storeEntity.address = addressNode.stringValue;
                storeEntity.kDetaiCoupon = [kDetaiCouponNode.stringValue integerValue];
                
                [_dataArray addObject: storeEntity];
                
                rowTask(storeEntity);
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

- (HPStoreEntity *)storeEntityAtIndex:(NSInteger)idx {
    return [_dataArray objectAtIndex:idx];
}

- (NSInteger)numberOfStore {
    return [_dataArray count];
}


@end
