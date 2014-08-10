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
        
        [self loadPhotoEvent];
        
        GMGridView *gmGridView2 = [[GMGridView alloc] initWithFrame:self.bounds];
        gmGridView2.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        gmGridView2.style = GMGridViewStylePush;
        gmGridView2.itemSpacing = 5;
        gmGridView2.minEdgeInsets = UIEdgeInsetsMake(5, 5, 5, 5);
        gmGridView2.centerGrid = YES;
        gmGridView2.layoutStrategy = [GMGridViewLayoutStrategyFactory strategyFromType:GMGridViewLayoutHorizontal];
        CGRect frame1 = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
        gmGridView2.frame = frame1;
        [self addSubview:gmGridView2];
        _gmGridView2 = gmGridView2;
        _gmGridView2.dataSource = self;
        _gmGridView2.mainSuperView = self;
    }
    return self;
}


- (void)loadPhotoEvent {
    
    if([SCUtils isNetworkAvailable])
    {
        _count = 0;
        CGFloat wid = self.frame.size.width / _numberOfImageInRow;
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
                
            }
            [nPhotoEvent setPhoto:nPhotos];
            NSInteger heightOfTitle = 50;
            NSInteger numberOfImageRows = ((nPhotos.count - 1) / _numberOfImageInRow) + 1;
            NSInteger heightOfAlbum = (numberOfImageRows * _imgSize.width);
            NSInteger heightOfSection = heightOfTitle + heightOfAlbum;
            [sectionSizes addObject:[NSNumber numberWithInteger:heightOfSection]];
            [photoEvents addObject:nPhotoEvent];
        }
        
        // Load table view
        
    }

}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSNumber *height = [NSNumber numberWithInteger:1];
    if (_count < sectionSizes.count) {
        height = [sectionSizes objectAtIndex:_count];
        _count++;
    }
//    return 150;
    return [height intValue];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [photoEvents count];
//    return 2;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"didSelectRowAtIndexPath");
    // nothing
}

- (NSIndexPath *)tableView:(UITableView *)tableView willSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"willSelectRowAtIndexPath");
    if (indexPath.row == 0) {
        return nil;
    }
    
    return indexPath;
}

//////////////////////////////////////////////////////////////
#pragma mark GMGridViewDataSource
//////////////////////////////////////////////////////////////

- (NSInteger)numberOfItemsInGMGridView:(GMGridView *)gridView
{
    return 10;
}

- (CGSize)GMGridView:(GMGridView *)gridView sizeForItemsInInterfaceOrientation:(UIInterfaceOrientation)orientation
{
    if (UIInterfaceOrientationIsLandscape(orientation))
    {
        return CGSizeMake(self.frame.size.width, self.frame.size.height);
    }
    else
    {
        return CGSizeMake(self.frame.size.width, self.frame.size.height);
    }
}

- (GMGridViewCell *)GMGridView:(GMGridView *)gridView cellForItemAtIndex:(NSInteger)index
{
    //NSLog(@"Creating view indx %d", index);
    
//    CGSize size = CGSizeMake(_photoSize.width, _photoSize.height);
    
    GMGridViewCell *cell = [gridView dequeueReusableCell];
    
    if (!cell)
    {
        cell = [[GMGridViewCell alloc] init];
        
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
        view.backgroundColor = [UIColor clearColor];
        view.layer.masksToBounds = NO;
        view.layer.cornerRadius = 8;
        
       
        cell.contentView = view;
    }
    
    [[cell.contentView subviews] makeObjectsPerformSelector:@selector(removeFromSuperview)];

    if (_count < [photoEvents count]) {
        PhotoEvent *photoEvent = [photoEvents objectAtIndex:_count];
        photos = [photoEvent getPhoto];
        PhotoCustomCell *groupPhotos = [[PhotoCustomCell alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
        [groupPhotos passPhotoSize:_imgSize];
        [groupPhotos passData:photos];
        [groupPhotos setup];
        [cell.contentView addSubview:groupPhotos];

        [groupPhotos setTitle:NSLocalizedString(@"no_title", nil)];
        if ([photoEvent getTitle] != (id)[NSNull null] && [photoEvent getTitle].length != 0) {
            [groupPhotos setTitle:[photoEvent getTitle]];
        }
        [cell.contentView addSubview:groupPhotos];
        
        _count++;
    }
    
    return cell;
}


- (BOOL)GMGridView:(GMGridView *)gridView canDeleteItemAtIndex:(NSInteger)index
{
    return YES; //index % 2 == 0;
}



@end
