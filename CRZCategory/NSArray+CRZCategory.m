//
//  NSArray+Category.m
//  TestDemo
//
//  Created by ChenQing on 17/10/10.
//  Copyright © 2017年 ChenQing. All rights reserved.
//

#import "NSArray+CRZCategory.h"
#import <objc/message.h>

@implementation NSArray (CRZCategory)

+(void)load{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        //替换不可变数组中的方法
        Method oldObjectAtIndex = class_getInstanceMethod(objc_getClass("__NSArrayI"), @selector(objectAtIndex:));
        Method newObjectAtIndex = class_getInstanceMethod(objc_getClass("__NSArrayI"), @selector(__nickyTsui__objectAtIndex:));
        method_exchangeImplementations(oldObjectAtIndex, newObjectAtIndex);
        //替换可变数组中的方法
        Method oldMutableObjectAtIndex = class_getInstanceMethod(objc_getClass("__NSArrayM"), @selector(objectAtIndex:));
        Method newMutableObjectAtIndex =  class_getInstanceMethod(objc_getClass("__NSArrayM"), @selector(mutableObjectAtIndex:));
        method_exchangeImplementations(oldMutableObjectAtIndex, newMutableObjectAtIndex);
    });
}

- (id)__nickyTsui__objectAtIndex:(NSUInteger)index{
    if (index > self.count - 1 || !self.count){
        NSLog(@"数组越界");
        @try {
            return [self __nickyTsui__objectAtIndex:index];
        } @catch (NSException *exception) {
            //__throwOutException  抛出异常
            return nil;
        } @finally {
            
        }
    }
    else{
        return [self __nickyTsui__objectAtIndex:index];
    }
}

- (id)mutableObjectAtIndex:(NSUInteger)index{
    if (index > self.count - 1 || !self.count){
        NSLog(@"可变数组越界...");
        @try {
            return [self mutableObjectAtIndex:index];
        } @catch (NSException *exception) {
            //__throwOutException  抛出异常
            return nil;
        } @finally {
            
        }
    }
    else{
        return [self mutableObjectAtIndex:index];
    }
}

@end
