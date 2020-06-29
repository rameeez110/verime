//
//  SideMenuViewController.swift
//  veriMe
//
//  Created by Rameez Hasan on 29/06/2020.
//  Copyright © 2020 Rameez Hasan. All rights reserved.
//

import UIKit

enum SideMenuOptions: Int {
    case EditProfile = 0,ViewRefrence,PendingRefrence,ContactUs,AboutUs
}

class SideMenuViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var profileImageView: UIImageView!
    
    @IBOutlet weak var imageShadowView: UIView!
    
    @IBOutlet weak var nameLabel: UILabel!

    @objc weak var navRef: UINavigationController?
    @objc weak var tabBarRef: UITabBarController?

    let mainStoryboard = UIStoryboard(name: "Transactions", bundle: nil)
    var dataSource = [TransactionModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.regesterTableViewCells()
        self.didTapAll()
        self.updateLayerProperties()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        self.setupUI()
        self.mapIncomeExpense()
    }

}

extension MyTransactionsViewController {
    func setupUI() {
        
        self.tabBarController?.title = "Transactions"
        self.tabBarController?.navigationItem.hidesBackButton = true
        self.navigationController?.navigationBar.isHidden = true
        self.tabBarController?.navigationController?.navigationBar.isHidden = false
        
        let btn1 = UIButton(type: .custom)
        btn1.setImage(UIImage(named: "nav_menu_icon"), for: .normal)
        btn1.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        btn1.addTarget(self, action: #selector(self.didTapSideMenu), for: .touchUpInside)
        let item1 = UIBarButtonItem(customView: btn1)

        self.tabBarController?.navigationItem.leftBarButtonItem = item1
//        self.tabBarController?.navigationItem.rightBarButtonItem = item2
    }
    func regesterTableViewCells() {
        let budgetNib = UINib(nibName: "TransactionsTableViewCell", bundle: nil)
        self.tableView.tableFooterView = UIView()
        self.tableView.register(budgetNib, forCellReuseIdentifier: "TransactionsTableViewCell")
    }
    
    @objc func didTapAdd(){
        let vc = mainStoryboard.instantiateViewController(withIdentifier: "AddTransactionsVC") as! AddTransactionsViewController
        vc.delegate = self
        DispatchQueue.main.async {
            self.tabBarController?.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    @objc func didTapSideMenu(){
        CommonClass.sharedInstance.leftDrawerTransition.presentDrawerViewController(animated: true)
    }
    func getTransactions() {
        FirebaseStore.sharedInstance.getTransactions(userId: CommonClass.sharedInstance.currentLoggedInUser.userId) { (result) in
            switch (result) {
            case .Success(let json):
                if let models = json as? [TransactionModel] {
                    CommonClass.sharedInstance.transactionsArray = models
                    self.mapIncomeExpense()
                    DispatchQueue.main.async {
                        self.tableView.reloadData()
                    }
                }
            case .FailureDueToService(let error):
                print("Due to service error with error \(error)")
            case .Failure(let error):
                print(error)
            }
        }
    }
    
    func mapIncomeExpense() {
        let incomeTransactions = self.filteredDataSource.filter({$0.type == TransactionType.Income.rawValue})
        let expenseTransactions = self.filteredDataSource.filter({$0.type == TransactionType.Expense.rawValue})
        if incomeTransactions.count > 0 {
            self.incomeLabel.text = "$ \(CommonClass.sharedInstance.getValue(transactions: incomeTransactions))"
        } else {
            self.incomeLabel.text = "$ 0"
        }
        if expenseTransactions.count > 0 {
            self.expenseLabel.text = "$ \(CommonClass.sharedInstance.getValue(transactions: expenseTransactions))"
        } else {
            self.expenseLabel.text = "$ 0"
        }
    }
    
    func removeTransaction(model: TransactionModel) {
        if let indexOfA = CommonClass.sharedInstance.transactionsArray.firstIndex(where: {$0.id == model.id}) {
            CommonClass.sharedInstance.transactionsArray.remove(at: indexOfA)
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
        self.mapIncomeExpense()
    }
    func updateLayerProperties() {
        self.newTransactionButton.layer.shadowColor = UIColor.black.cgColor//UIColor(red: 0, green: 1, blue: 0, alpha: 0.25).cgColor
        self.newTransactionButton.layer.shadowOffset = CGSize(width: 0, height: 3)
        self.newTransactionButton.layer.shadowOpacity = 0.5
        self.newTransactionButton.layer.shadowRadius = 10.0
        self.newTransactionButton.layer.masksToBounds = false
    }
}

extension MyTransactionsViewController {
    @IBAction func didTapAll() {
        self.selectedIndex = .All
        self.allButton.setTitleColor(CommonClass.sharedInstance.greenThemeColor(), for: .normal)
        self.allView.backgroundColor = CommonClass.sharedInstance.greenThemeColor()
        self.todayView.backgroundColor = .systemFill
        self.weekView.backgroundColor = .systemFill
        self.yearView.backgroundColor = .systemFill
        self.todayButton.setTitleColor(.systemFill, for: .normal)
        self.weekButton.setTitleColor(.systemFill, for: .normal)
        self.yearButton.setTitleColor(.systemFill, for: .normal)
        self.mapIncomeExpense()
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
        
        self.allButton.layer.shadowColor = UIColor(red: 0, green: 1, blue: 0, alpha: 0.25).cgColor
        self.allButton.layer.shadowOffset = CGSize(width: 0, height: 10)
        self.allButton.layer.shadowOpacity = 1.0
        self.allButton.layer.shadowRadius = 100.0
        self.allButton.layer.masksToBounds = false
        
//        self.todayButton.layer.shadowOpacity = 0.0
//        self.weekButton.layer.shadowOpacity = 0.0
//        self.yearButton.layer.shadowOpacity = 0.0
    }
    @IBAction func didTapToday() {
        self.selectedIndex = .Today
        self.todayButton.setTitleColor(CommonClass.sharedInstance.greenThemeColor(), for: .normal)
        self.todayView.backgroundColor = CommonClass.sharedInstance.greenThemeColor()
        self.allView.backgroundColor = .systemFill
        self.weekView.backgroundColor = .systemFill
        self.yearView.backgroundColor = .systemFill
        self.allButton.setTitleColor(.systemFill, for: .normal)
        self.weekButton.setTitleColor(.systemFill, for: .normal)
        self.yearButton.setTitleColor(.systemFill, for: .normal)
        self.mapIncomeExpense()
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
        
        self.todayButton.layer.shadowColor = UIColor(red: 0, green: 1, blue: 0, alpha: 0.25).cgColor
        self.todayButton.layer.shadowOffset = CGSize(width: 0, height: 10)
        self.todayButton.layer.shadowOpacity = 1.0
        self.todayButton.layer.shadowRadius = 100.0
        self.todayButton.layer.masksToBounds = false
        
//        self.allButton.layer.shadowOpacity = 0.0
//        self.weekButton.layer.shadowOpacity = 0.0
//        self.yearButton.layer.shadowOpacity = 0.0
    }
    @IBAction func didTapWeek() {
        self.selectedIndex = .Week
        self.weekButton.setTitleColor(CommonClass.sharedInstance.greenThemeColor(), for: .normal)
        self.weekView.backgroundColor = CommonClass.sharedInstance.greenThemeColor()
        self.todayView.backgroundColor = .systemFill
        self.allView.backgroundColor = .systemFill
        self.yearView.backgroundColor = .systemFill
        self.todayButton.setTitleColor(.systemFill, for: .normal)
        self.allButton.setTitleColor(.systemFill, for: .normal)
        self.yearButton.setTitleColor(.systemFill, for: .normal)
        self.mapIncomeExpense()
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
        
        self.weekButton.layer.shadowColor = UIColor(red: 0, green: 1, blue: 0, alpha: 0.25).cgColor
        self.weekButton.layer.shadowOffset = CGSize(width: 0, height: 10)
        self.weekButton.layer.shadowOpacity = 1.0
        self.weekButton.layer.shadowRadius = 100.0
        self.weekButton.layer.masksToBounds = false
        
//        self.allButton.layer.shadowOpacity = 0.0
//        self.todayButton.layer.shadowOpacity = 0.0
//        self.yearButton.layer.shadowOpacity = 0.0
    }
    @IBAction func didTapMonth() {
        self.selectedIndex = .Month
        self.yearButton.setTitleColor(CommonClass.sharedInstance.greenThemeColor(), for: .normal)
        self.yearView.backgroundColor = CommonClass.sharedInstance.greenThemeColor()
        self.todayView.backgroundColor = .systemFill
        self.weekView.backgroundColor = .systemFill
        self.allView.backgroundColor = .systemFill
        self.todayButton.setTitleColor(.systemFill, for: .normal)
        self.weekButton.setTitleColor(.systemFill, for: .normal)
        self.allButton.setTitleColor(.systemFill, for: .normal)
        self.mapIncomeExpense()
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
        
        self.yearButton.layer.shadowColor = UIColor(red: 0, green: 1, blue: 0, alpha: 0.25).cgColor
        self.yearButton.layer.shadowOffset = CGSize(width: 0, height: 10)
        self.yearButton.layer.shadowOpacity = 1.0
        self.yearButton.layer.shadowRadius = 100.0
        self.yearButton.layer.masksToBounds = false
        
//        self.allButton.layer.shadowOpacity = 0.0
//        self.todayButton.layer.shadowOpacity = 0.0
//        self.weekButton.layer.shadowOpacity = 0.0
    }
    
    @IBAction func didTapAddTransaction() {
        let vc = mainStoryboard.instantiateViewController(withIdentifier: "AddTransactionsVC") as! AddTransactionsViewController
        vc.delegate = self
        DispatchQueue.main.async {
            self.tabBarController?.navigationController?.pushViewController(vc, animated: true)
        }
    }
}

extension MyTransactionsViewController: UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.filteredDataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TransactionsTableViewCell", for: indexPath) as! TransactionsTableViewCell
        
        cell.bindData(model: self.filteredDataSource[indexPath.row])
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let vc = mainStoryboard.instantiateViewController(withIdentifier: "AddTransactionsVC") as! AddTransactionsViewController
        vc.delegate = self
        vc.isEditingFlow = true
        vc.transactionModel = self.filteredDataSource[indexPath.row]
        DispatchQueue.main.async {
            self.tabBarController?.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let model = self.filteredDataSource[indexPath.row]
            model.isDeleted = true
            FirebaseStore.sharedInstance.createOrUpdateTransaction(model: model) { (result) in
                self.removeTransaction(model: model)
            }
        }
    }
}

extension MyTransactionsViewController: MyTransactionsVCDelegate {
    func didAddTransactions() {
        self.getTransactions()
        
        let purchased = UserDefaults.standard.bool(forKey: ActiceProducts.ProductID)
        if purchased {
            return
        }
        
        interstitial = CommonClass.sharedInstance.createAndLoadInterstitial()
        interstitial.delegate = self
        if interstitial.isReady {
            //          interstitial.present(fromRootViewController: self)
        } else {
            print("Ad wasn't ready")
        }
    }
}

extension MyTransactionsViewController: GADInterstitialDelegate {
    /// Tells the delegate an ad request succeeded.
    func interstitialDidReceiveAd(_ ad: GADInterstitial) {
      print("interstitialDidReceiveAd")
        interstitial.present(fromRootViewController: self)
    }

    /// Tells the delegate an ad request failed.
    func interstitial(_ ad: GADInterstitial, didFailToReceiveAdWithError error: GADRequestError) {
      print("interstitial:didFailToReceiveAdWithError: \(error.localizedDescription)")
    }

    /// Tells the delegate that an interstitial will be presented.
    func interstitialWillPresentScreen(_ ad: GADInterstitial) {
      print("interstitialWillPresentScreen")
    }

    /// Tells the delegate the interstitial is to be animated off the screen.
    func interstitialWillDismissScreen(_ ad: GADInterstitial) {
      print("interstitialWillDismissScreen")
    }

    /// Tells the delegate the interstitial had been animated off the screen.
    func interstitialDidDismissScreen(_ ad: GADInterstitial) {
      print("interstitialDidDismissScreen")
    }

    /// Tells the delegate that a user click will open another app
    /// (such as the App Store), backgrounding the current app.
    func interstitialWillLeaveApplication(_ ad: GADInterstitial) {
      print("interstitialWillLeaveApplication")
    }
}
