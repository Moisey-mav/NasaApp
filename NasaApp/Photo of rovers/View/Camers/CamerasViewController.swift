//
//  CamerasViewController.swift
//  NasaApp
//
//  Created by Владислав Моисеев on 21.07.2022.
//

import UIKit

class CamerasViewController: UIViewController {
    
    let constantFile = Constant()
    let urlRover = UrlRover()
    let networkDataFetcher = NetworkDataFetcher()
    
    public var roverName: String? = "Spirit"
    let date = "2017-5-26"
    
    private let navigationLabel: UILabel = {
        let label = UILabel()
        label.textColor = #colorLiteral(red: 0.7215686275, green: 0.7607843137, blue: 0.8, alpha: 1)
        label.font = UIFont(name: "Helvetica", size: 11)
        label.font = UIFont.boldSystemFont(ofSize: 11)
        return label
    }()
    
    private let arrowRight: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "arrow-right"), for: .normal)
        return button
    }()
    
    private let arrowLeft: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "arrow-left"), for: .normal)
        return button
    }()
    
    let camerasTableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.separatorStyle = UITableViewCell.SeparatorStyle.none
        tableView.backgroundColor = .white
        tableView.register(ImageTableViewCell.self, forCellReuseIdentifier: ImageTableViewCell.identifier)
        tableView.register(TitleHeaderTableView.self, forHeaderFooterViewReuseIdentifier: TitleHeaderTableView.identifier)
        return tableView
    }()
    
    private let activityIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView()
        indicator.hidesWhenStopped = true
        indicator.color = .black
        return indicator
    }()
    
    let errorLabel: UILabel = {
        let label = UILabel()
        label.text = "This rover \n has not images!"
        label.font = UIFont(name: "Helvetica-Bold", size: 25)
        label.alpha = 0.5
        label.textColor = .black
        label.textAlignment = .center
        label.numberOfLines = 2
        label.isHidden = true
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    private func setupUI() {
        view.backgroundColor = .white
        setupConstrain()
        patterns()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupTitle()
    }
   
    private func setupTitle() {
        navigationTitles(topTitle: "23.08.22")
        activityIndicator.startAnimating()
        networkData()
    }
    
    private func networkData() {
        let url = urlRover.setupData(name: roverName, earthDate: date, apiKey: constantFile.apiKey)
        networkDataFetcher.fetchData(url) { [weak self] in
            DispatchQueue.main.async {
                self?.nothingError()
                self?.activityIndicator.stopAnimating()
                self?.activityIndicator.isHidden = true
                self?.camerasTableView.reloadData()
            }
        }
    }
    
    private func nothingError() {
        let sectionsCount = networkDataFetcher.sections.count
        if sectionsCount == 0 {
            errorLabel.isHidden = false
        } else {
            errorLabel.isHidden = true
        }
    }
    
    private func patterns() {
        camerasTableView.dataSource = self
        camerasTableView.delegate = self
        networkDataFetcher.delegate = self
    }
    
    private func navigationTitles(topTitle: String?) {
        let name = RoverSettings.roverName
        if name != nil {
            title = name
            roverName = name ?? "Unknown rover"
        } else {
            title = roverName
        }
        navigationLabel.text = topTitle
        navigationController?.navigationBar.prefersLargeTitles = true
        titleConstraint()
    }
    
    private func titleConstraint() {
        guard let navigationBar = self.navigationController?.navigationBar else { return }
        navigationBar.addSubview(navigationLabel)
        navigationLabel.translatesAutoresizingMaskIntoConstraints = false
        navigationLabel.leftAnchor.constraint(equalTo: navigationBar.leftAnchor, constant: 16).isActive = true
        navigationLabel.topAnchor.constraint(equalTo: navigationBar.topAnchor, constant: 22).isActive = true
        navigationLabel.heightAnchor.constraint(equalToConstant: 12).isActive = true
        navigationLabel.widthAnchor.constraint(equalToConstant: 70).isActive = true
        
        navigationBar.addSubview(arrowLeft)
        arrowLeft.translatesAutoresizingMaskIntoConstraints = false
        arrowLeft.centerYAnchor.constraint(equalTo: navigationBar.centerYAnchor, constant: 20).isActive = true
        arrowLeft.rightAnchor.constraint(equalTo: navigationBar.rightAnchor, constant: -68).isActive = true
        arrowLeft.heightAnchor.constraint(equalToConstant: 24).isActive = true
        arrowLeft.widthAnchor.constraint(equalToConstant: 24).isActive = true
        
        navigationBar.addSubview(arrowRight)
        arrowRight.translatesAutoresizingMaskIntoConstraints = false
        arrowRight.centerYAnchor.constraint(equalTo: arrowLeft.centerYAnchor).isActive = true
        arrowRight.leftAnchor.constraint(equalTo: arrowLeft.rightAnchor, constant: 32).isActive = true
        arrowRight.heightAnchor.constraint(equalToConstant: 24).isActive = true
        arrowRight.widthAnchor.constraint(equalToConstant: 24).isActive = true
        
    }
    
    private func setupConstrain() {
        view.addSubview(camerasTableView)
        camerasTableView.frame = view.bounds
        
        view.addSubview(errorLabel)
        errorLabel.translatesAutoresizingMaskIntoConstraints = false
        errorLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        errorLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        view.addSubview(activityIndicator)
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
    }
}

extension CamerasViewController: UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return networkDataFetcher.sections.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ImageTableViewCell.identifier, for: indexPath) as? ImageTableViewCell else { return UITableViewCell() }
        cell.configure(with: networkDataFetcher.sections[indexPath.section])
        cell.selectionStyle = .none
        return cell
    }
}

extension CamerasViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 122
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 45
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let headerView = camerasTableView.dequeueReusableHeaderFooterView(withIdentifier: TitleHeaderTableView.identifier) as? TitleHeaderTableView else { return UITableViewHeaderFooterView() }
        switch networkDataFetcher.sections[section].template {
        case .photos(let camera):
            headerView.set(photoCamera: camera)
        }
        headerView.delegate = self
        return headerView
    }
}

extension CamerasViewController: NetworkDataDelegate {
    func refresh() {
        camerasTableView.reloadData()
    }
}

extension CamerasViewController: TitleDelegate {
    func did(select camera: Photo.Camera) {
        let vc = GalleryViewController()
        vc.cameraName = camera.name
        navigationController?.pushViewController(vc, animated: true)
    }
}





