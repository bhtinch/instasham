//
//  SettingsViewController.swift
//  instasham
//
//  Created by Benjamin Tincher on 2/13/21.
//
import SafariServices
import UIKit

struct SettingCellModel {
    let title: String
    let handler: (() -> Void)
}

/// View Controller to show user settings
final class SettingsViewController: UIViewController {
    
    private let tableView: UITableView = {
        let table = UITableView(frame: .zero, style: .grouped)
        table.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        return table
    }()
    
    private var data = [[SettingCellModel]]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        view.backgroundColor = .systemBackground
        self.tableView.delegate = self
        self.tableView.dataSource = self
        configureModels()
        view.addSubview(tableView)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
    }
        
    private func configureModels() {
        data.append([
            SettingCellModel(title: "Edit Profile") { [weak self] in
                self?.didTapEditProfile()
            },
            SettingCellModel(title: "Invite Friends") { [weak self] in
                self?.didTapInviteFriends()
            },
            SettingCellModel(title: "Save Original Posts") { [weak self] in
                self?.didTapOriginalPosts()
            }
            
        ])
        
        data.append([
            SettingCellModel(title: "Terms of Service") { [weak self] in
                self?.openURL(type: .terms)
            },
            SettingCellModel(title: "Privacy Policy") { [weak self] in
                self?.openURL(type: .privacy)
            },
            SettingCellModel(title: "Help / Feedback") { [weak self] in
                self?.openURL(type: .help)
            }
        ])
        
        data.append([
            SettingCellModel(title: "Log Out") { [weak self] in
                self?.didTapLogOut()
            }
        ])
    }
    
    private func didTapEditProfile() {
        
    }
    
    private func didTapInviteFriends() {
        //  Show share sheet to invite friends
    }
    
    private func didTapOriginalPosts() {
        let vc = EditProfileViewController()
        vc.title = "Edit Profile"
        let navVC = UINavigationController(rootViewController: vc)
        present(navVC, animated: true, completion: nil)
    }
    
    enum SettingsURLType {
        case terms, privacy, help
    }
    
    private func openURL(type: SettingsURLType) {
        let urlString: String
        
        switch type {
        case .terms: urlString = "https://help.instagram.com/581066165581870"
        case .privacy: urlString = "https://help.instagram.com/519522125107875"
        case .help: urlString = "https://help.instagram.com/"
        }
        
        guard let url = URL(string: urlString) else { return }
        
        let vc = SFSafariViewController(url: url)
        present(vc, animated: true, completion: nil)
    }
    
    private func didTapLogOut() {
        
        let actionSheet = UIAlertController(title: "Log Out", message: "Are you sure you want to log out?", preferredStyle: .actionSheet)

        actionSheet.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))

        actionSheet.addAction(UIAlertAction(title: "Log Out", style: .destructive, handler: { (_) in

            AuthManager.shared.logoutUser { (loggedOut) in
                DispatchQueue.main.async {
                    if loggedOut {
                        let loginVC = LoginViewController()
                        loginVC.modalPresentationStyle = .fullScreen
                        self.present(loginVC, animated: false) {
                            self.navigationController?.popToRootViewController(animated: false)
                            self.tabBarController?.selectedIndex = 0
                        }
                    } else {
                        //  error occurred
                        fatalError("Could not log out user")
                    }
                }
            }
        }))

        actionSheet.popoverPresentationController?.sourceView = tableView
        actionSheet.popoverPresentationController?.sourceRect = tableView.bounds

        present(actionSheet, animated: true, completion: nil)
    }
}

extension SettingsViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data[section].count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = data[indexPath.section][indexPath.row].title
        cell.accessoryType = .disclosureIndicator
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("cheee")
        tableView.deselectRow(at: indexPath, animated: true)
        data[indexPath.section][indexPath.row].handler()
    }
    
}
