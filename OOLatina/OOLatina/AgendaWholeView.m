//
//  AgendaWholeView.m
//  OOLatina
//
//  Created by Macbook air on 8/3/14.
//  Copyright (c) 2014 Jérôme Laurent. All rights reserved.
//

#import "AgendaWholeView.h"


@implementation AgendaWholeView

@synthesize agendaButton;
@synthesize arroundMeButton;
@synthesize mapButton;
@synthesize slidLabel;
@synthesize nibScrollView;

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
    // Do any additional setup after loading the view from its nib.
    
    [self setNavBar];
    
    [self addBasicView];
    
    [self initScrollView];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void)dealloc {
//    [agendaButton release];
//    [arroundMeButton release];
//    [slidLabel release];
//    [nibScrollView release];
//    [super dealloc];
}

#pragma mark-
#pragma mark navigationController Methods

- (void) setNavBar
{
    //    self.navigationController.navigationBarHidden = NO;//显示nav，这里使用动画
    [self.navigationController  setNavigationBarHidden:NO animated:YES];
    
    //设置Navigation Bar颜色
    self.navigationController.navigationBar.tintColor = [UIColor colorWithRed:(30/255.0) green:(175/255.0) blue:(200/255.0) alpha:1];
    
    
    UIButton *BackBtn = [[UIButton alloc] initWithFrame:CGRectMake(0.0, 164.0, 45, 45)];
	[BackBtn setImage:[UIImage imageNamed:@"btn_back1.png"]  forState:UIControlStateNormal];
	[BackBtn setImage:[UIImage imageNamed:@"btn_back2"] forState:UIControlStateHighlighted];
	BackBtn.backgroundColor = [UIColor clearColor];
	[BackBtn addTarget:self action:@selector(backAction) forControlEvents:UIControlEventTouchUpInside];
	UIBarButtonItem *temporaryBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:BackBtn];
	temporaryBarButtonItem.style = UIBarButtonItemStylePlain;
	self.navigationItem.leftBarButtonItem = temporaryBarButtonItem;
//	[temporaryBarButtonItem release];
    
}

- (void) backAction
{
	[self.navigationController popViewControllerAnimated:YES];
}

- (void) addBasicView
{
    agendaButton.showsTouchWhenHighlighted = YES;
    [agendaButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [agendaButton addTarget:self action:@selector(agendaButtonAction) forControlEvents:UIControlEventTouchUpInside];
    
    arroundMeButton.showsTouchWhenHighlighted = YES;
    [arroundMeButton setTitleColor:[UIColor colorWithRed:(220/255.0) green:(220/255.0) blue:(220/255.0) alpha:1] forState:UIControlStateNormal];
    [arroundMeButton addTarget:self action:@selector(arroundMeButtonAction) forControlEvents:UIControlEventTouchUpInside];
    
    mapButton.showsTouchWhenHighlighted = YES;
    [mapButton setTitleColor:[UIColor colorWithRed:(220/255.0) green:(220/255.0) blue:(220/255.0) alpha:1] forState:UIControlStateNormal];
    [mapButton addTarget:self action:@selector(mapButtonAction) forControlEvents:UIControlEventTouchUpInside];
}

#pragma mark-
#pragma mark 界面按钮事件

- (void) btnActionShow
{
    if (currentPage == 0) {
        [self agendaButtonAction];
    } else if (currentPage == 1) {
        [self arroundMeButtonAction];
    } else if (currentPage == 2) {
        [self mapButtonAction];
    }
}

- (void) agendaButtonAction
{
    [agendaButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [arroundMeButton setTitleColor:[UIColor colorWithRed:(220/255.0) green:(220/255.0) blue:(220/255.0) alpha:1] forState:UIControlStateNormal];
    [mapButton setTitleColor:[UIColor colorWithRed:(220/255.0) green:(220/255.0) blue:(220/255.0) alpha:1] forState:UIControlStateNormal];
    
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.3];
    
    slidLabel.frame = CGRectMake(0, 36, 107, 4);
    [nibScrollView setContentOffset:CGPointMake(nibScrollView.frame.size.width*0, 0)];
    
    [UIView commitAnimations];
}

- (void) arroundMeButtonAction
{
    [arroundMeButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [agendaButton setTitleColor:[UIColor colorWithRed:(220/255.0) green:(220/255.0) blue:(220/255.0) alpha:1] forState:UIControlStateNormal];
    [mapButton setTitleColor:[UIColor colorWithRed:(220/255.0) green:(220/255.0) blue:(220/255.0) alpha:1] forState:UIControlStateNormal];
    
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.3];
    
    slidLabel.frame = CGRectMake(108, 36, 107, 4);
    [nibScrollView setContentOffset:CGPointMake(nibScrollView.frame.size.width*1, 0)];
    
    [UIView commitAnimations];
}

- (void) mapButtonAction
{
    [mapButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [arroundMeButton setTitleColor:[UIColor colorWithRed:(220/255.0) green:(220/255.0) blue:(220/255.0) alpha:1] forState:UIControlStateNormal];
    [agendaButton setTitleColor:[UIColor colorWithRed:(220/255.0) green:(220/255.0) blue:(220/255.0) alpha:1] forState:UIControlStateNormal];
    
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.3];
    
    slidLabel.frame = CGRectMake(215, 36, 107, 4);
    [nibScrollView setContentOffset:CGPointMake(nibScrollView.frame.size.width*2, 0)];
    
    [UIView commitAnimations];
}

- (void) showSearch
{
    [agendaView showSearch];
}

- (void) loadEvent
{
//    [agendaView loadEvent];
}

#pragma mark -
#pragma mark 左右滑动相关函数

- (void)initScrollView {
    
    //tableScrollView
    // a page is the width of the scroll view
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
    
    agendaView = [[AgendaView alloc] initWithFrame:CGRectMake(0, 0, nibScrollView.frame.size.width, nibScrollView.frame.size.height)];
    agendaView.frame = CGRectMake(nibScrollView.frame.size.width*0, 0, nibScrollView.frame.size.width, nibScrollView.frame.size.height);
    arroundMeView = [[AgendaView alloc] initWithFrame:CGRectMake(0, 0, nibScrollView.frame.size.width, nibScrollView.frame.size.height)];
    arroundMeView.frame = CGRectMake(nibScrollView.frame.size.width*1, 0, nibScrollView.frame.size.width, nibScrollView.frame.size.height);
//    agendaMapView = [[AgendaMapView alloc]init ];
//    agendaMapView.view.frame = CGRectMake(nibScrollView.frame.size.width*2, 0, nibScrollView.frame.size.width, nibScrollView.frame.size.height);
    
    [nibScrollView addSubview: agendaView];
    [nibScrollView addSubview: arroundMeView];
//    [nibScrollView addSubview: agendaMapView];
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


@end
