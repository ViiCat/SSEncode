//
//  MainView.m
//  SSEncode
//
//  Created by Jason.Liu on 17/2/10.
//  Copyright © 2017年 ViiCat.com. All rights reserved.
//

#import "MainView.h"

@implementation MainView

- (instancetype)init
{
    self = [super init];
    if (self) {
        
        [self createUI];
    }
    return self;
}

- (void)createUI{
    
    CGRect _rect = [UIScreen mainScreen].bounds;
    
    self.frame = _rect;
    
    if (!self.btnSerialize) {
        self.btnSerialize = [self createButtonWithTitle:@"序列化"];
        self.btnSerialize.frame = CGRectMake(_rect.origin.x, _rect.origin.y + 50, _rect.size.width, 30);
    }
    
    if (!self.btnDeserialize) {
        self.btnDeserialize = [self createButtonWithTitle:@"反序列化"];
        self.btnDeserialize.frame = CGRectMake(_rect.origin.x, _rect.origin.y + 100, _rect.size.width, 30);
    }
    

    [self addSubview:self.btnSerialize];
    [self addSubview:self.btnDeserialize];
}


#pragma mark - <Other>
- (UIButton *)createButtonWithTitle:(NSString *)title{
    UIButton *btn = [[UIButton alloc]init];
    [btn setBackgroundColor:[UIColor redColor]];
    [btn setTitle:title forState:UIControlStateNormal];
    return btn;
}

@end
