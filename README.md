# iTunesAlbums
iTunes Albums App
## General info
iTunesAlbums is the application for the iPhone that displays information about musical albums from [iTunesApi](https://affiliate.itunes.apple.com/resources/documentation/itunes-store-%20web-service-search-api/). If you want to see detailed information about the albums you are interested in - just enter title in the search bar.

## Screenshots  
![Simulator Screen Shot - iPhone 11 - 2020-12-06 at 22 03 56](https://user-images.githubusercontent.com/50327663/101289698-287ede00-380f-11eb-8f9c-a11087da129d.png) ![Simulator Screen Shot - iPhone 11 - 2020-12-06 at 22 04 21](https://user-images.githubusercontent.com/50327663/101289725-5532f580-380f-11eb-8d55-a4261846bbf8.png)


## Technologies 
* Xcode 12.2
* Swift 5
* R.swift 5.3.0
* SDWebImage 5.9.5
## Technical detail
The app uses MVVM architecture.  

Albums data is retrieved with standart URLRequest; response(REST) is parsed using Decodable protocol. View controllers work with retrieved data using Delegate protocol.

Implemented error handling for no internet or server errors.  

Localization has been prepared for the required language using R.swift.

Album artwork is loaded and cached using SDWebImage.

## Features and UI
* Searching albums are sorted alphabetically and displayed in UICollectionView
* Tap on album to see detailed information about it in UICollectionView
* Navigation between screens realized with UINavigationController
* Supported dark theme
