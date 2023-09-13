//
//  PhotoViewController.swift
//  SeSAC3FreeImages
//
//  Created by Taekwon Lee on 2023/09/12.
//

import UIKit

final class PhotoViewController: UIViewController {
    
    @IBOutlet private var tableView: UITableView!
    
    var viewModel = PhotoViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel.list.bind { [weak self] _ in
            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }
            
        }
        
        viewModel.fetchPhoto()
        
        tableView.delegate = self
        tableView.dataSource = self
    }
    
}

extension PhotoViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.rowCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "photoCell") else { return UITableViewCell() }
        
        let data = viewModel.cellForRowAt(at: indexPath)
        
        cell.backgroundColor = .systemGreen
//        cell.imageView?.image = viewModel.uploadPhoto(url: data.urls)
//        cell.imageView?.image = UIImage(systemName: "star")
        
        return cell
    }
}
