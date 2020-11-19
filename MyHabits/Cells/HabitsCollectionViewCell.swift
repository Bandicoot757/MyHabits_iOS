//
//  HabitsCollectionViewCell.swift
//  MyHabits
//
//  Created by Stanislav Leontyev on 06.11.2020.
//

import UIKit

class HabitsCollectionViewCell: UICollectionViewCell {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayout()
        contentView.backgroundColor = .white
        if habit?.isAlreadyTakenToday == true {
            checkButton.backgroundColor = habit?.color
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var delegate: RefreshProgress?
    
    var habit: Habit? {
        didSet {
            guard let habits = habit else { return }
            nameLabel.text = habits.name
            nameLabel.textColor = habits.color
            timeLabel.text = habits.dateString
            checkButton.layer.borderColor = habits.color.cgColor
            checkButton.tintColor = habits.color
            
            if habits.isAlreadyTakenToday == true {
                checkButton.backgroundColor = habits.color
            } else {
                checkButton.backgroundColor = .white
            }
        }
    }
    
    private lazy var nameLabel: UILabel = {
        let label: UILabel = UILabel()
        label.numberOfLines = 2
        label.font = UIFont.systemFont(ofSize: 17, weight: .semibold)
        return label
    }()
    
    private lazy var timeLabel: UILabel = {
        let label: UILabel = UILabel()
        label.font = UIFont.systemFont(ofSize: 12, weight: .regular)
        label.textColor = .systemGray
        return label
    }()
    
    lazy var repeatQuantityLabel: UILabel = {
        let label: UILabel = UILabel()
        label.font = UIFont.systemFont(ofSize: 13, weight: .regular)
        label.textColor = .systemGray
        return label
    }()
    
    lazy var checkButton: UIButton = {
        let button: UIButton = UIButton()
        button.layer.cornerRadius = 18
        button.layer.borderWidth = 2
        button.layer.borderColor = UIColor.red.cgColor
        button.layer.masksToBounds = true
        button.addTarget(self, action: #selector(takeToday), for: .touchUpInside)
        return button
    }()
    
    func setupLayout() {
        
        self.layer.cornerRadius = 8
        self.layer.masksToBounds = true
        
        contentView.addSubviews(nameLabel)
        contentView.addSubviews(timeLabel)
        contentView.addSubviews(repeatQuantityLabel)
        contentView.addSubviews(checkButton)
        
        NSLayoutConstraint.activate([
        
            nameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            nameLabel.trailingAnchor.constraint(equalTo: checkButton.leadingAnchor, constant: -80),
            nameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20),
            nameLabel.bottomAnchor.constraint(equalTo: timeLabel.topAnchor, constant: -4),
            
            timeLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            timeLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            timeLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 4),
            
            repeatQuantityLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            repeatQuantityLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            repeatQuantityLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -20),
            
            checkButton.leadingAnchor.constraint(equalTo: nameLabel.trailingAnchor, constant: 100),
            checkButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -26),
            checkButton.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 47),
            checkButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -47),
            checkButton.widthAnchor.constraint(equalToConstant: 36),
            checkButton.heightAnchor.constraint(equalToConstant: 36)
        
        ])
    }

    @objc func takeToday() {
        if habit?.isAlreadyTakenToday == false {
            checkButton.setBackgroundImage(.checkmark, for: .normal)
            checkButton.tintColor = habit?.color
            checkButton.backgroundColor = habit?.color
            HabitsStore.shared.track(habit!)
            delegate?.refreshProgress()
            print(HabitsStore.shared.dates)
        }
    }
    
}
