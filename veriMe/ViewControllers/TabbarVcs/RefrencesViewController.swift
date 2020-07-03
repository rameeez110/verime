//
//  RefrencesViewController.swift
//  veriMe
//
//  Created by Rameez Hasan on 29/06/2020.
//  Copyright © 2020 Rameez Hasan. All rights reserved.
//

import UIKit
import BetterSegmentedControl

enum ViewRefrenceType: Int {
    case Landlord = 0,Workplace
}

class RefrencesViewController: UIViewController {
    
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
extension RefrencesViewController {
    func setupUI() {
        self.title = "View References"
        self.navigationController?.navigationBar.isHidden = false
    }
    func regesterTableViewCells() {
        let budgetNib = UINib(nibName: "ViewReferenceTableViewCell", bundle: nil)
        self.tableView.tableFooterView = UIView()
        self.tableView.register(budgetNib, forCellReuseIdentifier: "referenceCell")
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

extension RefrencesViewController: UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 6
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "referenceCell", for: indexPath) as! ViewReferenceTableViewCell
        
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}
