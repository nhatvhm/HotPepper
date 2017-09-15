//
//  HPPropertyListUtility.m
//  HotPepper
//
//  Created by Hiền Hoà Co.,LTD on 8/25/17.
//  Copyright © 2017 Hiền Hoà Co.,LTD. All rights reserved.
//

#import "HPPropertyListUtility.h"
#import "PrefixHeader.pch"

@implementation HPPropertyListUtility

+ (id) valueForKeyOfMaster:(NSString*)keyName master:(NSString*) masterName {
    
    //
    NSString *plistPath = [[NSBundle mainBundle] pathForResource:masterName ofType:@"plist"];
    if (![[NSFileManager defaultManager] fileExistsAtPath:plistPath]) {
        
        NSString *documentRootPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
        plistPath = [documentRootPath stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.plist", masterName]];
        
        if (![[NSFileManager defaultManager] fileExistsAtPath:plistPath]) {
            /*
             An unavoidable error. The specified master file does not exist. Display a dialog.
             */
            
        }
    }
    
    //
    NSData *plistXML = [[NSFileManager defaultManager] contentsAtPath:plistPath];
    
    NSPropertyListFormat format;
    NSString *errorDesc = nil;
    NSDictionary *propertyListDic = (NSDictionary *)[NSPropertyListSerialization propertyListFromData:plistXML
                                                                                     mutabilityOption:kCFPropertyListImmutable
                                                                                               format:&format
                                                                                     errorDescription:&errorDesc];
    //
    if (propertyListDic) {
        return [propertyListDic valueForKey:keyName];
    }
    
    HHDebugPrint(@"Error reading plist: %@, format: %zd", errorDesc, format);
    return nil;
}


@end
