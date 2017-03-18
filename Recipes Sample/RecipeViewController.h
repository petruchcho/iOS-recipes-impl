//
//  RecipeViewController.h
//  Recipes Sample
//
//  Created by user on 18.03.17.
//  Copyright © 2017 edu.self. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RecipeViewController : UIViewController
@property(nonatomic) NSDictionary *recipe;

@property (weak, nonatomic) IBOutlet UILabel *titleView;
@end
