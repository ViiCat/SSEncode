//
//  Person.m
//  SSEncode
//
//  Created by Jason.Liu on 17/2/10.
//  Copyright © 2017年 ViiCat.com. All rights reserved.
//

#import "Person.h"
#import "objc/runtime.h"

@implementation Person

- (void)encodeWithCoder:(NSCoder *)aCoder{
    
     Class cls = [self class];   //cls指针处理完指向SuperClass
     
     while (cls != [NSObject class]) {
         
         unsigned int ivarCount = 0;
         unsigned int propCount = 0;
         unsigned int shareCount = 0;
         
         //判断是否是当前类，由于下面的[self valueForKey:key]，KVC获取父类成员变量会崩溃，所以获取父类的属性变量好了
         BOOL isSelfClass = (cls == [self class]);
         Ivar *ivarList = isSelfClass ? class_copyIvarList(cls, &ivarCount) : NULL;
         objc_property_t *propList = isSelfClass ? NULL : class_copyPropertyList(cls, &propCount);
         shareCount = isSelfClass ? ivarCount : propCount;
     
         for (int i = 0; i < shareCount; i++) {
     
             const char *varName = isSelfClass ? ivar_getName(*(ivarList + i)) : property_getName(*(propList + i));
             
             NSString *key = [NSString stringWithUTF8String:varName];
             
             id value = [self valueForKey:key];//使用KVC获取key对应的变量值
             
             //iOS中打印propertyList可能会发现有 superClass、description、debugDescription、hash等四个属性。对这几个属性进行encode操作会导致崩溃，因此在encode前需要屏蔽掉这些key
             NSArray *filters = @[@"superclass", @"description", @"debugDescription", @"hash"];
             
             if (value && [filters containsObject:key] == NO) {
                 [aCoder encodeObject:value forKey:key];
             }
             
             NSLog(@"序列化 Value:%@ Key:%@", value, key);
         }
         //记得释放
         free(ivarList);
         free(propList);
         cls = class_getSuperclass(cls);//cls指针处理完指向SuperClass
     }
}


- (instancetype)initWithCoder:(NSCoder *)aDecoder{
    
    Class cls = [self class];
    
    while (cls != [NSObject class]) {
        
        unsigned int ivarCount = 0;
        unsigned int propCount = 0;
        unsigned int shareCount = 0;
        
        BOOL isSelfClass = (cls == [self class]);
        Ivar *ivarList = isSelfClass ? class_copyIvarList(cls, &ivarCount) : NULL;
        objc_property_t *propList = isSelfClass ? NULL : class_copyPropertyList(cls, &propCount);
        
        shareCount = isSelfClass ? ivarCount : propCount;
        
        for (int i = 0; i < shareCount; i++) {
            
            const char *varName = isSelfClass ? ivar_getName(*(ivarList + i)) : property_getName(*(propList + i));
            
            NSString *key = [NSString stringWithUTF8String:varName];
            
            id value = [aDecoder decodeObjectForKey:key];//使用KVC获取key对应的变量值
            
            NSArray *filters = @[@"superclass", @"description", @"debugDescription", @"hash"];
            
            if (value && [filters containsObject:key] == NO) {
                [self setValue:value forKey:key];
            }
            
            NSLog(@"反序列化 Value:%@ Key:%@", value, key);
        }
        //记得释放
        free(ivarList);
        free(propList);
        cls = class_getSuperclass(cls);
    }
    return self;
}
@end
