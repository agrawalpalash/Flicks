//
//  MovieModel.h
//  Flicks
//
//  Created by  Palash Agrawal on 1/23/17.
//  Copyright © 2017  Palash Agrawal. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MovieModel : NSObject

- (instancetype) initWithDictionary:(NSDictionary *)otherDictionary;

@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *movieDescription;
@property (nonatomic, strong) NSDate *movieReleaseDate;
@property (nonatomic, strong) NSURL *posterImageUrl;
@property (nonatomic, strong) NSURL *lowResPosterUrl;
@property (nonatomic, strong) NSURL *hiResPosterUrl;
@property (nonatomic, strong) NSURL *bgImageUrl;

@end
