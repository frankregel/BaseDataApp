//
//  ToolBarViewController.m
//  BaseDataApp
//
//  Created by Frank on 02.02.14.
//  Copyright (c) 2014 Frank. All rights reserved.
//

#import "ToolBarViewController.h"
#import "TableViewController.h"
#import "PickerViewController.h"
#import "GraphicsProtocol.h"

@interface ToolBarViewController ()//<GraphicsProtocol>
@property UIToolbar *bottomToolBar;
@property UINavigationBar *topNavBar;
@property TableViewController *tableViewController;
@property PickerViewController *pickerViewController;
@property UIButton *tableStartButton;
@property UIButton *pickerStartButton;
@end

@implementation ToolBarViewController
/*
-(void)pickerButtonTouched:(UIViewController *)pickerViewController
{
    
    [self.view bringSubviewToFront:pickerViewController.view];
    NSLog(@"picker Button touched");
#warning UINavigationController???? Siehe AppDelegate
}

-(void)tableButtonTouched:(UIViewController *)tableViewController
{
    [self.view bringSubviewToFront:tableViewController.view];
}
*/
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self)
    {
        // Custom initialization
        _tableViewController = [TableViewController new];
        _pickerViewController = [PickerViewController new];

        [self loadBottomToolBar];
        
    }
    return self;
}


- (void)loadBottomToolBar
{
    int tabBarHeight = 50;
    int viewHeight = self.view.bounds.size.height;
    int viewWidth = self.view.bounds.size.width;
    
#warning No Idea, no Tutrial...
    //_topNavBar = [UINavigationBar new];//alloc]initWithFrame:CGRectMake(0, 0, viewWidth, tabBarHeight)];
    //[self.view addSubview:_topNavBar];
    
    //[self.navigationItem setBackBarButtonItem:UIBarButtonItemStyleBordered];
    
    _bottomToolBar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, viewHeight- tabBarHeight, viewWidth, tabBarHeight)];
    [self.view addSubview:_bottomToolBar];
    
    
    UIBarButtonItem *tableItem = [[UIBarButtonItem alloc] initWithTitle:@"tableView"
                                                                  style:UIBarButtonItemStyleBordered
                                                                 target:self
                                                                 action:@selector(tableButtonTouched)];
    
    UIBarButtonItem *pickerItem = [[UIBarButtonItem alloc] initWithTitle:@"pickerView"
                                                                   style:UIBarButtonItemStyleBordered
                                                                  target:self
                                                                  action:@selector(pickerButtonTouched)];
    
    UIBarButtonItem *flexItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace
                                                                              target:nil
                                                                              action:nil];

    //Der UIToolbar die Items hinzufügen
    [_bottomToolBar setItems:@[tableItem, flexItem, pickerItem] animated:YES];
    
    
}

-(void) tableButtonTouched
{

    [self.view addSubview:_tableViewController.view];
}

-(void) pickerButtonTouched
{

    [self.view addSubview:_pickerViewController.view];

}

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


