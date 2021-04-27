//
//  ViewController.swift
//  SingleViewTest
//
//  Created by Anton Skvartsou on 27/06/2018.
//  Copyright © 2018 Anton Skvartsou. All rights reserved.
//

import Cocoa

class MainViewController: NSViewController, NSTableViewDelegate, NSTableViewDataSource {
    
    let label: NSTextField = {
        let label = NSTextField()
        label.stringValue = "Test App"
        label.font = NSFont.boldSystemFont(ofSize: 14)
        label.textColor = .white
        label.alignment = .center
        label.drawsBackground = false
        label.isBezeled = false
        label.isSelectable = false
        label.isEditable = false
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let labelContainerView: NSView = {
        let view = NSView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var tableView: NSTableView = {
        let tableView = NSTableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.usesAlternatingRowBackgroundColors = true
        
        let column = NSTableColumn(identifier: .init(rawValue: "MyColumnID"))
        column.title = "test"
        column.headerCell.alignment = .center
        tableView.addTableColumn(column)
        
        return tableView
    }()
    
    let scrollView: NSScrollView = {
        let scrollView = NSScrollView()
        scrollView.hasVerticalScroller = true
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    
    override func loadView() {
        view = NSView()
        view.wantsLayer = true
    }
    
    var names: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        layoutUI()
        scrollView.documentView = tableView
    }
    
    override func viewDidAppear() {
        super.viewDidAppear()
        setupTableView()
    }
    
    fileprivate func setupTableView() {
        if tableView.delegate == nil || tableView.dataSource == nil {
            tableView.delegate = self
            tableView.dataSource = self
            loadData()
        }
    }
    
    private func loadData() {
        for i in 1...1000 {
            let name = "Test \(i)"
            names.append(name)
        }
        
        tableView.reloadData()
    }
    
    func tableView(_ tableView: NSTableView, viewFor tableColumn: NSTableColumn?, row: Int) -> NSView? {
        
        if tableColumn == tableView.tableColumns[0] {
            let newCell = MyCellView(identfier: .init("MyCell"))
            
            newCell.textView.stringValue = names[row]
            
            return newCell
        }
        
        return nil
    }
    
    func numberOfRows(in tableView: NSTableView) -> Int {
        return names.count
    }
    
    func layoutUI() {
        view.addSubview(labelContainerView)
        view.addSubview(scrollView)
        labelContainerView.addSubview(label)
        
        NSLayoutConstraint.activate([
            labelContainerView.topAnchor.constraint(equalTo: view.topAnchor),
            labelContainerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            labelContainerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            labelContainerView.heightAnchor.constraint(equalTo: view.heightAnchor,
                                                       multiplier: 1/5),
            
            label.centerXAnchor.constraint(equalTo: labelContainerView.centerXAnchor),
            label.centerYAnchor.constraint(equalTo: labelContainerView.centerYAnchor,
                                           constant: -4),
            
            scrollView.heightAnchor.constraint(equalTo: view.heightAnchor,
                                               multiplier: 4/5),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
}

class MyCellView: NSTableCellView {
    
    var textView: NSTextField!
    
    init(identfier: NSUserInterfaceItemIdentifier) {
        super.init(frame: .zero)
        self.identifier = identfier
        
        setupViews()
    }
    
    fileprivate func setupViews() {
        textView = NSTextField()
        textView.backgroundColor = NSColor.clear
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.isBordered = false
        textView.controlSize = NSControl.ControlSize.small
        
        self.addSubview(textView)
        
        addConstraints(
            NSLayoutConstraint.constraints(withVisualFormat: "H:|[textField]|",
                                           options: [],
                                           metrics: nil,
                                           views: ["textField" : textView]))
        
        addConstraints(
            NSLayoutConstraint.constraints(withVisualFormat: "V:|[textField]|",
                                           options: [],
                                           metrics: nil,
                                           views: ["textField" : textView]))
        
        textView.bind(NSBindingName.value,
                      to: self,
                      withKeyPath: "objectValue",
                      options: nil)
    }
    
    required init?(coder decoder: NSCoder) {
        fatalError()
    }
}
