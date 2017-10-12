//
//  NSString+CRZCategory.h
//  TestDemo
//
//  Created by ChenQing on 17/10/11.
//  Copyright © 2017年 ChenQing. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (CRZCategory)

- (NSString *) subString:(NSUInteger) fromIndex toIndex:(NSUInteger) toIndex;

- (BOOL) contains:(NSString *)str;

- (BOOL) equalsIgnoreCase:(NSString *) str;
/*
 * 去除字符串左边空格
 */
- (NSString *) ltrim;
/*
 * 去除字符串右边空格
 */
- (NSString *) rtrim;
/*
 * 去除字符串空格
 */
- (NSString *) trim;

- (NSString *) replace:(NSString *) find replaceWith: (NSString *)replace;

-(NSString *) reverseString;
//SHA1加密
- (NSString *) sha1;

//URLEncode
+(NSString*)encodeString:(NSString*)unencodedString;
//URLDEcode
-(NSString *)decodeString:(NSString*)encodedString;

//随机生成32位字符串
+(NSString *)ret32bitString;


// MD5 hash of the file on the filesystem specified by path
+ (NSString *) stringWithMD5OfFile: (NSString *) path;
// The string's MD5 hash
- (NSString *) MD5Hash;

@end
