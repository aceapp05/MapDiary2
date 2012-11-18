//
//  AddNoteViewController.h
//  MapDiaryDemo2
//
//  Created by Lion User on 11/12/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CoreDataTableViewController.h"
#import "MapViewController.h"

@class Note;

@interface AddNoteViewController : UIViewController <UITextFieldDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate, MapViewControllerDelegate>
@property (strong, nonatomic) IBOutlet UITextField *note_title;
@property (strong, nonatomic) IBOutlet UILabel *note_date;
@property (strong, nonatomic) IBOutlet UITextField *note_body;
@property (strong, nonatomic) IBOutlet UIButton *note_image;
@property (nonatomic, strong) UIManagedDocument *noteDatabase;
@property (nonatomic,strong) NSString* noteDateText;
@property (nonatomic, strong) NSNumber* noteLongitude;
@property (nonatomic, strong) NSNumber* noteLatitude;

- (IBAction)photoTapped:(id)sender;

@end
