//
//  ViewController.swift
//  Meat Calculator
//
//  Created by Novgorodcev on 22.11.2023.
//

import UIKit

final class MainViewController: UIViewController {
    
    var viewModel: MainViewModelProtocol?
    
    //MARK: - scrollView
    private lazy var scrollView: UIScrollView = {
        let scrl = UIScrollView()
        scrl.translatesAutoresizingMaskIntoConstraints = false
        scrl.backgroundColor = UIColor(named: "backgroundColor")
        scrl.showsVerticalScrollIndicator = true
        scrl.isUserInteractionEnabled = true
        
        return scrl
    }()
    
    //MARK: - contentView
    private let contentView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.isUserInteractionEnabled = true
        
        return view
    }()
    
    //MARK: - personsLabel
    private let personsLabel: UILabel = {
        let lab = UILabel()
        lab.translatesAutoresizingMaskIntoConstraints = false
        lab.text = "Количество кайфующих"
        lab.textColor = UIColor(named: "otherColor")
        lab.font = .boldSystemFont(ofSize: 18)
        
        return lab
    }()
    
    //MARK: - personSlider
    private lazy var personSlider: PersonSlider = {
        let slider = PersonSlider(frame: CGRect(x: 0, y: 0,
                                                width: view.frame.width - 32, height: 50))
        slider.translatesAutoresizingMaskIntoConstraints = false
        slider.delegate = self
        slider.maximumValue = 20
        slider.minimumValue = 1
        
        return slider
    }()
    
    //MARK: - countPersonLabel
    private let countPersonLabel: UILabel = {
        let lab = UILabel()
        lab.translatesAutoresizingMaskIntoConstraints = false
        lab.textAlignment = .center
        lab.textColor = UIColor(named: "otherColor")
        
        return lab
    }()
    
    //MARK: - meatLabel
    private let meatLabel: UILabel = {
        let lab = UILabel()
        lab.translatesAutoresizingMaskIntoConstraints = false
        lab.text = "Что жарим?"
        lab.textColor = UIColor(named: "otherColor")
        lab.font = .boldSystemFont(ofSize: 18)
        
        return lab
    }()
    
    //MARK: - meatCollectioView
    private lazy var meatCollectioView: UICollectionView = {
        var collection = UICollectionView(frame: .zero, collectionViewLayout: createLayout())
        collection.translatesAutoresizingMaskIntoConstraints = false
        collection.backgroundColor = UIColor(named: "backgroundColor")
        
        //register cells
        collection.register(MeatCollectionViewCell.self, forCellWithReuseIdentifier: MeatCollectionViewCell.identifier)
        
        //protocols
        collection.delegate = self
        collection.dataSource = self
        
        return collection
    }()
    
    //MARK: - randomMeatButton
    private lazy var randomMeatButton: UIButton = {
        let but = UIButton(type: .system)
        but.translatesAutoresizingMaskIntoConstraints = false
        but.setTitle("Выбрать мясо случайным образом",
                     for: .normal)
        but.frame.size = CGSize(width: view.frame.width - 32, height: 60)
        but.tintColor = .white
        but.layer.cornerRadius = but.frame.height/2
        but.titleLabel?.font = .boldSystemFont(ofSize: 18)
        but.clipsToBounds = true
        
        return but
    }()
    
    //MARK: - gradinetLayer
    private let gradientLayer: CAGradientLayer = {
        let layer = CAGradientLayer()
        
        //colors
        let firstColor = #colorLiteral(red: 0.9995197654, green: 0.7011556029, blue: 0.2833247483, alpha: 1).cgColor
        let secondColor =  #colorLiteral(red: 0.9308266044, green: 0.3063942194, blue: 0.1038768366, alpha: 1).cgColor
        
        layer.colors = [firstColor,
                        secondColor]
        layer.startPoint = .init(x: 0, y: 1)
        layer.endPoint = .init(x: 0.6, y: 1)
        
        return layer
    }()
    
    //MARK: - hungerLabel
    private let hungerLabel: UILabel = {
        let lab = UILabel()
        lab.translatesAutoresizingMaskIntoConstraints = false
        lab.text = "Насколько вы голодны?"
        lab.textColor = UIColor(named: "otherColor")
        lab.font = .boldSystemFont(ofSize: 18)
        
        return lab
    }()
    
    //MARK: - hungerSlider
    private lazy var hungerSlider: HungerSlider = {
        let slider = HungerSlider(frame: CGRect(x: 0, y: 0,
                                                width: view.frame.width - 32, height: 50))
        slider.translatesAutoresizingMaskIntoConstraints = false
        slider.delegate = self
        slider.value = 0
        slider.maximumValue = 5
        
        return slider
    }()
    
    //MARK: - timeLabel
    private let timeLabel: UILabel = {
        let lab = UILabel()
        lab.translatesAutoresizingMaskIntoConstraints = false
        lab.text = "Как долго планируем балдеть?"
        lab.font = .boldSystemFont(ofSize: 18)
        lab.textColor = UIColor(named: "otherColor")
        
        return lab
    }()
    
    //MARK: - timeStackViewVertical
    private let timeStackViewVertical: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        stack.distribution = .fillEqually
        stack.spacing = -13
        
        return stack
    }()
    
    //MARK: - recipeLabel
    private let recipeLabel: UILabel = {
        let lab = UILabel()
        lab.translatesAutoresizingMaskIntoConstraints = false
        lab.text = "Ваш рецепт идеальной посиделки"
        lab.font = .boldSystemFont(ofSize: 18)
        lab.textColor = UIColor(named: "otherColor")
        
        return lab
    }()
    
    //MARK: - containerWeight
    private let containerWeight: UIView = {
        let container = UIView()
        container.translatesAutoresizingMaskIntoConstraints = false
        container.clipsToBounds = true
        
        return container
    }()
    
    //MARK: - weightLabel
    private let weightLabel: UILabel = {
        let lab = UILabel()
        lab.translatesAutoresizingMaskIntoConstraints = false
        lab.textColor = .white
        lab.textAlignment = .center
        lab.backgroundColor = .clear
        lab.font = .boldSystemFont(ofSize: 18)
        
        return lab
    }()
    
    //MARK: - weightLayer
    private let weightLayer: CAGradientLayer = {
        let layer = CAGradientLayer()
        
        //colors
        let firstColor = #colorLiteral(red: 0.9995197654, green: 0.7011556029, blue: 0.2833247483, alpha: 1).cgColor
        let secondColor =  #colorLiteral(red: 0.9308266044, green: 0.3063942194, blue: 0.1038768366, alpha: 1).cgColor
        
        layer.colors = [firstColor,
                        secondColor]
        layer.startPoint = .init(x: 0, y: 1)
        layer.endPoint = .init(x: 0.6, y: 1)
        
        return layer
    }()
    
    //MARK: - propertyes
    private lazy var countPersonConst = countPersonLabel.leadingAnchor.constraint(
        equalTo: contentView.leadingAnchor,
        constant: 15)
    
    private lazy var meatCollectioViewConst = meatCollectioView.heightAnchor.constraint(
        equalToConstant: lengthCollectionView())
    
    
    //MARK: - viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(named: "backgroundColor")
        title = "Калькулятор мяса"
        createUI()
    }
    
    //MARK: - viewWillLayoutSubviews
    override func viewWillLayoutSubviews() {
        super .viewWillLayoutSubviews()
        meatCollectioViewConst.constant = lengthCollectionView()
        gradientLayer.frame.size = CGSize(width: view.frame.width - 32, height: 60)
        randomMeatButton.setNeedsDisplay()
        weightLayer.frame.size = CGSize(width: view.frame.width - 32, height: 80)
        containerWeight.setNeedsDisplay()
        personSlider.setNeedsDisplay()
        hungerSlider.setNeedsDisplay()
    }
    
    //MARK: - createUI
    private func createUI() {
        //constraints scrollView
        view.addSubview(scrollView)
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            scrollView.trailingAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            scrollView.bottomAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.bottomAnchor),
        ])
        
        //constraints contentView
        scrollView.addSubview(contentView)
        NSLayoutConstraint.activate([
            contentView.topAnchor.constraint(
                equalTo: scrollView.topAnchor),
            contentView.leadingAnchor.constraint(
                equalTo: scrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(
                equalTo: scrollView.trailingAnchor),
            contentView.bottomAnchor.constraint(
                equalTo: scrollView.bottomAnchor),
            contentView.widthAnchor.constraint(
                equalTo: scrollView.widthAnchor)
        ])
        
        //constraints personCount
        contentView.addSubview(personsLabel)
        NSLayoutConstraint.activate([
            personsLabel.topAnchor.constraint(
                equalTo: contentView.topAnchor,
                constant: 40),
            personsLabel.leadingAnchor.constraint(
                equalTo: contentView.leadingAnchor,
                constant: 16)
        ])
        
        //constraints countPersonLabel
        contentView.addSubview(countPersonLabel)
        NSLayoutConstraint.activate([
            countPersonLabel.topAnchor.constraint(
                equalTo: personsLabel.bottomAnchor,
                constant: 8),
            countPersonConst,
            countPersonLabel.widthAnchor.constraint(
                equalToConstant: 50)
        ])
        
        //constraints personSlider
        scrollView.addSubview(personSlider)
        NSLayoutConstraint.activate([
            personSlider.topAnchor.constraint(
                equalTo: countPersonLabel.bottomAnchor,
                constant: 4),
            personSlider.leadingAnchor.constraint(
                equalTo: contentView.leadingAnchor,
                constant: 16),
            personSlider.trailingAnchor.constraint(
                equalTo: contentView.trailingAnchor,
                constant: -16),
            personSlider.heightAnchor.constraint(
                equalToConstant: 50)
        ])
        
        //constraints meatLabel
        contentView.addSubview(meatLabel)
        NSLayoutConstraint.activate([
            meatLabel.topAnchor.constraint(
                equalTo: personSlider.bottomAnchor,
                constant: 24),
            meatLabel.leadingAnchor.constraint(
                equalTo: personsLabel.leadingAnchor),
        ])
        
        //constraints meatCollectioView
        contentView.addSubview(meatCollectioView)
        NSLayoutConstraint.activate([
            meatCollectioView.topAnchor.constraint(
                equalTo: meatLabel.bottomAnchor,
                constant: 8),
            meatCollectioView.leadingAnchor.constraint(
                equalTo: contentView.leadingAnchor,
                constant: 16),
            meatCollectioView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            meatCollectioViewConst
        ])
        
        //constraints randomMeatButton
        contentView.addSubview(randomMeatButton)
        NSLayoutConstraint.activate([
            randomMeatButton.topAnchor.constraint(
                equalTo: meatCollectioView.bottomAnchor,
                constant: 24),
            randomMeatButton.leadingAnchor.constraint(
                equalTo: contentView.leadingAnchor,
                constant: 16),
            randomMeatButton.trailingAnchor.constraint(
                equalTo: contentView.trailingAnchor,
                constant: -16),
            randomMeatButton.heightAnchor.constraint(equalToConstant: 60),
        ])
        gradientLayer.frame = randomMeatButton.frame
        randomMeatButton.layer.insertSublayer(gradientLayer, at: 0)
        
        //добавления действия на нажатие
        randomMeatButton.addTarget(self,
                                   action: #selector(randomButtonTouch), for: .touchUpInside)
        
        //constraints hungerLabel
        contentView.addSubview(hungerLabel)
        NSLayoutConstraint.activate([
            hungerLabel.topAnchor.constraint(
                equalTo: randomMeatButton.bottomAnchor,
                constant: 32),
            hungerLabel.leadingAnchor.constraint(
                equalTo: meatLabel.leadingAnchor)
        ])
        
        //constraints hungerSlider
        contentView.addSubview(hungerSlider)
        NSLayoutConstraint.activate([
            hungerSlider.topAnchor.constraint(
                equalTo: hungerLabel.bottomAnchor,
                constant: 16),
            hungerSlider.leadingAnchor.constraint(
                equalTo: personSlider.leadingAnchor),
            hungerSlider.trailingAnchor.constraint(
                equalTo: personSlider.trailingAnchor),
            hungerSlider.heightAnchor.constraint(
                equalToConstant: 50)
        ])
             
        //constrants timeLabel
        contentView.addSubview(timeLabel)
        NSLayoutConstraint.activate([
            timeLabel.topAnchor.constraint(
                equalTo: hungerSlider.bottomAnchor,
                constant: 32),
            timeLabel.leadingAnchor.constraint(
                equalTo: hungerLabel.leadingAnchor)
        ])
        
        //constrants timeStackViewVertical
        contentView.addSubview(timeStackViewVertical)
        NSLayoutConstraint.activate([
            timeStackViewVertical.topAnchor.constraint(
                equalTo: timeLabel.bottomAnchor,
                constant: 8),
            timeStackViewVertical.leadingAnchor.constraint(
                equalTo: timeLabel.leadingAnchor),
            timeStackViewVertical.trailingAnchor.constraint(
                equalTo: contentView.trailingAnchor,
                constant: -8),
            timeStackViewVertical.heightAnchor.constraint(
                equalToConstant: 120)
        ])
        
        createTimeStackView()
        
        //constraints recipeLabel
        contentView.addSubview(recipeLabel)
        NSLayoutConstraint.activate([
            recipeLabel.topAnchor.constraint(
                equalTo: timeStackViewVertical.bottomAnchor,
                constant: 24),
            recipeLabel.leadingAnchor.constraint(
                equalTo: timeLabel.leadingAnchor),
            recipeLabel.trailingAnchor.constraint(
                equalTo: contentView.trailingAnchor,
                constant: -16),
            recipeLabel.heightAnchor.constraint(
                equalToConstant: 16),
        ])
        
        //constraints containerWeight
        contentView.addSubview(containerWeight)
        NSLayoutConstraint.activate([
            containerWeight.topAnchor.constraint(
                equalTo: recipeLabel.bottomAnchor,
                constant: 28),
            containerWeight.leadingAnchor.constraint(
                equalTo: contentView.leadingAnchor,
                constant: 16),
            containerWeight.trailingAnchor.constraint(
                equalTo: contentView.trailingAnchor,
                constant: -16),
            containerWeight.heightAnchor.constraint(
                equalToConstant: 60),
            containerWeight.bottomAnchor.constraint(
                equalTo: contentView.bottomAnchor,
                constant: -32)
        ])
        
        containerWeight.frame.size = CGSize(
            width: view.frame.width - 32, height: 60)
        containerWeight.layer.cornerRadius = containerWeight.frame.height/2
        weightLayer.frame.size = containerWeight.frame.size
        containerWeight.layer.insertSublayer(weightLayer, at: 0)
        
        //constraints weightLabel
        containerWeight.addSubview(weightLabel)
        NSLayoutConstraint.activate([
            weightLabel.topAnchor.constraint(
                equalTo: recipeLabel.bottomAnchor,
                constant: 28),
            weightLabel.leadingAnchor.constraint(
                equalTo: contentView.leadingAnchor,
                constant: 16),
            weightLabel.trailingAnchor.constraint(
                equalTo: contentView.trailingAnchor,
                constant: -16),
            weightLabel.heightAnchor.constraint(
                equalToConstant: 60),
            weightLabel.bottomAnchor.constraint(
                equalTo: contentView.bottomAnchor,
                constant: -32)
        ])
    }
    
    //MARK: - createLayout
    private func createLayout() -> UICollectionViewLayout {
        UICollectionViewCompositionalLayout { sectionIndex, env in
            switch sectionIndex {
            case .zero:
                let itemSize = NSCollectionLayoutSize(widthDimension: .absolute(100), heightDimension: .absolute(100))
                let item = NSCollectionLayoutItem(layoutSize: itemSize)
                item.edgeSpacing = .init(leading: nil, top: .fixed(16), trailing: nil, bottom: nil)
                
                let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .estimated(10))
                let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
                group.interItemSpacing = .flexible(8)
                
                let section = NSCollectionLayoutSection(group: group)
                
                return section
            default:
                return NSCollectionLayoutSection(group: NSCollectionLayoutGroup(layoutSize: NSCollectionLayoutSize(widthDimension: .absolute(0), heightDimension: .absolute(0))))
            }
        }
        
    }
    
    //MARK: - lengthCollectionView
    private func lengthCollectionView() -> CGFloat {
        guard let meat = viewModel?.meatArray else { return .zero }
        
        let itemSize: CGFloat = 100
        let widthScreen = view.frame.width - 32
        let space: CGFloat = 8
        let spaceTop: CGFloat = 16
        var totalLines: CGFloat = 1
        var currentWidth: CGFloat = .zero
        
        for _ in meat {
            //поместится ли элемент
            if currentWidth < widthScreen {
                currentWidth += itemSize + space
            }
            
            //если элемент больше ширины экрана, добавим новую линию
            if currentWidth > widthScreen {
                currentWidth = .zero
                currentWidth = itemSize
                totalLines += 1
            } else if currentWidth == widthScreen {
                currentWidth = 0
                totalLines += 1
            }
        }
        
        return (itemSize * totalLines) + (totalLines * spaceTop)
    }
    
    //MARK: - createTimeStackView
    private func createTimeStackView() {
        //цикл определяет, сколько будет линиий с едой
        for index in 0...2 {
            let timeStackViewHorizontal: UIStackView =  {
                let stack = UIStackView()
                stack.translatesAutoresizingMaskIntoConstraints = false
                stack.axis = .horizontal
                stack.distribution = .fill
                stack.spacing = 8
                stack.layoutMargins = UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)
                stack.isLayoutMarginsRelativeArrangement = true
                
                return stack
            }()
            
            let image1 = UIImage(systemName: "circle")
            var image2 = UIImage(named: "Fire")
            image2 = image2?.scaled(to: CGSize(width: 25, height: 25))
            
            let gesture = UITapGestureRecognizer()
            gesture.addTarget(self, action: #selector(selectTime(sender:)))
            
            let button = UIButton()
            button.imageView?.contentMode = .scaleAspectFit
            button.setBackgroundImage(image1,
                                      for: .normal)
            button.widthAnchor.constraint(equalToConstant: 35).isActive = true
            button.tintColor = .orange
            button.tag = index
            button.addTarget(self, action: #selector(selectTime(sender:)), for: .touchUpInside)
            
            //select
            if index == 0 {
                button.setImage(image2, for: .normal)
            }
            
            let titleLabel = UILabel()
            titleLabel.numberOfLines = 2
            titleLabel.lineBreakMode = .byWordWrapping
            titleLabel.text = viewModel?.getTime(index: button.tag)
            titleLabel.tag = index
            titleLabel.isUserInteractionEnabled = true
            titleLabel.addGestureRecognizer(gesture)
            titleLabel.textColor = UIColor(named: "otherColor")
            
            timeStackViewHorizontal.addArrangedSubview(button)
            timeStackViewHorizontal.addArrangedSubview(titleLabel)
            timeStackViewVertical.addArrangedSubview(timeStackViewHorizontal)
        }
    }
    
    //MARK: - randomButtonTouch
    @objc private func randomButtonTouch() {
        guard let vm = viewModel else { return }
        let number = Int.random(in: 0...vm.meatArray.count - 1)
        
        //убираем выбор
        for item in 0...(viewModel?.meatArray.count ?? 0) - 1 {
            guard let cell = meatCollectioView.cellForItem(at: IndexPath(item: item, section: .zero)) else { return }
            
            if cell.contentView.layer.sublayers?.count == 2 {
                cell.contentView.layer.sublayers?.remove(at: 0)
            }
        }
        
        //ставим выбор мяса
        guard let cell = meatCollectioView.cellForItem(at: IndexPath(row: number, section: .zero)) as? MeatCollectionViewCell else { return }
        cell.select()
        
        //определяем какое мясо выбранно
        switch number {
        case .zero:
            vm.meatModel.meat = .cow
        case 1:
            vm.meatModel.meat = .pig
        case 2:
            vm.meatModel.meat = .sheep
        case 3:
            vm.meatModel.meat = .chicken
        case 4:
            vm.meatModel.meat = .turkey
        case 5:
            vm.meatModel.meat = .vegetables
        default:
            break
        }
        updateWeight()
    }
    
    //MARK: - selectTime
    @objc func selectTime(sender: Any) {
        var imageFire = UIImage(named: "Fire")
        imageFire = imageFire?.scaled(to: CGSize(width: 25, height: 25))
        var index = 0
        
        if let tap = sender as? UITapGestureRecognizer {
            index = tap.view?.tag ?? 0
        } else {
            guard let button = sender as? UIButton else { return }
            index = button.tag
        }
        
        //скидываем предыдуший выбор
        for item in 0...2 {
            guard let horizontalStack = timeStackViewVertical.arrangedSubviews[item] as? UIStackView else { return }
            guard let button = horizontalStack.arrangedSubviews[0] as? UIButton else { return }
            button.setImage(UIImage(), for: .normal)
            
            if index == item {
                button.setImage(imageFire, for: .normal)
            }
        }
    
        switch index {
        case .zero:
            viewModel?.meatModel.time = .easy
        case 1:
            viewModel?.meatModel.time = .normal
        case 2:
            viewModel?.meatModel.time = .hard
        default:
            break
        }
        updateWeight()
        
        let generator = UISelectionFeedbackGenerator()
        generator.selectionChanged()
    }
    
    //MARK: - updateWeight
    private func updateWeight() {
        if let vm = viewModel {
            weightLabel.text = vm.resultMeat()
        }
    }
    
}

extension MainViewController: PersonSliderDelegate,
                              UICollectionViewDelegate,
                              UICollectionViewDataSource,
                              MeatCollectionViewCellDelegate,
                              HungerSliderDelegate {
    
    //MARK: - PersonSliderDelegate
    func getPersonCount(person: Int,
                        location: CGFloat) {
        if Int(countPersonLabel.text ?? "0") != person {
            viewModel?.meatModel.person = person
            updateWeight()
            
            let generator = UISelectionFeedbackGenerator()
            generator.selectionChanged()
        }
        countPersonLabel.text = "\(person)"
        countPersonConst.constant = location - 10
    }
    
    //MARK: - DataSource
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel?.meatArray.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MeatCollectionViewCell.identifier, for: indexPath) as? MeatCollectionViewCell else { return UICollectionViewCell() }
        
        if let vm = viewModel {
            cell.config(titleButton: vm.meatArray[indexPath.row])
            cell.tag = indexPath.row
            cell.delegate = self
        }
        
        if indexPath.row == 0 {
            let firstColor = #colorLiteral(red: 0.9995197654, green: 0.7011556029, blue: 0.2833247483, alpha: 1).cgColor
            let secondColor =  #colorLiteral(red: 0.9308266044, green: 0.3063942194, blue: 0.1038768366, alpha: 1).cgColor
            
            //layers
            let layer = CAGradientLayer()
            layer.colors = [firstColor,
                            secondColor]
            layer.frame = cell.contentView.frame
            layer.startPoint = .init(x: 0, y: 1)
            layer.endPoint = .init(x: 0.6, y: 1)
            cell.contentView.layer.insertSublayer(layer, at: 0)
        }
        
        return cell
    }
    
    //MARK: - HungerSliderDelegate
    func getHunger(hunger: Lavel) {
        let oldValue = viewModel?.meatModel.hunger
        if oldValue != hunger {
            viewModel?.meatModel.hunger = hunger
            updateWeight()

            //вибрация
            let generator = UISelectionFeedbackGenerator()
            generator.selectionChanged()
        }
    }
    
    //MARK: - MeatCollectionViewCellDelegate
    func cellWasSelect(index: Int) {
        for item in 0...(viewModel?.meatArray.count ?? 0) - 1 {
            guard let cell = meatCollectioView.cellForItem(at: IndexPath(item: item, section: .zero)) else { return }
            
            if cell.contentView.layer.sublayers?.count == 2 {
                cell.contentView.layer.sublayers?.remove(at: 0)
            }
        }
        guard let vm = viewModel else { return }
        
        //определяем какое мясо выбранно
        switch index {
        case .zero:
            vm.meatModel.meat = .cow
        case 1:
            vm.meatModel.meat = .pig
        case 2:
            vm.meatModel.meat = .sheep
        case 3:
            vm.meatModel.meat = .chicken
        case 4:
            vm.meatModel.meat = .turkey
        case 5:
            vm.meatModel.meat = .vegetables
        default:
            break
        }
        updateWeight()
    }
}

