//
//  GitHubViewController.swift
//  DeveloperHit
//
//  Created by Yang Li on 27/10/2017.
//  Copyright © 2017 Yang LI. All rights reserved.
//

import UIKit

@objcMembers class GitHubViewController: UIViewController, XMLParserDelegate {
  
  var eleName = String()
  var projects: [Project] = []
  var developers: [Developer] = []
  
  dynamic var name: String? = nil
  dynamic var owner: String? = nil
  dynamic var repositoryName: String? = nil
  dynamic var descriptions: String? = nil
  dynamic var language: String? = nil
  dynamic var stars: Int? = nil
  dynamic var url: String? = nil
  dynamic var contributorUrl: String? = nil
  dynamic var contributor: [Developer]? = nil
  
  dynamic var id: Int? = nil
  dynamic var displayName: String? = nil
  dynamic var fullName: String? = nil
  dynamic var devUrl: String? = nil
  dynamic var avatar: String? = nil
  
  override func viewDidLoad() {
    super.viewDidLoad()
    requestGitHub()
  }
  
  func requestGitHub() {
    let parse = XMLParser(contentsOf: URL(string: ServiceBase.GitHubUrl)!)
    parse?.delegate = self
    parse?.parse()
  }
  
  func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String] = [:]) {
    eleName = elementName
    if elementName == "project" {
      name = String()
      owner = String()
      repositoryName = String()
      descriptions = String()
      language = String()
      stars = Int()
      url = String()
      contributorUrl = String()
      contributor = []
    }
    if elementName == "developer" {
      id = Int()
      displayName = String()
      fullName = String()
      devUrl = String()
      avatar = String()
    }
  }
  
  func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
    if elementName == "project" {
      let project = Project(name: name!, owner: owner!, repositoryName: repositoryName!, descriptions: descriptions!, language: language!, stars: stars!, url: url!, contributorUrl: contributorUrl!, contributor: developers)
      projects.append(project)
      developers = []
    }
    if elementName == "developer" {
      let developer = Developer(id: id!, displayName: displayName!, fullName: fullName!, devUrl: devUrl!, avatar: avatar!)
      developers.append(developer)
    }
  }
  
  func parser(_ parser: XMLParser, foundCharacters string: String) {
    let str = string.trimmingCharacters(in: .whitespacesAndNewlines)
    self.setValue(String(describing: value(forKey: eleName)!) + str, forKey: eleName)
  }
  
  override func setValue(_ value: Any?, forUndefinedKey key: String) {}
  override func value(forUndefinedKey key: String) -> Any? {
    return ""
  }
}
