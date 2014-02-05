//
//  TableViewController.m
//  DataSucker
//
//  Created by Frank Regel on 23.01.14.
//  Copyright (c) 2014 Frank Regel. All rights reserved.
//

#import "TableViewController.h"
#import "DataSourceModel.h"
#import "UniversalDetailViewController.h"
#import "NoteBookViewController.h"
#import "NoteCell.h"
#import "AppConfig.h"

@interface TableViewController ()
@property NSArray *postArray;
@property NSMutableArray *mutableImageArray;
@property UniversalDetailViewController *detailViewController;
@property NSDictionary *noteBookDict;
@property NSMutableArray *noteBookArray;
//@property NSMutableArray *noteBookTimeArray;
@property NoteBookViewController *noteBookViewController;
//@property DataSourceModel *dataSource;

@end

@implementation TableViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self)
    {
        self.view.backgroundColor = [UIColor whiteColor];
        //Bezeichner für die Navbar
        self.navigationItem.title = @"table";
        
        UIBarButtonItem *addButton = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(loadNoteBook)];
        
        self.navigationItem.rightBarButtonItem = addButton;
        
        _tableItem = [[UITabBarItem alloc]initWithTitle:@"Table" image:nil tag:0];
        _tableItem.titlePositionAdjustment = UIOffsetMake(0 , -20);
        _detailViewController = [UniversalDetailViewController new];

        [self loadPostObjectsFromSource];
        
        _noteBookViewController = [NoteBookViewController new];
        _noteBookViewController.modalPresentationStyle = UIModalPresentationFormSheet;
        _noteBookViewController.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
        
        _noteBookArray = [NSMutableArray new];
        
        //table hört zu, aber reagiert nur auf meldungen aus Datasourcemodel, hier: useDataMethod, da Shared Instance
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(updateTableContentWithDict:) name:BDANotification_notesUpdated object:[DataSourceModel useDataMethod]];
        // Custom initialization
    }
    return self;
}

- (void)loadNoteBook
{
    [_noteBookViewController setContentAndTimeStampWith:@"" and:@""];
    [self presentViewController:_noteBookViewController animated:YES completion:nil];
}


#pragma mark - Datenquelle
- (void)updateTableContentWithDict:(NSNotification *)noteFromDataSourceModel
{
    _noteBookDict = [noteFromDataSourceModel userInfo];
    [self setValuesInArrays];
}

- (void)loadPostObjectsFromSource
{
    _noteBookDict = [[DataSourceModel useDataMethod]loadNotesDict];
    [self setValuesInArrays];
    
}

#warning Sortieralgorythmus auftreiben "NSSortDescriptor"
- (void)setValuesInArrays
{
    [_noteBookArray removeAllObjects];
    for (NSString *oldTimeStampKey in _noteBookDict.allKeys)
    {
        //objectforKey ist der Wert der neben dem Key gespeichert wurde
        NSString *noteContent = [_noteBookDict objectForKey:oldTimeStampKey];
        
        NSDictionary *oneDict = @{@"timestamp": oldTimeStampKey,@"value":noteContent};
        [_noteBookArray addObject:oneDict];
    }
    
    
    //NSMutableArray *sortArray = [NSMutableArray new];
    
    //NSString *oneString;
    
   // for (oneString in )
    
    //Inhalte der Tabelle aktualisieren
    [self.tableView reloadData];
}
#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    //Sektionen sind die Gruppierungsüberschriften
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return _noteBookArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    //Verwenden der SubClass NoteCell um nicht jedes mal die labels neu zu instanzieren und zu adden
    NoteCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil)
    {
        cell = [[NoteCell alloc] initWithStyle:UITableViewCellStyleDefault
                                      reuseIdentifier:CellIdentifier];
    }
    NSDictionary *oneDict = [_noteBookArray objectAtIndex:indexPath.row];
    
    [cell setDateLabelValue:[oneDict objectForKey:@"timestamp"]];
    [cell setNoteLabelValue:[oneDict objectForKey:@"value"]];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;

    return cell;
}

-(void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    NSDictionary *oneDict = [_noteBookArray objectAtIndex:indexPath.row];
    
    NSString *touchString = [oneDict objectForKey:@"value"];
    NSString *dateString = [oneDict objectForKey:@"timestamp"];
    
    [_noteBookViewController setContentAndTimeStampWith:touchString and:dateString];
    [self presentViewController:_noteBookViewController animated:YES completion:nil];
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a story board-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}

 */

@end
