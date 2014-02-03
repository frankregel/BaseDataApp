//
//  UniversalDetailViewController.m
//  BaseDataApp
//
//  Created by Frank Regel on 03.02.14.
//  Copyright (c) 2014 Frank. All rights reserved.
//

#import "UniversalDetailViewController.h"

@interface UniversalDetailViewController ()

@end

@implementation UniversalDetailViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)renameTitleTo:(NSString *)detailViewTitle
{
    NSString *concatTitle = @"no title";
    if (detailViewTitle != nil && ![detailViewTitle isEqualToString:@""])
    {
        concatTitle = detailViewTitle;
        if (detailViewTitle.length >10)
        {
            concatTitle = [detailViewTitle substringToIndex:10];
        }
    }
    self.navigationItem.title = concatTitle;
}

#pragma mark - System
- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end