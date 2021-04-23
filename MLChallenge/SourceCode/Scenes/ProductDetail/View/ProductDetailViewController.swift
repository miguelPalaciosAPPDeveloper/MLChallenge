//
//  ProductDetailViewController.swift
//  MLChallenge
//
//  Created by Miguel Angel De Leon Palacios on 21/04/21.
//

import UIKit

class ProductDetailViewController: UIViewController, ProductDetailViewProtocol {
    // MARK: - IBOUTLETS.
    @IBOutlet private weak var detailTableView: UITableView!
    
    // MARK: - PROPERTIES.
    var viewModel: ProductDetailViewModelProtocol?
    private var numberOfItems = 0
    private typealias constants = GeneralConstants
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        bind()
        
        presentLoader { [weak self] in
            self?.viewModel?.didLoad()
        }
    }
    
    // MARK: - SETUP.
    private func setup() {
        self.navigationController?.setNavigationBarHidden(true, animated: true)
        setupTableView()
    }
    
    private func setupTableView() {
        detailTableView.isHidden = true
        detailTableView.delegate = self
        detailTableView.dataSource = self
        detailTableView.rowHeight = UITableView.automaticDimension
        detailTableView.estimatedRowHeight = constants.estimatedRowHeight
        detailTableView.register(DetailPriceViewCell.nib,
                                 forCellReuseIdentifier: DetailPriceViewCell.reuseIdentifier)
        detailTableView.register(ProductAvailableViewCell.nib,
                                 forCellReuseIdentifier: ProductAvailableViewCell.reuseIdentifier)
        detailTableView.register(ProductShippingViewCell.nib,
                                 forCellReuseIdentifier: ProductShippingViewCell.reuseIdentifier)
    }
    
    private func bind() {
        self.viewModel?.openURL = ({ url in
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        })
        
        self.viewModel?.reloadData = ({ [weak self] numberOfItems in
            self?.numberOfItems = numberOfItems
            self?.detailTableView.isHidden = false
            self?.detailTableView.reloadData()
            self?.dismissLoader(completion: nil)
        })
    }
    
    // MARK: - IBACTIONS.
    @IBAction func backAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    
    @IBAction func homeAction(_ sender: Any) {
        self.navigationController?.popToRootViewController(animated: true)
    }
}

// MARK: - UITABLEVIEWDELEGATE & UITABLEVIEWDAATASOURCE IMPLEMENTATION.
extension ProductDetailViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return numberOfItems
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let model = viewModel?.getCellModel(at: indexPath.item) else { return UITableViewCell() }
        
        let cell = tableView.dequeueReusableCell(withIdentifier: model.reuseIdentifier, for: indexPath)
        
        if let cellConfigurable = cell as? ViewCellConfigurable {
            cellConfigurable.setup(model, delegate: self)
        }
        
        return cell
    }
}

// MARK: - VIECELLDELEGATE IMPLEM
extension ProductDetailViewController: ViewCellDelegate {
    func didTapActionButtton(_ buttonType: MLButtonType) {
        viewModel?.didTapLink()
    }
}
