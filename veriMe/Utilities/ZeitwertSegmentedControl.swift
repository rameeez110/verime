//
//  ZeitwertSegmentedControl.swift
//  Zeitwert
//
//  Created by Hamza Jalal on 2/4/19.
//  Copyright © 2019 Digital Dividend. All rights reserved.
//

import UIKit

protocol ZeitwertSegmentedControlDelegate {
    func didSelectSegmentedControl(segmentedControl : ZeitwertSegmentedControl, selectedIndex : Int)
    func shouldSelectIndexAtSegmentedControl(segmentedControl : ZeitwertSegmentedControl, selectedIndex : Int) -> Bool
}

protocol ZeitwertSegmentedControlDataSource {
    func numberOfSegments(segmentedControl : ZeitwertSegmentedControl) -> Int
}

@IBDesignable class ZeitwertSegmentedControl : UIControl {
    
    private var labels = [UIView]()
    private var selectedImageView = UIImageView()
    private var seperatorViews = [UIView]()
    
    @objc var selectedImage = UIImage()
    @objc var nonSelectedImage = UIImage()
    @objc var separatorImage : UIImage? = nil
    @objc var separatorToImageDistance : CGFloat = 0
    var delegate : ZeitwertSegmentedControlDelegate? = nil
    var dataSource : ZeitwertSegmentedControlDataSource? = nil
    
    @objc var items:[Int] {
        if let indexes = self.dataSource?.numberOfSegments(segmentedControl: self) {
            return Array(repeating: 0, count: indexes)
        }
        return []
    }
    
    @objc var selectedIndex : Int = 0 {
        didSet {
            displayNewSelectedIndex()
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        setupView()
    }
    
    
    @objc func setupView() {
        backgroundColor = UIColor.clear
        prefilledData()
        insertSubview(selectedImageView, at: 0)
    }
    
    @objc func prefilledData() {
        self.separatorImage = UIImage.init(named: "lineshort")
        self.selectedImage = UIImage.init(named: "activeprocess")!
        self.nonSelectedImage = UIImage.init(named: "status1")!
        self.separatorToImageDistance = 4
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()        
        //Remove all views if any exists
        for view in labels {
            view.removeFromSuperview()
        }
        self.labels.removeAll(keepingCapacity: true)
        //Remove all separators if any exists
        for view in seperatorViews {
            view.removeFromSuperview()
        }
        self.seperatorViews.removeAll(keepingCapacity: true)
        
        
        let totalWidthOfView = self.bounds.width - 35
        let totalHeightOfView = self.bounds.height
        
        /*var heightOfEachImage = totalHeightOfView
         var widthOfEachImage = totalWidthOfView / CGFloat(self.items.count)
         
         var minValueOfImage = min(heightOfEachImage, widthOfEachImage) //This will be used for image size
         var imageSize = CGSize.init(width: minValueOfImage, height: minValueOfImage) //Each image size
         
         var widthOfSeparator = (totalWidthOfView - (minValueOfImage * CGFloat(self.items.count))) / CGFloat(self.items.count - 2) - (2 * separatorToImageDistance)*/
        
        //******        Way around start, uncomment above code and found better way for clipsToBound approach       ******
        
        var itemsCount  = CGFloat(self.items.count)
        if itemsCount == 5 {
            itemsCount = 5.2
        }
        if itemsCount < 5 {
            itemsCount = 4.5
        }
        
        let heightOfEachImage = totalHeightOfView
        let widthOfEachImage = totalWidthOfView / CGFloat(itemsCount)
        
        let minValueOfImage = min(heightOfEachImage, widthOfEachImage) //This will be used for image size
        let imageSize = CGSize.init(width: minValueOfImage, height: minValueOfImage) //Each image size
        
        let widthOfSeparator = (totalWidthOfView - (minValueOfImage * CGFloat(itemsCount))) / CGFloat(itemsCount - 2) - (2 * separatorToImageDistance)
        
        //******        Way around ended        *******
        
        var xPosition : CGFloat = 0
        for index in 0...items.count - 1 {
            
            let origin = CGPoint.init(x: xPosition, y: 0)
            let frame = CGRect.init(origin: origin, size: imageSize)
            let imageView = UIImageView.init(frame: frame)
            
            if self.selectedIndex == index {
                imageView.image = self.selectedImage
                self.selectedImageView = imageView
                imageView.contentMode = .scaleAspectFit
            } else {
                //widthOfSelectedImage = 5
                imageView.image = self.nonSelectedImage
                imageView.contentMode = .center
                //imageView.frame = CGRect.init(x: xPosition, y: 10, width: widthOfSelectedImage, height: 5)
            }
            self.addSubview(imageView)
            self.labels.append(imageView)
            //Check if separator required
            if index != items.count - 1 {
                let separatorHeight : CGFloat = 2
                xPosition = CGFloat(xPosition + separatorToImageDistance) + CGFloat(imageSize.width)
                let separatorRect = CGRect.init(x: xPosition, y: CGFloat((totalHeightOfView / 2) - (separatorHeight / 2)), width: CGFloat(widthOfSeparator), height: CGFloat(separatorHeight))
                let separatorImageView = UIImageView.init(frame: separatorRect)
                separatorImageView.image = self.separatorImage!
                separatorImageView.contentMode = .scaleToFill
                self.addSubview(separatorImageView)
                self.seperatorViews.append(separatorImageView)
                xPosition = xPosition + CGFloat(widthOfSeparator) + (separatorToImageDistance)
            } else {
                xPosition = xPosition + CGFloat(imageSize.width)
            }
        }
        
        print("x position: \(xPosition) widthOfSeparator \(widthOfSeparator)")
        
        /*var xPosition = 0
        for index in 0...items.count - 1 {
            var widthOfSelectedImage = 20
            let frame = CGRect.init(x: xPosition, y: 0, width: widthOfSelectedImage, height: 20)
            let imageView = UIImageView.init(frame: frame)
            imageView.contentMode = .scaleAspectFit
            if self.selectedIndex == index {
                imageView.image = self.selectedImage
                self.selectedImageView = imageView
            } else {
                widthOfSelectedImage = 5
                imageView.image = self.nonSelectedImage
                imageView.frame = CGRect.init(x: xPosition, y: 10, width: widthOfSelectedImage, height: 5)
            }
            self.addSubview(imageView)
            self.labels.append(imageView)
            //Check if separator required
            if index != items.count - 1 {
                let separatorWidth = 30
                let separatorRect = CGRect.init(x: xPosition + separatorToImageDistance + widthOfSelectedImage, y: Int(10), width: separatorWidth, height: 5)
                let separatorImageView = UIImageView.init(frame: separatorRect)
                separatorImageView.image = self.separatorImage!
                separatorImageView.contentMode = .scaleAspectFit
                self.addSubview(separatorImageView)
                self.seperatorViews.append(separatorImageView)
                xPosition = xPosition + separatorWidth + (2 * separatorToImageDistance)
            }
            
            xPosition = xPosition + widthOfSelectedImage
        }*/
    }
    
    override func beginTracking(_ touch: UITouch, with event: UIEvent?) -> Bool {
        let location = touch.location(in: self)
        
        var calculatedIndex : Int?
        for (index, item) in labels.enumerated() {
            if item.frame.contains(location) {
                calculatedIndex = index
            }
        }
        
        if calculatedIndex != nil {
            if let shouldSelect = self.delegate?.shouldSelectIndexAtSegmentedControl(segmentedControl: self, selectedIndex: calculatedIndex!), shouldSelect == true {
                selectedIndex = calculatedIndex!
                self.delegate?.didSelectSegmentedControl(segmentedControl: self, selectedIndex: selectedIndex)
                sendActions(for: .valueChanged)
            }
        }
        
        return false
    }
    
    @objc func setSelectedIndex(index : Int) {
        if self.items.count > index && index >= 0 {
            if let shouldSelect = self.delegate?.shouldSelectIndexAtSegmentedControl(segmentedControl: self, selectedIndex: index), shouldSelect == true {
                selectedIndex = index
                self.delegate?.didSelectSegmentedControl(segmentedControl: self, selectedIndex: selectedIndex)
                sendActions(for: .valueChanged)
            }
        }
    }
    
    @objc func displayNewSelectedIndex() {
        let label = labels[selectedIndex]
        self.selectedImageView.frame = label.frame
        self.layoutSubviews()
    }
}
