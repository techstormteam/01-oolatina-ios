//
//  PhotoCustomCell.m
//  OOLatina
//
//  Created by Macbook air on 8/1/14.
//  Copyright (c) 2014 Jérôme Laurent. All rights reserved.
//

#import "PhotoCustomCell.h"


@implementation PhotoCustomCell


- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _originalFrameSize = self.frame.size;
        myQueue = dispatch_queue_create("PhotoDownload",NULL);
    }
    return self;
}

- (void)setup
{
    
    // Initialization code
    _photoIndex = 0;
    self.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    
    
    lblCity = [[UILabel alloc] initWithFrame:CGRectMake(5, 20, self.frame.size.width, 20)];
    lblCity.textColor = [UIColor colorWithRed:0.0/255.0 green:154.0/255.0 blue:210/255.0 alpha:1];
    [lblCity setFont:[UIFont fontWithName:@"Arial-BoldMT" size:18]];
    [self addSubview:lblCity];
    
    lblDayOfWeek = [[UILabel alloc] initWithFrame:CGRectMake(0, 5, self.frame.size.width - 5, 20)];
    lblDayOfWeek.textColor = [UIColor blackColor];
    lblDayOfWeek.textAlignment = NSTextAlignmentRight;
    [lblDayOfWeek setFont:[UIFont fontWithName:@"Arial" size:16]];
    [self addSubview:lblDayOfWeek];
    
    lblDate = [[UILabel alloc] initWithFrame:CGRectMake(0, 24, self.frame.size.width - 5, 20)];
    lblDate.textColor = [UIColor blackColor];
    lblDate.textAlignment = NSTextAlignmentRight;
    [lblDate setFont:[UIFont fontWithName:@"Arial" size:16]];
    [self addSubview:lblDate];
    
    _gridView = [[AQGridView alloc] initWithFrame:CGRectMake(0, 55, self.frame.size.width, self.frame.size.height)];
    _gridView.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
	_gridView.autoresizesSubviews = YES;
	_gridView.delegate = self;
	_gridView.dataSource = self;
    [self addSubview:_gridView];
    
    float heightThird = 65 + (ceil([mPhotos count] / 3.0) * _photoSize.height);
    lblTitle = [[UILabel alloc] initWithFrame:CGRectMake(5, heightThird, self.frame.size.width, 20)];
    lblTitle.textColor = [UIColor colorWithRed:0.0/255.0 green:154.0/255.0 blue:210/255.0 alpha:1];
    [lblTitle setFont:[UIFont fontWithName:@"Arial" size:16]];
    [self addSubview:lblTitle];
    
    lblSeeAlbum = [[UILabel alloc] initWithFrame:CGRectMake(0, heightThird, self.frame.size.width - 5, 20)];
    lblSeeAlbum.textColor = [UIColor colorWithRed:0.0/255.0 green:154.0/255.0 blue:210/255.0 alpha:1];
    lblSeeAlbum.textAlignment = NSTextAlignmentRight;
    [lblSeeAlbum setFont:[UIFont fontWithName:@"Arial" size:14]];
    [self addSubview:lblSeeAlbum];
    
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path moveToPoint:CGPointMake(0, heightThird + 30)];
    [path addLineToPoint:CGPointMake(self.frame.size.width, heightThird + 30)];
    
    shapeLayer = [CAShapeLayer layer];
    shapeLayer.path = [path CGPath];
    shapeLayer.strokeColor = [[UIColor colorWithRed:225.0/255.0 green:225.0/255.0 blue:225.0/255.0 alpha:1] CGColor];
    shapeLayer.lineWidth = 1.0;
    shapeLayer.fillColor = [[UIColor clearColor] CGColor];
    
    [self.layer addSublayer:shapeLayer];
    
    [_gridView reloadData];
//    GMGridView *gmGridView = [[GMGridView alloc] initWithFrame:CGRectMake(0, 25, self.frame.size.width, 40)];
//    gmGridView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
//    gmGridView.backgroundColor = [UIColor clearColor];
//    gmGridView.layoutStrategy = [GMGridViewLayoutStrategyFactory strategyFromType:GMGridViewLayoutVertical];
//    gmGridView.centerGrid = false;
//    gmGridView.itemSpacing = 2;
//
//    gmGridView.dataSource = self;
//    _gmGridView = gmGridView;
//    [self addSubview:_gmGridView];
    
    
}

- (void)passPhotoSize:(CGSize) pSize;
{
    _photoSize = pSize;
}

- (void)passData:(NSMutableArray *) photos
{
    mPhotos = photos;
}

- (void)setTitle:(NSString *)title
{
    lblTitle.text = title;
}

- (void)setCity:(NSString *)city
{
    lblCity.text = city;
}

- (void)setDate:(NSString *)date dayOfWeek:day
{
    lblDate.text = date;
    lblDayOfWeek.text = day;
}

- (void)setSeeAlbum:(NSString *)seeAlbum;
{
    lblSeeAlbum.text = seeAlbum;
    
}

-(void)imageTapped:(UITapGestureRecognizer *)recognizer{
    [self.delegate photoTapped:recognizer];
}


//////////////////////////////////////////////////////////////
#pragma mark GMGridViewActionDelegate
//////////////////////////////////////////////////////////////

- (void)GMGridView:(GMGridView *)gridView didTapOnItemAtIndex:(NSInteger)position
{
//    NSLog(@"Did tap at index %d", position);
}

- (void)GMGridViewDidTapOnEmptySpace:(GMGridView *)gridView
{
    NSLog(@"Tap on empty space");
}

- (void)GMGridView:(GMGridView *)gridView processDeleteActionForItemAtIndex:(NSInteger)index
{
    //empty
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
//    if (buttonIndex == 1)
//    {
//        [_currentData removeObjectAtIndex:_lastDeleteItemIndexAsked];
//        [_gmGridView removeObjectAtIndex:_lastDeleteItemIndexAsked withAnimation:GMGridViewItemAnimationFade];
//    }
}

#pragma mark - ProgressHud
-(void)showHud:(NSString *)text superView:view
{
    if (_theHud == nil) {
        _theHud = [[MBProgressHUD alloc] init];
    }
    
    _theHud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    _theHud.labelFont = [UIFont fontWithName:@"HelveticaNeue-Light" size:12.0];
    _theHud.labelText = text;
}

-(void)hideHud
{
    [_theHud hide:YES];
}

#pragma mark -
#pragma mark Grid View Data Source

- (NSUInteger) numberOfItemsInGridView: (AQGridView *) aGridView
{
    return mPhotos.count;
}

- (AQGridViewCell *) gridView: (AQGridView *) aGridView cellForItemAtIndex: (NSUInteger) index
{
    static NSString * OffsetCellIdentifier = @"OffsetCellIdentifier";
    
    AQGridViewCell * cell = (AQGridViewCell *)[aGridView dequeueReusableCellWithIdentifier: OffsetCellIdentifier];
    
    if ( cell == nil )
    {
        cell = [[AQGridViewCell alloc] initWithFrame: CGRectMake(0.0, 0.0, _photoSize.width, _photoSize.height)
                                                 reuseIdentifier: OffsetCellIdentifier];
        cell.selectionGlowColor = [UIColor blueColor];
    }
    
    if (_photoIndex < [mPhotos count]) {
        
        // init image
        Photo *photo = [mPhotos objectAtIndex:_photoIndex];
        NSString *url = [photo getUrl];
        
        PhotoImageView *imageView = [[PhotoImageView alloc] initWithFrame:cell.contentView.bounds];
        imageView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        //        imageView.backgroundColor = [UIColor blackColor];
        //        imageView.tintColor = [UIColor blackColor];
        
        [self showHud:@"" superView:cell.contentView];

        dispatch_async(myQueue, ^{
            // Perform long running process
            
            dispatch_async(dispatch_get_main_queue(), ^{
                UIImage *img = [Utility getImageFromURL:url];
                imageView.image = [Utility imageWithImage: img scaledToSize:imageView.frame.size];
                [self hideHud];
            });
        });
        [imageView setPhotoInfo:photo];
        [cell.contentView addSubview:imageView];
        
        UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(imageTapped:)];
        singleTap.numberOfTapsRequired = 1;
        imageView.userInteractionEnabled = YES;
        [imageView addGestureRecognizer:singleTap];
        
        _photoIndex++;
    }
    
    return ( cell );
}

- (CGSize) portraitGridCellSizeForGridView: (AQGridView *) aGridView
{
    return ( _photoSize );
//    return CGSizeMake(106.5, 106.5);
}



@end
