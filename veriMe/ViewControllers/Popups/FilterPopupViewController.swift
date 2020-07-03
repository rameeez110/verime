//
//  FilterPopupViewController.swift
//  veriMe
//
//  Created by Rameez Hasan on 03/07/2020.
//  Copyright © 2020 Rameez Hasan. All rights reserved.
//

import UIKit
import STPopup

enum ReferenceFilterType: Int {
    case All = 0,pending
}

struct FilterViewModel {
    var type = ReferenceFilterType.All
    var selected = false
    var title = String()
}
class FilterPopupViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var dataSource = [FilterViewModel]()
    var titles = ["All references","Pending references"]
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: "FilterPopupViewController", bundle: nil)
        self.contentSizeInPopup = CGSize.init(width: UIScreen.main.bounds.width, height: 600)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.regesterTableViewCells()
        self.mapDataSource()
        self.setupUI()
    }

}

extension FilterPopupViewController {
    func setupUI() {
        self.regesterTableViewCells()
    }
    func mapDataSource() {
        self.dataSource = [FilterViewModel]()
        for i in 0..<self.titles.count {
            var model = FilterViewModel()
            model.title = self.titles[i]
            model.type = ReferenceFilterType(rawValue: i) ?? ReferenceFilterType.All
            model.selected = false
            if i == 0 {
                model.selected = true
            }
            self.dataSource.append(model)
        }
        self.tableView.reloadData()
    }
    func regesterTableViewCells() {
        let budgetNib = UINib(nibName: "FilterTableViewCell", bundle: nil)
        self.tableView.tableFooterView = UIView()
        self.tableView.register(budgetNib, forCellReuseIdentifier: "filterCell")
    }
    
}

extension FilterPopupViewController: UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "filterCell", for: indexPath) as! FilterTableViewCell
        
        let model = self.dataSource[indexPath.row]
        
        cell.titleLabel.text = model.title
        if model.selected {
            cell.checkImageView.image = UIImage(named: "check_box_selected")
        } else {
            cell.checkImageView.image = UIImage(named: "check_box")
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        self.dismiss(animated: true, completion: nil)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}
