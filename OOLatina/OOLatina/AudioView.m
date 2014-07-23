//
//  AudioView.m
//  OOLatina
//
//  Created by Jérôme Laurent on 13/03/2014.
//  Copyright (c) 2014 Jérôme Laurent. All rights reserved.
//

#import "AudioView.h"
#import "Artist.h"
#import "SCUtils.h"

@implementation AudioView

@synthesize delegate;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        arrayArtist = [[NSMutableArray alloc] init];
        
        background = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
        background.image = [UIImage imageNamed:@"background.png"];
        [self addSubview:background];
        
        if([SCUtils isPhone5])
        {
            mDoubleScroll = [[UIDoubleScroll alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height-60)];
        }
        else
        {
            mDoubleScroll = [[UIDoubleScroll alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height-60)];
        }
        mDoubleScroll.delegate = self;
        mDoubleScroll.backgroundColor = [UIColor colorWithRed:26.0/255.0 green:26.0/255.0 blue:26.0/255.0 alpha:0.75];
        [self addSubview:mDoubleScroll];
        
        
        [self getAllArtist];
    }
    return self;
}

- (void)getAllArtist
{
    if([SCUtils isNetworkAvailable])
    {
        NSURL *url = [NSURL URLWithString:@"http://www.oolatina.com/webservice/oolatina_api.php?command=GET_ALL_ARTIST_AUDIO"];
        NSData *data = [[NSData alloc] initWithContentsOfURL:url];
        id object = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
        NSMutableArray *results = object;
        for (int x=0; x<results.count; x++)
        {
            NSDictionary *dict = [results objectAtIndex:x];
            [mDoubleScroll addElement:[dict objectForKey:@"image"] andTitle:[dict objectForKey:@"artistname"] andId:[dict objectForKey:@"artistid"]];
        //[self addArtist:[dict objectForKey:@"artistname"] andArtistId:[dict objectForKey:@"artistid"]];
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
    
    [[self delegate] loadAllAlbum:idElement];
}

@end
