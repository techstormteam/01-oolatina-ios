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
        
        thumbnail = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
        thumbnail.userInteractionEnabled = YES;
        [self addSubview:thumbnail];
        UITapGestureRecognizer *singleFingerTap_Image =
        [[UITapGestureRecognizer alloc] initWithTarget:self
                                                action:@selector(cellAgendaTapped:)];
        [thumbnail addGestureRecognizer:singleFingerTap_Image];
        
        int widthOfTitleBackground = 220;
        int heightOfTitleBackground = 30;
        titleBackground = [[UIView alloc] initWithFrame:CGRectMake(frame.size.width - widthOfTitleBackground, frame.size.height - heightOfTitleBackground, widthOfTitleBackground, heightOfTitleBackground)];
        titleBackground.backgroundColor = [UIColor colorWithRed:221.0/255.0 green:39.0/255.0 blue:116.0/255.0 alpha:0.90];
        titleBackground.userInteractionEnabled = YES;
        [self addSubview:titleBackground];
        UITapGestureRecognizer *singleFingerTap_Title =
        [[UITapGestureRecognizer alloc] initWithTarget:self
                                                action:@selector(cellAgendaTapped:)];
        [titleBackground addGestureRecognizer:singleFingerTap_Title];
        
        titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, titleBackground.frame.size.width, titleBackground.frame.size.height)];
        titleLabel.textColor = [UIColor whiteColor];
        titleLabel.textAlignment = NSTextAlignmentCenter;
        titleLabel.numberOfLines = 3;
        titleLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:20.0];
        [titleBackground addSubview:titleLabel];
        
        mLoading = [[UIActivityIndicatorView alloc] initWithFrame:thumbnail.bounds];
        mLoading.activityIndicatorViewStyle = UIActivityIndicatorViewStyleGray;
        [mLoading startAnimating];
        [self addSubview:mLoading];
        
        separator = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, 1)];
        separator.backgroundColor = [UIColor colorWithRed:0.5 green:0.5 blue:0.5 alpha:0.5];
        [self addSubview:separator];
        
//        lieuLabel = [[UILabel alloc] initWithFrame:CGRectMake(85, 55, frame.size.width-140, 20)];
//        lieuLabel.textColor = [UIColor grayColor];
//        lieuLabel.font = [UIFont fontWithName:@"Helvetica" size:12.0];
//        [self addSubview:lieuLabel];
        
        UIView *ViewRed = [[UIView alloc] initWithFrame:CGRectMake(self.frame.size.width-50, 0, 50, 35)];
        ViewRed.userInteractionEnabled = YES;
        ViewRed.backgroundColor = [UIColor redColor];
        [self addSubview:ViewRed];
        
        titleDay = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 50, 35)];
        titleDay.textColor = [UIColor whiteColor];
        titleDay.numberOfLines = 2;
        titleDay.textAlignment = NSTextAlignmentCenter;
        titleDay.text = @"Jeu\nMAR";
        titleDay.font = [UIFont fontWithName:@"Helvetica-Bold" size:12.0];
        [ViewRed addSubview:titleDay];
        UITapGestureRecognizer *singleFingerTap_ViewRed =
        [[UITapGestureRecognizer alloc] initWithTarget:self
                                                action:@selector(cellAgendaTapped:)];
        [ViewRed addGestureRecognizer:singleFingerTap_ViewRed];
        
        UIView *ViewWhite = [[UIView alloc] initWithFrame:CGRectMake(self.frame.size.width-50, 35, 50, 35)];
        ViewWhite.userInteractionEnabled = YES;
        ViewWhite.backgroundColor = [UIColor whiteColor];
        [self addSubview:ViewWhite];
        
        titleDayLetter = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 50, 30)];
        titleDayLetter.textColor = [UIColor grayColor];
        titleDayLetter.numberOfLines = 1;
        titleDayLetter.textAlignment = NSTextAlignmentCenter;
        titleDayLetter.text = @"20";
        titleDayLetter.font = [UIFont fontWithName:@"Helvetica-Bold" size:21.0];
        [ViewWhite addSubview:titleDayLetter];
        UITapGestureRecognizer *singleFingerTap_ViewWhite =
        [[UITapGestureRecognizer alloc] initWithTarget:self
                                                action:@selector(cellAgendaTapped:)];
        [ViewWhite addGestureRecognizer:singleFingerTap_ViewWhite];
        
    }
    return self;
}

- (void)cellAgendaTapped:(UITapGestureRecognizer *)recognizer {
    [self.delegate tappedCellAgenda:mEvent];
}


- (void)addEvent:(Event *)_event
{
    mEvent = _event;
    titleLabel.text = [_event getTitle];
//    lieuLabel.text = [NSString stringWithFormat:@"%@",[_event getVille]];
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
//    dispatch_queue_t myQueue = dispatch_queue_create("PhotoDownload",NULL);
//    dispatch_async(myQueue, ^{
//        // Perform long running process
//        dispatch_async(dispatch_get_main_queue(), ^{
    UIImage *image = [Utility getImageFromURL:[_event getThumbnailEvent]];
//            thumbnail.image = [Utility imageWithImage:image scaledToSize:thumbnail.frame.size];
    if (image == nil) {
        image = [UIImage imageNamed: @"no_image.gif"];
    }
    thumbnail.image = image;
    
//            NSData *data = [[NSData alloc] initWithContentsOfURL:[NSURL URLWithString:[_event getThumbnailEvent]]];
//            thumbnail.image = [UIImage imageWithData:data];
    [mLoading stopAnimating];
    mLoading.hidden = YES;
//        });
//    });
    //dispatch_async(dispatch_get_main_queue(), ^{
    
    
    //});
}

@end
