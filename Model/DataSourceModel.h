//
//  DataSourceModel.h
//  DataSucker
//
//  Created by Frank Regel on 24.01.14.
//  Copyright (c) 2014 Frank Regel. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface DataSourceModel : NSObject

//public Readonly Array
@property NSMutableArray *noteBookArray;

//sharedInstance
+(DataSourceModel*) useDataMethod;

//verfügbare Methoden
-(NSArray*)loadDataFromWanWith:(NSString*)quellURL and:(NSString*)keyForObject;
-(NSMutableArray*) getPicsFromWanWith:(NSString*)stringForKey inPostArray:(NSArray*)thumbNailArray;
- (void)saveNoteToFileWith:(NSString *)actualTextInputString andTimeStampString:(NSString *)uniqueTimeStampString;
- (NSDictionary *)loadNotesDict;


@end

