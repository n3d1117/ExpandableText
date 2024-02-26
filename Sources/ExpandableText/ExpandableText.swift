//
//  ExpandableText.swift
//  ExpandableText
//
//  Created by ned on 23/02/23.
//

import Foundation
import SwiftUI

/**
An expandable text view that displays a truncated version of its contents with a "show more" button that expands the view to show the full contents.

 To create a new ExpandableText view, use the init method and provide the initial text string as a parameter. The text string will be automatically trimmed of any leading or trailing whitespace and newline characters.

Example usage with default parameters:
 ```swift
ExpandableText("Lorem ipsum dolor sit amet, consectetur adipiscing elit...")
    .font(.body)
    .foregroundColor(.primary)
    .lineLimit(3)
    .moreButtonText("more")
    .moreButtonColor(.accentColor)
    .expandAnimation(.default)
    .trimMultipleNewlinesWhenTruncated(true)
 ```
*/
public struct ExpandableText: View {

    @State internal var isExpanded: Bool = false
    @State private var isTruncated: Bool = false
    @State private var showLessButton: Bool = false
    @State private var intrinsicSize: CGSize = .zero
    @State private var truncatedSize: CGSize = .zero
    @State private var moreTextSize: CGSize = .zero
    
    private let text: String
    internal var font: Font = .body
    internal var color: Color = .primary
    internal var lineLimit: Int = 3
    internal var moreButtonText: String = "more"
    internal var lessButtonText: String = "less"
    internal var buttonFont: Font?
    internal var buttonColor: Color = .accentColor
    internal var expandAnimation: Animation = .default
    internal var collapseEnabled: Bool = false
    internal var trimMultipleNewlinesWhenTruncated: Bool = true
    
    /**
     Initializes a new `ExpandableText` instance with the specified text string, trimmed of any leading or trailing whitespace and newline characters.
     - Parameter text: The initial text string to display in the `ExpandableText` view.
     - Returns: A new `ExpandableText` instance with the specified text string and trimming applied.
     */
    public init(_ text: String) {
        self.text = text.trimmingCharacters(in: .whitespacesAndNewlines)
    }
    
    public var body: some View {
        content
            .onChange(of: text) { _ in
                if isExpanded {
                    isExpanded = false
                }
            }
            .lineLimit(isExpanded ? nil : lineLimit)
            .applyingTruncationMask(size: moreTextSize, enabled: shouldShowMoreButton)
            .readSize { size in
                truncatedSize = size
                isTruncated = truncatedSize != intrinsicSize
            }
            .background(
                content
                    .lineLimit(nil)
                    .fixedSize(horizontal: false, vertical: true)
                    .hidden()
                    .readSize { size in
                        intrinsicSize = size
                        isTruncated = truncatedSize != intrinsicSize
                    }
            )
            .background(
                Text(moreButtonText)
                    .font(buttonFont ?? font)
                    .hidden()
                    .readSize { moreTextSize = $0 }
            )
            .background(
                Text(lessButtonText)
                    .font(buttonFont ?? font)
                    .hidden()
                    .readSize { moreTextSize = $0 }
            )
            .contentShape(Rectangle())
            .onTapGesture {
                if (isExpanded && collapseEnabled) || shouldShowMoreButton {
                    withAnimation(expandAnimation) {
                        isExpanded.toggle()
                        showLessButton = false
                    }
                }
            }
            .modifier(OverlayAdapter(alignment: .trailingLastTextBaseline, view: {
                if shouldShowMoreButton {
                    Button {
                        withAnimation(expandAnimation) {
                            isExpanded.toggle()
                            showLessButton = false
                        }
                    } label: {
                        Text(moreButtonText)
                            .font(buttonFont ?? font)
                            .foregroundColor(buttonColor)
                    }
                    .buttonStyle(.plain)
                    .animation(.smooth, value: shouldShowMoreButton)
                } else if (isExpanded && !isTruncated) {
                    VStack {
                        if showLessButton {
                            Button {
                                withAnimation(expandAnimation) {
                                    showLessButton = false
                                    isExpanded.toggle()
                                }
                            } label: {
                                Text(lessButtonText)
                                    .font(buttonFont ?? font)
                                    .foregroundColor(buttonColor)
                            }
                            .buttonStyle(.plain)
                        }
                    }
                    .animation(.smooth, value: showLessButton)
                    .animation(.smooth, value: shouldShowMoreButton)
                    .onAppear {
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.25) {
                            // Show the button after a delay of 0.25 seconds
                            showLessButton = true
                        }
                    }
                }
            }))
            .animation(.smooth, value: shouldShowMoreButton)
    }
    
    private var content: some View {
        Text(.init(
            trimMultipleNewlinesWhenTruncated
                ? (shouldShowMoreButton ? textTrimmingDoubleNewlines : text)
                : text
        ))
        .font(font)
        .foregroundColor(color)
        .frame(maxWidth: .infinity, alignment: .leading)
    }

    private var shouldShowMoreButton: Bool {
        !isExpanded && isTruncated
    }
    
    private var textTrimmingDoubleNewlines: String {
        text.replacingOccurrences(of: #"\n\s*\n"#, with: "\n", options: .regularExpression)
    }
}

#Preview {
    ExpandableText("Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.")
}
