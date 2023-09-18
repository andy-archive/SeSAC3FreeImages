//
//  PhotoViewController.swift
//  SeSAC3FreeImages
//
//  Created by Taekwon Lee on 2023/09/12.
//

import UIKit

final class PhotoViewController: UIViewController {
    
    @IBOutlet private weak var collectionView: UICollectionView!
    
    private let viewModel = PhotoViewModel()
    private var dataSource: UICollectionViewDiffableDataSource<Int, PhotoResult>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let searchBar = UISearchBar()
        searchBar.delegate = self
        navigationItem.titleView = searchBar
        
        collectionView.collectionViewLayout = createLayout()
        configureDataSource()
        
        viewModel.list.bind { [weak self] _ in
            self?.updateSnapShot()
        }
    }
    
    private func updateSnapShot() {
        var snapshot = NSDiffableDataSourceSnapshot<Int, PhotoResult>()
        snapshot.appendSections([0])
        snapshot.appendItems(viewModel.list.value.results)
        dataSource.apply(snapshot)
    }
    
    private func createLayout() -> UICollectionViewLayout {
        var configuration = UICollectionLayoutListConfiguration(appearance: .insetGrouped)
        configuration.showsSeparators = false
        configuration.backgroundColor = .systemGray6
        let layout = UICollectionViewCompositionalLayout.list(using: configuration)
        return layout
    }
    
    private func configureDataSource() {
        
        let cellRegistration = UICollectionView.CellRegistration<UICollectionViewListCell, PhotoResult> { cell, indexPath, itemIdentifier in
            
            var content = UIListContentConfiguration.valueCell()
            content.text = "\(itemIdentifier.likes)"
            
            DispatchQueue.global().async {
                guard let url = URL(string: itemIdentifier.urls.thumb) else { return }
                
                do {
                    let data = try Data(contentsOf: url)
                    
                    DispatchQueue.main.async {
                        content.image = UIImage(data: data)
                        cell.contentConfiguration = content
                    }
                    
                } catch {
                    print(error)
                }
            }
        }
        
        dataSource = UICollectionViewDiffableDataSource(collectionView: collectionView, cellProvider: { collectionView, indexPath, itemIdentifier in
            
            let cell = collectionView.dequeueConfiguredReusableCell(using: cellRegistration, for: indexPath, item: itemIdentifier)
            return cell
        })
    }
}

//MARK: UISearchBarDelegate

extension PhotoViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let text = searchBar.text else { return }
        viewModel.fetchPhoto(text: text)
    }
    
}

/*
 func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    cell.imageView?.image = viewModel.uploadPhoto(url: data.urls)
    cell.imageView?.image = UIImage(systemName: "star")
 }
 
 tableView.delegate = self
 tableView.dataSource = self
 
 extension PhotoViewController: UITableViewDelegate, UITableViewDataSource {
     
     func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
         return viewModel.rowCount
     }
     
     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
         guard let cell = tableView.dequeueReusableCell(withIdentifier: "photoCell") else { return UITableViewCell() }
         
         let data = viewModel.cellForRowAt(at: indexPath)
         
         cell.backgroundColor = .systemGreen

         return cell
     }
 }
 */
