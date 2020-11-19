//
//  ProgressCollectionViewCell.swift
//  MyHabits
//
//  Created by Stanislav Leontyev on 08.11.2020.
//

import UIKit

class ProgressCollectionViewCell: UICollectionViewCell {
    
    func updateProgressData() {
        progressView.setProgress(HabitsStore.shared.todayProgress, animated: true)
        progressPercentLabel.text = "\(String(Int(HabitsStore.shared.todayProgress * 100)))%"
    }
    
    private lazy var progressTitleLabel: UILabel = {
        let label: UILabel = UILabel()
        label.text = "Всё получится!"
        label.textColor = .systemGray
        label.font = UIFont.systemFont(ofSize: 13, weight: .semibold)
        return label
    }()
    
    private lazy var progressPercentLabel: UILabel = {
        let label: UILabel = UILabel()
        label.textColor = .systemGray
        label.font = UIFont.systemFont(ofSize: 13, weight: .semibold)
        return label
    }()
    
    private lazy var progressView: UIProgressView = {
        let progressView: UIProgressView = UIProgressView()
        progressView.layer.cornerRadius = 4
        return progressView
    }()
    
    func setupLayout() {
        
        self.layer.cornerRadius = 8
        self.layer.masksToBounds = true
        
        contentView.addSubviews(progressTitleLabel)
        contentView.addSubviews(progressPercentLabel)
        contentView.addSubviews(progressView)
        
        NSLayoutConstraint.activate([
            
            progressTitleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 12),
            progressTitleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            progressTitleLabel.bottomAnchor.constraint(equalTo: progressView.topAnchor, constant: -10),
            
            progressPercentLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -12),
            progressPercentLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            progressPercentLabel.bottomAnchor.constraint(equalTo: progressView.topAnchor, constant: -10),
            
            progressView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 12),
            progressView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -12),
            progressView.topAnchor.constraint(equalTo: progressTitleLabel.bottomAnchor, constant: -10),
            progressView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -15),
            progressView.heightAnchor.constraint(equalToConstant: 7)
            
        ])
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayout()
        contentView.backgroundColor = .white
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

