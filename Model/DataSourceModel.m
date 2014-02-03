//
//  DataSourceModel.m
//  DataSucker
//
//  Created by Frank Regel on 24.01.14.
//  Copyright (c) 2014 Frank Regel. All rights reserved.
//

#import "DataSourceModel.h"

@interface DataSourceModel()
@property NSArray *postArray;
@property NSMutableArray *mutableImageArray;
@property NSMutableDictionary *mutableTextInputDict;


@end

@implementation DataSourceModel

- (id)init
{
    self = [super init];
    if (self)
    {
        _mutableTextInputDict = [NSMutableDictionary new];
        [self loadNotesDict];
    }
    return self;
}

#pragma mark - Shared Instance aka Singleton
+(DataSourceModel*)useDataMethod
{
    static DataSourceModel *_useDataMethod;
    if (!_useDataMethod)
    {
        _useDataMethod = [DataSourceModel new];
    }
    return _useDataMethod;
}

- (void)saveNoteToFileWith:(NSString *)actualTextInputString andDate:(NSDate *)uniqueDate
{
    NSInteger timestamp = [uniqueDate timeIntervalSince1970];
    NSString *timeStampString = [NSString stringWithFormat:@"%d",timestamp];
    [_mutableTextInputDict setObject:actualTextInputString forKey:timeStampString];
    
    //Datenweg
    NSString *documentsDirectory  = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)objectAtIndex:0];
    NSString *txtFile = [documentsDirectory stringByAppendingPathComponent:@"notebook.txt"];
    
    [_mutableTextInputDict writeToFile:txtFile atomically:YES];
}

- (void)loadNotesDict
{
    NSString *documentsDirectory  = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)objectAtIndex:0];
    NSString *txtFile = [documentsDirectory stringByAppendingPathComponent:@"notebook.txt"];
    NSDictionary *tmpDict = [[NSDictionary alloc]initWithContentsOfFile:txtFile];
    
    if (tmpDict)
    {
        [_mutableTextInputDict addEntriesFromDictionary:tmpDict];
    }
    
}


#pragma mark - Daten aus dem Netz holen
-(NSArray*)loadDataFromWanWith:(NSString*)quellURL and:(NSString*)keyForObject
{
        //URL benennen
        NSURL *tmpUrl = [NSURL URLWithString:quellURL];
        //NSData die Daten der Quelle übergeben
        NSData *quellData = [NSData dataWithContentsOfURL:tmpUrl];
        //NSData in ein Dictionary umwandeln
        NSDictionary *dictionaryJSON = [NSJSONSerialization JSONObjectWithData:quellData
                                                                   options:NSJSONReadingAllowFragments
                                                                     error:nil];
        //ERgebnisse ins Array schreiben
        _postArray = [dictionaryJSON objectForKey:keyForObject];
    
    
        return _postArray;
}

-(NSMutableArray*) getPicsFromWanWith:(NSString*)stringForKey inPostArray:(NSArray*)thumbNailArray
{
    _mutableImageArray = [NSMutableArray new];
    
    for (NSDictionary *tmpDict in thumbNailArray)
    {
        NSString *thumbnailString =[tmpDict objectForKey:stringForKey];
        NSURL *thumbnailURL =[NSURL URLWithString:thumbnailString];
        NSData *tmpImageData = [NSData dataWithContentsOfURL:thumbnailURL];
        UIImage *tmpImage = [UIImage imageWithData:tmpImageData];
        [_mutableImageArray addObject:tmpImage];
        
    }
    return _mutableImageArray;
}

@end
