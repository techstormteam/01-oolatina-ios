//
//  VideoView.m
//  OOLatina
//
//  Created by Jérôme Laurent on 13/03/2014.
//  Copyright (c) 2014 Jérôme Laurent. All rights reserved.
//

#import "VideoView.h"
#import "ArtistTableViewCell.h"
#import "VideoCategory.h"
#import "SCUtils.h"

@implementation VideoView

@synthesize delegate;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        background = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
        background.image = [UIImage imageNamed:@"background.png"];
        [self addSubview:background];
        
        arrayVideoCategory = [[NSMutableArray alloc] init];
        
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
        
        [mDoubleScroll addElement:@"dance-shows.jpg" andTitle:@"Dance Shows" andId:@"10"];
        [mDoubleScroll addElement:@"dance-workshops.jpg" andTitle:@"Dance workshops" andId:@"45"];
        [mDoubleScroll addElement:@"dance-party.jpg" andTitle:@"Dance party" andId:@"46"];
        [mDoubleScroll addElement:@"salsa-cubaine.jpg" andTitle:@"Salsa Cubaine" andId:@"22"];
        [mDoubleScroll addElement:@"salsa-portoricaine.jpg" andTitle:@"Salsa Portoricaine" andId:@"47"];
        [mDoubleScroll addElement:@"bachataCat.jpg" andTitle:@"Bachata" andId:@"20"];
        [mDoubleScroll addElement:@"kizombaCat.jpg" andTitle:@"Kizomba" andId:@"21"];
        [mDoubleScroll addElement:@"reggaetonCat.jpg" andTitle:@"Reggaeton" andId:@"23"];
        [mDoubleScroll addElement:@"merengueCat.jpg" andTitle:@"Merengue" andId:@"26"];
    }
    return self;
}

- (void)loadCategory
{
    /*NSURL *url = [NSURL URLWithString:@"http://www.oolatina.com/webservice/oolatina_api.php?command=GET_ALL_VIDEO_CATEGORIE"];
    NSData *data = [[NSData alloc] initWithContentsOfURL:url];
    id object = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
    NSMutableArray *results = object;
    for (int x=0; x<results.count; x++)
    {
        NSDictionary *dict = [results objectAtIndex:x];
        
        if([[dict objectForKey:@"name"] isEqualToString:@"Bachata Video"])
        {
            [mDoubleScroll addElement:@"bachataCat.jpg" andTitle:[dict objectForKey:@"name"] andId:[dict objectForKey:@"term_id"]];
        }
        
        if([[dict objectForKey:@"name"] isEqualToString:@"Dance Shows"])
        {
            [mDoubleScroll addElement:@"dance-shows.jpg" andTitle:[dict objectForKey:@"name"] andId:[dict objectForKey:@"term_id"]];
        }
        
        if([[dict objectForKey:@"name"] isEqualToString:@"Kizomba Video"])
        {
            [mDoubleScroll addElement:@"kizombaCat.jpg" andTitle:[dict objectForKey:@"name"] andId:[dict objectForKey:@"term_id"]];
        }
        
        if([[dict objectForKey:@"name"] isEqualToString:@"Salsa Video"])
        {
            [mDoubleScroll addElement:@"salsa-cubaine.jpg" andTitle:[dict objectForKey:@"name"] andId:[dict objectForKey:@"term_id"]];
        }
        
        if([[dict objectForKey:@"name"] isEqualToString:@"Reggaeton Video"])
        {
            [mDoubleScroll addElement:@"reggaetonCat.jpg" andTitle:[dict objectForKey:@"name"] andId:[dict objectForKey:@"term_id"]];
        }
        
        if([[dict objectForKey:@"name"] isEqualToString:@"Merengue Video"])
        {
            [mDoubleScroll addElement:@"merengueCat.jpg" andTitle:[dict objectForKey:@"name"] andId:[dict objectForKey:@"term_id"]];
        }
        
        if([[dict objectForKey:@"name"] isEqualToString:@"Dance workshops"])
        {
            [mDoubleScroll addElement:@"dance-workshops.jpg" andTitle:[dict objectForKey:@"name"] andId:[dict objectForKey:@"term_id"]];
        }
        
        if([[dict objectForKey:@"name"] isEqualToString:@"Dance party"])
        {
            [mDoubleScroll addElement:@"dance-party.jpg" andTitle:[dict objectForKey:@"name"] andId:[dict objectForKey:@"term_id"]];
        }
    }*/
}

- (void)selectVideoCategory:(NSString *)idElement
{
    [[self delegate] showCategoryVideo:idElement];
}


@end
