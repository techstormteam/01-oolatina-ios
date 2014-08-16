//
//  CellAgenda.m
//  OOLatina
//
//  Created by Jérôme Laurent on 20/03/2014.
//  Copyright (c) 2014 Jérôme Laurent. All rights reserved.
//

#import "CellAgenda.h"

@implementation CellAgenda

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        self.backgroundColor = [UIColor colorWithRed:1 green:1 blue:1 alpha:0.7];
        
        titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(85, 5, frame.size.width-140, 50)];
        titleLabel.textColor = [UIColor blackColor];
        titleLabel.numberOfLines = 3;
        titleLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:12.0];
        [self addSubview:titleLabel];
        
        thumbnail = [[UIImageView alloc] initWithFrame:CGRectMake(0, 5, 80, 80)];
        [self addSubview:thumbnail];
        
        mLoading = [[UIActivityIndicatorView alloc] initWithFrame:CGRectMake((80-30)/2, (80-30)/2, 30, 30)];
        mLoading.activityIndicatorViewStyle = UIActivityIndicatorViewStyleGray;
        [mLoading startAnimating];
        [self addSubview:mLoading];
        
        separator = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, 1)];
        separator.backgroundColor = [UIColor colorWithRed:0.5 green:0.5 blue:0.5 alpha:0.5];
        [self addSubview:separator];
        
        lieuLabel = [[UILabel alloc] initWithFrame:CGRectMake(85, 55, frame.size.width-140, 20)];
        lieuLabel.textColor = [UIColor grayColor];
        lieuLabel.font = [UIFont fontWithName:@"Helvetica" size:12.0];
        [self addSubview:lieuLabel];
        
        UIView *ViewRed = [[UIView alloc] initWithFrame:CGRectMake(self.frame.size.width-50, 0, 50, 35)];
        ViewRed.backgroundColor = [UIColor redColor];
        [self addSubview:ViewRed];
        
        titleDay = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 50, 35)];
        titleDay.textColor = [UIColor whiteColor];
        titleDay.numberOfLines = 2;
        titleDay.textAlignment = NSTextAlignmentCenter;
        titleDay.text = @"Jeu\nMAR";
        titleDay.font = [UIFont fontWithName:@"Helvetica-Bold" size:12.0];
        [ViewRed addSubview:titleDay];
        
        UIView *ViewWhite = [[UIView alloc] initWithFrame:CGRectMake(self.frame.size.width-50, 35, 50, 35)];
        ViewWhite.backgroundColor = [UIColor whiteColor];
        [self addSubview:ViewWhite];
        
        titleDayLetter = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 50, 30)];
        titleDayLetter.textColor = [UIColor grayColor];
        titleDayLetter.numberOfLines = 1;
        titleDayLetter.textAlignment = NSTextAlignmentCenter;
        titleDayLetter.text = @"20";
        titleDayLetter.font = [UIFont fontWithName:@"Helvetica-Bold" size:21.0];
        [ViewWhite addSubview:titleDayLetter];
    }
    return self;
}

- (void)addEvent:(Event *)_event
{
    titleLabel.text = [_event getTitle];
    lieuLabel.text = [NSString stringWithFormat:@"%@",[_event getVille]];
    titleDayLetter.text = [_event getDayLetter];
    
    // Dating
    NSDate *dating = [[NSDate alloc] init];
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"yyyy-MM-dd"];
    dating = [dateFormat dateFromString:[NSString stringWithFormat:@"%@-%@-%@",[_event getYear],[_event getMonth],[_event getDayLetter]]];
    NSDateFormatter *df = [[NSDateFormatter alloc] init];
    [df setDateFormat:@"EEEE"];
    
    NSDate *datingMonth = [dateFormat dateFromString:[NSString stringWithFormat:@"%@-%@-%@",[_event getYear],[_event getMonth],[_event getDayLetter]]];
    NSDateFormatter *uf = [[NSDateFormatter alloc] init];
    [uf setDateFormat:@"MMM"];
    
    titleDay.text = [NSString stringWithFormat:@"%@\n%@",[[df stringFromDate:dating] substringWithRange:NSMakeRange(0, 3)],[uf stringFromDate:datingMonth]];
    
    [self performSelectorInBackground:@selector(loadImage:) withObject:_event];
}

- (void)loadImage:(Event *)_event
{
    dispatch_queue_t myQueue = dispatch_queue_create("PhotoDownload",NULL);
    dispatch_async(myQueue, ^{
        // Perform long running process
        
        
        dispatch_async(dispatch_get_main_queue(), ^{
//            UIImage *image = [Utility getImageFromURL:[_event getThumbnailEvent]];
//            thumbnail.image = image;
            
            NSData *data = [[NSData alloc] initWithContentsOfURL:[NSURL URLWithString:[_event getThumbnailEvent]]];
            thumbnail.image = [UIImage imageWithData:data];
            [mLoading stopAnimating];
            mLoading.hidden = YES;
        });
    });
    //dispatch_async(dispatch_get_main_queue(), ^{
    
    
    //});
}

@end
