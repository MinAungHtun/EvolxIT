//
//  PlayerView.swift
//  MoviesDB
//
//  Created by User on 7/26/23.
//

import SwiftUI
import AVKit

struct PlayerView: View {
    var body: some View {
        VideoPlayer(player: AVPlayer(url: URL(string: "thinkingform.com/video-sample-mp4/")!))
    }
}

struct PlayerView_Previews: PreviewProvider {
    static var previews: some View {
        PlayerView()
    }
}
