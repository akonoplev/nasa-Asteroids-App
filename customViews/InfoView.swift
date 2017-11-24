//
//  InfoView.swift
//  nasaAsteroids
//
//  Created by Андрей Коноплев on 24.11.17.
//  Copyright © 2017 Андрей Коноплев. All rights reserved.
//

import UIKit

class InfoView: UIView {

    @IBOutlet var view: UIView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var minDLabel: UILabel!
    @IBOutlet weak var maxDLabel: UILabel!
    @IBOutlet weak var distanceToEarth: UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    fileprivate func commonInit() {
        Bundle.main.loadNibNamed("InfoView", owner: self, options: nil)
        addSubview(view)
        view.frame = self.bounds
        view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        view.layer.masksToBounds = true
        view.layer.cornerRadius = 10
        view.layer.borderWidth = 1
        view.layer.borderColor = #colorLiteral(red: 0.1411764771, green: 0.3960784376, blue: 0.5647059083, alpha: 1)
    }
    
}
