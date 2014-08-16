//
//  Interface.m
//  OOLatina
//
//  Created by Jérôme Laurent on 23/03/2014.
//  Copyright (c) 2014 Jérôme Laurent. All rights reserved.
//

#import "Interface.h"
#import "FirstGuideView.h"
#import "AgendaWholeView.h"
#import "PhotoPreviewView.h"

@interface Interface ()

@end

@implementation Interface

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self)
    {
        NSLog(@"Nib load: %@",nibNameOrNil);
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self start];
}

- (void)start
{
    MenuNavActive = NO;
    arrayMenu = [[NSMutableArray alloc] init];
    [arrayMenu addObject:NSLocalizedString(@"news", nil)];
    [arrayMenu addObject:NSLocalizedString(@"agenda", nil)];
    //[arrayMenu addObject:@"Gallery"];
    [arrayMenu addObject:NSLocalizedString(@"audio", nil)];
    [arrayMenu addObject:NSLocalizedString(@"video", nil)];
    [arrayMenu addObject:NSLocalizedString(@"radio", nil)];
    [arrayMenu addObject:NSLocalizedString(@"photo", nil)];
    
    mWebView = nil;
    
    self.view.backgroundColor = [UIColor colorWithRed:16.0/255.0 green:16.0/255.0 blue:16.0/255.0 alpha:1.0];
    
    currentRowCloseMenu = -1;
    
    mNavigationBar = [[NavigationBar alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 60+20)];
    [mNavigationBar SetBackgroundImage:@"navigation_bar.png"];
    [self.view addSubview:mNavigationBar];
    
    UIButton *openNavigation = [UIButton buttonWithType:UIButtonTypeCustom];
    [openNavigation setImage:[UIImage imageNamed:@"reduce_button.png"] forState:UIControlStateNormal];
    openNavigation.frame = CGRectMake(8,(80-30)/2,30,30);
    [openNavigation addTarget:self action:@selector(showMenu) forControlEvents:UIControlEventTouchUpInside];
    [mNavigationBar addSubview:openNavigation];
    
    searchButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [searchButton setImage:[UIImage imageNamed:@"search_button.png"] forState:UIControlStateNormal];
    searchButton.frame = CGRectMake(mNavigationBar.frame.size.width-35,(80-30)/2,30,30);
    [searchButton addTarget:self action:@selector(showSearch) forControlEvents:UIControlEventTouchUpInside];
    searchButton.hidden = YES;
    [mNavigationBar addSubview:searchButton];
    
    mMenuTableView = [[TableView alloc] initWithFrame:CGRectMake(-self.view.frame.size.width, 60, 200, self.view.frame.size.height)];
    mMenuTableView.backgroundColor = [UIColor colorWithRed:52.0/255.0 green:52.0/255.0 blue:52.0/255.0 alpha:0.95];
    [mMenuTableView SetHeightCells:50];
    mMenuTableView.delegate = self;
    [self.view addSubview:mMenuTableView];
    
    // Pageview
    pageView = [[UIView alloc] initWithFrame:CGRectMake(0, 60, self.view.frame.size.width, self.view.frame.size.height)];
    [self.view addSubview:pageView];
    
    UISwipeGestureRecognizer *swipeRight = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeMenuRight)];
    swipeRight.direction = UISwipeGestureRecognizerDirectionRight;
    
    [pageView addGestureRecognizer:swipeRight];
    
    UISwipeGestureRecognizer *swipeLeft = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeMenuLeft)];
    swipeLeft.direction = UISwipeGestureRecognizerDirectionLeft;
    
    [mMenuTableView addGestureRecognizer:swipeLeft];
    
    background = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, pageView.frame.size.width, pageView.frame.size.height)];
    background.image = [UIImage imageNamed:@"background.png"];
    [pageView addSubview:background];
    
    // Surplus de la navigation bar
    /*mPlusNavigation = [[UIView alloc] initWithFrame:CGRectMake(-self.view.frame.size.width, 0, self.view.frame.size.width, 60)];
     mPlusNavigation.backgroundColor = [UIColor colorWithRed:16.0/255.0 green:16.0/255.0 blue:16.0/255.0 alpha:1.0];*/
    
    UIImageView *logoOOLatina = [[UIImageView alloc] initWithFrame:CGRectMake(((mNavigationBar.frame.size.width-102)/2)+3,(mNavigationBar.frame.size.height-18)/2,102,18)];
    logoOOLatina.image = [UIImage imageNamed:@"logo_oolatina.png"];
    [mNavigationBar addSubview:logoOOLatina];
    
    //[self.view addSubview:mPlusNavigation];
    
    
    for (int x=0; x<arrayMenu.count; x++)
    {
        TableViewElement *mElement = [[TableViewElement alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 80)];
        [mElement SetFontSize:17];
        [mElement SetTextAlignment:@"LEFT"];
        [mElement SetTextFrame:CGRectMake(50, 0, mElement.frame.size.width-50, 80)];
        [mElement SetTitle:arrayMenu[x]];
        [mElement SetSeparatorColor:[UIColor colorWithRed:68.0/255.0 green:68.0/255.0 blue:68.0/255.0 alpha:1.0]];
        [mElement SetTitleColor:CGRectMake(255, 255, 255, 255)];
        mElement.tag = x;
        
        NSString *fileName = [NSString stringWithFormat:@"%@_icon.png",arrayMenu[x]];
        UIImageView *mImage = [[UIImageView alloc] initWithFrame:CGRectMake((60-30)/2, (50-20)/2, 20, 20)];
        mImage.image = [UIImage imageNamed:[fileName lowercaseString]];
        [mElement addSubview:mImage];
        
        [mMenuTableView AddElement:mElement];
    }
    
    mNewsView = [[NewsView alloc] initWithFrame:CGRectMake(0, 0, pageView.frame.size.width, pageView.frame.size.height)];
    mNewsView.delegate = self;
    mNewsView.backgroundColor = [UIColor redColor];
    [pageView addSubview:mNewsView];
}

- (void)showSearch
{
    [mAgendaWholeView showSearch];
}

- (void)showPageFeed:(NSString *)url
{
    mWebView = [[WebView alloc] initWithFrame:CGRectMake(0, 0, pageView.frame.size.width, pageView.frame.size.height-50)];
    [mWebView loadURL:url];
    [pageView addSubview:mWebView];
}

- (void)swipeMenuLeft
{
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.2];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationDidStopSelector:@selector(finishCloseMenu)];
    
    CGRect frame;
    
    frame = mMenuTableView.frame;
    frame.origin.x = -self.view.frame.size.width;
    mMenuTableView.frame = frame;
    MenuNavActive = NO;
    
    [UIView commitAnimations];
}

- (void)swipeMenuRight
{
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.2];
    
    [self.view bringSubviewToFront:mPlusNavigation];
    [self.view bringSubviewToFront:mMenuTableView];
    
    CGRect frame;
    
    frame = mMenuTableView.frame;
    frame.origin.x = 0;
    mMenuTableView.frame = frame;
    MenuNavActive = YES;
    
    [UIView commitAnimations];
}

- (void)showMenu
{
    if (MenuNavActive)
    {
        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationDuration:0.2];
        [UIView setAnimationDelegate:self];
        [UIView setAnimationDidStopSelector:@selector(finishCloseMenu)];
        
        /*CGRect frame = mNavigationBar.frame;
         frame.origin.x = 0;
         mNavigationBar.frame = frame;
         MenuNavActive = NO;
         
         frame = pageView.frame;
         frame.origin.x = 0;
         pageView.frame = frame;*/
        
        CGRect frame;
        
        /*frame = mPlusNavigation.frame;
         frame.origin.x = -self.view.frame.size.width;
         mPlusNavigation.frame = frame;*/
        
        frame = mMenuTableView.frame;
        frame.origin.x = -self.view.frame.size.width;
        mMenuTableView.frame = frame;
        MenuNavActive = NO;
        
        [UIView commitAnimations];
    }
    else
    {
        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationDuration:0.2];
        
        /*CGRect frame = mNavigationBar.frame;
         frame.origin.x = self.view.frame.size.width-45;
         mNavigationBar.frame = frame;
         MenuNavActive = YES;
         
         frame = pageView.frame;
         frame.origin.x = self.view.frame.size.width-45;
         pageView.frame = frame;*/
        
        [self.view bringSubviewToFront:mPlusNavigation];
        [self.view bringSubviewToFront:mMenuTableView];
        
        CGRect frame;
        
        /*frame = mPlusNavigation.frame;
         frame.origin.x = -45;
         mPlusNavigation.frame = frame;*/
        
        frame = mMenuTableView.frame;
        frame.origin.x = 0;
        mMenuTableView.frame = frame;
        MenuNavActive = YES;
        
        [UIView commitAnimations];
    }
}

- (void)selectedRow:(int)rownumber
{
    if(rownumber == 0)
    {
        if(mNewsView != nil)
        {
            [mNewsView removeFromSuperview];
        }
        //else
        //{
        if(mWebView != nil)
        {
            [mWebView removeFromSuperview];
        }
        
        searchButton.hidden = YES;
        mNewsView = [[NewsView alloc] initWithFrame:CGRectMake(0, 0, pageView.frame.size.width, pageView.frame.size.height)];
        mNewsView.backgroundColor = [UIColor redColor];
        [pageView addSubview:mNewsView];
        //}
    }
    
    if(rownumber == 1)
    {
        if(mAgendaWholeView != nil)
        {
            searchButton.hidden = NO;
            [mAgendaWholeView loadEvent];
            [pageView bringSubviewToFront:mAgendaWholeView];
        }
        else
        {
            searchButton.hidden = NO;
            mAgendaWholeView = [[AgendaWholeView alloc] initWithNibName:@"AgendaWholeView" bundle:nil];
//            mAgendaView = [[AgendaView alloc] initWithFrame:CGRectMake(0, 0, pageView.frame.size.width, pageView.frame.size.height)];
//            mAgendaView.backgroundColor = [UIColor blueColor];
//            [pageView addSubview:mAgendaView];
            [pageView addSubview:mAgendaWholeView.view];
        }
    }
    
    /*if(rownumber == 2)
     {
     if(mGalleryView != nil)
     {
     [pageView bringSubviewToFront:mGalleryView];
     }
     else
     {
     mGalleryView = [[GalleryView alloc] initWithFrame:CGRectMake(0, 0, pageView.frame.size.width, pageView.frame.size.height)];
     mGalleryView.backgroundColor = [UIColor greenColor];
     [pageView addSubview:mGalleryView];
     }
     }*/
    
    if(rownumber == 2)
    {
        if(mAudioView != nil)
        {
            [mAudioView removeFromSuperview];
        }
        //else
        //{
        searchButton.hidden = YES;
        mAudioView = [[AudioView alloc] initWithFrame:CGRectMake(0, 0, pageView.frame.size.width, pageView.frame.size.height)];
        mAudioView.delegate = self;
        mAudioView.backgroundColor = [UIColor purpleColor];
        [pageView addSubview:mAudioView];
        //}
    }
    
    if(rownumber == 3)
    {
        if(mVideoView != nil)
        {
            searchButton.hidden = YES;
            [pageView bringSubviewToFront:mVideoView];
        }
        else
        {
            searchButton.hidden = YES;
            mVideoView = [[VideoView alloc] initWithFrame:CGRectMake(0, 0, pageView.frame.size.width, pageView.frame.size.height)];
            [mVideoView loadCategory];
            mVideoView.delegate = self;
            [pageView addSubview:mVideoView];
        }
    }
    
    if(rownumber == 4)
    {
        if(mRadioView != nil)
        {
            searchButton.hidden = YES;
            [pageView bringSubviewToFront:mRadioView];
        }
        else
        {
            searchButton.hidden = YES;
            mRadioView = [[RadioView alloc] initWithFrame:CGRectMake(0, 0, pageView.frame.size.width, pageView.frame.size.height)];
            mRadioView.backgroundColor = [UIColor orangeColor];
            [pageView addSubview:mRadioView];
        }
    }
    
    if(rownumber == 5) {
//        if(mPhotoView != nil)
//        {
//            searchButton.hidden = YES;
//            [pageView bringSubviewToFront:mPhotoView];
//        }
//        else
//        {
            searchButton.hidden = YES;
            mPhotoView = [[PhotoView alloc] initWithFrame:CGRectMake(0, 0, pageView.frame.size.width, pageView.frame.size.height)];
        
            [pageView addSubview:mPhotoView];
//        }
    }
    
    [self showMenu];
    currentRowCloseMenu = rownumber;
    NSLog(@"Select element : %d",rownumber);
}

- (void)finishCloseMenu
{
}

- (void)loadAllAlbum:(NSString *)artistid
{
    mArtistAlbum = [[ArtistAlbum alloc] initWithFrame:CGRectMake(0, 0, pageView.frame.size.width, pageView.frame.size.height)];
    mArtistAlbum.delegate = self;
    [mArtistAlbum getAllAlbum:artistid];
    [pageView addSubview:mArtistAlbum];
}

- (void)loadAlbum:(NSString *)idAlbum
{
    mAlbumView = [[AlbumView alloc] initWithFrame:CGRectMake(0, 0, pageView.frame.size.width, pageView.frame.size.height)];
    mAlbumView.backgroundColor = [UIColor redColor];
    [mAlbumView loadAlbum:idAlbum];
    [pageView addSubview:mAlbumView];
}

- (void)showCategoryVideo:(NSString *)idcategory
{
    mVideoCategoryView = [[VideoCategoryView alloc] initWithFrame:CGRectMake(0, 0, pageView.frame.size.width, pageView.frame.size.height)];
    [mVideoCategoryView loadCategory:idcategory];
    [pageView addSubview:mVideoCategoryView];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
