//
//  ThumbnailImageView.swift
//
//
//  Created by Trey on 12/1/23.
//

import BGGDemoUtilities
import SwiftUI

public protocol HasImageThumbnailURLString {
    var imageThumbnailURLString: String? { get }
}

/// View of a BoardGame's Thumbnail
public struct ThumbnailImageView: View {
    public var body: some View {
        if let imageThumbnailURLString = game.imageThumbnailURLString {
            AsyncImage(url: URL(string: imageThumbnailURLString),
                       content: { image in
                image
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 80, height: 80)
            },
                       placeholder: {
                ProgressView()
            })
        } else {
            // TODO: put in missing photo asset
            Text("Missing cover")
                .frame(width: 80, height: 80)
                .font(.headline)
                .foregroundStyle(.primary)
                .background(Color.lightKhaki)
        }
    }
    
    public init(_ game: HasImageThumbnailURLString) {
        self.game = game
    }
    
    private let game: HasImageThumbnailURLString
}

extension BoardGame: HasImageThumbnailURLString { }

extension UserCollectionBoardGame: HasImageThumbnailURLString { }

struct MockHasThumbnailURLString: HasImageThumbnailURLString {
    let imageThumbnailURLString: String?
}

#Preview {
//    return ThumbnailImageView(MockHasThumbnailURLString(imageThumbnailURLString: nil))
    ThumbnailImageView(previewBoardGame)
}
