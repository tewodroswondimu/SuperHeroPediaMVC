//
//  SuperHero.m
//  SuperHeroPedia
//
//  Created by Tewodros Wondimu on 1/26/15.
//  Copyright (c) 2015 Mobile Makers. All rights reserved.
//

#import "SuperHero.h"

@interface SuperHero ()

@property NSURL *imageURL;

@end

@implementation SuperHero

- (instancetype)initWithDictionary:(NSDictionary *)dictionary
{
    self = [super init];
    if (self) {
        self.name = dictionary[@"name"];
        self.textDescription = dictionary[@"description"];

        self.imageURL = [NSURL URLWithString:dictionary[@"avatar_url"]];
    }
    return self;
}

// A class method means you don't need to have an instance to call it
// A block is a block of code that is executed and returns a value once it's done
+ (void)retrieveSuperHerosWithCompletion:(void(^)(NSArray *heroes))complete
{
    NSURL *url = [NSURL URLWithString:@"https://s3.amazonaws.com/mobile-makers-lib/superheroes.json"];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];

    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {

        NSMutableArray *temporaryArray = [NSMutableArray new];
        NSArray *heroes = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&connectionError];
        for (NSDictionary *dictionary in heroes) {
            SuperHero *hero = [[SuperHero alloc] initWithDictionary:dictionary];
            [temporaryArray addObject:hero];
        }

        // Send back the array with all of its heros to the caller
        complete(temporaryArray);
    }];
}

- (void)getImageWithCompletion:(void(^)(NSData *imageData))complete
{
    [NSURLConnection sendAsynchronousRequest:[NSURLRequest requestWithURL:self.imageURL] queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        complete(data);
    }];
}

@end
