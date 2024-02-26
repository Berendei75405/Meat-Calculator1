//
//  MeatCollectionViewCell.swift
//  Meat Calculator
//
//  Created by Novgorodcev on 08.01.2024.
//

import UIKit

protocol MeatCollectionViewCellDelegate: AnyObject {
    func cellWasSelect(index: Int)
}

final class MeatCollectionViewCell: UICollectionViewCell {
    static let identifier = "MeatCollectionViewCell"
    
    weak var delegate: MeatCollectionViewCellDelegate?
    
    //MARK: - meatButton
    private let meatButton: UIButton = {
        let but = UIButton()
        but.translatesAutoresizingMaskIntoConstraints = false
        but.layer.cornerRadius = 10
        but.clipsToBounds = true
        
        return but
    }()
    
    //MARK: - init
    override init(frame: CGRect) {
        super .init(frame: frame)
        contentView.layer.cornerRadius = 10
        contentView.clipsToBounds = true
        
        //constraints meatButton
        contentView.addSubview(meatButton)
        
        NSLayoutConstraint.activate([
            meatButton.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 3),
            meatButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 3),
            meatButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -3),
            meatButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -3)
        ])
        
        meatButton.addTarget(self,
                             action: #selector(selectMeat(sender:)),
                             for: .touchUpInside)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - config
    func config(titleButton: String) {
        guard let img = UIImage(named: titleButton) else { return }
        self.meatButton.setImage(img,
                                 for: .normal)
    }
    
    //MARK: - selectMeat
    @objc private func selectMeat(sender: UIButton) {
        delegate?.cellWasSelect(index: tag)
        select()
    }
    
    //MARK: - select
    func select() {
        //colors
        let firstColor = #colorLiteral(red: 0.9995197654, green: 0.7011556029, blue: 0.2833247483, alpha: 1).cgColor
        let secondColor =  #colorLiteral(red: 0.9308266044, green: 0.3063942194, blue: 0.1038768366, alpha: 1).cgColor
        
        //layers
        let layer = CAGradientLayer()
        layer.colors = [firstColor,
                        secondColor]
        layer.frame = contentView.frame
        layer.startPoint = .init(x: 0, y: 1)
        layer.endPoint = .init(x: 0.6, y: 1)
        
        contentView.layer.insertSublayer(layer, at: 0)
        
        let generator = UISelectionFeedbackGenerator()
        generator.selectionChanged()
    }
}
