//
//  ViewController.m
//  SuperHeroPedia
//
//  Created by Dave Krawczyk on 9/6/14.
//  Copyright (c) 2014 Mobile Makers. All rights reserved.
//

#import "ViewController.h"
#import "SuperHero.h"

@interface ViewController () <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) NSArray *heroes;

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation ViewController
            
- (void)viewDidLoad {
    [super viewDidLoad];

    [SuperHero retrieveSuperHerosWithCompletion:^(NSArray *heroes) {
        self.heroes = heroes;
    }];
}

// Setter methods for properites can be overloaded to have stuff done
- (void)setHeroes:(NSArray *)heroes
{
    _heroes = heroes;
    [self.tableView reloadData];
}

#pragma mark - Tableview Methods

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.heroes.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"superHeroCell"];
    
//    NSDictionary *superhero = [self.heroes objectAtIndex:indexPath.row];

    SuperHero *hero = [self.heroes objectAtIndex:indexPath.row];
    //
    cell.textLabel.text = hero.name;
    cell.detailTextLabel.text = hero.textDescription;
    cell.detailTextLabel.numberOfLines = 2;

    [hero getImageWithCompletion:^(NSData *imageData) {
        cell.imageView.image = [UIImage imageWithData:imageData];
        [cell layoutSubviews];
    }];

//    NSURL *url = [NSURL URLWithString:[superhero objectForKey:@"avatar_url"]];
//    [NSURLConnection sendAsynchronousRequest:[NSURLRequest requestWithURL:url] queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
//        [cell.imageView setImage:[UIImage imageWithData:data]];
//        [cell layoutSubviews];
//    }];

    return cell;
}

@end
