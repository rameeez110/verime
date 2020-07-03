//
//  SubmitReferenceViewController.swift
//  veriMe
//
//  Created by Rameez Hasan on 03/07/2020.
//  Copyright © 2020 Rameez Hasan. All rights reserved.
//

import UIKit
import Sevruk_PageControl
import STPopup

class SubmitReferenceViewController: UIViewController, UIScrollViewDelegate {
    
    var popupVC = STPopupController()
    var detailsView: DetailsView?
    var filesView: FilesView?
    var completedView: CompletedView?

    @IBOutlet weak var scrollView: UIScrollView!{
        didSet{
            scrollView.delegate = self
        }
    }
    
    @IBOutlet weak var pageControl: PageControl!
    
    
    var slides:[UIView] = [];
    
    override func viewDidLoad() {
        super.viewDidLoad()
        slides = createSlides()
        setupSlideScrollView(slides: slides)
        
        pageControl.numberOfPages = slides.count
        pageControl.currentPage = 0
        view.bringSubviewToFront(pageControl)
        
        pageControl.currentIndicatorTintColor = UIColor().colorWithHexString(hexString: "5BBA6F")
        pageControl.currentIndicatorDiameter = CGFloat(20)
        pageControl.indicatorDiameter = CGFloat(10)
        pageControl.spacing = CGFloat(10)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.setupUI()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func setupUI() {
        self.title = "Submit References"
        self.navigationController?.navigationBar.isHidden = false
        
        let btn1 = UIButton(type: .custom)
        btn1.setImage(UIImage(named: "back_button_black"), for: .normal)
        btn1.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        btn1.addTarget(self, action: #selector(self.didTapSideMenu), for: .touchUpInside)
        let item1 = UIBarButtonItem(customView: btn1)
        
        let btn2 = UIButton(type: .custom)
        btn2.setImage(UIImage(named: "filter_button"), for: .normal)
        btn2.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        btn2.addTarget(self, action: #selector(self.didTapFilter), for: .touchUpInside)
        let item2 = UIBarButtonItem(customView: btn2)
        
        self.navigationItem.leftBarButtonItem = item1
        self.navigationItem.rightBarButtonItem = item2
        
    }
    @objc func didTapSideMenu(){
        CommonClass.sharedInstance.leftDrawerTransition.presentDrawerViewController(animated: true)
    }
    @objc func didTapFilter(){
        let vc = FilterPopupViewController(nibName: "FilterPopupViewController", bundle: nil)
        self.initializeQlmController(viewController: vc)
    }
    @objc func initializeQlmController(viewController: UIViewController){
        popupVC = STPopupController.init(rootViewController: viewController)
        popupVC.containerView.backgroundColor = UIColor.clear
        let blur = UIBlurEffect.init(style: .dark)
        popupVC.style = .bottomSheet
        popupVC.backgroundView = UIVisualEffectView.init(effect: blur)
        popupVC.backgroundView?.alpha = 0.9
        popupVC.setNavigationBarHidden(true, animated: true)
        popupVC.backgroundView?.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.handleTapPopup(_:))))
        popupVC.present(in: self)
    }
    // function which is triggered when handleTap is called
    
    @objc func handleTapPopup(_ sender: UITapGestureRecognizer) {
        popupVC.dismiss()
    }
    
    func createSlides() -> [UIView] {

        detailsView = Bundle.main.loadNibNamed("DetailsView", owner: self, options: nil)?.first as? DetailsView
        detailsView?.delegate = self
        filesView = Bundle.main.loadNibNamed("FilesView", owner: self, options: nil)?.first as? FilesView
        filesView?.delegate = self
        completedView = Bundle.main.loadNibNamed("CompletedView", owner: self, options: nil)?.first as? CompletedView
        completedView?.delegate = self
        return [detailsView!, filesView!, completedView!]
    }
    
    
    func setupSlideScrollView(slides : [UIView]) {
        scrollView.contentSize = CGSize(width: view.frame.width * CGFloat(slides.count), height: view.frame.height - 120)
        scrollView.isPagingEnabled = true
        
        for i in 0 ..< slides.count {
            slides[i].frame = CGRect(x: view.frame.width * CGFloat(i), y: 0, width: view.frame.width, height: view.frame.height - 120)
            scrollView.addSubview(slides[i])
        }
    }
    
    
    /*
     * default function called when view is scolled. In order to enable callback
     * when scrollview is scrolled, the below code needs to be called:
     * slideScrollView.delegate = self or
     */
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let pageIndex = round(scrollView.contentOffset.x/view.frame.width)
        pageControl.currentPage = Int(pageIndex)
    }
}

extension SubmitReferenceViewController: DetailsViewDelegate,FilesViewDelegate,CompletedViewDelegate {
    func didTapSubmit() {
        self.scrollView.setContentOffset(CGPoint(x: self.scrollView.contentOffset.x + scrollView.frame.width, y: self.scrollView.contentOffset.y ), animated: true)
    }
    func didTapSend() {
        self.scrollView.setContentOffset(CGPoint(x: self.scrollView.contentOffset.x + scrollView.frame.width, y: self.scrollView.contentOffset.y ), animated: true)
    }
    func didTapHome() {
        self.navigationController?.popViewController(animated: true)
    }
}
