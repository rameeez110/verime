//
//  SubmitReferenceViewController.swift
//  veriMe
//
//  Created by Rameez Hasan on 03/07/2020.
//  Copyright © 2020 Rameez Hasan. All rights reserved.
//

import UIKit
import Sevruk_PageControl

class SubmitReferenceViewController: UIViewController {
    
    @IBOutlet weak var scrollingPageControl: PageControl!
    @IBOutlet weak var scrollView: UIScrollView!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        scrollView.delegate = self
        self.scrollView.contentSize = CGSize.init(width: 900, height: 500)
        self.scrollingPageControl.numberOfPages = Int(scrollView.contentSize.width / scrollView.bounds.width)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.setupUI()
    }
}
extension SubmitReferenceViewController {
    func setupUI() {
        self.title = "Submit References"
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
        
        self.scrollingPageControl.indicatorTintColor = .black
        self.scrollingPageControl.currentIndicatorTintColor = UIColor().colorWithHexString(hexString: "5BBA6F")
    }
    @objc func didTapSideMenu(){
        self.navigationController?.popViewController(animated: true)
    }
}

extension SubmitReferenceViewController: UITableViewDelegate,UITableViewDataSource {
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

extension SubmitReferenceViewController: UIScrollViewDelegate {
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let page = scrollView.contentOffset.x / scrollView.bounds.width
        self.scrollingPageControl.currentPage = Int(page)
    }
}
