//
//  NoteCell.h
//  BaseDataApp
//
//  Created by Frank Regel on 05.02.14.
//  Copyright (c) 2014 Frank. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NoteCell : UITableViewCell

- (void)setDateLabelValue:(NSString *)dateValueString;
- (void)setNoteLabelValue:(NSString *)noteValueString;

@end
