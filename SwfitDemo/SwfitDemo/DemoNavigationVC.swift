//
//  DemoNavigationVC.swift
//  SwfitDemo
//
//  Created by JiangNanBuYi-1012665604@qq.com on 2019/2/25.
//  Copyright © 2019 JiangNanBuYi-1012665604@qq.com. All rights reserved.
//

import UIKit

class DemoNavigationVC: UINavigationController {

    override func viewDidLoad() {
      super.viewDidLoad()
      view.backgroundColor = UIColor.white
      self.setNavBarBase()
        // Do any additional setup after loading the view.
    }
    
  private func setNavBarBase() {
    self.navigationBar.barTintColor = UIColor.pumpkin
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
