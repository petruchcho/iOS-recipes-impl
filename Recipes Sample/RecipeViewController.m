//
//  RecipeViewController.m
//  Recipes Sample
//
//  Created by user on 18.03.17.
//  Copyright © 2017 edu.self. All rights reserved.
//

#import "RecipeViewController.h"

@interface RecipeViewController ()

@end

@implementation RecipeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self addBackButtonWithTitle: [_recipe objectForKey:@"title"]];
    
    [self startLoading];
    [self showImage];
}

/**
 *  @brief set lef bar button with custom title
 */
- (void)addBackButtonWithTitle:(NSString *)title {
    UINavigationBar *myNav = [[UINavigationBar alloc]initWithFrame:CGRectMake(0, 0, 420, 80)];
    [self.view addSubview:myNav];


    
    UIBarButtonItem *backButton = [[UIBarButtonItem alloc] initWithTitle:NSLocalizedString(@"Back", nil) style: UIBarButtonItemStylePlain target:self action:@selector(backButtonPressed:)];
    
    UINavigationItem *navigItem = [[UINavigationItem alloc] initWithTitle:title];
    navigItem.leftBarButtonItem = backButton;
    myNav.items = [NSArray arrayWithObjects: navigItem,nil];
    
    
    [UIBarButtonItem appearance].tintColor = [UIColor blueColor];
}

- (void)backButtonPressed:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)showImage {
    NSString *imageURLString = [_recipe objectForKey:@"image_url"];
    NSURL *url = [NSURL URLWithString:imageURLString];
    NSData *data = [NSData dataWithContentsOfURL:url];
    UIImage *img = [[UIImage alloc] initWithData:data];
    _imageView.image = img;
}

- (void)startLoading {
    NSString *recipeId = [self.recipe objectForKey:@"recipe_id"];
    
    NSString *urlString = [NSString stringWithFormat: @"http://food2fork.com/api/get?key=74aa18f5cda819ae69e51504ca5e6059&rId=%@", recipeId];
    
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
                            [self dataLoadedSuccessfully:jsonResponse];
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

- (void)dataLoadedSuccessfully:(NSDictionary *)recipeData {
    NSString * result = [[[recipeData objectForKey:@"recipe"] objectForKey:@"ingredients"] componentsJoinedByString:@"\n"];
    dispatch_async(dispatch_get_main_queue(), ^{
        self.ingredientsText.text=result;
    });
}

- (void)showError {
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
