//
//  MovieCollectionViewCell.m
//  Flicks
//
//  Created by  Palash Agrawal on 1/26/17.
//  Copyright © 2017  Palash Agrawal. All rights reserved.
//

#import "MovieCollectionViewCell.h"
#import <AFNetworking/UIImageView+AFNetworking.h>

@interface MovieCollectionViewCell ()

@property (nonatomic, strong) UIImageView *posterView;

@end

@implementation MovieCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        UIImageView *imageView = [[UIImageView alloc] init];
        [self.contentView addSubview:imageView];
        self.posterView = imageView;
    }
    return self;
}

- (void)reloadData {
    [self.posterView setImageWithURL:self.movieModel.posterImageUrl];
    [self setNeedsLayout];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    self.posterView.frame = self.contentView.bounds;
}

@end
