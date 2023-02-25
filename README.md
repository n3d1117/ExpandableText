# ExpandableText
[![build](https://github.com/n3d1117/ExpandableText/actions/workflows/build.yml/badge.svg)](https://github.com/n3d1117/ExpandableText/actions/workflows/build.yml)
[![swift-version](https://img.shields.io/badge/swift-5.7-orange.svg)](https://github.com/apple/swift/)
[![ios-version](https://img.shields.io/badge/ios-13.0+-brightgreen.svg)](https://github.com/apple/ios/)
[![xcode-version](https://img.shields.io/badge/xcode-14.2-blue)](https://developer.apple.com/xcode/)
[![license](https://img.shields.io/badge/license-The%20Unlicense-yellow.svg)](LICENSE)

An expandable text view that displays a truncated version of its contents with a "show more" button that expands the view to show the full contents.

iOS 13+ compatible, fully customizable, written in SwiftUI.

## Installation
Available via the [Swift Package Manager](https://developer.apple.com/documentation/swift_packages/adding_package_dependencies_to_your_app). Requires iOS 13+.

```
https://github.com/n3d1117/ExpandableText
```

## Features
- Customizable line limit
- Customizable font, color, and `more` button appearance with SwiftUI-like modifiers
- Automatically hide `more` button if the whole text fits within the view
- Support right-to-left languages
- Support custom expand animation
- Automatically trim multiple new lines when truncated (can be disabled)

## Usage

### Basic usage
<table>
<tr>
<td>

```swift
import ExpandableText

let loremIpsum = """
Lorem ipsum dolor sit amet, consectetur adipiscing 
elit, sed do eiusmod tempor incididunt ut labore et 
dolore magna aliqua. Ut enim ad minim veniam, quis 
nostrud exercitation ullamco laboris nisi ut aliquip 
ex ea commodo consequat. Duis aute irure dolor in 
reprehenderit in voluptate velit esse cillum dolore 
eu fugiat nulla pariatur.
"""

ExpandableText(loremIpsum)
  .border(.red)
```
</td>
<td>

![Basic usage demo](https://user-images.githubusercontent.com/11541888/221367314-5e59b284-41a9-43d2-9ac2-4d51ee3bc46b.png)
</td>
</tr>
</table>

### Customization options
<table>
<tr>
<td>

```swift
ExpandableText(loremIpsum)
  .font(.headline)
  .foregroundColor(.secondary)
  .lineLimit(4)
  .moreButtonText("read more")
  .moreButtonFont(.headline.bold())
  .moreButtonColor(.red)
  .expandAnimation(.easeInOut(duration: 2))
  .trimMultipleNewlinesWhenTruncated(false)
  .border(.red)
```
</td>
<td>

![Customization demo](https://user-images.githubusercontent.com/11541888/221367312-3062bd32-5eae-45d4-bf3a-0474985cb712.png)
</td>
</tr>
</table>

## Credits
- [NuPlay/ExpandableText](https://github.com/NuPlay/ExpandableText) for inspiration and some portions of code

## License
Available under The Unlicense license. See [LICENSE](LICENSE) file for further information.



</tr>
</table>
