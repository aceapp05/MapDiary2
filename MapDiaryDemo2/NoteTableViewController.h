//
//  NoteTableViewController.h
//  MapDiaryDemo
//
//  Created by Lion User on 11/6/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CoreDataTableViewController.h"

@class Note;

@interface NoteTableViewController : CoreDataTableViewController

@property (nonatomic, strong) UIManagedDocument *noteDatabase;  // Model is a Core Data database of photos

- (void)showNote:(Note *)recipe animated:(BOOL)animated;

@end
