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
        _numberOfImageInRow = [NSNumber numberWithInteger:3];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aCoder
{
    self = [super initWithCoder:aCoder];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setup {
    [[NSBundle mainBundle] loadNibNamed:@"PhotoView"
                                  owner:self options:nil];
    [self loadPhotoEvent];
    
    [self addSubview:self.view];
}

- (void)loadPhotoEvent {
    
    if([SCUtils isNetworkAvailable])
    {
        _count = 0;
        _imgSize = CGSizeMake(100, 100);
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
            NSInteger numberOfImageRows = ((nPhotos.count - 1) / [_numberOfImageInRow intValue]) + 1;
            NSInteger heightOfAlbum = (numberOfImageRows * _imgSize.width);
            NSInteger heightOfSection = heightOfTitle + heightOfAlbum;
            [sectionSizes addObject:[NSNumber numberWithInteger:heightOfSection]];
            [photoEvents addObject:nPhotoEvent];
        }
        
        // Load table view
        
    }

}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *simpleTableIdentifier = @"PhotoCustomCell";
    
    PhotoCustomCell *cell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    
    if (cell == nil) {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:simpleTableIdentifier owner:self options:nil];
        cell = [nib objectAtIndex:0];
    }
    
    PhotoEvent *photoEvent = [photoEvents objectAtIndex:[indexPath section]];
    
    cell.lblTitle.text = NSLocalizedString(@"no_title", nil);
    if ([photoEvent getTitle] != (id)[NSNull null] && [photoEvent getTitle].length != 0) {
        cell.lblTitle.text = [photoEvent getTitle];
    }
    photos = [photoEvent getPhoto];
    [cell passData: photos];
    [cell passPhotoSize: _imgSize];
    cell.covAlbum.backgroundColor = [UIColor clearColor];
    cell.covAlbum.backgroundView = [[UIView alloc] initWithFrame:CGRectZero];
    [cell.covAlbum registerNib:[UINib nibWithNibName:@"PhotoCollectionCell" bundle:nil] forCellWithReuseIdentifier:@"PhotoCollectionCell"];
    return cell;
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



@end
