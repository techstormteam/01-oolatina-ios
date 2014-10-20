//
//  AgendaDescription.m
//  OOLatina
//
//  Created by Macbook air on 9/4/14.
//  Copyright (c) 2014 Jérôme Laurent. All rights reserved.
//

#import "AgendaDescription.h"

@implementation AgendaDescription

@synthesize descriptionButton;
@synthesize mapButton;
@synthesize slidLabel;
@synthesize nibScrollView;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        
        UIView *mySelf = [[[NSBundle mainBundle] loadNibNamed:@"AgendaDescription" owner:self options:nil] lastObject];

        [self addSubview:mySelf];
        
        [self addBasicView];
        
        [self initScrollView];
        
        [self descriptionButtonAction];
        
        [descriptionButton setTitle:NSLocalizedString(@"description", @"") forState:UIControlStateNormal];
        [mapButton setTitle:NSLocalizedString(@"map", @"") forState:UIControlStateNormal];

        needLoadingMap = YES;
    }
    return self;
}

- (void)setEvent:(Event *)uEvent{
    mEvent = uEvent;
    [self setDescription];
}

- (void)setDescription
{
    mDescriptionLabel.text = [NSString stringWithFormat:@"%@: %@\n%@: %@\n%@: %@\n%@: %@\n%@: %@\n%@: %@", NSLocalizedString(@"address", @""),[mEvent getAdresse], NSLocalizedString(@"place", @""), [mEvent getLieu], NSLocalizedString(@"city", @""), [mEvent getVille], NSLocalizedString(@"country", @""), [mEvent getCountry], NSLocalizedString(@"code_postal", @""), [mEvent getCodePostal], NSLocalizedString(@"description", @""), [mEvent getDescription]];
    [mDescriptionLabel sizeToFit];
}

#pragma mark -
#pragma mark

- (void)initScrollView {
    
    
    nibScrollView.pagingEnabled = YES;
    nibScrollView.clipsToBounds = NO;
    nibScrollView.contentSize = CGSizeMake(nibScrollView.frame.size.width * 2, nibScrollView.frame.size.height);
    nibScrollView.showsHorizontalScrollIndicator = NO;
    nibScrollView.showsVerticalScrollIndicator = NO;
    nibScrollView.scrollsToTop = NO;
    nibScrollView.delegate = self;
    
    [nibScrollView setContentOffset:CGPointMake(0, 0)];
    
    currentPage = 0;
    pageControl.numberOfPages = 3;
    pageControl.currentPage = 0;
    pageControl.backgroundColor = [UIColor whiteColor];
    [self createAllEmptyPagesForScrollView];
}

- (void)createAllEmptyPagesForScrollView {
    
    background = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, nibScrollView.frame.size.width, nibScrollView.frame.size.height)];
    background.image = [UIImage imageNamed:@"background.png"];
    [nibScrollView addSubview:background];
    
    backgroundPlayer = [[UIView alloc] initWithFrame:CGRectMake(0, 0, nibScrollView.frame.size.width, nibScrollView.frame.size.height)];
    backgroundPlayer.backgroundColor = [UIColor colorWithRed:26.0/255.0 green:26.0/255.0 blue:26.0/255.0 alpha:0.75];
    [nibScrollView addSubview:backgroundPlayer];
    
    CGRect labelFrame = CGRectMake(nibScrollView.frame.size.width*0 + 10, 10, nibScrollView.frame.size.width - 20, 50);
    mDescriptionLabel = [[UILabel alloc] init];
    mDescriptionLabel.textColor = [UIColor whiteColor];
    mDescriptionLabel.numberOfLines = 0;
    mDescriptionLabel.frame = labelFrame;
    
    agendaMapView = [[AgendaMapView alloc]init ];
    agendaMapView.view.frame = CGRectMake(nibScrollView.frame.size.width*1, 0, nibScrollView.frame.size.width, nibScrollView.frame.size.height);
    
    [nibScrollView addSubview: mDescriptionLabel];
    [nibScrollView addSubview: agendaMapView.view];
}

// At the end of scroll animation, reset the boolean used when scrolls originate from the UIPageControl
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    
    CGFloat pageWidth = self.nibScrollView.frame.size.width;
    int page = floor((self.nibScrollView.contentOffset.x - pageWidth / 2) / pageWidth) + 1;
    
    pageControl.currentPage = page;
    currentPage = page;
    pageControlUsed = NO;
    [self btnActionShow];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
}

- (BOOL)touchesShouldBegin:(NSSet *)touches withEvent:(UIEvent *)event inContentView:(UIView *)view
{
    return YES;
}
- (BOOL)touchesShouldCancelInContentView:(UIView *)view
{
    return NO;
}

#pragma mark-
#pragma mark navigationController Methods

- (void) addBasicView
{
    descriptionButton.showsTouchWhenHighlighted = YES;
    [descriptionButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [descriptionButton addTarget:self action:@selector(descriptionButtonAction) forControlEvents:UIControlEventTouchUpInside];
    
    mapButton.showsTouchWhenHighlighted = YES;
    [mapButton setTitleColor:[UIColor colorWithRed:(220/255.0) green:(220/255.0) blue:(220/255.0) alpha:1] forState:UIControlStateNormal];
    [mapButton addTarget:self action:@selector(mapButtonAction) forControlEvents:UIControlEventTouchUpInside];
}

#pragma mark-
#pragma mark

- (void) btnActionShow
{
    if (currentPage == 0) {
        [self descriptionButtonAction];
    } else if (currentPage == 1) {
        [self mapButtonAction];
    }
}



- (void) descriptionButtonAction
{
    [descriptionButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [mapButton setTitleColor:[UIColor colorWithRed:(220/255.0) green:(220/255.0) blue:(220/255.0) alpha:1] forState:UIControlStateNormal];
    
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.3];
    
    slidLabel.frame = CGRectMake(0, 36, 107, 4);
    [nibScrollView setContentOffset:CGPointMake(nibScrollView.frame.size.width*0, 0)];
    
    [UIView commitAnimations];
}


- (void) mapButtonAction
{
    if (needLoadingMap) {
        NSMutableArray *eventArray = [[NSMutableArray alloc] init];
        [eventArray addObject:mEvent];
        [agendaMapView addAnnotations:eventArray];
        needLoadingMap = NO;
    }
    [mapButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [descriptionButton setTitleColor:[UIColor colorWithRed:(220/255.0) green:(220/255.0) blue:(220/255.0) alpha:1] forState:UIControlStateNormal];
    
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.3];
    
    slidLabel.frame = CGRectMake(108, 36, 107, 4);
    [nibScrollView setContentOffset:CGPointMake(nibScrollView.frame.size.width*1, 0)];
    
    [UIView commitAnimations];
}


@end
