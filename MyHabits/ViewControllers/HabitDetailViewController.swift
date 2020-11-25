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
        
        guard let index = Manager.shared.index else {
            return
        }
        self.navigationController?.navigationBar.tintColor = .customMagenta
        self.navigationItem.title = HabitsStore.shared.habits[index].name
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Править", style: .plain, target: self, action: #selector(showEditPage))
        self.navigationItem.leftBarButtonItem?.action = #selector(cancel)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationItem.largeTitleDisplayMode = .never
    }
    

    //MARK: - Views

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
        
        view.addSubviews(tableView)
        
        NSLayoutConstraint.activate([
            
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
            
        ])
    }
    
    @objc func cancel() {
        dismiss(animated: true, completion: nil)
    }
    
    @objc func showEditPage() {
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        let habitVC = storyBoard.instantiateViewController(withIdentifier: String(describing: HabitViewController.self)) as! HabitViewController
        let habitVCNavigationController = UINavigationController(rootViewController: habitVC)
        habitVC.deleteHabitButton.isHidden = false
        habitVCNavigationController.modalPresentationStyle = .fullScreen
        self.present(habitVCNavigationController, animated: true, completion: nil)
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
            cell.dateLabel.text = HabitsStore.shared.trackDateString(forIndex: indexPath.row)
        } else {
            cell.dateLabel.text = ""
        }
        
        return cell
    }
    
}
