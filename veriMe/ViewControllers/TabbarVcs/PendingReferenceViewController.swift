//
//  PendingReferenceViewController.swift
//  veriMe
//
//  Created by Rameez Hasan on 03/07/2020.
//  Copyright © 2020 Rameez Hasan. All rights reserved.
//

import UIKit
import BetterSegmentedControl

class PendingReferenceViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var control: BetterSegmentedControl?

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.regesterTableViewCells()
        self.setupSegmentControl()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.setupUI()
    }
}
extension PendingReferenceViewController {
    func setupUI() {
        self.title = "Pending References"
        self.navigationController?.navigationBar.isHidden = false
        
        let btn1 = UIButton(type: .custom)
        btn1.setImage(UIImage(named: "back_button_black"), for: .normal)
        btn1.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        btn1.addTarget(self, action: #selector(self.didTapSideMenu), for: .touchUpInside)
        let item1 = UIBarButtonItem(customView: btn1)
        
        self.navigationItem.leftBarButtonItem = item1
        
        DispatchQueue.main.async {
            self.view.layoutIfNeeded()
        }
    }
    @objc func didTapSideMenu(){
        self.navigationController?.popViewController(animated: true)
    }
    func regesterTableViewCells() {
        let budgetNib = UINib(nibName: "PendingReferenceTableViewCell", bundle: nil)
        self.tableView.tableFooterView = UIView()
        self.tableView.register(budgetNib, forCellReuseIdentifier: "pendingReferenceCell")
    }
    func setupSegmentControl() {
        control = BetterSegmentedControl(
            frame: CGRect(x: UIScreen.main.bounds.size.width / 6, y: 100, width: 300, height: 44),
            segments: LabelSegment.segments(withTitles: ["Landlord", "Workplace"],
            normalFont: UIFont(name: "Comfortaa", size: 14.0)!,
            normalTextColor: .lightGray,
            selectedFont: UIFont(name: "Comfortaa-Bold", size: 14.0)!,
            selectedTextColor: .white),
            index: 1,
            options: [.backgroundColor(.white),
                      .indicatorViewBackgroundColor(UIColor().colorWithHexString(hexString: "5BBA6F")),.cornerRadius(20)])//
        control?.addTarget(self, action: #selector(self.controlValueChanged(_:)), for: .valueChanged)
        control?.layer.cornerRadius = 20
        control?.borderWidth = 0.5
        control?.borderColor = .lightGray
        control?.clipsToBounds = true
        self.view.addSubview(control!)
    }
    @objc func controlValueChanged(_ sender:UIButton){
        print(control?.index ?? 0)
    }
}

extension PendingReferenceViewController: UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "pendingReferenceCell", for: indexPath) as! PendingReferenceTableViewCell
        
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}
