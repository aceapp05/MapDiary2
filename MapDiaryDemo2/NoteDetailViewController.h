//
//  NoteDetailViewController.h
//  MapDiaryDemo2
//
//  Created by Lion User on 11/14/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Note;

@interface NoteDetailViewController : UIViewController

@property (nonatomic, strong) Note* note;
@property (nonatomic, strong) UILabel* titleLabel;
@property (nonatomic, strong) UILabel* dateLabel;
@property (nonatomic, strong) UILabel* bodyLabel;
@property (nonatomic, strong) UIImageView* imageView;

@end
