//
//  SDSNotifierDataEntity.h
//  SDSNotifier
//
//  Created by KOSHIDA Takayoshi on 2013/12/11.
//
//

#import <Foundation/Foundation.h>

@interface SDSNotifierDataEntity : NSObject

/*!
 プロパティ名
 例:content
 */
@property (nonatomic, copy) NSString *name;

/*!
 プロパティ値
 例:キャンペーンが始まりました！！
 */
@property (nonatomic, copy) NSString *value;

@end
