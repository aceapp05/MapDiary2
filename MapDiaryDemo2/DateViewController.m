//
//  DateViewController.m
//  MapDiaryDemo2
//
//  Created by Lion User on 11/12/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "DateViewController.h"
#import "AddNoteViewController.h"

@interface DateViewController ()

@end

@implementation DateViewController
@synthesize datePicker = _datePicker;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)viewDidUnload
{
    [self setDatePicker:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    NSDateFormatter* df = [[NSDateFormatter alloc] init];
    [df setDateFormat:@"yyyy/MM/dd"];
    
    if( [segue.destinationViewController respondsToSelector:@selector(setNoteDateText:)] )
    {
        [segue.destinationViewController setNoteDateText:[df stringFromDate:self.datePicker.date]];
    }
}

@end
