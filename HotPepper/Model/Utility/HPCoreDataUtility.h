//
//  HPCoreDataUtility.h
//  HotPepper
//
//  Created by Hiền Hoà Co.,LTD on 8/25/17.
//  Copyright © 2017 Hiền Hoà Co.,LTD. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@interface HPCoreDataUtility : NSObject

@property (nonatomic, strong) NSManagedObjectModel *mom;


@property (nonatomic, strong) NSManagedObjectContext *moc;


@property (nonatomic, strong) NSPersistentStoreCoordinator *psc;


+ (HPCoreDataUtility *) sharedInstance;


- (void) save;



@end
