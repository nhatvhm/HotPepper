//
//  SDSCrashReporter.h
//
//  Created by KOSHIDA Takayoshi on 12/04/18.
//  Copyright (c) 2012 Recruit Co.,Ltd. All rights reserved.
//

#define SDSCRASHREPORTER_SDK_VERSION_STRING  @"2.1.1"

#import <Foundation/Foundation.h>

#define kSDSErrorLogAPIDevelopmentURL @"http://ASG-SDSDEV-LB-181011855.ap-northeast-1.elb.amazonaws.com/sds-api/report/"
#define kSDSErrorLogAPIProductionURL @"https://dev.r-mit.jp/sds-api/report/"
#define SDSErrorLogAPIDevelopmentURL kSDSErrorLogAPIDevelopmentURL
#define SDSErrorLogAPIProductionURL kSDSErrorLogAPIProductionURL

@class SDSCrashReport;

/*!
 クラッシュレポーターデリゲート
 */
@protocol SDSCrashReporterDelegate <NSObject>
@optional
/*!
 エラーログ生成時のアプリステータス指定用デリゲート
 
 当メソッドに反応してアプリの状態に関する文字列を返却すると、
 サイト側のエラーログに"appStatus"として表示されます。
 表示中の画面の情報などを送信してデバッグを行いやすくできます。
 
 @param onTerminate YES:アプリクラッシュによるエラーログ送信 / NO:任意タイミングのエラーログ送信
 @return アプリステータスを現す文字列（改行は無視されます）, nilや空文字の場合はエラーログに表示しません。
 */
- (NSString *)crashReporterAppStatusOnTerminate:(BOOL)onTerminate;

/*!
 アプリケーションが前回の実行中にクラッシュした場合の次回起動時に呼ばれるデリゲート
 
 @param クラッシュレポート
 */
- (void)crashReporterAppDidCrashInLastSession:(SDSCrashReport *)report;
@end

/*!
 レコーダーデリゲート
 */
@protocol SDSCrashReporterRecorderDelegate <NSObject>
/*!
 録画を開始する
 */
- (void)startScreenRecording;
/*!
 録画を終了する
 
 @return 録画ファイルのURL
 */
- (NSArray *)stopScreenRecording;
@end

/*!
 エラーログ収集クラス
 */
@interface SDSCrashReporter : NSObject

+ (SDSCrashReporter *)sharedManager;

/*!
 当メソッドをコールすることにより、SDK内のログを出力することができます。
 */
+ (void)outputLog;

/*!
 エラーログをSDSに送付
 
 当メソッドをコールしたタイミングで、exceptionに指定した例外情報をSDSにエラーログとして送付します。
 アプリのtry-catchや、任意のタイミングでNSExceptionを生成してエラーログを送付することができます。
 
 例1: 任意の例外を作成して送付する
   NSException *exception = [[NSException alloc] initWithName:@"My Exception 1"
                                reason:@"Something has gone wrong"
                                userInfo:@{@"key desu": @"value desu", @"aaaa": @"bbbb"}];
   [[SDSCrashReporter sharedManager] sendReportWithException:exception];
 
 例2: try-catchで取得した例外を送付する
   @try {
     NSArray *array = @[];
     NSLog(@"%@", array[99]);
   }
   @catch (NSException *exception) {
     [[SDSCrashReporter sharedManager] sendReportWithException:exception];
   }
 
 @param exception 例外情報
 @note 
   当メソッドをコールした結果、SDSへのエラーログの送付に成功／失敗の結果はアプリでは検知できません。
   また、一定期間内に多数の送付を行った場合や、連続で同一エラーを送ろうとした場合には、これを無視し送付を行いません。
 */
- (void)sendReportWithException:(NSException *)exception;

/*!
 SDSと連携するApp-IDを指定します。
 
 デフォルトでは、アプリのBundle IDで連携を行います。
 
 セットする場合には submissionURL をセットする前に呼ぶようにしてください。
 */
@property (nonatomic, copy) NSString *sdsAppId;

/*!
 submission URL defines where to send the crash reports to (required)

 development: SDSErrorLogAPIDevelopmentURL
 production: SDSErrorLogAPIProductionURL
 */
@property (nonatomic, copy) NSString *submissionURL;

/*!
 delegate is optional
 */
@property (nonatomic, assign) id<SDSCrashReporterDelegate> delegate;

/*!
 アプリ操作状況を録画するレコーダー
 
 レコーダーをプロパティ登録しておくと、クラッシュまでに操作していた状況の録画ファイルパスを、
 クラッシュ後の次回起動時にアプリで取得できます。
 
 レコーダーには、RSDで指定する RSScreenRecorder をインスタンス化してセットする必要があります。
 詳しくはwikiをご確認ください。
 */
@property (nonatomic, retain) id<SDSCrashReporterRecorderDelegate> recorder;

/*!
 アプリが前回クラッシュしたかのフラグ
 */
@property (nonatomic, readonly) BOOL didCrashInLastSession;

@end
