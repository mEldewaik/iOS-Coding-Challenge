//
//  ViewController.swift
//  iOS_Challenge
//
//  Created by Mohamed Eldewaik on 9/25/19.
//  Copyright © 2019 Mohamed Eldewaik. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var items = [
        "Apple Music",
        "iTunes Music",
        "iOS Apps",
        "Audiobooks",
        "Books",
        "TV Shows",
        "Movies",
        "iTunes U",
        "Prodcasts",
        "Music Videos"
    ]
    
    var itemsValue = [
        "apple-music/coming-soon",
        "itunes-music/hot-tracks",
        "ios-apps/new-apps-we-love",
        "audiobooks/top-audiobooks",
        "books/top-free",
        "tv-shows/top-tv-episodes",
        "movies/top-movies",
        "itunes-u/top-itunes-u-courses",
        "podcasts/top-podcasts",
        "music-videos/top-music-videos"
    ]
    
    let screenSize: CGRect = UIScreen.main.bounds
    
    
    // ------------------ Create tableView ------------------------------------ //
    
    fileprivate let tableView: UITableView = {
        let tv = UITableView(frame: .zero)
        tv.register(AppleCell.self, forCellReuseIdentifier: "MyCell")
        tv.translatesAutoresizingMaskIntoConstraints = false
        tv.separatorInset = .zero
        tv.contentInset = .zero
        tv.tableFooterView = UIView()
        tv.separatorStyle = .singleLine
        return tv
    }()
    
    func initTableView() {
        self.view.addSubview(tableView)
        tableView.dataSource = self
        tableView.delegate = self
        
        tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 55).isActive = true
        tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 0).isActive = true
        tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: 0).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: 0).isActive = true
    }
    
    // ---------------------------------------------------------------------- //
    
    
    // --------- Create collectionView in the top of viewController ----------//
    
    var selectedCollectionCell = 0
    
    fileprivate let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.register(MediaTypeCell.self, forCellWithReuseIdentifier: "collectionCell")
        return cv
    }()
    
    
    func createCollectionView() {
        view.addSubview(collectionView)
        
        collectionView.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0).isActive = true
        collectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 0).isActive = true
        collectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: 0).isActive = true
        collectionView.heightAnchor.constraint(equalToConstant: 50).isActive = true
    }
    
    // ---------------------------------------------------------------------- //
    
    // This model to parse data from api on it
    
    var model: AppleModel?
    
    
    var shownIndexes : [IndexPath] = []
    let heightOfCell : CGFloat = 116
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.initTableView()
        self.createCollectionView()
        self.getItunes(ForMediaType: self.itemsValue[self.selectedCollectionCell])
        
        self.view.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        
        self.setUpNavigation()
    }
    
    func setUpNavigation() {
        navigationItem.title = "iTunes Media"
        self.navigationController?.navigationBar.barTintColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        self.navigationController?.navigationBar.isTranslucent = false
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor:UIColor(red: 1, green: 1, blue: 1, alpha: 1)]
    }
    
    
    // Function that return Media Accourding to Medi type
    func getItunes(ForMediaType media: String) {
        Services.instance.getAppleMedia(view: self.view, forMediaType: media, numberOfResults: "10") { (returnedModel) in
            self.model = returnedModel
            self.tableView.reloadWithAnimation()
        }
    }
    
    
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.model?.feed?.results?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MyCell") as! AppleCell
        if let result = self.model?.feed?.results?[indexPath.row] {
            cell.configureCellData(result)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return heightOfCell
    }
    
}

extension ViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "collectionCell", for: indexPath) as! MediaTypeCell
        
        cell.mediaTitle = self.items[indexPath.item]
        
        if self.selectedCollectionCell == indexPath.item {
            cell.backgroundColor = #colorLiteral(red: 0.1607843137, green: 0.3137254902, blue: 0.6196078431, alpha: 1)
        }else{
            cell.backgroundColor = #colorLiteral(red: 0.768627451, green: 0.8039215686, blue: 0.8352941176, alpha: 1)
        }
        
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.selectedCollectionCell = indexPath.item
        self.getItunes(ForMediaType: self.itemsValue[self.selectedCollectionCell])
        self.collectionView.reloadData()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: screenSize.size.width / 3, height: collectionView.frame.size.height)
    }
    
}

