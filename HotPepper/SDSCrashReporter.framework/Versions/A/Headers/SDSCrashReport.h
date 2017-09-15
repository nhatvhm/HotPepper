//
//  SDSCrashReport.h
//  SDSCrashReporter
//
//  Created by KOSHIDA Takayoshi on 12/05/10.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

@class PLCrashReport;

typedef NS_ENUM(NSInteger, SDSExceptionType) {
    SDSExceptionTypeSystem = 0,
    SDSExceptionTypeApplication,
};

@interface SDSCrashReport : NSObject

+ (NSString *)crashDirPath;
+ (instancetype)reportWithErrorName:(NSString *)errorName
                      errorLocation:(NSString *)errorLocation
                         stackTrace:(NSString *)stackTrace
                               kind:(NSString *)kind
                               type:(SDSExceptionType)type
                   stackTraceHeader:(NSString *)stackTraceHeader
                        onTerminate:(BOOL)onTerminate;
- (instancetype)initWithDictionary:(NSDictionary *)dictionary;
- (instancetype)initWithPLCrashReport:(PLCrashReport *)report stackTraceHeader:(NSString *)stackTraceHeader shortVersion:(NSString *)shortVersion;
- (void)save;
+ (instancetype)loadFromFilePath:(NSString *)filepath;
+ (void)discardAtFilePath:(NSString *)filepath;

@property (nonatomic, readonly, copy) NSString *appIdText;
@property (nonatomic, readonly, copy) NSString *versionName;
@property (nonatomic, readonly, copy) NSString *versionCode;
@property (nonatomic, readonly, copy) NSString *deviceName;
@property (nonatomic, readonly, copy) NSString *modelName;
@property (nonatomic, readonly, copy) NSString *osVersion;
@property (nonatomic, readonly, copy) NSString *date;
@property (nonatomic, readonly, copy) NSString *errorName;
@property (nonatomic, readonly, copy) NSString *stackTrace;
@property (nonatomic, readonly, copy) NSString *crashReport;
@property (nonatomic, readonly, copy) NSString *vmAddr;
@property (nonatomic, readonly, copy) NSString *errorLocation;
@property (nonatomic, readonly, copy) NSString *stackTraceHeader;
@property (nonatomic, readonly, strong) NSNumber *exceptionType;
@property (nonatomic, readonly, copy) NSArray *recordFiles;
@property (nonatomic, readonly, copy) NSString *formattedStackTrace;
@property (nonatomic, readonly, copy) NSString *kind;

@end
