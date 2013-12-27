//
//  homesViewController.m
//  times
//
//  Created by Netcoc on 13-12-24.
//  Copyright (c) 2013年 Netcoc. All rights reserved.
//

#import "homesViewController.h"
@interface homesViewController ()

@end

@implementation homesViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    NSDate * senddates=[NSDate date];//当前时间
	datapickview *dak = [[datapickview alloc]initWithFrame:CGRectMake(0, 100, 320, 120)];
    dak.Delegate = self;
    dak.istime = YES;
    [dak setdate:senddates];
    [self.view addSubview:dak];
}
#pragma mark  DatapickviewDelegate
-(void)getdeta:(NSDate *)dataarray{
    NSLog(@"%@",dataarray);
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
