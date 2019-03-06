//
//  TourGuideAssistantVC.swift
//  SwfitDemo
//
//  Created by JiangNanBuYi-1012665604@qq.com on 2019/2/27.
//  Copyright © 2019 JiangNanBuYi-1012665604@qq.com. All rights reserved.
//


import UIKit


class TourGuideAssistantCell: UICollectionViewCell {

  var titleLabel:UILabel = {
  let titleLabel = UILabel (frame: CGRect.zero)
  titleLabel.textAlignment = NSTextAlignment.center
  return titleLabel
  }()


  override init(frame: CGRect) {
    super .init(frame: frame)
    self.setUpBaseCell()
  }

  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  func setUpBaseCell() {
    contentView.addSubview(titleLabel)
    titleLabel.snp.makeConstraints { (make) in
      make.center.left.right.equalToSuperview()
    }
  }
  func setText(text:String)  {
    self.titleLabel.text = text
  }
}


class TourGuideAssistantVC: UIViewController,TeamMessageVCDelegate,UICollectionViewDelegate,UICollectionViewDataSource {

static  let screenSize = UIScreen.main.bounds.size


  var collectionView:UICollectionView = {
    let layout = UICollectionViewFlowLayout()
    layout.itemSize = CGSize(width:screenSize.width / 4, height: 60)
    let collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
    collectionView.backgroundColor = UIColor.white
    return collectionView
  }()


  var dataArray = Array<String>()

    override func viewDidLoad() {
      super.viewDidLoad()
      view.addSubview(collectionView)
      collectionView.register(TourGuideAssistantCell.classForCoder(), forCellWithReuseIdentifier: "TourGuideAssistantCell")
      collectionView.delegate = self
      collectionView.dataSource = self
      collectionView.snp.makeConstraints { (make) in
        make.left.right.top.bottom.equalToSuperview()
      }
      self.dataArray.append("通讯录")
      self.dataArray.append("知识库")
      self.dataArray.append("省内接送")
      self.dataArray.append("推荐码")
      self.dataArray.append("线路咨询")
      self.dataArray.append("预约报账")

      collectionView.reloadData()
        // Do any additional setup after loading the view.

    }

  override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
    let teamVC =   TeamMessageVC()
    teamVC.delegate = self

    self.navigationController?.pushViewController(teamVC, animated: true)
  }

  func testDelegate() {
    view.backgroundColor = TourGuideAssistantVC.getColorValue()
  }

  class  func getColorValue()->UIColor {
  return   UIColor.init(red: CGFloat(arc4random_uniform(255))/255.0, green: CGFloat(arc4random_uniform(255))/255.0 , blue:CGFloat(arc4random_uniform(255))/255.0, alpha: 1)
  }

 // MARK: - collectionViewDataSource
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return dataArray.count
  }
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell:TourGuideAssistantCell = collectionView.dequeueReusableCell(withReuseIdentifier: "TourGuideAssistantCell", for: indexPath) as! TourGuideAssistantCell
    cell.setText(text: dataArray[indexPath.item])
    return cell
  }

  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    let vc:UIViewController?

    switch indexPath.row {
    case 0:
      vc = AddressBookVC()
    case 1:
      vc = KnowledgeBaseVC()
    case 2:
      vc = ShuttleProvinceVC()
    case 3:
      vc = RecommendedCodeVC()
    case 4:
      vc = LineConsultingVC()
    case 5:
      vc = AppointmentReimbursementVC()
    default:
      vc = UIViewController()
    }
    if vc != nil {
      vc?.title = dataArray[indexPath.row]
      navigationController?.pushViewController(vc!, animated: false)
    }

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
