//
//  TourGuideAppointmentVC.swift
//  SwfitDemo
//
//  Created by JiangNanBuYi-1012665604@qq.com on 2019/2/27.
//  Copyright © 2019 JiangNanBuYi-1012665604@qq.com. All rights reserved.
//

import UIKit




class TourGuideAppointmentVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

      self.baseView()


      let calendar = JTAppleCalendarView.init();
      calendar.frame = CGRect(x: 0, y: 100, width: UIScreen.main.bounds.size.width, height: 400)
      view.addSubview(calendar)
      calendar.backgroundColor = UIColor.white
        // Do any additional setup after loading the view.
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
extension  TourGuideAppointmentVC{

  func baseView() {
//    view.backgroundColor = UIColor.red
  }
}
