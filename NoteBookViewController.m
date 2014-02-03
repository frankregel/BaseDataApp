//
//  NoteBookViewController.m
//  BaseDataApp
//
//  Created by Frank Regel on 03.02.14.
//  Copyright (c) 2014 Frank. All rights reserved.
//

#import "NoteBookViewController.h"
#import "DataSourceModel.h"

@interface NoteBookViewController ()
@property UITextView *textInputView;
@end

@implementation NoteBookViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self)
    {
        self.view.backgroundColor = [UIColor lightGrayColor];
        [self loadQuitAndSaveButton];
        [self loadTextField];
        
        // Custom initialization
    }
    return self;
}


- (void)loadQuitAndSaveButton
{
    UIButton *quitAndSaveButton = [[UIButton alloc]initWithFrame:CGRectMake(self.view.frame.size.width -100, self.view.frame.size.height-470, 100, 44)];
    [quitAndSaveButton setTitle:@"Fertig" forState:UIControlStateNormal];
    [quitAndSaveButton addTarget:self action:@selector(saveCalled) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:quitAndSaveButton];
    
}

- (void)loadTextField
{
    _textInputView = [[UITextView alloc]initWithFrame:CGRectMake(10, 70, 300, 190)];
    _textInputView.backgroundColor = [UIColor whiteColor];
    _textInputView.textColor = [UIColor blackColor];
    [self.view addSubview:_textInputView];
    
}

- (void)saveCalled
{
    NSLog(@"Fertig");
    
    NSString *submitString = _textInputView.text;
    NSDate *submitDate = [NSDate date];
    
    [[DataSourceModel useDataMethod]saveNoteToFileWith:submitString andDate:submitDate];
    
    [self dismissViewControllerAnimated:YES completion:nil];
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
