//
//  ContentView.swift
//  ExpandableTextExample
//
//  Created by ned on 25/02/23.
//

import SwiftUI
import ExpandableText

struct ContentView: View {
    
    let loremIpsum = #"Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum."#
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                ExpandableText(loremIpsum)
                    .border(.red)
                
                ExpandableText(loremIpsum)
                    .border(.red)
                    .environment(\.layoutDirection, .rightToLeft)
                
                ExpandableText(loremIpsum)
                    .font(.system(.headline, design: .rounded))
                    .foregroundColor(.secondary)
                    .lineLimit(4)
                    .moreButtonText("read more")
                    .moreButtonFont(.system(.headline, design: .rounded).bold())
                    .moreButtonColor(.red)
                    .expandAnimation(.easeInOut(duration: 2))
                    .trimMultipleNewlinesWhenTruncated(false)
                    .border(.red)
                
                ExpandableText("**Markdown** is _supported_")
                    .border(.red)
                
                ExpandableText(String(localized: "EXAMPLE_LOCALIZED_TEXT_KEY"))
                    .border(.red)
                
                Spacer()
            }
            .padding()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
