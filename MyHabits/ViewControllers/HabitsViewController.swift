//
//  HabitsViewController.swift
//  MyHabits
//
//  Created by Stanislav Leontyev on 03.11.2020.
//

import UIKit

class HabitsViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.tintColor = .customMagenta
        navigationItem.title = "Сегодня"
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(presentModallyHabitVC))
    }
    
    override func viewWillAppear(_ animated: Bool) {
        collectionView.reloadData()
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationItem.largeTitleDisplayMode = .always
    }
    
    
    //MARK: - Views
    
     private lazy var collectionView: UICollectionView = {
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        
        let collectionView: UICollectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        
        collectionView.register(ProgressCollectionViewCell.self, forCellWithReuseIdentifier: String(describing: ProgressCollectionViewCell.self))
        collectionView.register(HabitsCollectionViewCell.self, forCellWithReuseIdentifier: String(describing: HabitsCollectionViewCell.self)
        )
        
        collectionView.dataSource = self
        collectionView.delegate = self
        
        collectionView.backgroundColor = .systemGray6
        
        return collectionView
    }()
    
    //MARK: - Layout setup
    
    override func viewWillLayoutSubviews() {

        view.addSubviews(collectionView)
        
        NSLayoutConstraint.activate([
            
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
            
        ])
    }
    
    //MARK: - @objc methods
    
    @objc func presentModallyHabitVC() {
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        let habitVC = storyBoard.instantiateViewController(withIdentifier: String(describing: HabitViewController.self))
        let habitVCNavigationController = UINavigationController(rootViewController: habitVC)
        habitVCNavigationController.modalPresentationStyle = .fullScreen
        self.present(habitVCNavigationController, animated: true, completion: nil)

    }

}

    //MARK: - Extensions

extension HabitsViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let habit = HabitsStore.shared.habits[indexPath.item]
        Manager.shared.datesStringArray = Manager.shared.sendHabitToNewVC(habit: habit)
        Manager.shared.index = indexPath.item
        
        let destinationViewController = storyboard?.instantiateViewController(identifier: String(describing: HabitDetailViewController.self)) as! HabitDetailViewController
        destinationViewController.modalPresentationStyle = .fullScreen
        self.show(destinationViewController, sender: self)
    
    }
}

extension HabitsViewController: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if section == 0 {
            return 1
        } else {
            return HabitsStore.shared.habits.count
        }

    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if indexPath.section == 0 {
            
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: ProgressCollectionViewCell.self), for: indexPath) as! ProgressCollectionViewCell
            
            cell.updateProgressData()
            
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: HabitsCollectionViewCell.self), for: indexPath) as! HabitsCollectionViewCell
            
            cell.delegate = self
            
            cell.habit = HabitsStore.shared.habits[indexPath.item]
            let thisHabit = HabitsStore.shared.habits[indexPath.item]
            let trackedDates = Manager.shared.sendHabitToNewVC(habit: thisHabit)
            cell.repeatQuantityLabel.text = String("Подряд: \(trackedDates.count)")
            
            cell.checkButton.setBackgroundImage(.checkmark, for: .normal)
            
            if cell.habit?.isAlreadyTakenToday == true {
                cell.checkButton.tintColor = HabitsStore.shared.habits[indexPath.item].color
            } else {
                cell.checkButton.tintColor = .clear
            }
    
            return cell
        }
    }
    
}

extension HabitsViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_: UICollectionView, layout: UICollectionViewLayout, sizeForItemAt: IndexPath) -> CGSize {
        
        if sizeForItemAt.section == 0 {
            return CGSize(width: view.frame.width-32, height: 60)
        } else {
            return CGSize(width: view.frame.width-32, height: 130)
        }
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        if section == 0 {
           return UIEdgeInsets(top: 22, left: 0, bottom: 18, right: 0)
        } else {
            return UIEdgeInsets(top: 0, left: 0, bottom: 12, right: 0)
        }
    }
    
}

extension HabitsViewController: RefreshProgress {
    func refreshProgress() {
        collectionView.reloadData()
    }
}
