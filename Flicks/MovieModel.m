//
//  MovieModel.m
//  Flicks
//
//  Created by  Palash Agrawal on 1/23/17.
//  Copyright © 2017  Palash Agrawal. All rights reserved.
//

#import "MovieModel.h"

@implementation MovieModel

- (instancetype)initWithDictionary:(NSDictionary *)dictionary{
    self = [super init];
    if (self) {
        self.title = dictionary[@"original_title"];
        self.movieDescription = dictionary[@"overview"];
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"yyyy-mm-dd"];
        self.movieReleaseDate = [dateFormatter dateFromString:dictionary[@"release_date"]];
        NSString *bgImageUrlString = [@"https://image.tmdb.org/t/p/w342" stringByAppendingString:dictionary[@"backdrop_path"]];
        self.bgImageUrl = [NSURL URLWithString:bgImageUrlString];
        NSString *posterImageUrlString = [@"https://image.tmdb.org/t/p/w342" stringByAppendingString:dictionary[@"poster_path"]];
        self.posterImageUrl = [NSURL URLWithString:posterImageUrlString];
        NSString *lowResPosterUrlString = [@"https://image.tmdb.org/t/p/w45" stringByAppendingString:dictionary[@"poster_path"]];
        self.lowResPosterUrl = [NSURL URLWithString:lowResPosterUrlString];
        NSString *hiResPosterUrlString = [@"https://image.tmdb.org/t/p/original" stringByAppendingString:dictionary[@"poster_path"]];
        self.hiResPosterUrl = [NSURL URLWithString:hiResPosterUrlString];
    }
    return self;
}

@end
