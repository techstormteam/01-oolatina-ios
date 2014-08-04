//
//  AgendaWholeView.m
//  OOLatina
//
//  Created by Macbook air on 8/3/14.
//  Copyright (c) 2014 Jérôme Laurent. All rights reserved.
//

#import "AgendaWholeView.h"


@implementation AgendaWholeView

@synthesize couponButton;
@synthesize groupbuyButton;
@synthesize slidLabel;
@synthesize nibScrollView;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
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
//    [couponButton release];
//    [groupbuyButton release];
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
    couponButton.showsTouchWhenHighlighted = YES;  //指定按钮被按下时发光
    [couponButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];//此时选中
    [couponButton addTarget:self action:@selector(couponButtonAction) forControlEvents:UIControlEventTouchUpInside];
    groupbuyButton.showsTouchWhenHighlighted = YES;  //指定按钮被按下时发光
    [groupbuyButton setTitleColor:[UIColor colorWithRed:(220/255.0) green:(220/255.0) blue:(220/255.0) alpha:1] forState:UIControlStateNormal];//此时未被选中
    [groupbuyButton addTarget:self action:@selector(groupbuyButtonAction) forControlEvents:UIControlEventTouchUpInside];
    
}

#pragma mark-
#pragma mark 界面按钮事件

- (void) btnActionShow
{
    if (currentPage == 0) {
        [self couponButtonAction];
    }
    else{
        [self groupbuyButtonAction];
    }
}

- (void) couponButtonAction
{
    [couponButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];//此时选中
    [groupbuyButton setTitleColor:[UIColor colorWithRed:(220/255.0) green:(220/255.0) blue:(220/255.0) alpha:1] forState:UIControlStateNormal];//此时未被选中
    
    [UIView beginAnimations:nil context:nil];//动画开始
    [UIView setAnimationDuration:0.3];
    
    slidLabel.frame = CGRectMake(0, 106, 160, 4);
    [nibScrollView setContentOffset:CGPointMake(320*0, 0)];//页面滑动
    
    [UIView commitAnimations];
}

- (void) groupbuyButtonAction
{
    [groupbuyButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];//此时选中
    [couponButton setTitleColor:[UIColor colorWithRed:(220/255.0) green:(220/255.0) blue:(220/255.0) alpha:1] forState:UIControlStateNormal];//此时未被选中
    
    [UIView beginAnimations:nil context:nil];//动画开始
    [UIView setAnimationDuration:0.3];
    
    slidLabel.frame = CGRectMake(159, 106, 161, 4);
    [nibScrollView setContentOffset:CGPointMake(320*1, 0)];
    
    [UIView commitAnimations];
}

#pragma mark -
#pragma mark table view data source methods


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView == couponTableView) {
        return couponArry.count;
    }
    else{
        return groupbuyArry.count;
    }
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                       reuseIdentifier: CellIdentifier];
    }else{

        //         [[cell.subviews objectAtIndex:1] removeFromSuperview];
        for (UIView *subView in cell.contentView.subviews)
        {
            [subView removeFromSuperview];
        }
    }
    
    if (tableView == couponTableView) {
        cell.textLabel.text = [NSString stringWithFormat:@"%@", [couponArry objectAtIndex:indexPath.row]];
    }
    else{
        cell.textLabel.text = [NSString stringWithFormat:@"%@", [groupbuyArry objectAtIndex:indexPath.row]];
    }
    
    return cell;
}


#pragma mark -
#pragma mark table delegate methods

- (NSIndexPath *)tableView:(UITableView *)tableView willSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    return indexPath;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (tableView == couponTableView) {
    }
    else{
    }
    
}
- (NSInteger) tableView:(UITableView *)tableView indentationLevelForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 0;
}


- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 80;
}

#pragma mark -
#pragma mark 左右滑动相关函数

- (void)initScrollView {
    
    //设置 tableScrollView
    // a page is the width of the scroll view
    nibScrollView.pagingEnabled = YES;
    nibScrollView.clipsToBounds = NO;
    nibScrollView.contentSize = CGSizeMake(nibScrollView.frame.size.width * 2, nibScrollView.frame.size.height);
    nibScrollView.showsHorizontalScrollIndicator = NO;
    nibScrollView.showsVerticalScrollIndicator = NO;
    nibScrollView.scrollsToTop = NO;
    nibScrollView.delegate = self;
    
    [nibScrollView setContentOffset:CGPointMake(0, 0)];
    
    //公用
    currentPage = 0;
    pageControl.numberOfPages = 2;
    pageControl.currentPage = 0;
    pageControl.backgroundColor = [UIColor whiteColor];
    [self createAllEmptyPagesForScrollView];
}

- (void)createAllEmptyPagesForScrollView {
    
    //设置 tableScrollView 内部数据
    couponTableView = [[UITableView alloc]init ];
    couponTableView.frame = CGRectMake(320*0, 0, 320, nibScrollView.frame.size.height);
    groupbuyTableView = [[UITableView alloc]init ];
    groupbuyTableView.frame = CGRectMake(320*1, 0, 320, nibScrollView.frame.size.height);
    
    //设置tableView委托并添加进视图
    couponTableView.delegate = self;
    couponTableView.dataSource = self;
    [nibScrollView addSubview: couponTableView];
    groupbuyTableView.delegate = self;
    groupbuyTableView.dataSource = self;
    [nibScrollView addSubview: groupbuyTableView];
    
    //设置 nibTableView 数据源数组 -- 仅仅用与测试
    couponArry = [[NSArray alloc]initWithObjects:@"coupon1",@"coupon2",@"coupon3", @"coupon4",nil ];
    groupbuyArry = [[NSArray alloc]initWithObjects:@"groupbuy1",@"groupbuy2",@"groupbuy3", nil ];
    
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
    //暂不处理 - 其实左右滑动还有包含开始等等操作，这里不做介绍
}

- (BOOL)touchesShouldBegin:(NSSet *)touches withEvent:(UIEvent *)event inContentView:(UIView *)view
{
    return YES;
}
- (BOOL)touchesShouldCancelInContentView:(UIView *)view
{
    return NO;
}


@end
