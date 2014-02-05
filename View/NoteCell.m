//
//  NoteCell.m
//  BaseDataApp
//
//  Created by Frank Regel on 05.02.14.
//  Copyright (c) 2014 Frank. All rights reserved.
//

#import "NoteCell.h"

@interface NoteCell()
@property UILabel *dateLabel;
@property UILabel *noteLabel;


@end

@implementation NoteCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        // Initialization code
        _dateLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 100, 50)];
        _noteLabel = [[UILabel alloc]initWithFrame:CGRectMake(110, 0, 200, 50)];
        [self addSubview:_noteLabel];
        [self addSubview:_dateLabel];
    }
    return self;
}

- (void)setDateLabelValue:(NSString *)dateValueString
{
    _dateLabel.text = dateValueString;
}

- (void)setNoteLabelValue:(NSString *)noteValueString
{
    _noteLabel.text = noteValueString;
}



- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
