//
//  ViewController.swift
//  ListCollectionView
//
//  Created by AzizOfficial on 3/1/22.
//

import UIKit

class ViewController: UIViewController {
    
    var dummies: [DummyModel] = []
    
    enum Section: Int, Hashable, CaseIterable, CustomStringConvertible  {
    case options, upnext
        var description: String {
            switch self {
            case .options: return "Options"
            case .upnext: return "Up Next"
            }
        }
    }
    
    var collectionView: UICollectionView!
    var dataSource: UICollectionViewDiffableDataSource<Section, DummyModel>!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        dummies.append(DummyModel.init(text: "Yeah", title: "C'mon"))
        dummies.append(DummyModel.init(text: "Yeah", title: "C'mon"))
        dummies.append(DummyModel.init(text: "Yeah", title: "C'mon"))
        dummies.append(DummyModel.init(text: "Yeah", title: "C'mon"))
        
        listViewSetup()
        configureDataSource()
        applyInitialSnapshots()
    }
}

extension ViewController {
    
    // 1. SETUP THE VIEW
    private func listViewSetup() {
        collectionView = UICollectionView.init(frame: view.bounds, collectionViewLayout: createLayout())
        collectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        collectionView.backgroundColor = .systemGroupedBackground
        collectionView.delegate = self
        view.addSubview(collectionView)
    }
    
    // 2.0 LAYOUT
    func createLayout() -> UICollectionViewLayout {
        let sectionProvider = { (sectionIndex: Int, layoutEnvironment: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection? in
            guard let sectionKind = Section(rawValue: sectionIndex) else { return nil }
            let section: NSCollectionLayoutSection
            
            if sectionKind == .options {
                section = NSCollectionLayoutSection.list(using: UICollectionLayoutListConfiguration(appearance: .insetGrouped), layoutEnvironment: layoutEnvironment)
                section.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 10, bottom: 0, trailing: 10)
            } else if sectionKind == .upnext {
                section = NSCollectionLayoutSection.list(using: UICollectionLayoutListConfiguration(appearance: .sidebar), layoutEnvironment: layoutEnvironment)
            } else {
                fatalError()
            }
            
            return section
        }
        return UICollectionViewCompositionalLayout(sectionProvider: sectionProvider)
    }
    
    // 3.0 Cell Registration
    func createListCellRegistration() -> UICollectionView.CellRegistration<UICollectionViewListCell, DummyModel> {
        return UICollectionView.CellRegistration<UICollectionViewListCell, DummyModel> { [weak self] (cell, indexPath, item) in
            guard let self = self else { return }
//            var content = UIListContentConfiguration.valueCell()
            var content = cell.defaultContentConfiguration()
//            content.text = self.dummies[indexPath.row].text
//            content.secondaryText = self.dummies[indexPath.row].title
            
            if indexPath.row == 0 {
                let switcher = UISwitch.init()
                switcher.addTarget(self, action: #selector(self.action), for: .valueChanged)
                cell.accessories = [.customView(configuration: UICellAccessory.CustomViewConfiguration.init(customView: switcher, placement: .trailing(displayed: .always)))]
                cell.isSelected = false
            }
            
            switch indexPath.row {
            case 0: content.secondaryText = "Fuck 1"
            case 1: content.secondaryText = "Fuck 2"
            case 2: content.secondaryText = "Fuck 3"
            case 3: content.secondaryText = "Fuck 4"
            case 4: content.secondaryText = "Fuck 5"
            default: content.secondaryText = "Fuck 1"
            }
            
            cell.contentConfiguration = content
        }
    }
    
    @objc func action(sender: UISwitch) {
        print(sender.isOn)
    }
    
    // 4.0 Data Source
    func configureDataSource() {
        
        // create registrations up front, then choose the appropriate one to use in the cell provider
        let listCellRegistration = createListCellRegistration()
        
        // data source
        dataSource = UICollectionViewDiffableDataSource<Section, DummyModel>(collectionView: collectionView) {
            (collectionView, indexPath, item) -> UICollectionViewCell? in
            guard let section = Section(rawValue: indexPath.section) else { fatalError("Unknown section") }
            switch section {
            case .options:
                return collectionView.dequeueConfiguredReusableCell(using: listCellRegistration, for: indexPath, item: item)
            case .upnext:
                return collectionView.dequeueConfiguredReusableCell(using: listCellRegistration, for: indexPath, item: item)
            }
        }
    }
    
    // 5.0 Snapshot
    func applyInitialSnapshots() {

        // set the order for our sections

        let sections = Section.allCases
        var snapshot = NSDiffableDataSourceSnapshot<Section, DummyModel>()
        snapshot.appendSections(sections)
        snapshot.appendItems(dummies, toSection: .options)
        dataSource.apply(snapshot, animatingDifferences: false)
        
//        // recents (orthogonal scroller)
//        let allSnapshot = NSDiffableDataSourceSectionSnapshot<DummyModel>()
//        let outlineSnapshot = NSDiffableDataSourceSectionSnapshot<DummyModel>()
//
//
//        dataSource.apply(allSnapshot, to: .options, animatingDifferences: false)
//        dataSource.apply(outlineSnapshot, to: .upnext, animatingDifferences: false)
        
        // prepopulate starred emojis
    }
}

extension ViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath.row == 0 {
            collectionView.deselectItem(at: indexPath, animated: false)
        }
    }
}
