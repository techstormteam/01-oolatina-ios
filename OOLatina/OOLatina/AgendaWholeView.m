//
//  AgendaWholeView.m
//  OOLatina
//
//  Created by Macbook air on 8/3/14.
//  Copyright (c) 2014 Jérôme Laurent. All rights reserved.
//

#import "AgendaWholeView.h"


@implementation AgendaWholeView

@synthesize agendaButton;
@synthesize arroundMeButton;
@synthesize mapButton;
@synthesize slidLabel;
@synthesize nibScrollView;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        [self initSearch];
        [self launchSearch];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self setNavBar];
    
    [self addBasicView];
    
    [self initScrollView];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void)dealloc {
//    [agendaButton release];
//    [arroundMeButton release];
//    [slidLabel release];
//    [nibScrollView release];
//    [super dealloc];
}

#pragma mark-
#pragma mark navigationController Methods

- (void) setNavBar
{
    //    self.navigationController.navigationBarHidden = NO;//显示nav，这里使用动画
    [self.navigationController  setNavigationBarHidden:NO animated:YES];
    
    //设置Navigation Bar颜色
    self.navigationController.navigationBar.tintColor = [UIColor colorWithRed:(30/255.0) green:(175/255.0) blue:(200/255.0) alpha:1];
    
    
    UIButton *BackBtn = [[UIButton alloc] initWithFrame:CGRectMake(0.0, 164.0, 45, 45)];
	[BackBtn setImage:[UIImage imageNamed:@"btn_back1.png"]  forState:UIControlStateNormal];
	[BackBtn setImage:[UIImage imageNamed:@"btn_back2"] forState:UIControlStateHighlighted];
	BackBtn.backgroundColor = [UIColor clearColor];
	[BackBtn addTarget:self action:@selector(backAction) forControlEvents:UIControlEventTouchUpInside];
	UIBarButtonItem *temporaryBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:BackBtn];
	temporaryBarButtonItem.style = UIBarButtonItemStylePlain;
	self.navigationItem.leftBarButtonItem = temporaryBarButtonItem;
//	[temporaryBarButtonItem release];
    
}

- (void) backAction
{
	[self.navigationController popViewControllerAnimated:YES];
}

- (void) addBasicView
{
    agendaButton.showsTouchWhenHighlighted = YES;
    [agendaButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [agendaButton addTarget:self action:@selector(agendaButtonAction) forControlEvents:UIControlEventTouchUpInside];
    
    arroundMeButton.showsTouchWhenHighlighted = YES;
    [arroundMeButton setTitleColor:[UIColor colorWithRed:(220/255.0) green:(220/255.0) blue:(220/255.0) alpha:1] forState:UIControlStateNormal];
    [arroundMeButton addTarget:self action:@selector(arroundMeButtonAction) forControlEvents:UIControlEventTouchUpInside];
    
    mapButton.showsTouchWhenHighlighted = YES;
    [mapButton setTitleColor:[UIColor colorWithRed:(220/255.0) green:(220/255.0) blue:(220/255.0) alpha:1] forState:UIControlStateNormal];
    [mapButton addTarget:self action:@selector(mapButtonAction) forControlEvents:UIControlEventTouchUpInside];
}

#pragma mark-
#pragma mark

- (void) btnActionShow
{
    if (currentPage == 0) {
        [self agendaButtonAction];
    } else if (currentPage == 1) {
        [self arroundMeButtonAction];
    } else if (currentPage == 2) {
        [self mapButtonAction];
    }
}

- (void) agendaButtonAction
{
    if (needLoadingAgenda) {
        [agendaView  loadEvent:eventArray];
        needLoadingAgenda = NO;
    }
    [agendaButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [arroundMeButton setTitleColor:[UIColor colorWithRed:(220/255.0) green:(220/255.0) blue:(220/255.0) alpha:1] forState:UIControlStateNormal];
    [mapButton setTitleColor:[UIColor colorWithRed:(220/255.0) green:(220/255.0) blue:(220/255.0) alpha:1] forState:UIControlStateNormal];
    
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.3];
    
    slidLabel.frame = CGRectMake(0, 36, 107, 4);
    [nibScrollView setContentOffset:CGPointMake(nibScrollView.frame.size.width*0, 0)];
    
    [UIView commitAnimations];
}

- (void) arroundMeButtonAction
{
    if (needLoadingArroundMe) {
        [arroundMeView  loadEvent:eventArray];
        needLoadingArroundMe = NO;
    }
    [arroundMeButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [agendaButton setTitleColor:[UIColor colorWithRed:(220/255.0) green:(220/255.0) blue:(220/255.0) alpha:1] forState:UIControlStateNormal];
    [mapButton setTitleColor:[UIColor colorWithRed:(220/255.0) green:(220/255.0) blue:(220/255.0) alpha:1] forState:UIControlStateNormal];
    
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.3];
    
    slidLabel.frame = CGRectMake(108, 36, 107, 4);
    [nibScrollView setContentOffset:CGPointMake(nibScrollView.frame.size.width*1, 0)];
    
    [UIView commitAnimations];
}

- (void) mapButtonAction
{
    if (needLoadingAgendaMap) {
        [agendaMapView loadEvent:eventArray];
        needLoadingAgendaMap = NO;
    }
    [mapButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [arroundMeButton setTitleColor:[UIColor colorWithRed:(220/255.0) green:(220/255.0) blue:(220/255.0) alpha:1] forState:UIControlStateNormal];
    [agendaButton setTitleColor:[UIColor colorWithRed:(220/255.0) green:(220/255.0) blue:(220/255.0) alpha:1] forState:UIControlStateNormal];
    
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.3];
    
    slidLabel.frame = CGRectMake(215, 36, 107, 4);
    [nibScrollView setContentOffset:CGPointMake(nibScrollView.frame.size.width*2, 0)];
    
    [UIView commitAnimations];
}

#pragma mark -
#pragma mark

- (void)initScrollView {
    
    //tableScrollView
    // a page is the width of the scroll view
    nibScrollView.pagingEnabled = YES;
    nibScrollView.clipsToBounds = NO;
    nibScrollView.contentSize = CGSizeMake(nibScrollView.frame.size.width * 2, nibScrollView.frame.size.height);
    nibScrollView.showsHorizontalScrollIndicator = NO;
    nibScrollView.showsVerticalScrollIndicator = NO;
    nibScrollView.scrollsToTop = NO;
    nibScrollView.delegate = self;
    
    [nibScrollView setContentOffset:CGPointMake(0, 0)];

    currentPage = 0;
    pageControl.numberOfPages = 3;
    pageControl.currentPage = 0;
    pageControl.backgroundColor = [UIColor whiteColor];
    [self createAllEmptyPagesForScrollView];
}

- (void)createAllEmptyPagesForScrollView {
    
    agendaView = [[AgendaView alloc] initWithFrame:CGRectMake(0, 0, nibScrollView.frame.size.width, nibScrollView.frame.size.height)];
    agendaView.frame = CGRectMake(nibScrollView.frame.size.width*0, 0, nibScrollView.frame.size.width, nibScrollView.frame.size.height);
    arroundMeView = [[AgendaView alloc] initWithFrame:CGRectMake(0, 0, nibScrollView.frame.size.width, nibScrollView.frame.size.height)];
    arroundMeView.frame = CGRectMake(nibScrollView.frame.size.width*1, 0, nibScrollView.frame.size.width, nibScrollView.frame.size.height);
    agendaMapView = [[AgendaMapView alloc]init ];
    agendaMapView.view.frame = CGRectMake(nibScrollView.frame.size.width*2, 0, nibScrollView.frame.size.width, nibScrollView.frame.size.height);
    
    [nibScrollView addSubview: agendaView];
    [nibScrollView addSubview: arroundMeView];
    [nibScrollView addSubview: agendaMapView.view];
}

// At the end of scroll animation, reset the boolean used when scrolls originate from the UIPageControl
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    
    CGFloat pageWidth = self.nibScrollView.frame.size.width;
    int page = floor((self.nibScrollView.contentOffset.x - pageWidth / 2) / pageWidth) + 1;
    
    pageControl.currentPage = page;
    currentPage = page;
    pageControlUsed = NO;
    [self btnActionShow];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{

}

- (BOOL)touchesShouldBegin:(NSSet *)touches withEvent:(UIEvent *)event inContentView:(UIView *)view
{
    return YES;
}
- (BOOL)touchesShouldCancelInContentView:(UIView *)view
{
    return NO;
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

- (void)hideSearch
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
        [self.view addSubview:mCalendarView];
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
//        [mAgendaScroll removeAllEvent];
        
        NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"http://www.oolatina.com/webservice/oolatina_api.php?command=GET_EVENT&year=2014&search=%@&ville=%@&day=%@&month=%@&year=%@&music=%@&genre=%@",[self urlEncodeUsingEncoding:searchField.text],villeField.text,day,month,year,musicArrayid,genreArrayid]];
        NSLog(@"URL : %@",url);
        NSData *data = [[NSData alloc] initWithContentsOfURL:url];
        id object = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
        NSMutableArray *results = object;
        NSMutableArray *eventList = [[NSMutableArray alloc] init];
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
            
            [eventList addObject:nEvent];
        }
        eventArray = eventList;
        [self loadEvent];
        mbackPopup.hidden = YES;
        closeButton.hidden = YES;
        needLoadingAgenda = YES;
        needLoadingArroundMe = YES;
        needLoadingAgendaMap = YES;
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
    
    //[self performSelectorInBackground:@selector(loadEvent) withObject:nil];
    [self loadEvent];
    
    mbackPopup = [[UIView alloc] initWithFrame:CGRectMake(20, 10, 265+20, 400)];
    mbackPopup.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.5];
    mbackPopup.hidden = YES;
    [self.view addSubview:mbackPopup];
    
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
    [self.view addSubview:closeButton];
    
    [self loadArray];
}
@end
