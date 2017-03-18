//
//  ViewController.h
//  Recipes Sample
//
//  Created by user on 18.03.17.
//  Copyright © 2017 edu.self. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController
{
    NSMutableData *_responseData;
}
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *progressBar;


@end

