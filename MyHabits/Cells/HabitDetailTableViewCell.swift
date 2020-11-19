//
//  HabitDetailTableViewCell.swift
//  MyHabits
//
//  Created by Stanislav Leontyev on 09.11.2020.
//

import UIKit

class HabitDetailTableViewCell: UITableViewCell {

     lazy var dateLabel: UILabel = {
        let label: UILabel = UILabel()
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 17, weight: .regular)
        return label
    }()

    func setupLayout() {

        contentView.addSubviews(dateLabel)

        NSLayoutConstraint.activate([

            dateLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            dateLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            dateLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
            dateLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -16)

        ])
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        setupLayout()
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
