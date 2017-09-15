//
//  PBookmarkManager.m
//  HotPepper
//
//

#import "HPBookmarkManager.h"

@interface HPBookmarkManager() {
    NSMutableArray *_dataArray;
}

@end

@implementation HPBookmarkManager

+ (HHManagerBase*)sharedInstance
{
    static id _LPBookmarkManagerSharedInstance;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (_LPBookmarkManagerSharedInstance == NULL) {
            _LPBookmarkManagerSharedInstance = [[self alloc] init];
        }
    });
    
    return(_LPBookmarkManagerSharedInstance);
}

- (id) init {
    if (self = [super init]) {
        _dataArray = [[NSMutableArray alloc] init];
    }
    
    return self;
}

- (void) beginFetchWithSuccessTask:(void (^)())successTask
                           rowTask:(void (^)(HPBookmarkedStoreEntity*))rowTask
{
    
    //
    [_dataArray removeAllObjects];
    
    //
    HPCoreDataUtility *cda = [HPCoreDataUtility sharedInstance];
    
    //
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    [request setEntity:[NSEntityDescription entityForName:@"HPBookmarkedStoreEntity"
                                   inManagedObjectContext:cda.moc]];
    
    //
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"created" ascending:NO];
    [request setSortDescriptors:[NSArray arrayWithObjects:sortDescriptor,nil]];
    
    //
    [_dataArray removeAllObjects];
    
    //
    NSError *anyError = nil;
    NSArray *results = [cda.moc executeFetchRequest:request error:&anyError];
    if( !results ) {
        HHDebugPrint(@"Error = %@", anyError);
    } else {
        for (id obj in results) {
            [_dataArray addObject:obj];
            
            rowTask(obj);
        }
    }
    
    //
    successTask();
    
}


//
- (HPBookmarkedStoreEntity *)addBookmark:(HPStoreEntity *)store {
    
    [_dataArray addObject:store];
    
    //
    HPCoreDataUtility *cda = [HPCoreDataUtility sharedInstance];
    
    //
    HPBookmarkedStoreEntity *newBookmark = [NSEntityDescription insertNewObjectForEntityForName:@"HPBookmarkedStoreEntity"
                 inManagedObjectContext:cda.moc];
    newBookmark.address = store.address;
    //newBookmark.kDetaiCoupon = store.kDetaiCoupon;
    newBookmark.logoImageURL = store.imageURL;
    newBookmark.name = store.name;
    newBookmark.nameKana = store.nameKana;
    newBookmark.storeId = store.storeId;
    newBookmark.created = [NSDate date];
    
    //
    [cda save];
    
    return newBookmark;
}


- (HPBookmarkedStoreEntity *)searchBookmark:(NSString *)storeId {
    
    //
    HPCoreDataUtility *cda = [HPCoreDataUtility sharedInstance];
    
    //
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    [request setEntity:[NSEntityDescription entityForName:@"HPBookmarkedStoreEntity"
                                   inManagedObjectContext:cda.moc]];
    
    NSMutableArray *array = [NSMutableArray array];
    [array addObject:[NSPredicate predicateWithFormat:@"(storeId = %@)", storeId]];
    
    NSPredicate *predicate = [NSCompoundPredicate andPredicateWithSubpredicates:array];
    [request setPredicate:predicate];
    
    NSError *anyError = nil;
    NSArray *results = [cda.moc executeFetchRequest:request error:&anyError];
    if ([results count] > 0) {
        return [results objectAtIndex:0];
    }
    
    return nil;
}


- (void) deleteBookmark:(HPBookmarkedStoreEntity *)bookmark {
    
    //
    HPCoreDataUtility *cda = [HPCoreDataUtility sharedInstance];
    [cda.moc deleteObject:bookmark];
    
    [_dataArray removeObject:bookmark];
    
    //
    [cda save];
}


- (NSInteger) deleteAllBookmark {
    
    HPCoreDataUtility* cda = [HPCoreDataUtility sharedInstance];
    
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    [request setEntity:[NSEntityDescription entityForName:@"HPBookmarkedStoreEntity"
                                   inManagedObjectContext:cda.moc]];
    
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"created" ascending:NO];
    [request setSortDescriptors:[NSArray arrayWithObjects:sortDescriptor,nil]];
    
    //
    [_dataArray removeAllObjects];
    
    //Check delete all bookmared didn't exist
    if (!request.entity) {
        return -1;
    }
    
    //Execute request
    NSError *anyError = nil;
    NSArray *results = [cda.moc executeFetchRequest:request error:&anyError];
    
    
    
    if( !results ) {
        HHDebugPrint(@"Error = %@", anyError);
    } else {
        for (id obj in results) {
            [cda.moc deleteObject:obj];
        }
    }
    
    [cda save];
    return 0;
}


- (HPBookmarkedStoreEntity *)bookmarkAtIndex:(NSInteger) idx {
    return [_dataArray objectAtIndex:idx];
}


- (NSInteger) numberOfBookmark {
    return [_dataArray count];
}


@end
