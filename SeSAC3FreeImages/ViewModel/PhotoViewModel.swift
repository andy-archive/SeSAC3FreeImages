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
    
    func fetchPhoto(text: String) {
        APIService.shared.searchPhoto(query: text) { [weak self] photo in
            
            DispatchQueue.main.async {
                guard let photo = photo else { return }
                self?.list.value = photo
            }
            
        }
    }
    
    var rowCount: Int{
        return list.value.results.count
    }
    
    func cellForRowAt(at indexPath: IndexPath) -> PhotoResult {
        return list.value.results[indexPath.row]
    }
    
}
