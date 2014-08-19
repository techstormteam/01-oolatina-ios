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
        _numberOfImageInRow = 4;
        
        
        
        background = [[UIImageView alloc] initWithFrame:self.bounds];
        background.contentMode = UIViewContentModeScaleToFill;
        background.image = [UIImage imageNamed:@"background.png"];
        [self addSubview:background];
        
        backgroundPlayer = [[UIView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
        backgroundPlayer.backgroundColor = [UIColor colorWithRed:26.0/255.0 green:26.0/255.0 blue:26.0/255.0 alpha:0.75];
        [self addSubview:backgroundPlayer];
        
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
        
        
    }
    return self;
}

- (void) createScrollView
{
    scrollView =[[UIScrollView alloc] initWithFrame:self.bounds];
    scrollView.delaysContentTouches = NO;
    CGSize a = self.frame.size;
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
            [mView addSubview:groupPhotos];
            _count++;
        }
        
        
        [scrollView addSubview:mView];
        currHeight += [height intValue];
    }
    scrollView.contentSize = CGSizeMake(self.frame.size.width, currHeight);
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
            NSMutableArray *mPhotos = [mDico objectForKey:@"photo"];
            
            PhotoEvent *nPhotoEvent = [[PhotoEvent alloc] init];
            [nPhotoEvent setTitle:[mDico objectForKey:@"eventTitle"]];
            [nPhotoEvent setId:[mDico objectForKey:@"eventId"]];
            
            
            NSMutableArray *nPhotos = [[NSMutableArray alloc] init];
            for (int photoNumber=0; photoNumber<mPhotos.count; photoNumber++) {
                NSDictionary *mPhotoDico = [mPhotos objectAtIndex:photoNumber];
                
                Photo *nPhoto = [[Photo alloc] init];
                [nPhoto setUrl:[mPhotoDico objectForKey:@"url"]];
                [nPhoto setName:[mPhotoDico objectForKey:@"name"]];
                [nPhoto setDescription:[mPhotoDico objectForKey:@"description"]];
                [nPhotos addObject:nPhoto];
                
                nPhoto = [[Photo alloc] init];
                [nPhoto setUrl:[mPhotoDico objectForKey:@"url"]];
                [nPhoto setName:[mPhotoDico objectForKey:@"name"]];
                [nPhoto setDescription:[mPhotoDico objectForKey:@"description"]];
                [nPhotos addObject:nPhoto];
                
                nPhoto = [[Photo alloc] init];
                [nPhoto setUrl:[mPhotoDico objectForKey:@"url"]];
                [nPhoto setName:[mPhotoDico objectForKey:@"name"]];
                [nPhoto setDescription:[mPhotoDico objectForKey:@"description"]];
                [nPhotos addObject:nPhoto];
                
                nPhoto = [[Photo alloc] init];
                [nPhoto setUrl:[mPhotoDico objectForKey:@"url"]];
                [nPhoto setName:[mPhotoDico objectForKey:@"name"]];
                [nPhoto setDescription:[mPhotoDico objectForKey:@"description"]];
                [nPhotos addObject:nPhoto];
                

            }
            [nPhotoEvent setPhoto:nPhotos];
            NSInteger heightOfTitle = 50;
            NSInteger numberOfImageRows = ((nPhotos.count - 1) / _numberOfImageInRow) + 1;
            NSInteger heightOfAlbum = (numberOfImageRows * _imgSize.width);
            NSInteger heightOfSection = heightOfTitle + heightOfAlbum;
            [sectionSizes addObject:[NSNumber numberWithInteger:heightOfSection]];
            [photoEvents addObject:nPhotoEvent];
            
            
            
            
            
            nPhotoEvent = [[PhotoEvent alloc] init];
            [nPhotoEvent setTitle:[mDico objectForKey:@"eventTitle"]];
            [nPhotoEvent setId:[mDico objectForKey:@"eventId"]];
            
            
            nPhotos = [[NSMutableArray alloc] init];
            for (int photoNumber=0; photoNumber<mPhotos.count; photoNumber++) {
                NSDictionary *mPhotoDico = [mPhotos objectAtIndex:photoNumber];
                
                Photo *nPhoto = [[Photo alloc] init];
                [nPhoto setUrl:[mPhotoDico objectForKey:@"url"]];
                [nPhoto setName:[mPhotoDico objectForKey:@"name"]];
                [nPhoto setDescription:[mPhotoDico objectForKey:@"description"]];
                [nPhotos addObject:nPhoto];
            }
            [nPhotoEvent setPhoto:nPhotos];
            heightOfTitle = 50;
            numberOfImageRows = ((nPhotos.count - 1) / _numberOfImageInRow) + 1;
            heightOfAlbum = (numberOfImageRows * _imgSize.width);
            heightOfSection = heightOfTitle + heightOfAlbum;
            [sectionSizes addObject:[NSNumber numberWithInteger:heightOfSection]];
            [photoEvents addObject:nPhotoEvent];
            
            
            
            
            
            
            nPhotoEvent = [[PhotoEvent alloc] init];
            [nPhotoEvent setTitle:[mDico objectForKey:@"eventTitle"]];
            [nPhotoEvent setId:[mDico objectForKey:@"eventId"]];
            
            
            nPhotos = [[NSMutableArray alloc] init];
            for (int photoNumber=0; photoNumber<mPhotos.count; photoNumber++) {
                NSDictionary *mPhotoDico = [mPhotos objectAtIndex:photoNumber];
                
                Photo *nPhoto = [[Photo alloc] init];
                [nPhoto setUrl:[mPhotoDico objectForKey:@"url"]];
                [nPhoto setName:[mPhotoDico objectForKey:@"name"]];
                [nPhoto setDescription:[mPhotoDico objectForKey:@"description"]];
                [nPhotos addObject:nPhoto];
            }
            [nPhotoEvent setPhoto:nPhotos];
            heightOfTitle = 50;
            numberOfImageRows = ((nPhotos.count - 1) / _numberOfImageInRow) + 1;
            heightOfAlbum = (numberOfImageRows * _imgSize.width);
            heightOfSection = heightOfTitle + heightOfAlbum;
            [sectionSizes addObject:[NSNumber numberWithInteger:heightOfSection]];
            [photoEvents addObject:nPhotoEvent];

            
            
            
            
            
            
            nPhotoEvent = [[PhotoEvent alloc] init];
            [nPhotoEvent setTitle:[mDico objectForKey:@"eventTitle"]];
            [nPhotoEvent setId:[mDico objectForKey:@"eventId"]];
            
            
            nPhotos = [[NSMutableArray alloc] init];
            for (int photoNumber=0; photoNumber<mPhotos.count; photoNumber++) {
                NSDictionary *mPhotoDico = [mPhotos objectAtIndex:photoNumber];
                
                Photo *nPhoto = [[Photo alloc] init];
                [nPhoto setUrl:[mPhotoDico objectForKey:@"url"]];
                [nPhoto setName:[mPhotoDico objectForKey:@"name"]];
                [nPhoto setDescription:[mPhotoDico objectForKey:@"description"]];
                [nPhotos addObject:nPhoto];
            }
            [nPhotoEvent setPhoto:nPhotos];
            heightOfTitle = 50;
            numberOfImageRows = ((nPhotos.count - 1) / _numberOfImageInRow) + 1;
            heightOfAlbum = (numberOfImageRows * _imgSize.width);
            heightOfSection = heightOfTitle + heightOfAlbum;
            [sectionSizes addObject:[NSNumber numberWithInteger:heightOfSection]];
            [photoEvents addObject:nPhotoEvent];

            
            
            
            
            
            
            nPhotoEvent = [[PhotoEvent alloc] init];
            [nPhotoEvent setTitle:[mDico objectForKey:@"eventTitle"]];
            [nPhotoEvent setId:[mDico objectForKey:@"eventId"]];
            
            
            nPhotos = [[NSMutableArray alloc] init];
            for (int photoNumber=0; photoNumber<mPhotos.count; photoNumber++) {
                NSDictionary *mPhotoDico = [mPhotos objectAtIndex:photoNumber];
                
                Photo *nPhoto = [[Photo alloc] init];
                [nPhoto setUrl:[mPhotoDico objectForKey:@"url"]];
                [nPhoto setName:[mPhotoDico objectForKey:@"name"]];
                [nPhoto setDescription:[mPhotoDico objectForKey:@"description"]];
                [nPhotos addObject:nPhoto];
            }
            [nPhotoEvent setPhoto:nPhotos];
            heightOfTitle = 50;
            numberOfImageRows = ((nPhotos.count - 1) / _numberOfImageInRow) + 1;
            heightOfAlbum = (numberOfImageRows * _imgSize.width);
            heightOfSection = heightOfTitle + heightOfAlbum;
            [sectionSizes addObject:[NSNumber numberWithInteger:heightOfSection]];
            [photoEvents addObject:nPhotoEvent];

            
            
            
            
            
            
            nPhotoEvent = [[PhotoEvent alloc] init];
            [nPhotoEvent setTitle:[mDico objectForKey:@"eventTitle"]];
            [nPhotoEvent setId:[mDico objectForKey:@"eventId"]];
            
            
            nPhotos = [[NSMutableArray alloc] init];
            for (int photoNumber=0; photoNumber<mPhotos.count; photoNumber++) {
                NSDictionary *mPhotoDico = [mPhotos objectAtIndex:photoNumber];
                
                Photo *nPhoto = [[Photo alloc] init];
                [nPhoto setUrl:[mPhotoDico objectForKey:@"url"]];
                [nPhoto setName:[mPhotoDico objectForKey:@"name"]];
                [nPhoto setDescription:[mPhotoDico objectForKey:@"description"]];
                [nPhotos addObject:nPhoto];
            }
            [nPhotoEvent setPhoto:nPhotos];
            heightOfTitle = 50;
            numberOfImageRows = ((nPhotos.count - 1) / _numberOfImageInRow) + 1;
            heightOfAlbum = (numberOfImageRows * _imgSize.width);
            heightOfSection = heightOfTitle + heightOfAlbum;
            [sectionSizes addObject:[NSNumber numberWithInteger:heightOfSection]];
            [photoEvents addObject:nPhotoEvent];

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
    }
    else
    {
        CGRect bounds = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
        self.frame = bounds;
        viePhotoPreview = [[PhotoPreviewView alloc] initWithNibName:@"PhotoPreviewView" bundle:nil];
        
        viePhotoPreview.view.frame = bounds;
        
        [viePhotoPreview setImageUrl:[photo getUrl]];
        viePhotoPreview.lblName.text = [photo getName];
        viePhotoPreview.lblDescription.text = [photo getDescription];
        viePhotoPreview.lblDescription.numberOfLines = 3;
        
        [self addSubview:viePhotoPreview.view];
        
    }
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
