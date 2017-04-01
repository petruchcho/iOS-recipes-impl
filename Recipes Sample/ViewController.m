//
//  ViewController.m
//  Recipes Sample
//
//  Created by user on 18.03.17.
//  Copyright © 2017 edu.self. All rights reserved.
//

#import "ViewController.h"
#import "RecipesViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [_progressBar startAnimating];
    
    // Do any additional setup after loading the view, typically from a nib.
    [self startLoading];
    [_retryButton addTarget:self action:@selector(retryButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [_retryButton setTitle:NSLocalizedString(@"Retry", nil) forState:UIControlStateNormal];
    _errorText.text=NSLocalizedString(@"Unexpected error occured.\nPlease try again.", nil);}


- (void)dataLoadedSuccessfully:(NSDictionary *)jsonData {
    NSArray *recipes = [jsonData objectForKey:@"recipes"];
    NSLog(@"SUCCESS: %@", recipes);
    
    RecipesViewController *recipesViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"RecipesViewController"];
    recipesViewController.recipes = recipes;
    [self presentViewController:recipesViewController animated:YES completion:nil];
}

- (void)showError {
    _progressBar.hidden = YES;
    _errorText.hidden = NO;
    _retryButton.hidden = NO;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)retryButtonClicked:(id)sender
{
    [self startLoading];
}

- (void)startLoading {
    _errorText.hidden = YES;
    _retryButton.hidden = YES;
    _progressBar.hidden = NO;
    NSString *urlString = [NSString stringWithFormat: @"http://food2fork.com/api/search?key=74aa18f5cda819ae69e51504ca5e6059"];
    
    NSCharacterSet *set = [NSCharacterSet URLQueryAllowedCharacterSet];
    NSString *encodedUrlAsString = [urlString stringByAddingPercentEncodingWithAllowedCharacters:set];
    
    NSURLSession *session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    
    [[session dataTaskWithURL:[NSURL URLWithString:encodedUrlAsString]
            completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
                
                if (!error) {
                    // Success
                    if ([response isKindOfClass:[NSHTTPURLResponse class]]) {
                        NSError *jsonError;
                        NSDictionary *jsonResponse = [NSJSONSerialization JSONObjectWithData:data options:0 error:&jsonError];
                        
                        if (jsonError) {
                            // Error Parsing JSON
                            [self showError];
                        } else {
                            // Success Parsing JSON
                            // Log NSDictionary response:
                           [self showError];
                           //[self dataLoadedSuccessfully:jsonResponse];
                        }
                    }  else {
                        //Web server is returning an error
                        [self showError];
                    }
                } else {
                    // Fail
                    NSLog(@"error : %@", error.description);
                    [self showError];
                }
            }] resume];
}

@end
