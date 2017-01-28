//
//  MovieCollectionViewCell.h
//  Flicks
//
//  Created by  Palash Agrawal on 1/26/17.
//  Copyright © 2017  Palash Agrawal. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MovieModel.h"

@interface MovieCollectionViewCell : UICollectionViewCell

@property (strong, nonatomic) MovieModel *movieModel;

- (void) reloadData;

@end
