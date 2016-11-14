//
//  ZXChangePersonInfoController.m
//  PocketOrder
//
//  Created by 青岛商通天下 on 2016/10/19.
//  Copyright © 2016年 QingDaoShangTong. All rights reserved.
//

#import "ZXChangePersonInfoController.h"
#import "ZXChangeEmailController.h"
@interface ZXChangePersonInfoController ()<UIActionSheetDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>



@end

@implementation ZXChangePersonInfoController

+ (ZXChangePersonInfoController *)sharedController;
{
    static ZXChangePersonInfoController *vc = nil;
    if (!vc) {
        vc = [[UIStoryboard storyboardWithName:@"ZXChangePersonInfoController" bundle:nil]instantiateViewControllerWithIdentifier:@"ZXChangePersonInfoController"];
    }
    return vc;
}
- (void)viewDidLoad {
    [super viewDidLoad];
}


- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}
#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 2;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 10;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 1) {
        if (indexPath.row == 1) {
            ZXChangeEmailController *vc = [[ZXChangeEmailController alloc] init];
            vc.title = @"换绑邮箱";
            [self.navigationController pushViewController:vc animated:YES];
        }
    }
}

- (IBAction)didClickChangeUserPhoto:(id)sender {
    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:nil delegate:self
                                                    cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"拍照",@"从手机相册选择",nil];
    actionSheet.actionSheetStyle = UIActionSheetStyleBlackTranslucent;
    [actionSheet showInView:self.view];
}

#pragma mark ActionSheetDelegate
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    UIImagePickerController *imagePicker = [UIImagePickerController new];
    imagePicker.delegate = self;
    if (buttonIndex == 2) return;
    if (buttonIndex == 0) {
        //调用相机
        if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
            imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
            [self presentViewController:imagePicker animated:YES completion:nil];
        }else{
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"您的照相机不可用或被您禁用了!" delegate:nil cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
            [alert show];
        }
    }
    if (buttonIndex == 1){
        //调用相册
        imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        [self presentViewController:imagePicker animated:YES completion:nil];
    }
}


-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{
    UIImage *image = info[UIImagePickerControllerOriginalImage];
    
    [picker dismissViewControllerAnimated:YES completion:^{
        [self.headImage setImage:image forState:UIControlStateNormal];
        if ([self.delegate respondsToSelector:@selector(passHeaderImage:)]) {
            [self.delegate passHeaderImage:self];
        }
    }];
    
}


@end
