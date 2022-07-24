//
//  CamersViewController.swift
//  NasaApp
//
//  Created by Владислав Моисеев on 21.07.2022.
//

import UIKit



class CamersViewController: UIViewController {
    
    let camersTableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.register(ImageTableViewCell.self, forCellReuseIdentifier: ImageTableViewCell.identifier)
        return tableView
    }()
    
    private var sections: [Section] = []
    public var roverName: String = "Curiosity"
    let camersArray = ["FRD", "FFF", "DOD", "LOL", "PPF"]
    let date = "2015-6-3"
    let constantFile = Constant()
    let urlRover = UrlRover()
    let networkDataFetcher = NetworkDataFetcher()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupTitleRover()
    }
    
    private func setupTitleRover() {
        if RoverSettings.roverName != roverName {
            title = RoverSettings.roverName
            roverName = RoverSettings.roverName
            networkData()
            camersTableView.reloadData()
        } else {
            title = RoverSettings.roverName
            roverName = RoverSettings.roverName
            networkData()
            camersTableView.reloadData()
        }
    }

    private func setupUI() {
        view.backgroundColor = .white
        setupNavigationController(topTitle: "23.08.22", bottomTitle: roverName)
        configureTableView()
    }
    
    private func networkData() {
        let url = urlRover.setupData(name: roverName, apiKey: constantFile.apiKey, earthDate: date)
        networkDataFetcher.fetchData(url)
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
    
    private func configureTableView() {
        view.addSubview(camersTableView)
        camersTableView.frame = view.bounds
        camersTableView.separatorStyle = UITableViewCell.SeparatorStyle.none
        camersTableView.backgroundColor = .white
        camersTableView.dataSource = self
        camersTableView.delegate = self
    }
}

extension CamersViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return camersArray.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ImageTableViewCell.identifier, for: indexPath) as? ImageTableViewCell else { return UITableViewCell() }
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
      return 122
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 45
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = TitleHeaderTableViewCell()
        headerView.cameraLabel.text = camersArray[section]
        headerView.indicatorImage.image = UIImage(named: "disclosure indicator")
        headerView.accessoryType = UITableViewCell.AccessoryType.none
        let tap = UITapGestureRecognizer(target: self, action: #selector(tappedHeader))
        headerView.addGestureRecognizer(tap)
        return headerView
    }
    
    @objc func tappedHeader() {
        let vc = GalleryViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
}


