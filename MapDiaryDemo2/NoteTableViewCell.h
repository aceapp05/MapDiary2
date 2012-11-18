//
//  NoteTableViewCell.h
//  MapDiaryDemo
//
//  Created by Lion User on 11/10/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Note.h"

@interface NoteTableViewCell : UITableViewCell

@property (nonatomic, retain) Note* note;
@property (nonatomic, retain) UIImageView* image;
@property (nonatomic, retain) UILabel *title;
@property (nonatomic, retain) UILabel *date;

@end
