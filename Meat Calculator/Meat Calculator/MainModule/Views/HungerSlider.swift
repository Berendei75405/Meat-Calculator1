//
//  HungerSlider.swift
//  Meat Calculator
//
//  Created by Novgorodcev on 02.01.2024.
//

import Foundation
import UIKit

//MARK: - HungerSliderDelegate
protocol HungerSliderDelegate: AnyObject {
    func getHunger(hunger: Lavel)
}

final class HungerSlider: UISlider {
    
    //MARK: - baseLayer
    private lazy var baseLayer: CALayer = {
        let base = CALayer()
        base.frame = .init(x: 0,
                           y: frame.height/4,
                           width: frame.width,
                           height: frame.height/2)
        base.cornerRadius = base.frame.height / 2
        base.borderWidth = 1
        base.borderColor = UIColor.lightGray.cgColor
        base.masksToBounds = true
        base.backgroundColor = UIColor.white.cgColor
        
        return base
    }()
    
    //MARK: - trackLayer
    private lazy var trackLayer: CAGradientLayer = {
        let track = CAGradientLayer()
        
        //colors
        let firstColor =  #colorLiteral(red: 0.7186132073, green: 0.8622717857, blue: 0.5358211398, alpha: 1).cgColor
        let secondColor = #colorLiteral(red: 0.9995197654, green: 0.7011556029, blue: 0.2833247483, alpha: 1).cgColor
        let thirdColor =  #colorLiteral(red: 0.9308266044, green: 0.3063942194, blue: 0.1038768366, alpha: 1).cgColor
        let thumbRectA = thumbRect(forBounds: bounds,
                                   trackRect: trackRect(forBounds: bounds),
                                   value: value)
        track.colors = [firstColor, secondColor,
                             thirdColor]
        track.startPoint = .init(x: 0, y: 0.3)
        //track.endPoint = .init(x: 1, y: 0.5)
        track.frame = .init(x: 0,
                                 y: frame.height / 4,
                                 width: thumbRectA.midX + 2,
                                 height: frame.height / 2)
        track.cornerRadius = track.frame.height / 2
        self.layer.insertSublayer(track, at: 1)
        
        return track
    }()
    
    //MARK: - thumbImage
    private var thumbImage: UIImage = {
        let img = UIImage(named: "Mouse")!
        
        let imgOriginal = img.scaled(to: CGSize(width: 50,
                                                height: 50))
        
        return imgOriginal
    }()
    
    weak var delegate: HungerSliderDelegate?
    
    override func draw(_ rect: CGRect) {
        super .draw(rect)
        
        let thumbRectA = thumbRect(forBounds: bounds,
                                   trackRect: trackRect(forBounds: bounds),
                                   value: value)
        
        //layers
        baseLayer.frame = .init(x: 0,
                           y: frame.height/4,
                           width: frame.width,
                           height: frame.height/2)
        
        trackLayer.frame = .init(x: 0,
                                 y: frame.height / 4,
                                 width: thumbRectA.midX + 2,
                                 height: frame.height / 2) 
    }
    
    override init(frame: CGRect) {
        super .init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - setup
    private func setup() {
        
        //убираем дефолтные элементы
        tintColor = .clear
        maximumTrackTintColor = .clear
        backgroundColor = .clear
        thumbTintColor = .clear
        minimumTrackTintColor = .clear
        
        //image
        setThumbImage(thumbImage, for: .normal)
        setThumbImage(thumbImage, for: .highlighted)
        setThumbImage(thumbImage, for: .application)
        setThumbImage(thumbImage, for: .disabled)
        setThumbImage(thumbImage, for: .focused)
        setThumbImage(thumbImage, for: .reserved)
        setThumbImage(thumbImage, for: .selected)
        
        //sublayers
        layer.insertSublayer(baseLayer, at: 0)
        layer.insertSublayer(trackLayer, at: 1)
        
        addTarget(self, action: #selector(valueChanged(_:)), for: .valueChanged)
    }
    
    //MARK: - valueChanged
    @objc private func valueChanged(_ sender: UISlider) {
        CATransaction.begin()
        CATransaction.setDisableActions(true)
        let thumbRectA = thumbRect(forBounds: bounds,
                                   trackRect: trackRect(forBounds: bounds),
                                   value: value)
        //trackLayer
        trackLayer.frame = .init(x: 0,
                                 y: frame.height / 4,
                                 width: thumbRectA.midX + 2,
                                 height: frame.height / 2)
        
        if sender.value <= 1.6 {
            thumbImage = UIImage(named: "Mouse")?.scaled(to: CGSize(width: 50, height: 50)) ?? UIImage()
            delegate?.getHunger(hunger: .easy)
        } else if sender.value <= 3.3 {
            thumbImage = UIImage(named: "Wolf")?.scaled(to: CGSize(width: 50, height: 50)) ?? UIImage()
            delegate?.getHunger(hunger: .normal)
        } else if sender.value <= 5 {
            thumbImage = UIImage(named: "Bear")?.scaled(to: CGSize(width: 50, height: 50)) ?? UIImage()
            delegate?.getHunger(hunger: .hard)
        }
        
        setThumbImage(thumbImage, for: .normal)
        setThumbImage(thumbImage, for: .highlighted)
        setThumbImage(thumbImage, for: .application)
        setThumbImage(thumbImage, for: .disabled)
        setThumbImage(thumbImage, for: .focused)
        setThumbImage(thumbImage, for: .reserved)
        setThumbImage(thumbImage, for: .selected)
        
        CATransaction.commit()
    }
}
