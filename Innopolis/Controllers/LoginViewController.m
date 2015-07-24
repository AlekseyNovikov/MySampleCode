//
//  LoginViewController.m
//  ITOPK
//
//  Created by Aleksey Novikov on 23/05/15.
//  Copyright (c) 2015 Aleksey Novikov. All rights reserved.
//

#import "LoginViewController.h"

/// keychain

/// login
#import "NetwokManager+SignIn.h"

#import "LoginNavigationController.h"

@interface LoginViewController () <UITextFieldDelegate>{
    UITextField *_activeTextfield;
}

@property (weak, nonatomic) IBOutlet UITextField *emailTextFiel;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextfield;
@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.emailTextFiel.layer.cornerRadius = self.passwordTextfield.layer.cornerRadius = 6;
    self.passwordTextfield.secureTextEntry = YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/


- (void) tryToLogin{
    if (self.emailTextFiel.text.length == 0) {
        [[[UIAlertView alloc] initWithTitle:@"Пустой логин"
                                    message:@"Логин не может быть пустым"
                                   delegate:nil cancelButtonTitle:nil otherButtonTitles:@"ОК", nil] show];
        
        return;
    }
    
    
    if (self.passwordTextfield.text.length == 0) {
        [[[UIAlertView alloc] initWithTitle:@"Пустой пароль"
                                    message:@"Пароль не может быть пустым"
                                   delegate:nil cancelButtonTitle:nil otherButtonTitles:@"ОК", nil] show];
        
        return;
    }
    
    
    
    
    [[NetwokManager sharedNetworkManager]
     signInWithLogin:self.emailTextFiel.text
     password:self.passwordTextfield.text
     onCompletion:^(BOOL success) {
         if (success) {
             [JNKeychain saveValue:self.emailTextFiel.text forKey:@"email"];
             [JNKeychain saveValue:self.passwordTextfield.text forKey:@"password"];
             
             [((LoginNavigationController *)self.parentViewController) closeEntrance];
         }
         else{
             [[[UIAlertView alloc] initWithTitle:@"Несуществующий пользователь"
                                         message:@"Вам необходимо зарегистрироваться"
                                        delegate:nil cancelButtonTitle:nil otherButtonTitles:@"ОК", nil] show];
         }
    } onError:^(NSError *error) {
        
    }];
    
    
}
#pragma mark - Actions
- (IBAction)loginAction:(id)sender {
    [self tryToLogin];
}




- (IBAction)passwordRecoveryAction:(id)sender {
}

- (IBAction)hideKeyboard:(id)sender {
    [_activeTextfield resignFirstResponder];
}

#pragma mark - TextField delegate
- (void)textFieldDidBeginEditing:(UITextField *)textField{
    _activeTextfield = textField;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [self tryToLogin];
    
    return YES;
}
@end
