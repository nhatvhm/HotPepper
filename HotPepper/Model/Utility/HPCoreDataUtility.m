//
//  HPCoreDataUtility.m
//  HotPepper
//
//  Created by Hiền Hoà Co.,LTD on 8/25/17.
//  Copyright © 2017 Hiền Hoà Co.,LTD. All rights reserved.
//

#import "HPCoreDataUtility.h"
#import "PrefixHeader.pch"

@implementation HPCoreDataUtility

+ (id) sharedInstance {
    
    static id _HPCoreDataUtilitySharedInstance;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (_HPCoreDataUtilitySharedInstance == NULL) {
            _HPCoreDataUtilitySharedInstance = [[self alloc] init];
        }
    });
    
    return(_HPCoreDataUtilitySharedInstance);
}


#pragma mark -

-(void) save {
    
    NSError *error = nil;
    if (![_moc save:&error]) {
        HHDebugPrint(@"Unresolved error %@, %@", error, [error userInfo]);
    }
    
}


#pragma mark -

- (NSManagedObjectModel *)mom {
    
    if (_mom != nil) {
        return _mom;
    }
    
    self.mom = [NSManagedObjectModel mergedModelFromBundles:nil];
    
    return _mom;
}

- (NSString *)appDocsPath {
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *basePath = ([paths count] > 0) ? [paths objectAtIndex:0] : nil;
    
    return basePath;
}

- (NSPersistentStoreCoordinator *)psc {
    
    if (_psc != nil) {
        return _psc;
    }else {
        
        NSString *storePath = [[self appDocsPath] stringByAppendingPathComponent:@"HotPepper.sqlite"];
        
        //
        NSError *error = nil;
        _psc = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:self.mom];
        
        //
        NSDictionary *optionDic = [NSDictionary dictionaryWithObjectsAndKeys:
                                   [NSNumber numberWithBool:YES],
                                   NSMigratePersistentStoresAutomaticallyOption,    //Automatic Migration
                                   [NSNumber numberWithBool:YES],
                                   NSInferMappingModelAutomaticallyOption,  //Infer Mapping Model
                                   nil];
        
        //
        if (![_psc addPersistentStoreWithType:NSSQLiteStoreType    //SQLite
                                configuration:nil
                                          URL:[NSURL fileURLWithPath:storePath]
                                      options:optionDic
                                        error:&error])
        {
            HHDebugPrint(@"Unresolved error %@, %@", error, [error userInfo]);
        }
        
        return _psc;
    }
}

- (NSManagedObjectContext *)moc {
    
    if (_moc != nil) {
        return _moc;
    }
    
    
    NSPersistentStoreCoordinator *_store = [self psc];
    
    if (_store != nil) {
        _moc = [NSManagedObjectContext new];
        [_moc setPersistentStoreCoordinator:_store];
    }
    
    return _moc;
}

@end
