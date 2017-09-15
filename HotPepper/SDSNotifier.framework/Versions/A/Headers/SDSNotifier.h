//
//  SDSNotifier.h
//  SDSNotifier
//
//  Created by tkoshida on 12/06/11.
//  Copyright 2012年 RECRUIT CO,LTD. All rights reserved.
//

#define SDSNOTIFIER_SDK_VERSION_STRING  @"1.3.0"

#import <Foundation/Foundation.h>

/*!
 SDS開発環境URL
 */
#define kSDSNotifierAPIDevelopmentURL @"http://ASG-SDSDEV-LB-181011855.ap-northeast-1.elb.amazonaws.com/sds-api/application/"

/*!
 SDS本番環境URL
 */
#define kSDSNotifierAPIProductionURL @"https://dev.r-mit.jp/sds-api/application/"

/*!
 Version Code: 通常アップデート
 */
#define kSDSNotifierAPIVersionUpCdNormalUpdate    1
/*!
 Version Code: 強制アップデート
 */
#define kSDSNotifierAPIVersionUpCdForceUpdate     2
/*!
 Version Code: 独自設定A
 */
#define kSDSNotifierAPIVersionUpCdCustomizedA     3
/*!
 Version Code: 独自設定B
 */
#define kSDSNotifierAPIVersionUpCdCustomizedB     4
/*!
 Version Code: 独自設定C
 */
#define kSDSNotifierAPIVersionUpCdCustomizedC     5
/*!
 Version Code: サービス停止
 */
#define kSDSNotifierAPIVersionUpCdSuspend         9

/*!
 Alert Types
 */
typedef NS_ENUM(NSInteger, SDSNotifierAlertType) {
    SDSNotifierAlertTypeVersionUp = 0,
    SDSNotifierAlertTypeNotification,
};

/*!
 This protocol is used to receive the updates and notifications.
 */
@protocol SDSNotifierDelegate <NSObject>
/*!
 App Store URL
 */
@property (nonatomic, copy) NSString *updateURL;
@optional
/*!
 SDSサーバーからアップデート情報／お知らせ情報を取得したときに呼ばれるdelegateメソッド
 
 updates, notificationsには、SDSサーバーから受信した情報をNSDictionaryで格納し、
 件数分のNSArrayにまとめた形式となります。
 updates, notificationsは空要素でも必ずNSArrayオブジェクトとなります。
 
 サーバーでは条件に合致したものだけを返却してきます。
 updatesの場合には、アプリのバージョンより低いものが管理画面から登録されていてもレスポンスには入ってきます。
 バージョンの比較は、1.2.0と1.11.0のような比較でも、1.11.0の方が新しいものとして正しく判定されます。
 notificationsの場合には、期間、バージョンを判定し、合致しないものはレスポンスには入ってきません。
 
 当メソッドはメインスレッドでコールされます。

 @param updates: SDSNotifierUpdateEntityの配列
 @param notifications: SDSNotifierNotificationEntityの配列
 */
- (void)notifierDidReceiveEntitiesOfUpdates:(NSArray *)updates notifications:(NSArray *)notifications;

/*!
 SDSサーバーからアップデート情報／お知らせ情報を取得したときに呼ばれるdelegateメソッド
 
 updates, notificationsには、SDSサーバーから受信した情報をNSDictionaryで格納し、
 件数分のNSArrayにまとめた形式となります。
 updates, notificationsは空要素でも必ずNSArrayオブジェクトとなります。
 
 サーバーでは条件に合致したものだけを返却してきます。
 updatesの場合には、アプリのバージョンより低いものが管理画面から登録されていてもレスポンスには入ってきます。
 バージョンの比較は、1.2.0と1.11.0のような比較でも、1.11.0の方が新しいものとして正しく判定されます。
 notificationsの場合には、期間、バージョンを判定し、合致しないものはレスポンスには入ってきません。
 
 当メソッドはサブスレッドでコールされます。
 
 @param updates: NSDictionaryの配列
   各NSDictionary要素（サーバーレスポンス内容）は次の通り
   app_version       アプリバージョン    例:1.0.2
   versionup_cd      バージョンコード    例:2 (強制更新)
   versionup_message バージョンメッセージ 例:新しいバージョンに更新してください
   locale            ロケール           例:ja_JP
 @param notifications: NSDictionaryの配列
   各NSDictionary要素（サーバーレスポンス内容）は次の通り
   number            お知らせ番号      例:10
   version_from      バージョンFROM   例:1.1.0
   version_to        バージョンTO     例:2.0.1
   term_from         期間FROM          例:2012-03-15T18:00.00.000+09:00
   term_to           期間TO            例:2012-04-01T18:00.00.000+09:00
   locale            ロケール           例:ja_JP
   data              下記NSDictionaryの配列
     name          プロパティ名      例:content
     value         プロパティ値      例:キャンペーンが始まりました！！
 */
- (void)notifierDidReceiveUpdates:(NSArray *)updates notifications:(NSArray *)notifications;

/*!
 SDSサーバーからアップデート情報／お知らせ情報の取得に失敗した場合に呼ばれるdelegateメソッド
 */
- (void)notifierDidFailWithError:(NSError *)error;

@end

/*!
 SDSお知らせ／バージョンアップ通知クラス
 */
@interface SDSNotifier : NSObject {
    NSString *_requestURL;
    
    id <SDSNotifierDelegate> _delegate;
    NSOperationQueue *_queue;
    
    NSUInteger _interval;
    NSDate *_notifiedAt;
}

+ (SDSNotifier *)sharedManager;

/*!
 当メソッドをコールすることにより、SDK内のログを出力することができます。
 */
+ (void)outputLog;

/*!
 お知らせ／アップデートの確認を行う
 
 @return
   YES:サーバー確認を行います。
   NO:無反応期間内のため、確認を行いません。
 */
- (BOOL)check;

/*!
 ロケール指定
 
 デフォルトではSDKは自動で端末のロケール情報を取得しSDSサーバーに送信しますが、
 独自に指定したい場合には当プロパティから文字列で指定してください。
 
 例：ja_JP
 
 デフォルトでは、設定＞言語環境＞言語 の設定に依存した、2桁の言語設定(例:ja）を利用します。
 */
@property (nonatomic, copy) NSString *locale;

/*!
 SDSと連携するApp-IDを指定します。
 
 デフォルトでは、アプリのBundle IDで連携を行います。
 */
@property (nonatomic, copy) NSString *sdsAppId;

/*!
 request URL defines where to send the request to (required)
 
 development: kSDSNotifierAPIDevelopmentURL
 production: SDSNotifierAPIProductionURL
 */
@property (nonatomic, retain) NSString *requestURL;

/*!
 サーバー確認した通知情報やエラー情報を利用側に渡すデリゲートです。
 */
@property (nonatomic, assign) id <SDSNotifierDelegate> delegate;

/*!
 checkメソッドの無反応期間（default: 5min）
 
 変更したい場合にはミリ秒で指定します。
 デバッグ時には0に設定し、リリース時にはデフォルトに戻すなりしてください。
 */
@property (nonatomic, assign) NSUInteger interval; 

@end
