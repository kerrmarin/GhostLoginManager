# GhostLoginManager

[![CI Status](http://img.shields.io/travis/Kerr Marin Miller/GhostLoginManager.svg?style=flat)](https://travis-ci.org/Kerr Marin Miller/GhostLoginManager)
[![Version](https://img.shields.io/cocoapods/v/GhostLoginManager.svg?style=flat)](http://cocoapods.org/pods/GhostLoginManager)
[![License](https://img.shields.io/cocoapods/l/GhostLoginManager.svg?style=flat)](http://cocoapods.org/pods/GhostLoginManager)
[![Platform](https://img.shields.io/cocoapods/p/GhostLoginManager.svg?style=flat)](http://cocoapods.org/pods/GhostLoginManager)

### Warning
This pod only works with versions < 7.0 of Ghost. Once the public write API comes out I'll look at updating this to support that.


## Usage

To run the example project, clone the repo, and run `pod install` from the Example directory first.

To login to a Ghost blog use the `GhostLoginClient`, then create an instance of a class that conforms to `GhostLoginTokenParser` (e.g. `GhostLoginTokenJSONParser`) and an instance of a class that conforms to `GhostLoginSessionManager` (e.g. `GhostLoginJSONSessionManager`). Use these objects to create a login client:

```swift
self.client = GhostLoginClient(manager: manager, parser: parser)
self.client!.loginWithUsername(email, password: password) { (token, error) -> Void in
    guard error == nil else {
        //Error
        return
    }                                                                         
    //Token is valid here
}

```


## Requirements

This project requires the latest iOS, iOS 9.0. It also has a dependency on Alamofire version 3.

## Installation

GhostLoginClient is available through [CocoaPods](http://cocoapods.org). To install it, simply add the following line to your Podfile:

```ruby
pod "GhostLoginManager"
```

Alternatively, although I discourage this approach, clone the project and copy all the files under the `Pod` folder into your project.

## Author

Kerr Marin Miller, kerr@kerrmarin.com

## License

GhostLoginManager is available under the MIT license. See the LICENSE file for more info.
