//
//  SDSNotifierUpdateEntity.h
//  SDSNotifier
//
//  Created by KOSHIDA Takayoshi on 2013/12/11.
//
//

#import <Foundation/Foundation.h>

@interface SDSNotifierUpdateEntity : NSObject

/*!
 アプリバージョン    例:1.0.2
 */
@property (nonatomic, copy) NSString *app_version;

/*!
 バージョンコード    例:2 (強制更新)
 */
@property (nonatomic) NSInteger versionup_cd;

/*!
 バージョンメッセージ 例:新しいバージョンに更新してください
 */
@property (nonatomic, copy) NSString *versionup_message;

/*!
 ロケール           例:ja_JP
 */
@property (nonatomic, copy) NSString *locale;

@end
