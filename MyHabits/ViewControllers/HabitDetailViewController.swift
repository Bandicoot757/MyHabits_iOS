//
//  HabitDetailViewController.swift
//  MyHabits
//
//  Created by Stanislav Leontyev on 09.11.2020.
//

import UIKit

class HabitDetailViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    //MARK: - Views
    
     lazy var navigationBar: UINavigationBar = {
        let navigationBar: UINavigationBar = UINavigationBar()
        navigationBar.backgroundColor = .white
        navigationBar.barTintColor = .white
        navigationBar.tintColor = .customMagenta
        let navigationItem = UINavigationItem(title: "")
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Сегодня", style: .plain, target: self, action: #selector(cancel))
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Править", style: .plain, target: self, action: #selector(showEditPage))
        navigationBar.setItems([navigationItem], animated: false)
        return navigationBar
    }()

    lazy var tableView: UITableView = {
        let tableView: UITableView = UITableView()
        tableView.register(HabitDetailTableViewCell.self, forCellReuseIdentifier: String(describing: HabitDetailTableViewCell.self))
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = .systemGray6
        return tableView
    }()
    
    private lazy var dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.timeStyle = .short
        return formatter
    }()
    
    //MARK: - Layout setup

    override func viewWillLayoutSubviews() {
    
        view.addSubviews(navigationBar)
        view.addSubviews(tableView)
        
        NSLayoutConstraint.activate([
            
            navigationBar.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            navigationBar.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            navigationBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            navigationBar.heightAnchor.constraint(equalToConstant: 44),
            
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.topAnchor.constraint(equalTo: navigationBar.bottomAnchor, constant: 0),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
            
        ])
    }
    
    @objc func cancel() {
        dismiss(animated: true, completion: nil)
    }
    
    @objc func showEditPage() {
        
        let destinationViewController = storyboard?.instantiateViewController(identifier: String(describing: HabitViewController.self)) as! HabitViewController
        destinationViewController.modalPresentationStyle = .fullScreen
        
        let habit = HabitsStore.shared.habits[Manager.shared.index!]
        destinationViewController.nameTextField.text = habit.name
        destinationViewController.nameTextField.textColor = habit.color
        destinationViewController.colorButton.backgroundColor = habit.color
        destinationViewController.editDateLabel.text = habit.dateString
      
        var mutableTextlabel = NSMutableAttributedString()
        mutableTextlabel = NSMutableAttributedString(string: destinationViewController.editDateLabel.text!, attributes: [NSAttributedString.Key.font:UIFont.systemFont(ofSize: 17, weight: .regular)])
        mutableTextlabel.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor.customMagenta, range: NSRange(location:13, length: mutableTextlabel.length-13))
        destinationViewController.editDateLabel.attributedText = mutableTextlabel
        destinationViewController.deleteHabitButton.isHidden = false
        self.show(destinationViewController, sender: self)
    }

}

extension HabitDetailViewController: UITableViewDelegate {
    
}

    //MARK: - Extensions

extension HabitDetailViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let headerView = UIView()
        let headerLabel = UILabel()
        headerView.backgroundColor = .systemGray6
        headerLabel.text = "АКТИВНОСТЬ"
        headerLabel.font = UIFont.systemFont(ofSize: 13, weight: .regular)
        headerLabel.textColor = .systemGray
        
        self.view.addSubviews(headerView)
        headerView.addSubviews(headerLabel)
        
        NSLayoutConstraint.activate([
        
            headerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            headerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            headerLabel.leadingAnchor.constraint(equalTo: headerView.leadingAnchor, constant: 16),
            headerLabel.trailingAnchor.constraint(equalTo: headerView.trailingAnchor, constant: -16),
            headerLabel.topAnchor.constraint(equalTo: headerView.topAnchor, constant: 32),
            headerLabel.bottomAnchor.constraint(equalTo: headerView.bottomAnchor, constant: -8)
            
        ])
        
        return headerView
    }
    
    // Скрывает разделительные линии ниже используемых ячеек
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let emptyFooter = UIView()
        emptyFooter.backgroundColor = .systemGray6
        return emptyFooter
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Manager.shared.datesStringArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: HabitDetailTableViewCell.self), for: indexPath) as! HabitDetailTableViewCell
        
        if Manager.shared.datesStringArray.capacity != 0 {
            cell.dateLabel.text = Manager.shared.datesStringArray[indexPath.row]
        } else {
            cell.dateLabel.text = ""
        }
        
        return cell
    }
    
}
