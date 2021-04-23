//
//  HomeViewController.swift
//  MLChallenge
//
//  Created by Miguel Angel De Leon Palacios on 20/04/21.
//

import UIKit

class HomeViewController: UIViewController, HomeViewProtocol {
    // MARK: - IBOUTLETS.
    @IBOutlet private weak var searchView: UIView!
    @IBOutlet private weak var searchTextField: UITextField!
    @IBOutlet private weak var cancelButton: UIButton!
    @IBOutlet private weak var informationView: UIView!
    @IBOutlet private weak var categoriesTableView: UITableView!
    @IBOutlet private weak var emptyStateView: UIMLEmptyStateView!
    
    // MARK: - PROPERTIES.
    var viewModel: HomeViewModelProtocol?
    private var numberOfItems = 0
    private let localizables = MLStringsLocalizables()
    private typealias constants = GeneralConstants
    
    deinit {
        NotificationCenter.default.removeObserver(self,
                                                  name: .updateSiteSelected,
                                                  object: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setup()
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(updateSite),
                                               name: .updateSiteSelected, object: nil)
        
        presentLoader { [weak self] in
            self?.viewModel?.getCategories()
        }
    }
    
    // MARK: - SETUP.
    private func setup() {
        self.navigationController?.setNavigationBarHidden(true, animated: true)
        emptyStateView.isHidden = true
        emptyStateView.delegate = self
        setupTextField()
        setupTableView()
        setupButtons()
        bind()
    }
    
    private func setupTextField() {
        searchTextField.placeholder = localizables.homePlaceHolderSearch
        searchTextField.delegate = self
        searchView.addShadow(useShadowPath: false)
        searchView.layer.cornerRadius = searchView.frame.height / 2.0
    }
    
    private func setupButtons() {
        self.cancelButton.isHidden = true
        self.cancelButton.setTitle(localizables.mlButtonTitleCancel, for: .normal)
    }
    
    private func setupTableView() {
        categoriesTableView.delegate = self
        categoriesTableView.dataSource = self
        categoriesTableView.register(CategoryViewCell.nib, forCellReuseIdentifier: CategoryViewCell.reuseIdentifier)
        categoriesTableView.estimatedRowHeight = constants.estimatedRowHeight
        categoriesTableView.rowHeight = UITableView.automaticDimension
    }
    
    private func bind() {
        self.viewModel?.reloadTable = ({ [weak self] numberOfItems in
            self?.numberOfItems = numberOfItems
            self?.categoriesTableView.reloadData()
            self?.updateView(isHidden: true)
            self?.dismissLoader(completion: nil)
        })
        
        self.viewModel?.updateEmptyState = ({ [weak self] showEmptyState, message, image in
            self?.emptyStateView.message = message
            self?.emptyStateView.errorImage = image
            self?.updateView(isHidden: !showEmptyState)
            self?.dismissLoader(completion: nil)
        })
        
        self.viewModel?.pushViewController = ({ [weak self] viewController in
            self?.navigationController?.pushViewController(viewController, animated: true)
        })
    }
    
    private func updateView(isHidden: Bool) {
        self.categoriesTableView.isHidden = !isHidden
        self.emptyStateView.isHidden = isHidden
    }
    
    private func updateButtons(cancelIsHidden: Bool) {
        cancelButton.isHidden = cancelIsHidden
        informationView.isHidden = !cancelIsHidden
    }
    
    // MARK: - IBACTIONS.
    @IBAction func cancelAction(_ sender: Any) {
        searchTextField.text = ""
        updateButtons(cancelIsHidden: true)
        self.view.endEditing(true)
    }
    
    @IBAction func informationAction(_ sender: Any) {
        viewModel?.didTapInformationButton()
    }
    
    @objc private func updateSite() {
        presentLoader { [weak self] in
            self?.viewModel?.getCategories()
        }
    }
}

// MARK: - UITextFieldDelegate implementation.
extension HomeViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        
        if let text = textField.text, !text.isEmpty {
            searchTextField.text = ""
            self.viewModel?.search(text)
        }
        
        updateButtons(cancelIsHidden: true)
        
        return true
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard let viewModel = self.viewModel,
              let editingText = textField.text else { return false }
        
        return viewModel.validate(editingField: textField,
                                  editingText: editingText,
                                  shouldChangeCharactersIn: range,
                                  replacementString: string)
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        updateButtons(cancelIsHidden: false)
    }
}

// MARK: - UITABLEVIEWDELEGATE & UITABLEVIEWDAATASOURCE IMPLEMENTATION.
extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
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
        self.viewModel?.didSelect(at: indexPath.item)
    }
}

// MARK: - UIMLBUTTONDELEGATE IMPLEMENTATION.
extension HomeViewController: UIMLButtonDelegate {
    func action(_ buttonType: MLButtonType, sender: Any) {
        self.presentLoader { [weak self] in
            self?.viewModel?.getCategories()
        }
    }
}
