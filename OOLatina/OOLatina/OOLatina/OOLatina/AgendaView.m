//
//  AgendaView.m
//  OOLatina
//
//  Created by Jérôme Laurent on 13/03/2014.
//  Copyright (c) 2014 Jérôme Laurent. All rights reserved.
//

#import "AgendaView.h"
#import "CustomTableViewCell.h"
#import "SCUtils.h"

@implementation AgendaView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
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
        
        background = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
        background.image = [UIImage imageNamed:@"background.png"];
        [self addSubview:background];
        
        if([SCUtils isPhone5])
        {
            mAgendaScroll = [[AgendaScroll alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height-60)];
        }
        else
        {
            mAgendaScroll = [[AgendaScroll alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height-60)];
        }

        [self addSubview:mAgendaScroll];
        
        //[self performSelectorInBackground:@selector(loadEvent) withObject:nil];
        [self loadEvent];
        
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
        searchField.placeholder = @"Recherche";
        [popupView addSubview:searchField];
        
        UIImageView *searchIcon = [[UIImageView alloc] initWithFrame:CGRectMake(220-30, 0, 30, 30)];
        searchIcon.image = [UIImage imageNamed:@"search_icon.png"];
        [searchField addSubview:searchIcon];
        
        calendarField = [[UITextField alloc] initWithFrame:CGRectMake(22, 210+50, 220, 30)];
        calendarField.borderStyle = UITextBorderStyleRoundedRect;
        calendarField.textColor = pinkColor;
        calendarField.placeholder = @"Calendrier";
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
        villeField.placeholder = @"Ville";
        villeField.delegate = self;
        [popupView addSubview:villeField];
        
        UIImageView *villeIcon = [[UIImageView alloc] initWithFrame:CGRectMake(220-30, 0, 30, 30)];
        villeIcon.image = [UIImage imageNamed:@"ville_icon.png"];
        [villeField addSubview:villeIcon];
        
        UILabel *dateandVille = [[UILabel alloc] initWithFrame:CGRectMake(0, 170, 265, 25)];
        dateandVille.backgroundColor = [UIColor colorWithRed:128.0/255.0 green:128.0/255.0 blue:128.0/255.0 alpha:0.85];
        dateandVille.textAlignment = NSTextAlignmentCenter;
        dateandVille.font = [UIFont fontWithName:@"Helvetica-Bold" size:21.0];
        dateandVille.text = @"Date & Ville";
        dateandVille.textColor = [UIColor blackColor];
        [popupView addSubview:dateandVille];
        
        UIButton *eventSearchButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        eventSearchButton.frame = CGRectMake(22, 260+50+50, 220, 30);
        [eventSearchButton setTitle:@"TROUVER DES EVENEMENTS" forState:UIControlStateNormal];
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
        genreTitle.text = @"Genre";
        genreTitle.textColor = [UIColor blackColor];
        [popupView addSubview:genreTitle];
        
        genreField = [[UITextField alloc] initWithFrame:CGRectMake(22, 45, 220, 30)];
        genreField.borderStyle = UITextBorderStyleRoundedRect;
        genreField.enabled = NO;
        genreField.delegate = self;
        genreField.font = [UIFont fontWithName:@"Helvetica" size:15.0];
        genreField.placeholder = @"State, Soirée, Cours, ...";
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
        [dropdownGenre setTitle:@"Sélectionner" forState:UIControlStateNormal];
        [dropdownGenre addTarget:self action:@selector(showDropDown:) forControlEvents:UIControlEventTouchUpInside];
        [popupView addSubview:dropdownGenre];
        
        UILabel *musicTitle = [[UILabel alloc] initWithFrame:CGRectMake(0, 90, 265, 25)];
        musicTitle.backgroundColor = [UIColor colorWithRed:128.0/255.0 green:128.0/255.0 blue:128.0/255.0 alpha:0.85];
        musicTitle.textAlignment = NSTextAlignmentCenter;
        musicTitle.font = [UIFont fontWithName:@"Helvetica-Bold" size:21.0];
        musicTitle.text = @"Musique";
        musicTitle.textColor = [UIColor blackColor];
        [popupView addSubview:musicTitle];
        
        musicField = [[UITextField alloc] initWithFrame:CGRectMake(22, 125, 220, 30)];
        musicField.borderStyle = UITextBorderStyleRoundedRect;
        musicField.enabled = NO;
        musicField.font = [UIFont fontWithName:@"Helvetica" size:15.0];
        musicField.placeholder = @"Bachata, Salsa, Kizomba, ...";
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
        [dropdownMusic setTitle:@"Sélectionner" forState:UIControlStateNormal];
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
    return self;
}

- (void)closePopup
{
    mbackPopup.hidden = YES;
    closeButton.hidden = YES;
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

- (void)showDropDown:(id)sender
{
    UIButton *nButton = (UIButton *)sender;
    dropSelected = nButton.tag;
    if(nButton.tag == 0)
    {
        NSMutableArray *array = [[NSMutableArray alloc] init];
        for (int x=0; x<genreArray.count; x++)
        {
            ArrayDropDown *mArray = (ArrayDropDown *)[genreArray objectAtIndex:x];
            [array addObject:[mArray getName]];
        }
        mDropDown = [[DropDownListView alloc] initWithTitle:@"" options:array xy:CGPointMake(16, 58) size:CGSizeMake(287, 330) isMultiple:YES];
        mDropDown.delegate = self;
        [mDropDown showInView:self animated:YES];
        
        /*----------------Set DropDown backGroundColor-----------------*/
        [mDropDown SetBackGroundDropDwon_R:226.0 G:95.0 B:117.0 alpha:0.70];
    }
    else if(nButton.tag == 1)
    {
        NSMutableArray *array = [[NSMutableArray alloc] init];
        for (int x=0; x<musicArray.count; x++)
        {
            ArrayDropDown *mArray = (ArrayDropDown *)[musicArray objectAtIndex:x];
            [array addObject:[mArray getName]];
        }
        
        mDropDown = [[DropDownListView alloc] initWithTitle:@"" options:array xy:CGPointMake(16, 58) size:CGSizeMake(287, 330) isMultiple:YES];
        mDropDown.delegate = self;
        [mDropDown showInView:self animated:YES];
        
        /*----------------Set DropDown backGroundColor-----------------*/
        [mDropDown SetBackGroundDropDwon_R:226.0 G:95.0 B:117.0 alpha:0.70];
    }
    else if(nButton.tag == 2)
    {
        NSMutableArray *array = [[NSMutableArray alloc] init];
        for (int x=0; x<villeArray.count; x++)
        {
            ArrayDropDown *mArray = (ArrayDropDown *)[villeArray objectAtIndex:x];
            [array addObject:[mArray getName]];
        }
        mDropDown = [[DropDownListView alloc] initWithTitle:@"" options:array xy:CGPointMake(16, 58) size:CGSizeMake(287, 330) isMultiple:NO];
        mDropDown.delegate = self;
        [mDropDown showInView:self animated:YES];
        
        /*----------------Set DropDown backGroundColor-----------------*/
        [mDropDown SetBackGroundDropDwon_R:226.0 G:95.0 B:117.0 alpha:0.70];
    }
}

- (void)DropDownListView:(DropDownListView *)dropdownListView didSelectedIndex:(NSInteger)anIndex
{
    /*NSMutableArray *array = [[NSMutableArray alloc] init];
    for (int x=0; x<villeArray.count; x++)
    {
        ArrayDropDown *mArray = (ArrayDropDown *)[villeArray objectAtIndex:x];
        [array addObject:[mArray getName]];
    }
    
    ArrayDropDown *mArray = (ArrayDropDown *)[villeArray objectAtIndex:anIndex];
    villeSelected = [mArray getName];
    [dropdownVille setTitle:[array objectAtIndex:anIndex] forState:UIControlStateNormal];*/
}

- (NSString *)getidGenre:(NSString *)_title
{
    for (int x=0; x<genreArray.count; x++)
    {
        ArrayDropDown *mDrop = (ArrayDropDown *)[genreArray objectAtIndex:x];
        if([_title isEqualToString:[mDrop getName]])
        {
            return [mDrop getIdArray];
        }
    }
    
    return @"";
}

- (void)DropDownListViewDidCancel
{
    
}

- (NSString *)getidMusic:(NSString *)_title
{
    for (int x=0; x<musicArray.count; x++)
    {
        ArrayDropDown *mDrop = (ArrayDropDown *)[musicArray objectAtIndex:x];
        if([_title isEqualToString:[mDrop getName]])
        {
            return [mDrop getIdArray];
        }
    }
    
    return @"";
}

- (void)DropDownListView:(DropDownListView *)dropdownListView Datalist:(NSMutableArray*)ArryData
{
    NSString *selection = @"";
    if (ArryData.count>0)
    {
        for (int x=0; x<ArryData.count; x++)
        {
            if(x == ArryData.count -1)
            {
                selection = [selection stringByAppendingString:[NSString stringWithFormat:@"%@",[ArryData objectAtIndex:x]]];
            }
            else
            {
                selection = [selection stringByAppendingString:[NSString stringWithFormat:@"%@, ",[ArryData objectAtIndex:x]]];
            }
        }
    }
    else
    {
        selection = @"";
    }
    
    if(dropSelected == 0)
    {
        // Construction de l'array de recherche
        if (ArryData.count>0)
        {
            for (int x=0; x<ArryData.count; x++)
            {
                //ArrayDropDown *mDrop = (ArrayDropDown *)[genreArray objectAtIndex:x];
                NSString *idArray = [self getidGenre:[ArryData objectAtIndex:x]];
                //NSString *idArray = [mDrop getIdArray];
                if(x == ArryData.count-1)
                {
                    genreArrayid = [NSString stringWithFormat:@"%@%@",genreArrayid,idArray];
                }
                else
                {
                    genreArrayid = [NSString stringWithFormat:@"%@%@,",genreArrayid,idArray];
                }
            }
        }
        genreField.text = selection;
        //[dropdownGenre setTitle:selection forState:UIControlStateNormal];
    }
    else if(dropSelected == 1)
    {
        // Construction de l'array de recherche
        if (ArryData.count>0)
        {
            for (int x=0; x<ArryData.count; x++)
            {
                //ArrayDropDown *mDrop = (ArrayDropDown *)[musicArray objectAtIndex:x];
                NSString *idArray = [self getidMusic:[ArryData objectAtIndex:x]];
                //NSString *idArray = [mDrop getIdArray];
                if(x == ArryData.count-1)
                {
                    musicArrayid = [NSString stringWithFormat:@"%@%@",musicArrayid,idArray];
                }
                else
                {
                    musicArrayid = [NSString stringWithFormat:@"%@%@,",musicArrayid,idArray];
                }
            }
        }
        musicField.text = selection;
        //[dropdownMusic setTitle:selection forState:UIControlStateNormal];
    }
    else if(dropSelected == 2)
    {
        //[dropdownVille setTitle:selection forState:UIControlStateNormal];
    }
    
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    if(textField == calendarField)
    {
        [textField resignFirstResponder];
        [calendarField resignFirstResponder];
        mCalendarView = [[CKCalendarView alloc] init];
        mCalendarView.delegate = self;
        [self addSubview:mCalendarView];
        return NO;
    }
    else if(textField == searchField)
    {
        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationDuration:0.25];
        
        CGRect frame = popupView.frame;
        frame.origin.y = -100;
        popupView.frame = frame;
        
        [UIView commitAnimations];
        
        return YES;
    }
    else if(textField == villeField)
    {
        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationDuration:0.25];
        
        CGRect frame = popupView.frame;
        frame.origin.y = -150;
        popupView.frame = frame;
        
        [UIView commitAnimations];
        
        return YES;
    }
    return YES;
}

- (BOOL)textFieldShouldEndEditing:(UITextField *)textField
{
    if(textField == searchField)
    {
        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationDuration:0.25];
        
        CGRect frame = popupView.frame;
        frame.origin.y = 0;
        popupView.frame = frame;
        
        [UIView commitAnimations];
    }
    else if(textField == villeField)
    {
        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationDuration:0.25];
        
        CGRect frame = popupView.frame;
        frame.origin.y = 0;
        popupView.frame = frame;
        
        [UIView commitAnimations];
    }
    return YES;
}

- (void)calendar:(CKCalendarView *)calendar didSelectDate:(NSDate *)date
{
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"dd/MM/YYYY"];
    NSString *dateEventString = [dateFormat stringFromDate:date];
    NSArray *arrayDate = [dateEventString componentsSeparatedByString:@"/"];
    day = [arrayDate objectAtIndex:0];
    month = [arrayDate objectAtIndex:1];
    year = [arrayDate objectAtIndex:2];
    calendarField.text = dateEventString;
    [mCalendarView removeFromSuperview];
}

- (void)launchSearch
{
    if([SCUtils isNetworkAvailable])
    {
        [mAgendaScroll removeAllEvent];
     
        NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"http://www.oolatina.com/webservice/oolatina_api.php?command=GET_EVENT&year=2014&search=%@&ville=%@&day=%@&month=%@&year=%@&music=%@&genre=%@",[self urlEncodeUsingEncoding:searchField.text],villeField.text,day,month,year,musicArrayid,genreArrayid]];
        NSLog(@"URL : %@",url);
        NSData *data = [[NSData alloc] initWithContentsOfURL:url];
        id object = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
        NSMutableArray *results = object;
        for (int x=0; x<results.count; x++)
        {
         NSDictionary *mDico = [results objectAtIndex:x];
         NSDictionary *mEvent = [mDico objectForKey:@"event"];
     
         Event *nEvent = [[Event alloc] init];
         [nEvent setTitle:[mEvent objectForKey:@"title"]];
         [nEvent setThumbnailEvent:[mEvent objectForKey:@"thumbnail"]];
         [nEvent setVille:[mEvent objectForKey:@"ville"]];
         [nEvent setYear:[mEvent objectForKey:@"year"]];
         [nEvent setMonth:[mEvent objectForKey:@"month"]];
         [nEvent setEventDay:[mEvent objectForKey:@"day"]];
         [nEvent setCodePostal:[mEvent objectForKey:@"codepostal"]];
         [nEvent setAdresse:[mEvent objectForKey:@"adresse"]];
         [nEvent setName:[mEvent objectForKey:@"lieu"]];
         [nEvent setLongitude:[[mEvent objectForKey:@"longitude"] floatValue]];
         [nEvent setLatitude:[[mEvent objectForKey:@"latitude"] floatValue]];
     
         [mAgendaScroll addEvent:nEvent];
        }
     
        [mAgendaScroll loadEvent];
        
        mbackPopup.hidden = YES;
        closeButton.hidden = YES;
    }
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    // Search
    if(textField == searchField)
    {
        [textField resignFirstResponder];
    }
    else if(textField == villeField)
    {
        [textField resignFirstResponder];
    }
    return YES;
}

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

- (void)hideSearch
{
    mbackPopup.hidden = YES;
    closeButton.hidden = YES;
}

- (NSString *)urlEncodeUsingEncoding:(NSString *)string
{
    NSString *s = [string stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    return s;
}

- (void)searchBarCancelButtonClicked:(UISearchBar *) searchBar
{
    [searchBar resignFirstResponder];
}

- (void)loadEvent
{
    if([SCUtils isNetworkAvailable])
    {
        [mAgendaScroll removeAllEvent];
        
        // Mois en cours
        NSDate *now = [NSDate date];
        NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
        [dateFormat setDateFormat:@"Y-M-d"];
        NSString *dateNow = [dateFormat stringFromDate:now];
        NSArray *dateNowArray = [dateNow componentsSeparatedByString:@"-"];
        NSString *yearNow = [dateNowArray objectAtIndex:0];
        NSString *monthNow = [dateNowArray objectAtIndex:1];
        
        if([monthNow isEqualToString:@"1"])
        {
            monthNow = @"01";
        }
        
        if([monthNow isEqualToString:@"2"])
        {
            monthNow = @"02";
        }
        
        if([monthNow isEqualToString:@"3"])
        {
            monthNow = @"03";
        }
        
        if([monthNow isEqualToString:@"4"])
        {
            monthNow = @"04";
        }
        
        if([monthNow isEqualToString:@"5"])
        {
            monthNow = @"05";
        }
        
        if([monthNow isEqualToString:@"6"])
        {
            monthNow = @"06";
        }
        
        if([monthNow isEqualToString:@"7"])
        {
            monthNow = @"07";
        }
        
        if([monthNow isEqualToString:@"8"])
        {
            monthNow = @"08";
        }
        
        if([monthNow isEqualToString:@"9"])
        {
            monthNow = @"09";
        }
        
        
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"http://www.oolatina.com/webservice/oolatina_api.php?command=GET_EVENT&year=%@&month=%@",yearNow,monthNow]];
    NSData *data = [[NSData alloc] initWithContentsOfURL:url];
    id object = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
    NSMutableArray *results = object;
    for (int x=0; x<results.count; x++)
    {
        NSDictionary *mDico = [results objectAtIndex:x];
        NSDictionary *mEvent = [mDico objectForKey:@"event"];
        NSLog(@"Dict");
        
        Event *nEvent = [[Event alloc] init];
        [nEvent setTitle:[mEvent objectForKey:@"title"]];
        [nEvent setThumbnailEvent:[mEvent objectForKey:@"thumbnail"]];
        [nEvent setVille:[mEvent objectForKey:@"ville"]];
        [nEvent setYear:[mEvent objectForKey:@"year"]];
        [nEvent setMonth:[mEvent objectForKey:@"month"]];
        [nEvent setEventDay:[mEvent objectForKey:@"day"]];
        [nEvent setCodePostal:[mEvent objectForKey:@"codepostal"]];
        [nEvent setAdresse:[mEvent objectForKey:@"adresse"]];
        [nEvent setName:[mEvent objectForKey:@"lieu"]];
        [nEvent setLongitude:[[mEvent objectForKey:@"longitude"] floatValue]];
        [nEvent setLatitude:[[mEvent objectForKey:@"latitude"] floatValue]];
        
        [mAgendaScroll addEvent:nEvent];
        
        /*NSString *startDate = [mDico objectForKey:@"eventStartDate"];
    
        NSDate *dateEvent = [[NSDate alloc] init];
        NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
        [dateFormat setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
        dateEvent = [dateFormat dateFromString:startDate];
        
        dateFormat = [[NSDateFormatter alloc] init];
        [dateFormat setDateFormat:@"Y-M-d"];
        NSString *dateEventString = [dateFormat stringFromDate:dateEvent];
        NSArray *dateEventArray = [dateEventString componentsSeparatedByString:@"-"];
        NSString *year = [dateEventArray objectAtIndex:0];
        NSString *month = [dateEventArray objectAtIndex:1];
        NSString *day = [dateEventArray objectAtIndex:2];
        
        // Date now
        NSDate *now = [NSDate date];
        dateFormat = [[NSDateFormatter alloc] init];
        [dateFormat setDateFormat:@"Y-M-d"];
        NSString *dateNow = [dateFormat stringFromDate:now];
        NSArray *dateNowArray = [dateNow componentsSeparatedByString:@"-"];
        NSString *yearNow = [dateNowArray objectAtIndex:0];
        NSString *monthNow = [dateNowArray objectAtIndex:1];
        //NSString *dayNow = [dateNowArray objectAtIndex:2];
        
        if(x != 0)
        {
        // Comparaison de la date de l'event et le jour actuelle
        if([yearNow isEqualToString:year])
        {
            if([monthNow isEqualToString:month])
            {
                // On enregistre l'event
                Event *mEvent = [[Event alloc] init];
                [mEvent setTitle:[mDico objectForKey:@"eventTitle"]];
                [mEvent setYear:year];
                [mEvent setMonth:month];
                [mEvent setEventDay:day];
                [mEvent setThumbnailEvent:[mDico objectForKey:@"eventPhoto"]];
                
                // NSDico Adresse
                NSDictionary *addressDico = [mDico objectForKey:@"eventAdresse"];
                [mEvent setName:[addressDico objectForKey:@"_VenueVenue"]];
                [mEvent setVille:[addressDico objectForKey:@"_VenueCity"]];
                [mEvent setCodePostal:[addressDico objectForKey:@"_VenueZip"]];
                [mEvent setAdresse:[addressDico objectForKey:@"_VenueAddress"]];
                [mEvent setLongitude:[[addressDico objectForKey:@"_VenueLng"] floatValue]];
                [mEvent setLatitude:[[addressDico objectForKey:@"_VenueLat"] floatValue]];
                
                [eventArray addObject:mEvent];
            }
        }
        }*/
    }
        
        [mAgendaScroll loadEvent];
        
        /*dispatch_async(dispatch_get_main_queue(), ^{
            [mLoading stopAnimating];
            messageView.hidden = YES;
            //mLoading.hidden = YES;
            [mTableView reloadData];
        });*/
    }
    else
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Erreur de connexion" message:@"Verifier votre connexion à internet" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
        [alert show];
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [eventArray count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 80.0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    AgendaCell *cell = (AgendaCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil)
    {
        cell = [[AgendaCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    int modulo = indexPath.row % 2;
    NSLog(@"modulo : %d",modulo);
    if (modulo == 1)
    {
        cell.backgroundColor = [UIColor colorWithRed:29.0/255.0 green:29.0/255.0 blue:29.0/255.0 alpha:0.7];
    }
    else
    {
        cell.backgroundColor =  [UIColor colorWithRed:5.0/255.0 green:5.0/255.0 blue:5.0/255.0 alpha:0.7];
    }
    
    Event *mEvent = (Event *)[eventArray objectAtIndex:indexPath.row];
    
    cell.tag = indexPath.row;
    cell.textLabel.textColor = [UIColor whiteColor];
    cell.textLabel.font = [UIFont fontWithName:@"Helvetica" size:12.0];
    [cell setTitleEvent:[mEvent getTitle]];
    [cell setDayLetter:[mEvent getDayLetter]];
    [cell setThumbnail:[mEvent getThumbnailEvent]];
    [cell setDateToDay:[mEvent getDayLetter] andMonth:[mEvent getMonth] andYear:[mEvent getYear]];
    [cell setAdresse:[mEvent getVille]];
    cell.textLabel.textAlignment = NSTextAlignmentLeft;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
}


@end
