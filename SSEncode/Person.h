//
//  Person.h
//  SSEncode
//
//  Created by Jason.Liu on 17/2/10.
//  Copyright © 2017年 ViiCat.com. All rights reserved.
//

#import "Primate.h"

@interface Person : Primate<NSCoding>{
    NSString *_father;
}

@property (nonatomic, copy) NSString *name;
@property (nonatomic, assign) NSInteger age;
@end
