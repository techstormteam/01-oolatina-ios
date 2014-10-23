//
//  PhotoView.m
//  OOLatina
//
//  Created by Macbook air on 8/1/14.
//  Copyright (c) 2014 Jérôme Laurent. All rights reserved.
//

#import "PhotoView.h"

@implementation PhotoView


- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        
        // Initialization code
        _numberOfImageInRow = 3;

        background = [[UIImageView alloc] initWithFrame:self.bounds];
        background.contentMode = UIViewContentModeScaleToFill;
        background.backgroundColor = [UIColor whiteColor];
//        background.image = [UIImage imageNamed:@"background.png"];
        [self addSubview:background];
        
//        backgroundPlayer = [[UIView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
//        backgroundPlayer.backgroundColor = photo;
//        [self addSubview:backgroundPlayer];
        
        GMGridView *gmGridView2 = [[GMGridView alloc] initWithFrame:self.bounds];
        gmGridView2.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        gmGridView2.style = GMGridViewStylePush;
        gmGridView2.itemSpacing = 5;
        gmGridView2.minEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 0);
        gmGridView2.centerGrid = NO;
        gmGridView2.layoutStrategy = [GMGridViewLayoutStrategyFactory strategyFromType:GMGridViewLayoutHorizontal];
        CGRect frame1 = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
        gmGridView2.frame = frame1;
//        [self addSubview:gmGridView2];
        _gmGridView2 = gmGridView2;
        _gmGridView2.dataSource = self;
        _gmGridView2.mainSuperView = self;
        
        [self loadPhotoEvent];
        
        [self initSearch];
        [self loadSearchData];
        
    }
    return self;
}

- (void)showPhotoList {
    [self bringSubviewToFront:background];
    [self bringSubviewToFront:backgroundPlayer];
    [self addSubview:scrollView];
}

- (void) createScrollView
{
    scrollView =[[UIScrollView alloc] initWithFrame:self.bounds];
    scrollView.delaysContentTouches = NO;

    [self addSubview:scrollView];
    
    int currHeight = 0;
    for (int x=0; x<sectionSizes.count; x++)
    {
        NSNumber *height = [sectionSizes objectAtIndex:x];
        UIView *mView = [[UIView alloc] initWithFrame:CGRectMake(0, currHeight, self.frame.size.width, [height intValue])];
//        CGRect s = mView.frame;
        
        if (_count < [photoEvents count]) {
            //    if (_count < 5) {
            PhotoEvent *photoEvent = [photoEvents objectAtIndex:_count];
            photos = [photoEvent getPhoto];
            PhotoCustomCell *groupPhotos = [[PhotoCustomCell alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
            groupPhotos.delegate = self;
            [groupPhotos passPhotoSize:_imgSize];
            [groupPhotos passData:photos];
            [groupPhotos setup];
            [mView addSubview:groupPhotos];
            
            [groupPhotos setTitle:NSLocalizedString(@"no_title", nil)];
            if ([photoEvent getTitle] != (id)[NSNull null] && [photoEvent getTitle].length != 0) {
                [groupPhotos setTitle:[photoEvent getTitle]];
            }
            
            [groupPhotos setDate:NSLocalizedString(@"no_date", nil) dayOfWeek:@""];
            if ([photoEvent getDate] != (id)[NSNull null]) {
                [groupPhotos setDate:[Utility toDateString:[photoEvent getDate]] dayOfWeek:[Utility toDayOfWeekString:[photoEvent getDate]]];
            }
            
            [groupPhotos setSeeAlbum:NSLocalizedString(@"see_album", nil)];
            
            [groupPhotos setCity:NSLocalizedString(@"no_city", nil)];
            if ([photoEvent getCity] != (id)[NSNull null] && [photoEvent getCity].length != 0) {
                [groupPhotos setCity:[photoEvent getCity]];
            }
            
            [mView addSubview:groupPhotos];
            _count++;
        }
        
        
        [scrollView addSubview:mView];
        currHeight += [height intValue];
    }
    scrollView.contentSize = CGSizeMake(self.frame.size.width, currHeight + 60);
}

- (void)loadPhotoEvent {
    
    if([SCUtils isNetworkAvailable])
    {
        _count = 0;
        CGFloat wid = (self.frame.size.width / _numberOfImageInRow) - 5;
        _imgSize = CGSizeMake(wid, wid);
        photoEvents = [[NSMutableArray alloc] init];
        sectionSizes = [[NSMutableArray alloc] init];
        NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"http://www.oolatina.com/webservice/oolatina_api.php?command=GET_PHOTO"]];
        NSLog(@"URL : %@",url);
        NSData *data = [[NSData alloc] initWithContentsOfURL:url];
        id object = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
        NSMutableArray *results = object;
        for (int x=0; x<results.count; x++)
        {
            NSDictionary *mDico = [results objectAtIndex:x];
            NSMutableArray *mPhotos = [mDico objectForKey:@"photos"];
            
            PhotoEvent *nPhotoEvent = [[PhotoEvent alloc] init];
            [nPhotoEvent setTitle:[mDico objectForKey:@"eventTitle"]];
            [nPhotoEvent setCity:[mDico objectForKey:@"city"]];
            [nPhotoEvent setDescription:[mDico objectForKey:@"description"]];
            [nPhotoEvent setDate:[Utility toNSDate:[mDico objectForKey:@"date"]]];
            [nPhotoEvent setId:[mDico objectForKey:@"eventId"]];
            
            
            NSMutableArray *nPhotos = [[NSMutableArray alloc] init];
            for (int photoNumber=0; photoNumber<mPhotos.count; photoNumber++) {
                NSDictionary *mPhotoDico = [mPhotos objectAtIndex:photoNumber];
                
                Photo *nPhoto = [[Photo alloc] init];
                [nPhoto setUrl:[mPhotoDico objectForKey:@"url"]];
                [nPhotos addObject:nPhoto];
                
//                nPhoto = [[Photo alloc] init];
//                [nPhoto setUrl:[mPhotoDico objectForKey:@"url"]];
//                [nPhotos addObject:nPhoto];
//                
//                nPhoto = [[Photo alloc] init];
//                [nPhoto setUrl:[mPhotoDico objectForKey:@"url"]];
//                [nPhotos addObject:nPhoto];
//                
//                nPhoto = [[Photo alloc] init];
//                [nPhoto setUrl:[mPhotoDico objectForKey:@"url"]];
//                [nPhotos addObject:nPhoto];
                

            }
            [nPhotoEvent setPhoto:nPhotos];
            NSInteger heightOfTitle = 50;
            NSInteger heightOfCity = 50;
            NSInteger numberOfImageRows = ((nPhotos.count - 1) / _numberOfImageInRow) + 1;
            NSInteger heightOfAlbum = (numberOfImageRows * _imgSize.width);
            NSInteger heightOfSection = heightOfCity + heightOfAlbum + heightOfTitle;
            [sectionSizes addObject:[NSNumber numberWithInteger:heightOfSection]];
            [photoEvents addObject:nPhotoEvent];
            
            
            
            
            
//            nPhotoEvent = [[PhotoEvent alloc] init];
//            [nPhotoEvent setTitle:[mDico objectForKey:@"eventTitle"]];
//            [nPhotoEvent setId:[mDico objectForKey:@"eventId"]];
//            
//            
//            nPhotos = [[NSMutableArray alloc] init];
//            for (int photoNumber=0; photoNumber<mPhotos.count; photoNumber++) {
//                NSDictionary *mPhotoDico = [mPhotos objectAtIndex:photoNumber];
//                
//                Photo *nPhoto = [[Photo alloc] init];
//                [nPhoto setUrl:[mPhotoDico objectForKey:@"url"]];
//                [nPhoto setName:[mPhotoDico objectForKey:@"name"]];
//                [nPhoto setDescription:[mPhotoDico objectForKey:@"description"]];
//                [nPhotos addObject:nPhoto];
//            }
//            [nPhotoEvent setPhoto:nPhotos];
//            heightOfTitle = 50;
//            numberOfImageRows = ((nPhotos.count - 1) / _numberOfImageInRow) + 1;
//            heightOfAlbum = (numberOfImageRows * _imgSize.width);
//            heightOfSection = heightOfTitle + heightOfAlbum;
//            [sectionSizes addObject:[NSNumber numberWithInteger:heightOfSection]];
//            [photoEvents addObject:nPhotoEvent];
//            
//            
//            
//            
//            
//            
//            nPhotoEvent = [[PhotoEvent alloc] init];
//            [nPhotoEvent setTitle:[mDico objectForKey:@"eventTitle"]];
//            [nPhotoEvent setId:[mDico objectForKey:@"eventId"]];
//            
//            
//            nPhotos = [[NSMutableArray alloc] init];
//            for (int photoNumber=0; photoNumber<mPhotos.count; photoNumber++) {
//                NSDictionary *mPhotoDico = [mPhotos objectAtIndex:photoNumber];
//                
//                Photo *nPhoto = [[Photo alloc] init];
//                [nPhoto setUrl:[mPhotoDico objectForKey:@"url"]];
//                [nPhoto setName:[mPhotoDico objectForKey:@"name"]];
//                [nPhoto setDescription:[mPhotoDico objectForKey:@"description"]];
//                [nPhotos addObject:nPhoto];
//            }
//            [nPhotoEvent setPhoto:nPhotos];
//            heightOfTitle = 50;
//            numberOfImageRows = ((nPhotos.count - 1) / _numberOfImageInRow) + 1;
//            heightOfAlbum = (numberOfImageRows * _imgSize.width);
//            heightOfSection = heightOfTitle + heightOfAlbum;
//            [sectionSizes addObject:[NSNumber numberWithInteger:heightOfSection]];
//            [photoEvents addObject:nPhotoEvent];
//
//            
//            
//            
//            
//            
//            
//            nPhotoEvent = [[PhotoEvent alloc] init];
//            [nPhotoEvent setTitle:[mDico objectForKey:@"eventTitle"]];
//            [nPhotoEvent setId:[mDico objectForKey:@"eventId"]];
//            
//            
//            nPhotos = [[NSMutableArray alloc] init];
//            for (int photoNumber=0; photoNumber<mPhotos.count; photoNumber++) {
//                NSDictionary *mPhotoDico = [mPhotos objectAtIndex:photoNumber];
//                
//                Photo *nPhoto = [[Photo alloc] init];
//                [nPhoto setUrl:[mPhotoDico objectForKey:@"url"]];
//                [nPhoto setName:[mPhotoDico objectForKey:@"name"]];
//                [nPhoto setDescription:[mPhotoDico objectForKey:@"description"]];
//                [nPhotos addObject:nPhoto];
//            }
//            [nPhotoEvent setPhoto:nPhotos];
//            heightOfTitle = 50;
//            numberOfImageRows = ((nPhotos.count - 1) / _numberOfImageInRow) + 1;
//            heightOfAlbum = (numberOfImageRows * _imgSize.width);
//            heightOfSection = heightOfTitle + heightOfAlbum;
//            [sectionSizes addObject:[NSNumber numberWithInteger:heightOfSection]];
//            [photoEvents addObject:nPhotoEvent];
//
//            
//            
//            
//            
//            
//            
//            nPhotoEvent = [[PhotoEvent alloc] init];
//            [nPhotoEvent setTitle:[mDico objectForKey:@"eventTitle"]];
//            [nPhotoEvent setId:[mDico objectForKey:@"eventId"]];
//            
//            
//            nPhotos = [[NSMutableArray alloc] init];
//            for (int photoNumber=0; photoNumber<mPhotos.count; photoNumber++) {
//                NSDictionary *mPhotoDico = [mPhotos objectAtIndex:photoNumber];
//                
//                Photo *nPhoto = [[Photo alloc] init];
//                [nPhoto setUrl:[mPhotoDico objectForKey:@"url"]];
//                [nPhoto setName:[mPhotoDico objectForKey:@"name"]];
//                [nPhoto setDescription:[mPhotoDico objectForKey:@"description"]];
//                [nPhotos addObject:nPhoto];
//            }
//            [nPhotoEvent setPhoto:nPhotos];
//            heightOfTitle = 50;
//            numberOfImageRows = ((nPhotos.count - 1) / _numberOfImageInRow) + 1;
//            heightOfAlbum = (numberOfImageRows * _imgSize.width);
//            heightOfSection = heightOfTitle + heightOfAlbum;
//            [sectionSizes addObject:[NSNumber numberWithInteger:heightOfSection]];
//            [photoEvents addObject:nPhotoEvent];
//
//            
//            
//            
//            
//            
//            
//            nPhotoEvent = [[PhotoEvent alloc] init];
//            [nPhotoEvent setTitle:[mDico objectForKey:@"eventTitle"]];
//            [nPhotoEvent setId:[mDico objectForKey:@"eventId"]];
//            
//            
//            nPhotos = [[NSMutableArray alloc] init];
//            for (int photoNumber=0; photoNumber<mPhotos.count; photoNumber++) {
//                NSDictionary *mPhotoDico = [mPhotos objectAtIndex:photoNumber];
//                
//                Photo *nPhoto = [[Photo alloc] init];
//                [nPhoto setUrl:[mPhotoDico objectForKey:@"url"]];
//                [nPhoto setName:[mPhotoDico objectForKey:@"name"]];
//                [nPhoto setDescription:[mPhotoDico objectForKey:@"description"]];
//                [nPhotos addObject:nPhoto];
//            }
//            [nPhotoEvent setPhoto:nPhotos];
//            heightOfTitle = 50;
//            numberOfImageRows = ((nPhotos.count - 1) / _numberOfImageInRow) + 1;
//            heightOfAlbum = (numberOfImageRows * _imgSize.width);
//            heightOfSection = heightOfTitle + heightOfAlbum;
//            [sectionSizes addObject:[NSNumber numberWithInteger:heightOfSection]];
//            [photoEvents addObject:nPhotoEvent];

        }
        
        // Load table view
        
    }
    [self createScrollView];
}

-(void)photoTapped:(UITapGestureRecognizer *)recognizer{
    PhotoImageView *imageView = (PhotoImageView *)recognizer.view;
    Photo *photo = [imageView getPhotoInfo];
    if(viePhotoPreview != nil)
    {
        [self bringSubviewToFront:viePhotoPreview.view];
        [self setPhotoPreviewData:photo];
    }
    else
    {
        CGRect bounds = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
        self.frame = bounds;
        viePhotoPreview = [[PhotoPreviewView alloc] initWithNibName:@"PhotoPreviewView" bundle:nil];
        
        viePhotoPreview.view.frame = bounds;
        
        [self setPhotoPreviewData:photo];
        
        [self addSubview:viePhotoPreview.view];
        
    }
}

-(void)setPhotoPreviewData:(Photo *)photo {
    [viePhotoPreview setImageUrl:[photo getUrl]];
    viePhotoPreview.lblName.text = [photo getName];
    viePhotoPreview.lblDescription.text = [photo getDescription];
    viePhotoPreview.lblDescription.numberOfLines = 3;
}

// Searching
- (void)showSearch
{
    [dropdownMusic setTitle:@"" forState:UIControlStateNormal];
    [dropdownGenre setTitle:@"" forState:UIControlStateNormal];
    villeField.text = @"";
    //[dropdownVille setTitle:@"" forState:UIControlStateNormal];
    villeSelected = @"";
    day = @"";
    month = @"";
    year = @"";
    musicArrayid = @"";
    genreArrayid = @"";
    mbackPopup.hidden = NO;
    closeButton.hidden = NO;
}

- (void) initSearch
{
    eventArray = [[NSMutableArray alloc] init];
    genreArray = [[NSMutableArray alloc] init];
    musicArray = [[NSMutableArray alloc] init];
    villeArray = [[NSMutableArray alloc] init];
    
    villeSelected = @"";
    musicArrayid = @"";
    genreArrayid = @"";
    day = @"";
    month = @"";
    year = @"";
    
    
    mbackPopup = [[UIView alloc] initWithFrame:CGRectMake(20, 10, 265+20, 400)];
    mbackPopup.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.5];
    mbackPopup.hidden = YES;
    [self addSubview:mbackPopup];
    
    popupView = [[UIView alloc] initWithFrame:CGRectMake(10, 0, 265, 400)];
    popupView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.5];
    //popupView.hidden = YES;
    [mbackPopup addSubview:popupView];
    
    UIColor *pinkColor = [UIColor colorWithRed:226.0/255.0 green:94.0/255.0 blue:117.0/255.0 alpha:1.0];
    
    searchField = [[UITextField alloc] initWithFrame:CGRectMake(22, 160+50, 220, 30)];
    searchField.borderStyle = UITextBorderStyleRoundedRect;
    searchField.delegate = self;
    searchField.returnKeyType = UIReturnKeyDone;
    searchField.font = [UIFont fontWithName:@"Helvetica" size:15.0];
    searchField.textColor = pinkColor;
    searchField.placeholder = NSLocalizedString(@"research", nil);
    [popupView addSubview:searchField];
    
    UIImageView *searchIcon = [[UIImageView alloc] initWithFrame:CGRectMake(220-30, 0, 30, 30)];
    searchIcon.image = [UIImage imageNamed:@"search_icon.png"];
    [searchField addSubview:searchIcon];
    
    calendarField = [[UITextField alloc] initWithFrame:CGRectMake(22, 210+50, 220, 30)];
    calendarField.borderStyle = UITextBorderStyleRoundedRect;
    calendarField.textColor = pinkColor;
    calendarField.placeholder = NSLocalizedString(@"calendar", nil);
    //calendarField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Calendrier" attributes:@{NSForegroundColorAttributeName: pinkColor}];
    calendarField.font = [UIFont fontWithName:@"Helvetica" size:15.0];
    calendarField.delegate = self;
    [popupView addSubview:calendarField];
    
    UIImageView *calendarIcon = [[UIImageView alloc] initWithFrame:CGRectMake(220-30, 0, 30, 30)];
    calendarIcon.image = [UIImage imageNamed:@"calendar_icon.png"];
    [calendarField addSubview:calendarIcon];
    
    villeField = [[UITextField alloc] initWithFrame:CGRectMake(22, 260+50, 220, 30)];
    villeField.borderStyle = UITextBorderStyleRoundedRect;
    villeField.enabled = YES;
    villeField.font = [UIFont fontWithName:@"Helvetica" size:15.0];
    villeField.returnKeyType = UIReturnKeyDone;
    villeField.textColor = pinkColor;
    villeField.placeholder = NSLocalizedString(@"city", nil);
    villeField.delegate = self;
    [popupView addSubview:villeField];
    
    UIImageView *villeIcon = [[UIImageView alloc] initWithFrame:CGRectMake(220-30, 0, 30, 30)];
    villeIcon.image = [UIImage imageNamed:@"ville_icon.png"];
    [villeField addSubview:villeIcon];
    
    UILabel *dateandVille = [[UILabel alloc] initWithFrame:CGRectMake(0, 170, 265, 25)];
    dateandVille.backgroundColor = [UIColor colorWithRed:128.0/255.0 green:128.0/255.0 blue:128.0/255.0 alpha:0.85];
    dateandVille.textAlignment = NSTextAlignmentCenter;
    dateandVille.font = [UIFont fontWithName:@"Helvetica-Bold" size:21.0];
    dateandVille.text = NSLocalizedString(@"date_and_city", nil);
    dateandVille.textColor = [UIColor blackColor];
    [popupView addSubview:dateandVille];
    
    UIButton *eventSearchButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    eventSearchButton.frame = CGRectMake(22, 260+50+50, 220, 30);
    [eventSearchButton setTitle:NSLocalizedString(@"find_events", nil) forState:UIControlStateNormal];
    [eventSearchButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    eventSearchButton.backgroundColor = [UIColor colorWithRed:51.0/255.0 green:51.0/255.0 blue:51.0/255.0 alpha:1.0];
    eventSearchButton.layer.cornerRadius = 5.0;
    eventSearchButton.titleLabel.textColor = [UIColor whiteColor];
    eventSearchButton.titleLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:12.0];
    [eventSearchButton addTarget:self action:@selector(launchSearch) forControlEvents:UIControlEventTouchUpInside];
    [popupView addSubview:eventSearchButton];
    
    UILabel *genreTitle = [[UILabel alloc] initWithFrame:CGRectMake(0, 5, 265, 25)];
    genreTitle.backgroundColor = [UIColor colorWithRed:128.0/255.0 green:128.0/255.0 blue:128.0/255.0 alpha:0.85];
    genreTitle.textAlignment = NSTextAlignmentCenter;
    genreTitle.font = [UIFont fontWithName:@"Helvetica-Bold" size:21.0];
    genreTitle.text = NSLocalizedString(@"kind", nil);
    genreTitle.textColor = [UIColor blackColor];
    [popupView addSubview:genreTitle];
    
    genreField = [[UITextField alloc] initWithFrame:CGRectMake(22, 45, 220, 30)];
    genreField.borderStyle = UITextBorderStyleRoundedRect;
    genreField.enabled = NO;
    genreField.delegate = self;
    genreField.font = [UIFont fontWithName:@"Helvetica" size:15.0];
    genreField.placeholder = NSLocalizedString(@"hint_kind", nil);
    genreField.textColor = pinkColor;
    [popupView addSubview:genreField];
    
    UIImageView *genreIcon = [[UIImageView alloc] initWithFrame:CGRectMake(220-30, 0, 30, 30)];
    genreIcon.image = [UIImage imageNamed:@"genre_icon.png"];
    [genreField addSubview:genreIcon];
    
    dropdownGenre = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    dropdownGenre.backgroundColor = [UIColor clearColor];
    dropdownGenre.titleLabel.textAlignment = NSTextAlignmentLeft;
    dropdownGenre.frame = CGRectMake(22, 45, 220, 30);
    dropdownGenre.tag = 0;
    [dropdownGenre setTitleColor:pinkColor forState:UIControlStateNormal];
    [dropdownGenre setTitle:NSLocalizedString(@"select", nil) forState:UIControlStateNormal];
    [dropdownGenre addTarget:self action:@selector(showDropDown:) forControlEvents:UIControlEventTouchUpInside];
    [popupView addSubview:dropdownGenre];
    
    UILabel *musicTitle = [[UILabel alloc] initWithFrame:CGRectMake(0, 90, 265, 25)];
    musicTitle.backgroundColor = [UIColor colorWithRed:128.0/255.0 green:128.0/255.0 blue:128.0/255.0 alpha:0.85];
    musicTitle.textAlignment = NSTextAlignmentCenter;
    musicTitle.font = [UIFont fontWithName:@"Helvetica-Bold" size:21.0];
    musicTitle.text = NSLocalizedString(@"music", nil);
    musicTitle.textColor = [UIColor blackColor];
    [popupView addSubview:musicTitle];
    
    musicField = [[UITextField alloc] initWithFrame:CGRectMake(22, 125, 220, 30)];
    musicField.borderStyle = UITextBorderStyleRoundedRect;
    musicField.enabled = NO;
    musicField.font = [UIFont fontWithName:@"Helvetica" size:15.0];
    musicField.placeholder = NSLocalizedString(@"hint_music", nil);
    musicField.delegate = self;
    musicField.textColor = pinkColor;
    [popupView addSubview:musicField];
    
    UIImageView *musicIcon = [[UIImageView alloc] initWithFrame:CGRectMake(220-30, 0, 30, 30)];
    musicIcon.image = [UIImage imageNamed:@"music_icon.png"];
    [musicField addSubview:musicIcon];
    
    dropdownMusic = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    dropdownMusic.backgroundColor = [UIColor clearColor];
    dropdownMusic.titleLabel.textAlignment = NSTextAlignmentLeft;
    dropdownMusic.frame = CGRectMake(22, 125, 220, 30);
    dropdownMusic.tag = 1;
    [dropdownMusic setTitleColor:pinkColor forState:UIControlStateNormal];
    [dropdownMusic setTitle:NSLocalizedString(@"select", nil) forState:UIControlStateNormal];
    [dropdownMusic addTarget:self action:@selector(showDropDown:) forControlEvents:UIControlEventTouchUpInside];
    [popupView addSubview:dropdownMusic];
    
    closeButton = [UIButton buttonWithType:UIButtonTypeCustom];
    closeButton.frame = CGRectMake(popupView.frame.origin.x+popupView.frame.size.width+10,0,30,30);
    [closeButton setImage:[UIImage imageNamed:@"close_icon.png"] forState:UIControlStateNormal];
    [closeButton addTarget:self action:@selector(closePopup) forControlEvents:UIControlEventTouchUpInside];
    closeButton.hidden = YES;
    [self addSubview:closeButton];
    
    [self loadArray];
}

- (void)loadArray
{
    // Music
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"http://www.oolatina.com/webservice/oolatina_api.php?command=GET_ARRAY_DROPDOWN&genre=music"]];
    NSData *data = [[NSData alloc] initWithContentsOfURL:url];
    id object = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
    NSMutableArray *results = object;
    for (int x=0; x<results.count; x++)
    {
        NSDictionary *mDict = (NSDictionary *)[results objectAtIndex:x];
        ArrayDropDown *mArray = [[ArrayDropDown alloc] init];
        [mArray setName:[mDict objectForKey:@"name"]];
        [mArray setIdArray:[mDict objectForKey:@"id"]];
        
        [musicArray addObject:mArray];
    }
    
    // Genre
    url = [NSURL URLWithString:[NSString stringWithFormat:@"http://www.oolatina.com/webservice/oolatina_api.php?command=GET_ARRAY_DROPDOWN&genre=genre"]];
    data = [[NSData alloc] initWithContentsOfURL:url];
    object = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
    results = object;
    for (int x=0; x<results.count; x++)
    {
        NSDictionary *mDict = (NSDictionary *)[results objectAtIndex:x];
        ArrayDropDown *mArray = [[ArrayDropDown alloc] init];
        [mArray setName:[mDict objectForKey:@"name"]];
        [mArray setIdArray:[mDict objectForKey:@"id"]];
        
        [genreArray addObject:mArray];
    }
    
    // Ville
    url = [NSURL URLWithString:[NSString stringWithFormat:@"http://www.oolatina.com/webservice/oolatina_api.php?command=GET_ARRAY_VILLE"]];
    data = [[NSData alloc] initWithContentsOfURL:url];
    object = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
    results = object;
    for (int x=0; x<results.count; x++)
    {
        NSDictionary *mDict = (NSDictionary *)[results objectAtIndex:x];
        ArrayDropDown *mArray = [[ArrayDropDown alloc] init];
        [mArray setName:[mDict objectForKey:@"name"]];
        
        [villeArray addObject:mArray];
    }
}


- (void)closePopup
{
    mbackPopup.hidden = YES;
    closeButton.hidden = YES;
}

- (void)loadSearchData
{
    if([SCUtils isNetworkAvailable])
    {
        NSString *urlString = [NSString stringWithFormat:@"http://www.oolatina.com/webservice/oolatina_api.php?command=GET_EVENT"];
        
        if (![searchField.text isEqualToString:@""]) {
            urlString = [NSString stringWithFormat:@"%@&search=%@",urlString,[self urlEncodeUsingEncoding:searchField.text]];
        }
        if (![villeField.text isEqualToString:@""]) {
            urlString = [NSString stringWithFormat:@"%@&ville=%@",urlString,villeField.text];
        }
        if (![day isEqualToString:@""]) {
            urlString = [NSString stringWithFormat:@"%@&day=%@",urlString,day];
        }
        if (![month isEqualToString:@""]) {
            urlString = [NSString stringWithFormat:@"%@&month=%@",urlString,month];
        }
        if (![year isEqualToString:@""]) {
            urlString = [NSString stringWithFormat:@"%@&year=%@",urlString,year];
        }
        if (![musicArrayid isEqualToString:@""]) {
            urlString = [NSString stringWithFormat:@"%@&music=%@",urlString,musicArrayid];
        }
        if (![genreArrayid isEqualToString:@""]) {
            urlString = [NSString stringWithFormat:@"%@&genre=%@",urlString,genreArrayid];
        }
        
        NSURL *url = [NSURL URLWithString:urlString];
        NSLog(@"URL : %@",url);
        NSData *data = [[NSData alloc] initWithContentsOfURL:url];
        id object = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
        NSMutableArray *results = object;
        NSMutableArray *eventList = [[NSMutableArray alloc] init];
        for (int x=0; x<results.count; x++)
            //        for (int x=30; x<31; x++)
        {
//            NSDictionary *mDico = [results objectAtIndex:x];
//            NSDictionary *mEvent = [mDico objectForKey:@"event"];
//            
//            Event *nEvent = [[Event alloc] init];
//            [nEvent setTitle:[mEvent objectForKey:@"title"]];
//            
//            NSMutableArray *mPhotos = [mDico objectForKey:@"photos"];
//            if (mPhotos.count > 0) {
//                NSDictionary *mPhotoDico = [mPhotos objectAtIndex:0];
//                [nEvent setThumbnailEvent:[mPhotoDico objectForKey:@"url"]];
//            }
//            
//            [nEvent setThumbnailEvent:[NSString stringWithFormat:@"http://www.oolatina.com/%@", [mEvent objectForKey:@"photos"]]];
//            [nEvent setVille:[mEvent objectForKey:@"ville"]];
//            [nEvent setYear:[mEvent objectForKey:@"year"]];
//            [nEvent setMonth:[mEvent objectForKey:@"month"]];
//            [nEvent setEventDay:[mEvent objectForKey:@"day"]];
//            [nEvent setCodePostal:[mEvent objectForKey:@"codepostal"]];
//            [nEvent setAdresse:[mEvent objectForKey:@"adresse"]];
//            [nEvent setDescription:[mEvent objectForKey:@"description"]];
//            [nEvent setCountry:[mEvent objectForKey:@"country"]];
//            [nEvent setLieu:[mEvent objectForKey:@"lieu"]];
//            [nEvent setName:[mEvent objectForKey:@"lieu"]];
//            if (![[mEvent objectForKey:@"longitude"] isEqual:[NSNull null]]) {
//                [nEvent setLongitude:[[mEvent objectForKey:@"longitude"] floatValue]];
//            }
//            if (![[mEvent objectForKey:@"latitude"] isEqual:[NSNull null]]) {
//                [nEvent setLatitude:[[mEvent objectForKey:@"latitude"] floatValue]];
//            }
//            [eventList addObject:nEvent];
        }

        
        eventArray = eventList;
//        [self loadEvent];
        mbackPopup.hidden = YES;
        closeButton.hidden = YES;
//        needLoadingAgenda = YES;
//        needLoadingArroundMe = YES;
//        needLoadingAgendaMap = YES;
    }
}

- (void)launchSearch
{
    [self loadSearchData];
//    [self btnActionShow];
}

- (NSString *)urlEncodeUsingEncoding:(NSString *)string
{
    NSString *s = [string stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    return s;
}


//////////////////////////////////////////////////////////////
#pragma mark GMGridViewDataSource
//////////////////////////////////////////////////////////////

- (NSInteger)numberOfItemsInGMGridView:(GMGridView *)gridView
{
    return [photoEvents count];
//    return 5;
}

- (CGSize)GMGridView:(GMGridView *)gridView sizeForItemsInInterfaceOrientation:(UIInterfaceOrientation)orientation
{
    
    if (UIInterfaceOrientationIsLandscape(orientation))
    {
        return CGSizeMake(300, 200);
    }
    else
    {
        return CGSizeMake(300, 200);
    }
}

- (GMGridViewCell *)GMGridView:(GMGridView *)gridView cellForItemAtIndex:(NSInteger)index
{
    GMGridViewCell *cell = [gridView dequeueReusableCell];
    
    if (!cell)
    {
        cell = [[GMGridViewCell alloc] init];
        
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 300, 200)];
        view.backgroundColor = [UIColor clearColor];
        view.layer.masksToBounds = NO;
        view.layer.cornerRadius = 8;
        
       
        cell.contentView = view;
    }
    
    [[cell.contentView subviews] makeObjectsPerformSelector:@selector(removeFromSuperview)];

    
    return cell;
}


- (BOOL)GMGridView:(GMGridView *)gridView canDeleteItemAtIndex:(NSInteger)index
{
    return YES; //index % 2 == 0;
}



@end
