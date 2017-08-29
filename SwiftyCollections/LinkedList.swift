//
//  LinkedList.swift
//  SwiftyCollections
//
//  Created by Vitaliy Yarkun on 8/29/17.
//  Copyright © 2017 Vitaliy Yarkun. All rights reserved.
//

class Node<T> {
    var value: T
    var next: Node<T>?
    weak var previous: Node<T>?
    init(value: T) {
        self.value = value
    }
}

struct LinkedList<T> {
    fileprivate var head: Node<T>?
    fileprivate var tail: Node<T>?
    
    var isEmpty: Bool {
        return head == nil
    }
    
    var first: Node<T>? {
        return head
    }
    
    var last: Node<T>? {
        return tail
    }
    
    mutating func push(value: T) {
        let newNode = Node(value: value)
        
        if let headNode = head {
            headNode.previous = newNode
            newNode.next = headNode
        } else {
            tail = newNode
        }
        head = newNode
    }
    
    mutating func append(value: T) {
        let newNode = Node(value: value)
        
        if let tailNode = tail {
            newNode.previous = tailNode
            tailNode.next = newNode
        } else {
            head = newNode
        }
        tail = newNode
    }
    
    func insert(_ value: T, after index: Int) {
        let prevNode = self.node(at: index)
        
        if prevNode == nil {
            return
        }
        
        let newNode = Node(value: value)
        newNode.next = prevNode?.next
        newNode.previous = prevNode?.previous
        
        prevNode?.next = newNode
    }
    
    func node(at index: Int) -> Node<T>? {
        if index >= 0 {
            
            var node = head
            var i = index
            while node != nil {
                if i == 0 { return node }
                i -= 1
                node = node?.next
            }
        }
        
        return nil
    }
    
    func value(at index: Int) -> T? {
        if let node = node(at: index) {
            return node.value
        }
        
        return nil
    }
    
    mutating func removeAll() {
        head = nil
        tail = nil
    }
    
    mutating func removeValue(at index: Int) -> T? {
        guard let node = self.node(at: index) else { return nil }
        
        let prev = node.previous
        let next = node.next
        
        if let prev = prev {
            prev.next = next
        } else {
            head = next
        }
        
        next?.previous = prev
        
        if next == nil {
            tail = prev
        }
        
        node.previous = nil
        node.next = nil
        
        return node.value
    }
}

extension LinkedList: CustomStringConvertible {
    
    public var description: String {
        var text = "["
        var node = head
        
        while node != nil {
            text += "\(node!.value)"
            node = node!.next
            if node != nil { text += ", " }
        }
        
        return text + "]"
    }
}














