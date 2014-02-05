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
@property NSString *timeStampString;
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

- (void)setContentAndTimeStampWith:(NSString *)contentString and:(NSString *)timeStampString
{
    _textInputView.text = contentString;
    _timeStampString = timeStampString;
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
    //prüfen ob das Textfeld leer ist
    if (![_textInputView.text isEqualToString:@""])
        
    {
        NSString *submitString = _textInputView.text;
        
        //prüfen ob ein timestamp existiert
        if ([_timeStampString isEqualToString:@""])
        {
            NSDate *submitDate = [NSDate date];
            NSInteger timestamp = [submitDate timeIntervalSince1970];
            _timeStampString = [NSString stringWithFormat:@"%d",timestamp];

        }
        [[DataSourceModel useDataMethod]saveNoteToFileWith:submitString andTimeStampString:_timeStampString];
    }

    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)viewDidAppear:(BOOL)animated
{
    //Fokus auf den inputView setzen, damit er gleich editierbar ist. Keyboard fährt per default hoch. Der gegenspieler ist resignFirstResponder
    [_textInputView becomeFirstResponder];
    
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
