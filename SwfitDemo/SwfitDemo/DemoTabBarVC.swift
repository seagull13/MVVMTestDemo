//
//  DemoTabBarVC.swift
//  SwfitDemo
//
//  Created by JiangNanBuYi-1012665604@qq.com on 2019/2/25.
//  Copyright © 2019 JiangNanBuYi-1012665604@qq.com. All rights reserved.
//

import UIKit
import ESTabBarController_swift

class DemoTabBarVC: ESTabBarController {

  override func viewDidLoad() {
    super.viewDidLoad()

    self.setTabBarVC()

    self.setTarbarItems()
    // Do any additional setup after loading the view.
  }

  func setTabBarVC() {
    var vcs = Array<UIViewController>()
    vcs.append(self.addSubVC(HomeVC(), tabBarItemTitle: "我的团队", imageName: "home", selectedImageName: "home_1", vcTitle: "团队查询"))
    vcs.append(self.addSubVC(TourGuideAssistantVC(), tabBarItemTitle: "导游助手", imageName: "find", selectedImageName: "find_1", vcTitle: "导游助手"))
    vcs.append(self.addSubVC(MineInformationVC(), tabBarItemTitle: "我的资讯", imageName: "photo", selectedImageName: "photo_1", vcTitle: "我的资讯"))
    vcs.append(self.addSubVC(TourGuideAppointmentVC(), tabBarItemTitle: "导游预约", imageName: "favor", selectedImageName: "favor_1", vcTitle: "订单列表"))
    vcs.append(self.addSubVC(MineVC(), tabBarItemTitle: "个人中心", imageName: "me", selectedImageName: "me_1", vcTitle: "Me"))
    viewControllers = vcs
  }


  func addSubVC(_ vc:UIViewController,tabBarItemTitle:String,imageName:String,selectedImageName:String,vcTitle:String) -> (UIViewController) {
    vc.tabBarItem = ESTabBarItem.init(title: tabBarItemTitle, image: UIImage(named: imageName), selectedImage: UIImage(named: selectedImageName))
    let nav = DemoNavigationVC.init(rootViewController: vc)
    vc.title = vcTitle
    return nav
  }

  private func setTarbarItems(){
    UITabBarItem.appearance().setTitleTextAttributes([NSAttributedString.Key.foregroundColor : UIColor.magenta,NSAttributedString.Key.font :UIFont.systemFont(ofSize: 17)], for: UIControl.State.selected)
    UITabBarItem.appearance().setTitleTextAttributes([NSAttributedString.Key.foregroundColor : UIColor.black,NSAttributedString.Key.font :UIFont.systemFont(ofSize: 14)], for: UIControl.State.normal)
  }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
