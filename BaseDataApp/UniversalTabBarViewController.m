//
//  UniversalTabBarViewController.m
//  BaseDataApp
//
//  Created by Frank Regel on 03.02.14.
//  Copyright (c) 2014 Frank. All rights reserved.
//

#import "UniversalTabBarViewController.h"
#import "PickerViewController.h"
#import "TableViewController.h"


@interface UniversalTabBarViewController ()
@property UITabBarController *tabBarController;

@end

@implementation UniversalTabBarViewController

/*
- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController
{
    [viewController.navigationController popViewControllerAnimated:YES];
    NSLog(@"reingehüpft");
    [((UIViewController *)[tabBarController.viewControllers objectAtIndex:0] ).navigationController popViewControllerAnimated:YES];
    
}
*/

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self)
    {
        // Custom initialization
        PickerViewController *pickerViewController = [PickerViewController new];
        TableViewController *tableViewController = [TableViewController new];
        
        UINavigationController *tableNavigationController = [[UINavigationController alloc]initWithRootViewController:tableViewController];
                //dem CONTROLLER den String mitgeben, nicht auf self
        [tableNavigationController setTabBarItem:tableViewController.tableItem];
        
        UINavigationController *pickerNavigationController = [[UINavigationController alloc]initWithRootViewController:pickerViewController];
        [pickerNavigationController setTabBarItem:pickerViewController.pickerItem];
        
        
        NSArray *viewControllerArray = @[pickerNavigationController,tableNavigationController];
        
        
        [self loadRequestedViewControllerInTabBarWith:viewControllerArray];
        [self.view addSubview:_tabBarController.view];
        
    }
    return self;
}

- (void)loadRequestedViewControllerInTabBarWith:(NSArray *)viewControllerArray
{
    _tabBarController = [UITabBarController new];
    //_tabBarController.delegate = self;
    [_tabBarController setViewControllers:viewControllerArray animated:YES];
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
