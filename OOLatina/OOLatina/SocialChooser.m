//
//  SocialChooser.m
//  OOLatina
//
//  Created by Macbook air on 8/14/14.
//  Copyright (c) 2014 Jérôme Laurent. All rights reserved.
//

#import "SocialChooser.h"

@interface SocialChooser ()

@end

@implementation SocialChooser

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        _socialNumber = 0;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - delefate tableView

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 3;
}

//- (NSInteger)tableView:(UITableView *)tableView numberOfSectionsInTableView: (NSInteger)section {
//    return 2;
//}

// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
//        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
//        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }

    UIColor *pinkColor = [UIColor colorWithRed:226.0/255.0 green:94.0/255.0 blue:117.0/255.0 alpha:1.0];
    NSInteger section = _socialNumber;
    switch (section) {
        case 0: // title
            cell.textLabel.text = @"SHARE PHOTO VIA";
            cell.backgroundColor = pinkColor;
            break;
        case 1: // facebook
            cell.imageView.image = [UIImage imageNamed:@"facebook_icon.png"];
            cell.textLabel.text = @"FACEBOOK";
            break;
        case 2: // twitter
            cell.imageView.image = [UIImage imageNamed:@"twitter_icon.png"];
            cell.textLabel.text = @"TWITTER";
            break;
        default:
            // Do something else here if a cell other than 1,2,3 or 4 is requested
            break;
    }
    _socialNumber++;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    if ([cell.textLabel.text  isEqual: @"FACEBOOK"]) {
        [self.delegate FacebookTapped];
    } else if ([cell.textLabel.text  isEqual: @"TWITTER"]) {
        [self.delegate TwitterTapped];
    }
}



@end
