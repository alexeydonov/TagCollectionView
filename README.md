# TagCollectionView

[![Carthage compatible](https://img.shields.io/badge/Carthage-compatible-4BC51D.svg?style=flat)](https://github.com/Carthage/Carthage)
[![license](https://img.shields.io/github/license/mashape/apistatus.svg?maxAge=2592000)](https://github.com/dotsau/TagCollectionView/blob/master/LICENSE)

Simple UILabel-based tag list view. Inspired by [TagListView](https://github.com/xhacker/TagListView). Use it if you don't need button semantics getting in your way.

## Installation

Use [Carthage](https://github.com/Carthage/Carthage)

```ruby
github "dotsau/TagCollectionView"
```

Or, just drag `TagCollectionView` folder into your project.

## Usage

Drag out a view in your storyboard and set it's class to `TagCollectionView`. Since Interface Builder does not show some properties in the Attributes Inspector, the easiest way to configure is when the outlet is set:

```swift
@IBOutlet weak var tagCollectionView: TagCollectionView! {
    didSet {
        tagCollectionView.font = UIFont.preferredFontForTextStyle(UIFontTextStyleFootnote)
    }
}
```

Then set, add or remove tags at your leisure:

```swift
tagCollectionView.tags = [Tag(name: "Taggy"), Tag(name: "McTagface")]
tagCollectionView.tags.append(Tag(name: "2016"))
```

## Contributions

Knock yourself out.

## License

TagCollectionView is released under the [MIT license](https://github.com/dotsau/TagCollectionView/blob/master/LICENSE).
