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

@interface TableViewController ()
@property NSArray *postArray;
@property NSMutableArray *mutableImageArray;
@property UniversalDetailViewController *detailViewController;
@property NSDictionary *noteBookDict;
@property NSMutableArray *noteBookArray;
@property NSMutableArray *noteBookTimeArray;
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
        // Custom initialization
    }
    return self;
}

- (void)loadNoteBook
{
    NoteBookViewController *noteBookViewController = [NoteBookViewController new];
    noteBookViewController.modalPresentationStyle = UIModalPresentationFormSheet;
    noteBookViewController.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
    [self presentViewController:noteBookViewController animated:YES completion:nil];
    
}


#pragma mark - Datenquelle
-(void) loadPostObjectsFromSource
{
    _noteBookDict = [[DataSourceModel useDataMethod]loadNotesDict];
    _noteBookArray = [[NSMutableArray alloc]initWithArray:_noteBookDict.allValues];
    _noteBookTimeArray = [[NSMutableArray alloc]initWithArray:_noteBookDict.allKeys];
    
#warning damit wären die Timestamps aber weg...
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
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                      reuseIdentifier:CellIdentifier];
    }
    
    UILabel *dateLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 100, 50)];
    UILabel *noteLabel = [[UILabel alloc]initWithFrame:CGRectMake(110, 0, 200, 50)];
    dateLabel.text = [_noteBookTimeArray objectAtIndex:indexPath.row];
    noteLabel.text = [_noteBookArray objectAtIndex:indexPath.row];
    [cell addSubview:noteLabel];
    [cell addSubview:dateLabel];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    // Configure the cell...
    
    //cell.textLabel.text = [_noteBookArray objectAtIndex:indexPath.row];
    
#warning geht aber die timestamps sind dann futsch
    //cell.textLabel.text = [_noteBookDict objectForKey:@"1391454144"];
    
    /*
    NSDictionary *oneResultDict = [_postArray objectAtIndex:indexPath.row];
    cell.textLabel.text = [oneResultDict objectForKey:@"title"];
                            
    UIImage *tmpImage = [_mutableImageArray objectAtIndex:indexPath.row];
    cell.imageView.image = tmpImage;*/
    return cell;
}

#warning hier die Daten aus dem File holen
-(void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    NSString *touchString = [_noteBookArray objectAtIndex:indexPath.row];
#warning auch das gefällt mir nicht, da ich nicht aufs Datum tippen kann
    [_detailViewController renameTitleTo:touchString];
    [_detailViewController addContentToTextfieldWith:touchString];
    [self.navigationController pushViewController:_detailViewController animated:YES];
    
    /*UIAlertView *touchAlertView = [[UIAlertView alloc] initWithTitle:@"Touch Information"
                                                             message:touchString
                                                            delegate:self
                                                   cancelButtonTitle:@"OK"
                                                   otherButtonTitles: nil];
        [touchAlertView show];*/
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
