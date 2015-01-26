//
//  SuperHero.h
//  SuperHeroPedia
//
//  Created by Tewodros Wondimu on 1/26/15.
//  Copyright (c) 2015 Mobile Makers. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SuperHero : NSObject

@property NSString *name;
@property NSString *textDescription;

- (instancetype)initWithDictionary:(NSDictionary *)dictionary;

+ (void)retrieveSuperHerosWithCompletion:(void(^)(NSArray *heroes))complete;

- (void)getImageWithCompletion:(void(^)(NSData *imageData))complete;

@end
