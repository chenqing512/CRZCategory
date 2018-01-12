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
        
        
        Method oldObjectAtIndexSubscript = class_getInstanceMethod(objc_getClass("__NSArrayI"), @selector(objectAtIndexedSubscript:));
        Method newObjectAtIndexSubscript = class_getInstanceMethod(objc_getClass("__NSArrayI"), @selector(__nickyTsui__objectAtIndex:));
        method_exchangeImplementations(oldObjectAtIndexSubscript, newObjectAtIndexSubscript);
        
        
        
        //替换可变数组中的方法
        Method oldMutableObjectAtIndex = class_getInstanceMethod(objc_getClass("__NSArrayM"), @selector(objectAtIndex:));
        Method newMutableObjectAtIndex =  class_getInstanceMethod(objc_getClass("__NSArrayM"), @selector(mutableObjectAtIndex:));
        method_exchangeImplementations(oldMutableObjectAtIndex, newMutableObjectAtIndex);
        
        Method oldMutableObjectAtIndexSubscript = class_getInstanceMethod(objc_getClass("__NSArrayM"), @selector(objectAtIndexedSubscript:));
        Method newMutableObjectAtIndexSubscript = class_getInstanceMethod(objc_getClass("__NSArrayM"), @selector(mutableObjectAtIndex:));
        method_exchangeImplementations(oldMutableObjectAtIndexSubscript, newMutableObjectAtIndexSubscript);
        
        
        Method sourceMethod2 = class_getInstanceMethod(objc_getClass("__NSArrayM"), @selector(removeObjectAtIndex:));
        Method destMethod2 = class_getInstanceMethod(objc_getClass("__NSArrayM"), @selector(safeRemoveObjectAtIndex:));
        
        method_exchangeImplementations(sourceMethod2, destMethod2);
        
        Method sourceMethod3 = class_getInstanceMethod(objc_getClass("__NSArrayM"), @selector(insertObject:atIndex:));
        Method destMethod3 = class_getInstanceMethod(objc_getClass("__NSArrayM"), @selector(safeInsertObject:atIndex:));
        
        method_exchangeImplementations(sourceMethod3, destMethod3);
        
        Method sourceMethod4 = class_getInstanceMethod(objc_getClass("__NSArrayM"), @selector(replaceObjectAtIndex:withObject:));
        Method destMethod4 = class_getInstanceMethod(objc_getClass("__NSArrayM"), @selector(safeReplaceObjectAtIndex:withObject:));
        
        method_exchangeImplementations(sourceMethod4, destMethod4);
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

-(void)safeRemoveObjectAtIndex:(NSInteger)index
{
    if (self.count <= index) {
        NSLog(@"Runtime Warning:index %li out of bound",index);
        return;
    }
    
    [self safeRemoveObjectAtIndex:index];
}
-(void)safeInsertObject:(id)object atIndex:(NSInteger)index
{
    if (!object) {
        NSLog(@"Runtime Warning:insert object can not be nil");
        return;
    }
    
    if (self.count < index) {
        NSLog(@"Runtime Warning:insert object at index %li out of bound",index);
        return;
    }
    
    [self safeInsertObject:object atIndex:index];
}
-(void)safeReplaceObjectAtIndex:(NSInteger)index withObject:(id)object
{
    if (index >= self.count) {
        NSLog(@"Runtime Warning:index %li out of bound",index);
        return;
    }
    
    if (!object) {
        NSLog(@"Runtime Warning:object can not be empty");
        return;
    }
    
    [self safeReplaceObjectAtIndex:index withObject:object];
}

@end
