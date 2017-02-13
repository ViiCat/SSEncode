//
//  ViewController.m
//  SSEncode
//
//  Created by Jason.Liu on 17/2/10.
//  Copyright © 2017年 ViiCat.com. All rights reserved.
//

#import "ViewController.h"
#import "Person.h"

@interface ViewController ()
@property (nonatomic, strong) Person *person;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    MainView *mView = [[MainView alloc] init];
    
    [mView.btnSerialize addTarget:self action:@selector(serializeButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [mView.btnDeserialize addTarget:self action:@selector(deserializeButtonClick) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:mView];
}

#pragma mark - <Action>
- (void)serializeButtonClick{
    [self.person setName:@"Jason"];
    [self.person setAge:18];
    [self.person setEyeColor:@"black"];
    
    //序列化对象并存储起来
    NSData *personData = [NSKeyedArchiver archivedDataWithRootObject:self.person];
    [[NSUserDefaults standardUserDefaults] setObject:personData forKey:@"Key_Person_Data"];
}

- (void)deserializeButtonClick{

    NSData *personData = [[NSUserDefaults standardUserDefaults] objectForKey:@"Key_Person_Data"];
    Person *person = [NSKeyedUnarchiver unarchiveObjectWithData:personData];
    NSLog(@"Name:%@ Age:%@", person.name, @(person.age));
}

#pragma mark - <LazyLoad>
- (Person *)person{
    if (!_person) {
        _person = [[Person alloc]init];
    }
    return _person;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
