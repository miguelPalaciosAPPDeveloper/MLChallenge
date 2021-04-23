//
//  SiteSelectorViewController.swift
//  MLChallenge
//
//  Created by Miguel Angel De Leon Palacios on 18/04/21.
//

import UIKit

class SiteSelectorViewController: UIViewController, SiteSelectorViewProtocol {
    // MARK: - IBOUTLETS.
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var descriptionLabel: UILabel!
    @IBOutlet private weak var sitesTableView: UITableView!
    @IBOutlet private weak var acceptButton: UIMLButton!
    @IBOutlet private weak var emptyStateView: UIMLEmptyStateView!
    @IBOutlet private weak var closeButton: UIButton!
    
    
    // MARK: - PROPERTIES.
    var viewModel: SiteSelectorViewModelProtocol?
    private var numberOfItems = 0
    private let localizables = MLStringsLocalizables()
    private typealias constants = GeneralConstants

    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        self.presentLoader { [weak self] in
            self?.viewModel?.didLoad()
        }
    }
    
    // MARK: - SETUP FUNCTIONS.
    private func setup() {
        self.navigationController?.setNavigationBarHidden(true, animated: true)
        emptyStateView.isHidden = true
        emptyStateView.delegate = self
        titleLabel.text = localizables.siteSelectorTitle
        descriptionLabel.text = localizables.siteSelectorDescription
        setupTableView()
        setupButton()
        bind()
    }
    
    private func setupTableView() {
        sitesTableView.isHidden = true
        sitesTableView.delegate = self
        sitesTableView.dataSource = self
        sitesTableView.register(SiteViewCell.nib, forCellReuseIdentifier: SiteViewCell.reuseIdentifier)
        sitesTableView.rowHeight = UITableView.automaticDimension
        sitesTableView.estimatedRowHeight = constants.estimatedRowHeight
    }
    
    private func setupButton() {
        acceptButton.isEnabled = false
        acceptButton.delegate = self
        acceptButton.backgroundColor = .clear
        acceptButton.titleLabel = localizables.mlButtonTitleAccept
        acceptButton.hiddeIcon = true
        closeButton.isHidden = true
    }
    
    // MARK: - PRIVATE FUNCTIONS.
    private func bind() {
        self.viewModel?.reloadTable = ({ [weak self] numberOfItems in
            self?.numberOfItems = numberOfItems
            self?.sitesTableView.reloadData()
            self?.updateView(isHidden: true)
            self?.dismissLoader(completion: nil)
        })
        
        self.viewModel?.enabledButton = ({ [weak self] isEnabled in
            self?.acceptButton.isEnabled = isEnabled
        })
        
        self.viewModel?.dismissSiteSelector = ({ [weak self] in
            self?.navigationController?.popViewController(animated: true)
            NotificationCenter.default.post(name: .updateSiteSelected, object: nil)
        })
        
        self.viewModel?.goToHome = ({ [weak self] viewControllers in
            self?.navigationController?.setViewControllers(viewControllers, animated: true)
        })
        
        self.viewModel?.updateEmptyState = ({ [weak self] showEmptyState, message, image in
            self?.updateView(isHidden: !showEmptyState)
            self?.emptyStateView.message = message
            self?.emptyStateView.errorImage = image
            self?.dismissLoader(completion: nil)
        })
        
        self.viewModel?.showCloseButton = ({ [weak self] in
            self?.closeButton.isHidden = false
        })
    }
    
    private func updateView(isHidden: Bool) {
        self.sitesTableView.isHidden = !isHidden
        self.emptyStateView.isHidden = isHidden
    }
    
    @IBAction func closeAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
}

// MARK: - UITABLEVIEWDELEGATE & UITABLEVIEWDAATASOURCE IMPLEMENTATION.
extension SiteSelectorViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return numberOfItems
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let model = viewModel?.getCellModel(at: indexPath.item) else { return UITableViewCell() }
        
        let cell = tableView.dequeueReusableCell(withIdentifier: model.reuseIdentifier, for: indexPath)
        
        (cell as? ViewCellConfigurable)?.setup(model)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel?.didSelect(at: indexPath.item)
    }
}

// MARK: - UIMLBUTTONDELEGATE IMPLEMENTATION.
extension SiteSelectorViewController: UIMLButtonDelegate {
    func action(_ buttonType: MLButtonType, sender: Any) {
        switch buttonType {
        case .normal:
            viewModel?.didTapAcceptButton()
        default:
            self.presentLoader { [weak self] in
                self?.viewModel?.didTapTryAgain()
            }
        }
    }
}
