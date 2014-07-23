//
//  ArtistAlbum.m
//  OOLatina
//
//  Created by Jérôme Laurent on 14/03/2014.
//  Copyright (c) 2014 Jérôme Laurent. All rights reserved.
//

#import "ArtistAlbum.h"
#import "ArtistTableViewCell.h"
#import "Albums.h"
#import "SCUtils.h"

@implementation ArtistAlbum

@synthesize delegate;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        arrayAlbum = [[NSMutableArray alloc] init];
        
        background = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
        background.image = [UIImage imageNamed:@"background.png"];
        [self addSubview:background];
        
        if([SCUtils isPhone5])
        {
            mDoubleScroll = [[UIDoubleScroll alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height-50)];
        }
        else
        {
            mDoubleScroll = [[UIDoubleScroll alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height-60)];
        }
        
        mDoubleScroll.delegate = self;
        mDoubleScroll.backgroundColor = [UIColor colorWithRed:26.0/255.0 green:26.0/255.0 blue:26.0/255.0 alpha:0.75];
        [self addSubview:mDoubleScroll];
    }
    return self;
}

- (void)getAllAlbum:(NSString *)artist
{
    if([SCUtils isNetworkAvailable])
    {
        NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"http://www.oolatina.com/webservice/oolatina_api.php?command=GET_ALL_ALBUM_ARTIST&idartist=%@",[artist stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]]];
        NSData *data = [[NSData alloc] initWithContentsOfURL:url];
        id object = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
        NSMutableArray *results = object;
        for (int x=0; x<results.count; x++)
        {
            NSDictionary *dict = [results objectAtIndex:x];
            [mDoubleScroll addElement:[dict objectForKey:@"cover"] andTitle:[dict objectForKey:@"title"] andId:[dict objectForKey:@"idalbum"]];
        }
    }
    else
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Erreur de connexion" message:@"Verifier votre connexion à internet" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
        [alert show];
    }
}

- (void)selectVideoCategory:(NSString *)idElement
{    
    [[self delegate] loadAlbum:idElement];
}


@end
