//
//  NewSimpleCollectionViewController.swift
//  SeSAC3FreeImages
//
//  Created by Taekwon Lee on 2023/09/14.
//

import UIKit

final class NewSimpleCollectionViewController: UIViewController {

    enum Section: Int, CaseIterable {
        case first = 1
        case second = 2
    }

    private var viewModel = NewSimpleViewModel()

    private var collectionView = UICollectionView(frame: .zero, collectionViewLayout: createLayout())
    private var cellRegistration: UICollectionView.CellRegistration<UICollectionViewListCell, User>!
    private var dataSource: UICollectionViewDiffableDataSource<Section, User>!

    override func viewDidLoad() {
        super.viewDidLoad()

        let searchBar = UISearchBar()
        navigationItem.titleView = searchBar
        searchBar.delegate = self

        view.addSubview(collectionView)
        collectionView.delegate = self

        setConstraints()
        configureDataSource()

        viewModel.append()

        viewModel.list.bind { [weak self] _ in
            self?.updateSnapShot()
        }

        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            self.viewModel.append()
        }
    }

    private static func createLayout() -> UICollectionViewLayout {
        var configuration = UICollectionLayoutListConfiguration(appearance: .insetGrouped)
        configuration.showsSeparators = false
        configuration.backgroundColor = .systemGray6
        let layout = UICollectionViewCompositionalLayout.list(using: configuration)
        return layout
    }

    private func configureDataSource() {

        //MARK: CellRegistration

        // @available(iOS 14.0, *)
        // UICollectionView.CellRegistration<Cell, Item>
        // 메서드 대신 제네릭을 사용하며, 셀이 생성할 때마다 클로저를 호출
        let cellRegistration = UICollectionView.CellRegistration<UICollectionViewListCell, User>(handler: { cell, indexPath, itemIdentifier in
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

        //MARK: DiffableDataSource

        dataSource = UICollectionViewDiffableDataSource<Section, User>(collectionView: collectionView, cellProvider: { collectionView, indexPath, itemIdentifier in

            let cell = collectionView.dequeueConfiguredReusableCell(using: cellRegistration, for: indexPath, item: itemIdentifier)
            return cell
        })
    }

    private func updateSnapShot() {
        var snapshot = NSDiffableDataSourceSnapshot<Section, User>()

        snapshot.appendSections(Section.allCases)
        snapshot.appendItems(viewModel.list.value, toSection: .first)
        snapshot.appendItems(viewModel.list2, toSection: .second)

        // by String
        //snapshot.appendSections(["andy", "noah"])
        //snapshot.appendItems(list, toSection: "andy")
        //snapshot.appendItems(list2, toSection: "noah")

        dataSource.apply(snapshot)
    }

    private func setConstraints() {
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
    }
}

//MARK: UICollectionViewDelegate

extension NewSimpleCollectionViewController: UICollectionViewDelegate {

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        //let user = viewModel.list.value[indexPath.item]
        
        guard let user = dataSource.itemIdentifier(for: indexPath) else { return }
        dump(user)
        
        //viewModel.removeUser(index: indexPath.item)
    }

}

//MARK: UISearchBarDelegate

extension NewSimpleCollectionViewController: UISearchBarDelegate {

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let text = searchBar.text else { return }
        viewModel.insertUser(name: text)
    }
    
}

/* 기존 방식 collectionView & dequeueConfiguredReusableCell

 collectionView.delegate = self
 collectionView.dataSource = self

 extension NewSimpleCollectionViewController: UICollectionViewDelegate, UICollectionViewDataSource {

     func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
         return list.count
     }

     func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
         let cell = collectionView.dequeueConfiguredReusableCell(using: cellRegistration, for: indexPath, item: list[indexPath.item])
         return cell
     }
 }

 */
