//
//  PhotoViewModel.swift
//  SeSAC3FreeImages
//
//  Created by Taekwon Lee on 2023/09/12.
//

import Foundation

class PhotoViewModel {
    
    var list = Observable(
        Photo(total: 0, total_pages: 0, results: [])
    )
    
    var rowCount: Int{
        return list.value.results?.count ?? 0
    }
    
    func fetchPhoto() {
        APIService.shared.searchPhoto(query: "sky") { [weak self] photo in
            guard let photo = photo else {
                return
            }
            self?.list.value = photo
        }
    }
    
    func cellForRowAt(at indexPath: IndexPath) -> PhotoResult {
        return list.value.results![indexPath.row]
    }
}
