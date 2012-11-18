//
//  NoteDetailViewController.m
//  MapDiaryDemo2
//
//  Created by Lion User on 11/14/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "NoteDetailViewController.h"
#import "Note.h"

@interface NoteDetailViewController ()

@end

@implementation NoteDetailViewController

@synthesize note = _note;
@synthesize titleLabel = _titleLabel;
@synthesize dateLabel = _dateLabel;
@synthesize bodyLabel = _bodyLabel;
@synthesize imageView = _imageView;

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
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.titleLabel = [[UILabel alloc] init];
    self.titleLabel.frame = CGRectMake(20, 10, 280, 31);
    self.titleLabel.text = self.note.title;
    [self.view addSubview:self.titleLabel];
    
    self.dateLabel = [[UILabel alloc] init];
    self.dateLabel.frame = CGRectMake(20, 40, 280, 31);
    NSDateFormatter* df = [[NSDateFormatter alloc] init];
    df.dateFormat = @"yyyy/MM/dd";
    self.dateLabel.text = [df stringFromDate:self.note.date];
    [self.view addSubview:self.dateLabel];
    
    self.bodyLabel = [[UILabel alloc] init];
    self.bodyLabel.frame = CGRectMake(20, 70, 280, 31);
    self.bodyLabel.text = self.note.body;
    [self.view addSubview:self.bodyLabel];
    
    self.imageView = [[UIImageView alloc]initWithImage:self.note.image];
    self.imageView.frame = CGRectMake(20, 100, 280, 280);
    self.imageView.contentMode = UIViewContentModeScaleAspectFit;
    [self.view addSubview:self.imageView];
    
    NSLog(@"%f, %f", self.note.longitude.doubleValue, self.note.latitude.doubleValue);
}

- (void)viewDidUnload
{
    self.titleLabel = nil;
    self.dateLabel = nil;
    self.bodyLabel = nil;
    self.imageView = nil;
    
    
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
