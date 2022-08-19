//
//  SettingsViewController.swift
//  NasaApp
//
//  Created by Владислав Моисеев on 21.07.2022.
//

import UIKit

class SettingsViewController: UIViewController {

    let roversArray = ["Spirit", "Opportunity", "Curiosity", "Perseverance"]
    let roverName: String? = ""
    let camersView = CamerasViewController()
    
    private let settingsTableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.estimatedRowHeight = 43
        tableView.register(SettingsTableViewCell.self, forCellReuseIdentifier: SettingsTableViewCell.identifier)
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    private func setupUI() {
        view.backgroundColor = .white
        setupNavigationController(topTitle: "ВЫБИРАЕМ", bottomTitle: "Марсоходы")
        settingTableView()
    }
    
    private func setupNavigationController(topTitle: String?, bottomTitle: String?) {
        title = bottomTitle
        navigationController?.navigationBar.prefersLargeTitles = true
        
        if let navigationBar = self.navigationController?.navigationBar {
            let topLable = UILabel()
            topLable.text = topTitle
            topLable.textColor = #colorLiteral(red: 0.7215686275, green: 0.7607843137, blue: 0.8, alpha: 1)
            topLable.font = UIFont(name: "Helvetica", size: 11)
            topLable.font = UIFont.boldSystemFont(ofSize: 11)
            topLable.translatesAutoresizingMaskIntoConstraints = false
            
            navigationBar.addSubview(topLable)
            topLable.leftAnchor.constraint(equalTo: navigationBar.leftAnchor, constant: 16).isActive = true
            topLable.topAnchor.constraint(equalTo: navigationBar.topAnchor, constant: 22).isActive = true
            topLable.widthAnchor.constraint(equalToConstant: 70).isActive = true
            topLable.heightAnchor.constraint(equalToConstant: 12).isActive = true
        }
    }
    
    private func settingTableView() {
        view.addSubview(settingsTableView)
        settingsTableView.frame = view.bounds
        settingsTableView.dataSource = self
        settingsTableView.delegate = self
    }
}

extension SettingsViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return roversArray.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 43
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: SettingsTableViewCell.identifier, for: indexPath) as? SettingsTableViewCell else { return UITableViewCell() }
        cell.labelRover.text = roversArray[indexPath.row]
        cell.accessoryType = UITableViewCell.AccessoryType.none
        cell.selectionStyle = .none
        return cell
    }
}

extension SettingsViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let cell = tableView.cellForRow(at: indexPath) as? SettingsTableViewCell else { return }
        cell.accessoryView = UIImageView(image: UIImage(named: "checkbox"))
        RoverSettings.roverName = roversArray[indexPath.row]
        cell.labelRover.textColor = UIColor(named: "CustomPurple")
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        guard let cell = tableView.cellForRow(at: indexPath) as? SettingsTableViewCell else { return }
        cell.accessoryView = nil
        cell.labelRover.textColor = UIColor(named: "CustomBlack")
    }
}


