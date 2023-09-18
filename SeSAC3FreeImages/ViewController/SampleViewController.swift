//
//  SampleViewController.swift
//  SeSAC3FreeImages
//
//  Created by Taekwon Lee on 2023/09/12.
//

import UIKit

final class SampleViewController: UIViewController {
    
    @IBOutlet private var tableView: UITableView!
    
    let viewModel = SampleViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        var num1 = 10
        var num2 = 3
        
        print(num1 - num2) // 7
        
        // Data가 변경 되어도 기존에는 알 수가 없다
        num1 = 4
        num2 = 1
        
        let num3 = Observable(10)
        let num4 = Observable(3)
        
        // MVVM은 기존과 다르게 데이터가 변경될 때마다 양방향으로 실행되고 있다
        num3.bind { num in
            print("Observable", num3.value - num4.value)
            
        }
        
        num3.value = 100
        num3.value = 500
        num3.value = 50
        
        tableView.delegate = self
        tableView.dataSource = self
    }
}

extension SampleViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRowsInSection
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: "sampleCell")!
//        let data = viewModel.cellForRowAt(at: indexPath)
//        cell.textLabel?.text = data.introduce
        
        // UIListContentConfiguration
        // withIdentifier를 사용할 필요가 없다
        let cell = UITableViewCell()
        var content = cell.defaultContentConfiguration() // returns UIListContentConfiguration (which is struct)
        content.text = "TEST"
        content.secondaryText = "Hello \(indexPath.row)" // detailTextLabel
        cell.contentConfiguration = content // Protocol as Type
        
        return cell
    }
}
