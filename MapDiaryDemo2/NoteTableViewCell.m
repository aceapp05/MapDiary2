//
//  NoteTableViewCell.m
//  MapDiaryDemo
//
//  Created by Lion User on 11/10/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "NoteTableViewCell.h"

@interface NoteTableViewCell (SubViewFrames)
- (CGRect)_imageViewFrame;
@end

@implementation NoteTableViewCell

@synthesize note = _note;
@synthesize image = _image;
@synthesize title = _title;
@synthesize date = _date;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        self.image = [[UIImageView alloc] initWithFrame:CGRectZero];
		self.image.contentMode = UIViewContentModeScaleAspectFit;
        [self.contentView addSubview:self.image];

        self.title = [[UILabel alloc] initWithFrame:CGRectZero];
        [self.title setFont:[UIFont boldSystemFontOfSize:14.0]];
        [self.title setTextColor:[UIColor blackColor]];
        [self.title setHighlightedTextColor:[UIColor whiteColor]];
        [self.contentView addSubview:self.title];
        
        self.date = [[UILabel alloc] initWithFrame:CGRectZero];
        [self.date setFont:[UIFont systemFontOfSize:12.0]];
        [self.date setTextColor:[UIColor darkGrayColor]];
        [self.date setHighlightedTextColor:[UIColor whiteColor]];
        [self.contentView addSubview:self.date];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
	
    [self.image setFrame:[self _imageViewFrame]];
    [self.title setFrame:[self _titleFrame]];
    [self.date setFrame:[self _dateFrame]];
}

#define IMAGE_SIZE          62.0
#define EDITING_INSET       10.0
#define TEXT_LEFT_MARGIN    8.0
#define TEXT_RIGHT_MARGIN   5.0

- (CGRect)_imageViewFrame {
    if (self.editing) {
        return CGRectMake(EDITING_INSET, 0.0, IMAGE_SIZE, IMAGE_SIZE);
    }
	else {
        return CGRectMake(0.0, 0.0, IMAGE_SIZE, IMAGE_SIZE);
    }
}

- (CGRect)_titleFrame {
    if (self.editing) {
        return CGRectMake(IMAGE_SIZE + EDITING_INSET + TEXT_LEFT_MARGIN, 4.0, self.contentView.bounds.size.width - IMAGE_SIZE - EDITING_INSET - TEXT_LEFT_MARGIN, 16.0);
    }
	else {
        return CGRectMake(IMAGE_SIZE + TEXT_LEFT_MARGIN, 4.0, self.contentView.bounds.size.width - IMAGE_SIZE - TEXT_RIGHT_MARGIN * 2, 16.0);
    }
}

- (CGRect)_dateFrame {
    if (self.editing) {
        return CGRectMake(IMAGE_SIZE + EDITING_INSET + TEXT_LEFT_MARGIN, 22.0, self.contentView.bounds.size.width - IMAGE_SIZE - EDITING_INSET - TEXT_LEFT_MARGIN, 16.0);
    }
	else {
        return CGRectMake(IMAGE_SIZE + TEXT_LEFT_MARGIN, 22.0, self.contentView.bounds.size.width - IMAGE_SIZE - TEXT_LEFT_MARGIN, 16.0);
    }
}


- (void)setNote:(Note *)newNote {
    if (newNote != _note) {
        _note = newNote;
	}
	self.image.image = _note.image;
    self.title.text = _note.title;
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy/MM/dd"];
    self.date.text = [dateFormatter stringFromDate:_note.date];
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
