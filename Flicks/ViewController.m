//
//  ViewController.m
//  Flicks
//
//  Created by  Palash Agrawal on 1/23/17.
//  Copyright © 2017  Palash Agrawal. All rights reserved.
//

#import "ViewController.h"
#import "MovieCell.h"
#import "MovieCollectionViewCell.h"
#import "MovieModel.h"
#import "MovieDetailViewController.h"
#import <AFNetworking/UIImageView+AFNetworking.h>
#import <MBProgressHUD/MBProgressHUD.h>

@interface ViewController () <UITableViewDataSource, UICollectionViewDataSource, UICollectionViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *moviesTableView;
@property (strong, nonatomic) NSArray<MovieModel *> *movies;
@property (strong, nonatomic) NSString *urlString;
@property (strong, nonatomic) UIRefreshControl *refreshControl;
@property (strong, nonatomic) UIRefreshControl *refreshControlForCollView;
@property (strong, nonatomic) UICollectionView *moviesCollView;
@property (strong, nonatomic) UISegmentedControl *segmentedControl;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.edgesForExtendedLayout = UIRectEdgeNone;
    // Do any additional setup after loading the view, typically from a nib.
    self.moviesTableView.backgroundColor = [UIColor orangeColor];
    self.moviesTableView.dataSource = self;
    
    NSString *apiKey = @"a07e22bc18f5cb106bfe4cc1f83ad8ed";
    if ([@"now_playing" isEqualToString:self.restorationIdentifier]){
        self.urlString = [@"https://api.themoviedb.org/3/movie/now_playing?api_key=" stringByAppendingString:apiKey];
    } else if([@"top_rated" isEqualToString:self.restorationIdentifier]) {
        self.urlString = [@"https://api.themoviedb.org/3/movie/top_rated?api_key=" stringByAppendingString:apiKey];
    }
    self.refreshControl = [[UIRefreshControl alloc] init];
    [self.refreshControl addTarget:self action:@selector(onRefresh) forControlEvents:UIControlEventValueChanged];
    [self.moviesTableView insertSubview:self.refreshControl atIndex:0];
    self.networkErrorView.hidden = true;
    
    UISegmentedControl *segmentedControl = [[UISegmentedControl alloc] initWithItems:[NSArray arrayWithObjects:@"List", @"Grid", nil]];
    [segmentedControl addTarget:self action:@selector(onSegmentChange) forControlEvents:UIControlEventValueChanged];
    [segmentedControl setSelectedSegmentIndex:0];
    [self.navigationItem setTitleView:segmentedControl];
    
    self.segmentedControl = segmentedControl;
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    CGFloat screenWidth = CGRectGetWidth(self.view.bounds);
    CGFloat itemHeight = 150;
    CGFloat itemWidth = screenWidth/3.5;
    layout.minimumLineSpacing = 15;
    layout.minimumInteritemSpacing = 10;
    layout.itemSize = CGSizeMake(itemWidth, itemHeight);
    layout.scrollDirection = UICollectionViewScrollDirectionVertical;
    
    UICollectionView *collView = [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:layout];
    [collView registerClass:[MovieCollectionViewCell class] forCellWithReuseIdentifier:@"MovieCollectionViewCell"];
    collView.backgroundColor = [UIColor orangeColor];
    self.refreshControlForCollView = [[UIRefreshControl alloc] init];
    [self.refreshControlForCollView addTarget:self action:@selector(onRefresh) forControlEvents:UIControlEventValueChanged];
    [collView insertSubview:self.refreshControlForCollView atIndex:0];
    collView.hidden = YES;
    [self.view addSubview:collView];
    self.moviesCollView = collView;
    self.moviesCollView.dataSource = self;
    self.moviesCollView.delegate = self;
    
    [self fetchMovies];
}

- (void)onRefresh {
    [self fetchMovies];
    [self.refreshControl endRefreshing];
    [self.refreshControlForCollView endRefreshing];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    self.moviesCollView.frame = self.view.bounds;
    self.moviesTableView.frame = self.view.bounds;
}

#pragma mark - UISegmentedControl

- (void) onSegmentChange {
    if (self.segmentedControl.selectedSegmentIndex == 0) {
        self.moviesCollView.hidden = YES;
        self.moviesTableView.hidden = NO;
    }
    if (self.segmentedControl.selectedSegmentIndex == 1) {
        self.moviesCollView.hidden = NO;
        self.moviesTableView.hidden = YES;
    }
    
}

#pragma mark - UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.movies.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    MovieCollectionViewCell* cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"MovieCollectionViewCell" forIndexPath:indexPath];
    MovieModel* movieModel = [self.movies objectAtIndex:indexPath.row];
    cell.movieModel = movieModel;
    [cell reloadData];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell* cell = [collectionView cellForItemAtIndexPath:indexPath];
    [self performSegueWithIdentifier:@"movieDetailSegue" sender:cell];
}

#pragma mark - UITableViewDataSource

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MovieCell* cell = [tableView dequeueReusableCellWithIdentifier:@"movieCell" forIndexPath:indexPath];
    MovieModel* movieModel = [self.movies objectAtIndex:indexPath.row];
    [cell.titleLabel setText:[NSString stringWithFormat:@"%@", movieModel.title]];
    [cell.overviewLabel setText:[NSString stringWithFormat:@"%@", movieModel.movieDescription]];
    [cell.posterImage setImageWithURL:movieModel.posterImageUrl];
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.movies.count;
}

- (void) fetchMovies {
    
    NSURL *url = [NSURL URLWithString:self.urlString];
    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:url];
    
    NSURLSession *session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]
                                                          delegate:nil
                                                     delegateQueue:[NSOperationQueue mainQueue]];
    
    [MBProgressHUD showHUDAddedTo:self.view animated:true];
    
    NSURLSessionDataTask *task = [session dataTaskWithRequest:request
                                            completionHandler:^(NSData * _Nullable data,
                                                                NSURLResponse * _Nullable response,
                                                                NSError * _Nullable error) {                                                
                                                [MBProgressHUD hideHUDForView:self.view animated:true];
                                                if (!error) {
                                                    self.networkErrorView.hidden = true;
                                                    NSError *jsonError = nil;
                                                    NSDictionary *responseDictionary =
                                                    [NSJSONSerialization JSONObjectWithData:data
                                                                                    options:kNilOptions
                                                                                      error:&jsonError];
                                                    NSArray *results = responseDictionary[@"results"];
                                                    NSMutableArray *movieModels = [NSMutableArray array];
                                                    for (NSDictionary *result in results) {
                                                        MovieModel *movieModel = [[MovieModel alloc] initWithDictionary:result];
                                                        [movieModels addObject:movieModel];
                                                    }
                                                    self.movies = movieModels;
                                                    [self.moviesTableView reloadData];
                                                    [self.moviesCollView reloadData];
                                                    
                                                } else {
                                                    self.networkErrorView.hidden = false;
                                                    NSLog(@"An error occurred: %@", error.description);
                                                }
                                            }];
    [task resume];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    MovieDetailViewController *destViewController = segue.destinationViewController;
    if (self.segmentedControl.selectedSegmentIndex == 1) {
        NSIndexPath *indexPath = [self.moviesCollView indexPathForCell:sender];
        destViewController.movieModel = [self.movies objectAtIndex:indexPath.item];
    }
    else if (self.segmentedControl.selectedSegmentIndex == 0) {
        NSIndexPath *indexPath = [self.moviesTableView indexPathForSelectedRow];
        destViewController.movieModel = [self.movies objectAtIndex:indexPath.row];
    }
}

@end
