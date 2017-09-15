//
//  SDSNotifierNotificationEntity.h
//  SDSNotifier
//
//  Created by KOSHIDA Takayoshi on 2013/12/11.
//
//

#import <Foundation/Foundation.h>
#import "SDSNotifierDataEntity.h"

@interface SDSNotifierNotificationEntity : NSObject

/*!
 お知らせ番号
 例:10
 */
@property (nonatomic) NSInteger number;

/*!
 バージョンFROM
 例:1.1.0
 */
@property (nonatomic, copy) NSString *version_from;

/*!
 バージョンTO
 例:2.0.1
 */
@property (nonatomic, copy) NSString *version_to;

/*!
 期間FROM
 例:2012-03-15T18:00.00.000+09:00
 */
@property (nonatomic, strong) NSDate *term_from;

/*!
 期間TO
 例:2012-04-01T18:00.00.000+09:00
 */
@property (nonatomic, strong) NSDate *term_to;

/*!
 ロケール
 例:ja_JP
 */
@property (nonatomic, copy) NSString *locale;

/*!
 SDSNotifierDataEntityの配列
 */
@property (nonatomic, strong) NSMutableArray *data;

@end
