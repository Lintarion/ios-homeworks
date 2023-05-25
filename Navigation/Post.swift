//
//  Post.swift
//  Navigation
//
//  Created by Ирина Савостьянова on 24.04.2023.
//

import Foundation

struct Post {
    let author: String
    let title: String
    let description: String
    let image: String
    var likes: Int
    var views: Int
}

extension Post {
    static let mockArray: [Post] = {
        [
            Post(author: "Author 1", title: "Title 1", description: "Desc 1", image: "image_1", likes: 1231, views: 232131),
            Post(author: "Author 2", title: "Title 2 \n(Two lines)", description: "Desc 2", image: "image_2", likes: 0, views: 12),
            Post(author: "Author 3", title: "Title 3", description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.", image: "image_3", likes: 12, views: 32348),
            Post(author: "Author 4", title: "Title 4", description: "Desc 4", image: "image_4", likes: 311, views: 9754)
        ]
    }()
}
