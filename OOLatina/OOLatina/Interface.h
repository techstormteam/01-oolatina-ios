//
//  Interface.h
//  OOLatina
//
//  Created by Jérôme Laurent on 23/03/2014.
//  Copyright (c) 2014 Jérôme Laurent. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NavigationBar.h"
#import "TableView.h"
#import "TableViewElement.h"
#import "NewsView.h"
#import "AgendaView.h"
#import "RadioView.h"
#import "GalleryView.h"
#import "AudioView.h"
#import "PhotoView.h"
#import "VideoView.h"
#import "AlbumView.h"
#import "ArtistAlbum.h"
#import "VideoCategoryView.h"
#import "WebView.h"
#import "AgendaWholeView.h"

#import "SCUtils.h"

@interface Interface : UIViewController <TableViewSCDelegate, AudioViewDelegate, ArtistAlbumDelegate, VideoViewDelegate,NewsViewDelegate>
{
    AgendaWholeView *mAgendaWholeView;
    NavigationBar *mNavigationBar;
    TableView *mMenuTableView;
    NewsView *mNewsView;
    PhotoView *mPhotoView;
    RadioView *mRadioView;
    GalleryView *mGalleryView;
    AudioView *mAudioView;
    VideoView *mVideoView;
    AlbumView *mAlbumView;
    ArtistAlbum *mArtistAlbum;
    VideoCategoryView *mVideoCategoryView;
    WebView *mWebView;
    UIView *pageView;
    UIView *mPlusNavigation;
    UIImageView *background;
    UIButton *searchButton;
    
    int menuSelectedNumber;
    
    NSMutableArray *arrayImageNames;
    NSMutableArray *arrayMenu;
    int currentRowCloseMenu;
    BOOL MenuNavActive;
}

- (void)start;

@end
