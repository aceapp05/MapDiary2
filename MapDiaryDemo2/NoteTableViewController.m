//
//  NoteTableViewController.m
//  MapDiaryDemo
//
//  Created by Lion User on 11/6/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "NoteTableViewController.h"
#import "Note.h"
#import "NoteTableViewCell.h"
#import "NoteDetailViewController.h"

@implementation NoteTableViewController

@synthesize noteDatabase = _noteDatabase;


#pragma mark -
#pragma mark View Realated

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    if (!self.noteDatabase) {
        NSURL *url = [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
        url = [url URLByAppendingPathComponent:@"note_db"];
        self.noteDatabase = [[UIManagedDocument alloc] initWithFileURL:url];
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"Notes";
    
    self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    // Set the table view's row height
    self.tableView.rowHeight = 64.0;
}

- (void)viewDidUnload
{
    self.noteDatabase = nil;
}


#pragma mark -
#pragma mark Core Data Realated

- (void)setupFetchedResultsController
{
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Note"];
    request.sortDescriptors = [NSArray arrayWithObject:[NSSortDescriptor sortDescriptorWithKey:@"date" ascending:NO selector:@selector(localizedCaseInsensitiveCompare:)]];
    
    self.fetchedResultsController = [[NSFetchedResultsController alloc] initWithFetchRequest:request
                                                                        managedObjectContext:self.noteDatabase.managedObjectContext
                                                                          sectionNameKeyPath:nil
                                                                                   cacheName:nil];
}

- (void)useDocument
{
    if (![[NSFileManager defaultManager] fileExistsAtPath:[self.noteDatabase.fileURL path]]) {
        // does not exist on disk, so create it
        [self.noteDatabase saveToURL:self.noteDatabase.fileURL forSaveOperation:UIDocumentSaveForCreating completionHandler:^(BOOL success) {
            [self setupFetchedResultsController];           
        }];
    } else if (self.noteDatabase.documentState == UIDocumentStateClosed) {
        // exists on disk, but we need to open it
        [self.noteDatabase openWithCompletionHandler:^(BOOL success) {
            [self setupFetchedResultsController];
        }];
    } else if (self.noteDatabase.documentState == UIDocumentStateNormal) {
        // already open and ready to use
        [self setupFetchedResultsController];
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
#pragma mark TableView Realated

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"NoteCellIdentifier";
    NoteTableViewCell *noteCell = (NoteTableViewCell *) [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (noteCell == nil) {
        noteCell = [[NoteTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
		noteCell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }

    // Configure the cell...
    [self configureCell:noteCell atIndexPath:indexPath];
    
    return noteCell;
}

- (void)configureCell:(NoteTableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath 
{
    // Configure the cell
	Note *note = (Note *)[self.fetchedResultsController objectAtIndexPath:indexPath];
    cell.note = note;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	Note *note = (Note *)[self.fetchedResultsController objectAtIndexPath:indexPath];
    
    [self showNote:note animated:YES];
}

// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the managed object for the given index path
		NSManagedObjectContext *context = [self.fetchedResultsController managedObjectContext];
		[context deleteObject:[self.fetchedResultsController objectAtIndexPath:indexPath]];
		
		// Save the context.
		NSError *error;
		if (![context save:&error]) {
			/*
			 Replace this implementation with code to handle the error appropriately.
			 
			 abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development. If it is not possible to recover from the error, display an alert panel that instructs the user to quit the application by pressing the Home button.
			 */
			NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
			abort();
		}
        [self.noteDatabase saveToURL:self.noteDatabase.fileURL forSaveOperation:UIDocumentSaveForOverwriting completionHandler:NULL];
	}   
}

#pragma mark -
#pragma mark Other Functions

- (void)showNote:(Note *)note animated:(BOOL)animated
{
    // Create a detail view controller, set the recipe, then push it.
    NoteDetailViewController *detailViewController = [[NoteDetailViewController alloc] init];
    detailViewController.note = note;
    
    [self.navigationController pushViewController:detailViewController animated:animated];
}

@end
