//
//  mainVC.swift
//  nasaAsteroids
//
//  Created by Андрей Коноплев on 23.11.17.
//  Copyright © 2017 Андрей Коноплев. All rights reserved.
//

import UIKit

class mainVC: UIViewController {

    //MARK:- outlets
    @IBOutlet weak var datePicker: UIDatePicker!
    
    //MARK: - vars
    var presenter = mainPresenter()
    var date = ""
    var earthView = UIImageView()
    var asteroidArray = [AsteroidModel]()
    var infoView = InfoView()
    var gradientLayer = CAGradientLayer()
    var starsLayer = CAShapeLayer()
    
    //MARK: - didLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        changeView()
        addEarth()
        presenter.initialPresenter(view: self)
        presenter.formDate()
        presenter.getAsteroids()
    }
}

//MARK: Tap Search
extension mainVC {
    @IBAction func tapSearch(_ sender: Any) {
        self.presenter.formDate()
        self.presenter.getAsteroids()
        self.removeSubviews(subviews: self.view.subviews)
        GradientAndStarsLayer.configureStarsLayer(view: self.view, shapeLayer: starsLayer)
    }
}

//MARK: - add earth to superview
extension mainVC {
    func addEarth() {
        earthView.translatesAutoresizingMaskIntoConstraints = false
        earthView.image = #imageLiteral(resourceName: "earth.png")
        earthView.tag = 203
        //change size to X and Y
        earthView.transform = CGAffineTransform(scaleX: 0, y: 0)
        view.addSubview(earthView)
        
        UIView.animate(withDuration: 3, delay: 0.5, usingSpringWithDamping: 0.7, initialSpringVelocity: 0, options: .curveEaseInOut, animations: {
            self.earthView.transform = CGAffineTransform(scaleX: 1, y: 1)
        }, completion: nil)
        
        //constraints
        let heightConstraint = earthView.heightAnchor.constraint(equalToConstant: self.view.frame.height)
        let widthConstraint = earthView.widthAnchor.constraint(equalToConstant: self.view.frame.height)
        let xConstraint = earthView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: -(view.frame.height / 2))
        let yConstraint = earthView.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        let constraints = [heightConstraint, widthConstraint,xConstraint, yConstraint]
        NSLayoutConstraint.activate(constraints)
    }
}

//MARK: - add Asteroids to superview
extension mainVC {
    func addAsteroids() {
        var sizeOfAsteroid = CGFloat(0)
        var cosmos = CGFloat(0)
        var tag = 0
        let maxSize = asteroidArray.map{$0.averegeSize}.max()!
        let placeXForAsteroids = view.frame.width - earthView.frame.maxX - 50
        
        for asteroid in asteroidArray {
            let asteroidImage = UIImageView()
            asteroidImage.translatesAutoresizingMaskIntoConstraints = false
            
            switch asteroid.averegeSize {
            case 0...(1/3 * maxSize) : asteroidImage.image = #imageLiteral(resourceName: "smallAsteroid.png")
            case (1/3 * maxSize)...(2/3 * maxSize): asteroidImage.image = #imageLiteral(resourceName: "middleAsteroid.png")
                default: asteroidImage.image = #imageLiteral(resourceName: "largeAsteroid.png")
            }
            
            sizeOfAsteroid = CGFloat(asteroid.averegeSize * Double(earthView.frame.width) / const.earth_params.earth_deametr)
            asteroidImage.transform = CGAffineTransform(scaleX: 0, y: 0)
            view.addSubview(asteroidImage)
            
            let heightConstraint = asteroidImage.heightAnchor.constraint(equalToConstant: sizeOfAsteroid)
            let widthConstraint = asteroidImage.widthAnchor.constraint(equalToConstant: sizeOfAsteroid)
            let yConstraint = asteroidImage.centerYAnchor.constraint(equalTo: view.centerYAnchor)
            
            cosmos = cosmos + sizeOfAsteroid
            let collection = placeXForAsteroids - cosmos
            let xConstraint = asteroidImage.leadingAnchor.constraint(equalTo: earthView.trailingAnchor, constant: collection)
            let constraints = [heightConstraint, widthConstraint, xConstraint, yConstraint]
            NSLayoutConstraint.activate(constraints)
            
            cosmos = cosmos + CGFloat(asteroid.rangeToEarth/3000000)
            
            UIView.animate(withDuration: 0.6, delay: 0.5, usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: .curveEaseInOut, animations: {
                asteroidImage.transform = CGAffineTransform(scaleX: 1, y: 1)
            }, completion: nil)
            
            asteroidImage.tag = tag
            tag += 1
            
            //MARK:- add gesture recognaizer for each asteroid
            let gestureRecognaizer = UILongPressGestureRecognizer(target: self, action: #selector(showInfo(tapGestureRecognaizer:)))
            asteroidImage.isUserInteractionEnabled = true
            asteroidImage.addGestureRecognizer(gestureRecognaizer)
        }
        view.layoutIfNeeded()
    }
}

//MARK: - show info for long gesture

extension mainVC {
    @objc func showInfo(tapGestureRecognaizer: UITapGestureRecognizer) {
        
        let selectedAsteroid = tapGestureRecognaizer.view!
        
        if tapGestureRecognaizer.state == .began {
            //Highlight select asteroid
            selectedAsteroid.layer.cornerRadius = selectedAsteroid.frame.height / 2
            selectedAsteroid.layer.borderWidth = 3
            selectedAsteroid.layer.borderColor = #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1)
            
            //Coord for info View
            let yCoord = selectedAsteroid.frame.midY + selectedAsteroid.frame.height / 2 + 20
            let width = UIScreen.main.bounds.width / 2.7
            let height = UIScreen.main.bounds.height / 4
            let xCoord = selectedAsteroid.frame.midX - width / 1.3
            
            infoView = InfoView(frame: CGRect(x: xCoord, y: yCoord, width: width, height: height))
            infoView.nameLabel.text = "Название: \(asteroidArray[selectedAsteroid.tag].name)"
            infoView.maxDLabel.text = "Диаметр.max: \(asteroidArray[selectedAsteroid.tag].maxSize)"
            infoView.minDLabel.text = "Диаметр.min: \(asteroidArray[selectedAsteroid.tag].minSize)"
            infoView.distanceToEarth.text = "Расстояние: \(asteroidArray[selectedAsteroid.tag].rangeToEarth) км."
            
            infoView.transform = CGAffineTransform(scaleX: 0, y: 0)
            view.addSubview(infoView)
            
            UIView.animate(withDuration: 0.5, animations: {
                self.infoView.transform = CGAffineTransform(scaleX: 1, y: 1)
            })
            
        } else if tapGestureRecognaizer.state == .ended {
            self.removeSubviews(subviews: [infoView])
            selectedAsteroid.layer.borderWidth = 0
        }
    }
}

//MARK: - add stars and gradien

extension mainVC {
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        GradientAndStarsLayer.configureGradient(gradientLayer: gradientLayer)
        gradientLayer.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
    }
}

//MARK: - change elements view
extension mainVC {
    func changeView() {
        self.datePicker.setValue(#colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0), forKey: "textColor")
        GradientAndStarsLayer.configureStarsLayer(view: self.view, shapeLayer: starsLayer)
        view.layer.addSublayer(starsLayer)
        view.layer.insertSublayer(gradientLayer, at: 0)
    }
}

//MARK: - remove all subview unless earth, searchButton and dataPicker
extension mainVC {
    func removeSubviews(subviews: [UIView]) {
        for subview in subviews {
            if subview.tag < 200 {
                subview.removeFromSuperview()
            }
        }
    }
}

