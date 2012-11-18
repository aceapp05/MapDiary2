//
//  AddNoteViewController.m
//  MapDiaryDemo2
//
//  Created by Lion User on 11/12/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "AddNoteViewController.h"
#import "Note.h"
#import "MapViewController.h"

@interface AddNoteViewController ()

@end

@implementation AddNoteViewController
@synthesize note_title = _note_title;
@synthesize note_date = _note_date;
@synthesize note_body = _note_body;
@synthesize note_image = _note_image;
@synthesize noteDatabase = _noteDatabase;
@synthesize noteDateText = _noteDateText;
@synthesize noteLatitude = _noteLatitude;
@synthesize noteLongitude = _noteLongitude;

#pragma mark -
#pragma mark View Realated

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    if (!self.noteDatabase) {  // for demo purposes, we'll create a default database if none is set
        NSURL *url = [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
        url = [url URLByAppendingPathComponent:@"note_db"];
        // url is now "<Documents Directory>/Default Photo Database"
        self.noteDatabase = [[UIManagedDocument alloc] initWithFileURL:url]; // setter will create this for us on disk
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.note_title.delegate = self;
    self.note_body.delegate = self;
    self.note_date.text = self.noteDateText;
	// Do any additional setup after loading the view.
}

- (void)viewDidUnload
{
    self.note_body = nil;
    self.note_date = nil;
    self.note_image = nil;
    self.note_title = nil;
    self.noteDateText = nil;
    self.noteDatabase = nil;
    self.noteLongitude = nil;
    self.noteLatitude = nil;
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark -
#pragma mark Core Data Realated

- (void)useDocument
{
    if (![[NSFileManager defaultManager] fileExistsAtPath:[self.noteDatabase.fileURL path]]) {
        // does not exist on disk, so create it
        [self.noteDatabase saveToURL:self.noteDatabase.fileURL forSaveOperation:UIDocumentSaveForCreating completionHandler:^(BOOL success) {
            // do nothing
        }];
    } else if (self.noteDatabase.documentState == UIDocumentStateClosed) {
        // exists on disk, but we need to open it
        [self.noteDatabase openWithCompletionHandler:^(BOOL success) {
            // do nothing
        }];
    } else if (self.noteDatabase.documentState == UIDocumentStateNormal) {
    }
}

- (void)setNoteDatabase:(UIManagedDocument *)noteDatabase
{
    if (_noteDatabase != noteDatabase) {
        _noteDatabase = noteDatabase;
        [self useDocument];
    }
}


#pragma mark -
#pragma mark ImagePicker Realated

- (IBAction)photoTapped:(id)sender 
{
	UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
	imagePicker.delegate = self;
	[self presentModalViewController:imagePicker animated:YES];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingImage:(UIImage *)selectedImage editingInfo:(NSDictionary *)editingInfo {
	
    CGSize size = selectedImage.size;
    CGFloat ratio = 0;
    if (size.width > size.height) 
    {
        ratio = self.note_image.frame.size.width / size.width;
    } else 
    {
        ratio = self.note_image.frame.size.height / size.height;
    }
    CGRect rect = CGRectMake(0.0, 0.0, ratio * size.width, ratio * size.height);
    UIGraphicsBeginImageContext(rect.size);
    [selectedImage drawInRect:rect];
    self.note_image.imageView.image = UIGraphicsGetImageFromCurrentImageContext();
	UIGraphicsEndImageContext();

    [self.note_image setImage:self.note_image.imageView.image forState:UIControlStateNormal];
    [self.note_image setTitle:@"" forState:UIControlStateNormal];	
    
    [self dismissModalViewControllerAnimated:YES];
}


- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [self dismissModalViewControllerAnimated:YES];
}


#pragma mark -
#pragma mark TextField Related
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
	[textField resignFirstResponder];
	return YES;
}


#pragma mark -
#pragma mark Segue
- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"note_confirmed"]) 
    {
        // save to database
        Note* note = [NSEntityDescription insertNewObjectForEntityForName:@"Note" inManagedObjectContext:self.noteDatabase.managedObjectContext];
        
        note.title = self.note_title.text;
        note.body = self.note_body.text;
        NSDateFormatter* df = [[NSDateFormatter alloc] init];
        [df setDateFormat:@"yyyy/MM/dd"];
        note.date = [df dateFromString:self.note_date.text];
        note.image = self.note_image.imageView.image;
        note.latitude = self.noteLatitude;
        note.longitude = self.noteLongitude;
        
        NSError *error = nil;
        if (![note.managedObjectContext save:&error]) {
            /*
             Replace this implementation with code to handle the error appropriately.
             
             abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development. If it is not possible to recover from the error, display an alert panel that instructs the user to quit the application by pressing the Home button.
             */
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            abort();
        }
        [self.noteDatabase saveToURL:self.noteDatabase.fileURL forSaveOperation:UIDocumentSaveForOverwriting completionHandler:NULL];

    }
    else if ([segue.identifier isEqualToString:@"note_map"])
    {
        [segue.destinationViewController performSelector:@selector(setDelegate:) withObject:self];
    }
}


#pragma mark -
#pragma mark Segue
- (void) didAddNewLocation:(CLLocationCoordinate2D) location
{
    self.noteLatitude = [NSNumber numberWithDouble:location.latitude];
    self.noteLongitude = [NSNumber numberWithDouble:location.longitude];
}

@end
