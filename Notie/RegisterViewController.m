//
//  RegisterViewController.m
//  Notie
//
//  Created by Amir on 9/22/16.
//  Copyright © 2016 Emersad. All rights reserved.
//

#import "RegisterViewController.h"
#import "A0SimpleKeychain.h"

@interface RegisterViewController ()
@property (weak, nonatomic) IBOutlet UITextField *usernameTextField;
@property (weak, nonatomic) IBOutlet UITextField *emailTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;

@end

@implementation RegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)registerButton:(id)sender {
    if (_usernameTextField.text.length == 0 || _passwordTextField.text.length == 0 || _emailTextField.text.length == 0) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Something Wrong" message:@"Some fields are empty check please." delegate:nil cancelButtonTitle:@"Okay" otherButtonTitles:nil];
        [alert show];
    }
    else {
        NSString *username = _usernameTextField.text;
        NSString *password = _passwordTextField.text;
        NSString *email = _emailTextField.text;
        NSString *urlString = [NSString stringWithFormat:@"http://amirfarsad.me/Notie/register.php?username=%@&password=%@&email=%@",username,password,email];
        NSURL *url = [NSURL URLWithString:urlString];
        NSString *result = [NSString stringWithContentsOfURL:url encoding:NSUTF8StringEncoding error:nil];
        if ([result isEqualToString:@"REGISTERED_SUCCESSFULLY"]) {
            [[A0SimpleKeychain keychain] setString:@"YES" forKey:@"userLoggedIn"];
            [[A0SimpleKeychain keychain] setString:username forKey:@"username"];
            [[A0SimpleKeychain keychain] setString:password forKey:@"password"];
            NSLog(@"NOTIELOG : Logged In");
            [UIApplication sharedApplication].delegate.window.rootViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"Decide"];
        }
        else {
            NSLog(@"NOTIELOG : Something is \"milange\"");
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Oops!" message:@"Username might be taken." delegate:nil cancelButtonTitle:@"Okay" otherButtonTitles:nil];
            [alert show];
        }
    }
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
