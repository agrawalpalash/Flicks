//
//  MovieDetailViewController.m
//  Flicks
//
//  Created by  Palash Agrawal on 1/24/17.
//  Copyright © 2017  Palash Agrawal. All rights reserved.
//

#import "MovieDetailViewController.h"
#import <AFNetworking/UIImageView+AFNetworking.h>

@interface MovieDetailViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *bgImageView;
@property (weak, nonatomic) IBOutlet UIScrollView *movieDetailScrollView;
@property (weak, nonatomic) IBOutlet UILabel *movieTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *movieOverviewLabel;
@property (weak, nonatomic) IBOutlet UIView *cardView;
@property (weak, nonatomic) IBOutlet UILabel *movieReleaseDateLabel;

@end

@implementation MovieDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    // Do any additional setup after loading the view.
    [self.bgImageView setImageWithURL:self.movieModel.posterImageUrl];
    self.movieTitleLabel.text = self.movieModel.title;
    self.movieOverviewLabel.text = self.movieModel.movieDescription;
    [self.navigationItem setTitleView:nil];
    [self.navigationItem setTitle:self.movieModel.title];
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateStyle:NSDateFormatterMediumStyle];
    [dateFormatter setTimeStyle:NSDateFormatterNoStyle];
    self.movieReleaseDateLabel.text = [dateFormatter stringFromDate:self.movieModel.movieReleaseDate];
    
    [self.movieOverviewLabel sizeToFit];
    [self.cardView sizeToFit];
    
    CGFloat contentOffsetY =  400 + CGRectGetHeight(self.movieOverviewLabel.bounds) + CGRectGetHeight(self.movieReleaseDateLabel.bounds);
    self.movieDetailScrollView.contentSize = CGSizeMake(self.movieDetailScrollView.bounds.size.width, contentOffsetY);
    [self.movieDetailScrollView setShowsVerticalScrollIndicator:NO];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSString *) formatDate:(NSString *)dateString {
    NSDateFormatter *format = [[NSDateFormatter alloc] init];
    [format setDateFormat:@"yyyy-MM-dd"];
    NSDate *date = [format dateFromString:dateString];
    [format setDateFormat:@"MM-dd-yyyy"];
    NSString* finalDateString = [format stringFromDate:date];
    return finalDateString;
}

- (void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
