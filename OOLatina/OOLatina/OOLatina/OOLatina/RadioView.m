//
//  RadioView.m
//  OOLatina
//
//  Created by Jérôme Laurent on 13/03/2014.
//  Copyright (c) 2014 Jérôme Laurent. All rights reserved.
//

#import "RadioView.h"
#import "SCUtils.h"

@implementation RadioView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        radioArray = [[NSMutableArray alloc] init];
        
        background = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
        background.image = [UIImage imageNamed:@"background.png"];
        [self addSubview:background];
        
        backgroundPlayer = [[UIView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
        backgroundPlayer.backgroundColor = [UIColor colorWithRed:26.0/255.0 green:26.0/255.0 blue:26.0/255.0 alpha:0.75];
        [self addSubview:backgroundPlayer];
        
        cover = [[UIImageView alloc] initWithFrame:CGRectMake((320-250)/2, 0, 250, 240)];
        [self addSubview:cover];
        
        artist = [[UILabel alloc] initWithFrame:CGRectMake(0, 240, frame.size.width, 30)];
        artist.textColor = [UIColor whiteColor];
        artist.text = @"Un Monton De Estrellas";
        artist.textAlignment = NSTextAlignmentCenter;
        artist.font = [UIFont fontWithName:@"Helvetica-Bold" size:12.0];
        artist.numberOfLines = 2;
        [self addSubview:artist];
        
        radioName = [[UILabel alloc] initWithFrame:CGRectMake(0, 250+12, frame.size.width, 20)];
        radioName.textColor = [UIColor colorWithRed:169.0/255.0 green:169.0/255.0 blue:169.0/255.0 alpha:1.0];
        radioName.textAlignment = NSTextAlignmentCenter;
        radioName.font = [UIFont fontWithName:@"Helvetica-Bold" size:8.0];
        radioName.text = @"OOlatina Radio";
        [self addSubview:radioName];
        
        buttonPlay = [UIButton buttonWithType:UIButtonTypeCustom];
        buttonPlay.frame = CGRectMake((self.frame.size.width-45)/2, 370, 45, 45);
        [buttonPlay setImage:[UIImage imageNamed:@"buttonplayradio.png"] forState:UIControlStateNormal];
        [buttonPlay addTarget:self action:@selector(playRadio) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:buttonPlay];
        
        UIView *separator = [[UIView alloc] initWithFrame:CGRectMake(0, 290, frame.size.width, 1)];
        separator.backgroundColor = [UIColor colorWithRed:221.0/255.0 green:38.0/255.0 blue:118.0/255.0 alpha:1.0];
        [self addSubview:separator];
        
        itunesLink = [UIButton buttonWithType:UIButtonTypeCustom];
        itunesLink.frame = CGRectMake(185, 250-(50), 100, 30);
        [itunesLink setImage:[UIImage imageNamed:@"ituneslink.png"] forState:UIControlStateNormal];
        [itunesLink addTarget:self action:@selector(showiTunesLink) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:itunesLink];
        
        mScrollLinear = [[UIScrollLinear alloc] initWithFrame:CGRectMake(0, 300, frame.size.width, 70)];
        mScrollLinear.delegate = self;
        [self addSubview:mScrollLinear];
        
        Radio *mRadio = [[Radio alloc] initWithFrame:CGRectMake(0, 0, 114, 68)];
        [mRadio setImage:@"kizomba.jpg"];
        mRadio.tag = 0;
        [mScrollLinear addView:mRadio];
        
        mRadio = [[Radio alloc] initWithFrame:CGRectMake(0, 0, 114, 68)];
        [mRadio setImage:@"bachata.jpg"];
        mRadio.tag = 1;
        [mScrollLinear addView:mRadio];
        
        mRadio = [[Radio alloc] initWithFrame:CGRectMake(0, 0, 114, 68)];
        [mRadio setImage:@"merengue.jpg"];
        mRadio.tag = 2;
        [mScrollLinear addView:mRadio];
        
        mRadio = [[Radio alloc] initWithFrame:CGRectMake(0, 0, 114, 68)];
        [mRadio setImage:@"oolatina.jpg"];
        mRadio.tag = 3;
        [mScrollLinear addView:mRadio];
        
        mRadio = [[Radio alloc] initWithFrame:CGRectMake(0, 0, 114, 68)];
        [mRadio setImage:@"dj.jpg"];
        mRadio.tag = 4;
        [mScrollLinear addView:mRadio];
        
        mRadio = [[Radio alloc] initWithFrame:CGRectMake(0, 0, 114, 68)];
        [mRadio setImage:@"reggaeton.jpg"];
        mRadio.tag = 5;
        [mScrollLinear addView:mRadio];
        
        mRadio = [[Radio alloc] initWithFrame:CGRectMake(0, 0, 114, 68)];
        [mRadio setImage:@"cubaine.jpg"];
        mRadio.tag = 6;
        [mScrollLinear addView:mRadio];
        
        mRadio = [[Radio alloc] initWithFrame:CGRectMake(0, 0, 114, 68)];
        [mRadio setImage:@"portoricaine.jpg"];
        mRadio.tag = 7;
        [mScrollLinear addView:mRadio];
        
        mRadio = [[Radio alloc] initWithFrame:CGRectMake(0, 0, 114, 68)];
        [mRadio setImage:@"zumba.jpg"];
        mRadio.tag = 8;
        [mScrollLinear addView:mRadio];
        
        isPlaying = NO;
        player = nil;
        
        [self setFlux:@"oolatina"];
        [self loadCover];
    }
    return self;
}

- (void)setFlux:(NSString *)flux
{
    if([SCUtils isNetworkAvailable])
    {
        fluxRadio = flux;
    
        if(player != nil)
        {
            [player stop];
            [player.view removeFromSuperview];
            player = nil;
        }
    
        NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"http://37.187.137.144:8000/%@",fluxRadio]];
        player = [[MPMoviePlayerController alloc] initWithContentURL:url];
        player.movieSourceType = MPMovieSourceTypeStreaming;
        player.view.hidden = YES;
        [self addSubview:player.view];
        isPlaying = NO;
    
        // On force le lance de la radio
        [self playRadio];
    }
    else
    {
    }
}

- (void)changeRadio:(int)radioSelect
{    
    switch (radioSelect)
    {
        case 0:
        {
            [self setFlux:@"kizomba"];
            radioName.text = @"Kizomba Radio";
        }
        break;
            
        case 1:
        {
            [self setFlux:@"bachata"];
            radioName.text = @"Bachata Radio";
        }
            break;
            
        case 2:
        {
            [self setFlux:@"merengue"];
            radioName.text = @"Merengue Radio";
        }
            break;
            
        case 3:
        {
            [self setFlux:@"oolatina"];
            radioName.text = @"OOLatina Radio";
        }
            break;
            
        case 4:
        {
            [self setFlux:@"dj"];
            radioName.text = @"DJ Radio";
        }
            break;
            
        case 5:
        {
            [self setFlux:@"reggaeton"];
            radioName.text = @"Reggaeton Radio";
        }
            break;
            
        case 6:
        {
            [self setFlux:@"salsa_cubaine"];
            radioName.text = @"Salsa Cubaine Radio";
        }
            break;
            
        case 7:
        {
            [self setFlux:@"salsa_portoricaine"];
            radioName.text = @"Salsa Portoricaine Radio";
        }
            break;
            
        case 8:
        {
            [self setFlux:@"zumba"];
            radioName.text = @"Zumba Radio";
        }
            break;
            
        default:
            break;
    }
}

- (void)loadCover
{
    if([SCUtils isNetworkAvailable])
    {
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"http://webradio.oolatina.com/getInfoFlux.php?command=getRadioMobileInfo&flux=%@",fluxRadio]];
    NSData *data = [[NSData alloc] initWithContentsOfURL:url];
    id object = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
    NSDictionary *results = object;
    
    // Mise en place d'un cache des covers sinon le chargement est trop long
    NSArray *array = [[results objectForKey:@"cover"] componentsSeparatedByString:@"/"];
    NSData *imageData;
    if(array.count != 0)
    {
        // Check si le fichier est pas déjà en cache
        NSFileManager *fileManager = [NSFileManager defaultManager];
        NSString *pathFile = [NSString stringWithFormat:@"%@/%@",NSTemporaryDirectory(),[array objectAtIndex:array.count-1]];
        if([fileManager fileExistsAtPath:pathFile])
        {
            // Il existe on charge directe
            imageData = [[NSData alloc] initWithContentsOfFile:pathFile];
        }
        else
        {
            // On le sauve dans le cache
            imageData = [[NSData alloc] initWithContentsOfURL:[NSURL URLWithString:[results objectForKey:@"cover"]]];
            [imageData writeToFile:pathFile atomically:YES];
        }
    }

    if(imageData != nil)
    {
        cover.image = [UIImage imageWithData:imageData];
    }
    artist.text = [results objectForKey:@"song_artist"];
    itunesURL = [results objectForKey:@"itunes_link"];
    
    if(itunesURL == nil || [itunesURL isKindOfClass:[NSNull class]])
    {
        itunesLink.hidden = YES;
    }
    else
    {
        itunesLink.hidden = NO;
    }
    
    [NSTimer scheduledTimerWithTimeInterval:0.5 target:self selector:@selector(loadCover) userInfo:nil repeats:NO];
    }
    else
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Erreur de connexion" message:@"Verifier votre connexion à internet" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
        [alert show];
    }
}

- (void)playRadio
{
    if(isPlaying)
    {
        [buttonPlay setImage:[UIImage imageNamed:@"buttonplayradio.png"] forState:UIControlStateNormal];
        isPlaying = NO;
        [player stop];
    }
    else
    {
        [buttonPlay setImage:[UIImage imageNamed:@"buttonpauseradio.png"] forState:UIControlStateNormal];
        isPlaying = YES;
        [player prepareToPlay];
        [player play];
    }
}

- (void)showiTunesLink
{
    NSLog(@"Show : %@",itunesURL);
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:itunesURL]];
}

@end
