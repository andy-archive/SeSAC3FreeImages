//
//  NewSimpleCollectionViewController.swift
//  SeSAC3FreeImages
//
//  Created by Taekwon Lee on 2023/09/14.
//

import UIKit

final class NewSimpleCollectionViewController: UIViewController {

    private var collectionView = UICollectionView(frame: .zero, collectionViewLayout: createLayout())
    private var cellRegistration: UICollectionView.CellRegistration<UICollectionViewListCell, User>!

    var list = [
        User(name: "Hue", age: 23),
        User(name: "Jack", age: 21),
        User(name: "Bran", age: 20),
        User(name: "Kokojong", age: 20),
    ]

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(collectionView)
        collectionView.delegate = self
        collectionView.dataSource = self
        
        setLayout()

        // @available(iOS 14.0, *)
        // UICollectionView.CellRegistration<Cell, Item>
        // 메서드 대신 제네릭을 사용하며, 셀이 생성할 때마다 클로저를 호출
        cellRegistration = UICollectionView.CellRegistration(handler: { cell, indexPath, itemIdentifier in
            // 셀 디자인 및 데이터의 처리
            var content = UIListContentConfiguration.valueCell() //.subtitleCell()
            content.text = itemIdentifier.name
            content.textProperties.color = .brown
            content.secondaryText = "\(itemIdentifier.age)"
            content.textToSecondaryTextVerticalPadding = 20
            content.prefersSideBySideTextAndSecondaryText = false // cell 우측에서 text 아래로 이동
            content.image = UIImage(systemName: "star.fill")
            content.imageProperties.tintColor = .systemGreen
            content.imageToTextPadding = 30
            cell.contentConfiguration = content
            
            var backgroundConfiguration = UIBackgroundConfiguration.listPlainCell()
            backgroundConfiguration.backgroundColor = .systemGray5
            backgroundConfiguration.cornerRadius = 10
            backgroundConfiguration.strokeWidth = 2
            backgroundConfiguration.strokeColor = .systemBlue
            cell.backgroundConfiguration = backgroundConfiguration
        })
        
    }

    private static func createLayout() -> UICollectionViewLayout {
        var configuration = UICollectionLayoutListConfiguration(appearance: .insetGrouped)
        configuration.showsSeparators = false
        configuration.backgroundColor = .systemIndigo
        let layout = UICollectionViewCompositionalLayout.list(using: configuration)
        return layout
    }
    
    private func setLayout() {
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
    }
}

extension NewSimpleCollectionViewController: UICollectionViewDelegate, UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return list.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueConfiguredReusableCell(using: cellRegistration, for: indexPath, item: list[indexPath.item])
        return cell
    }
}
