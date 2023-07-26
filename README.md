# SnippetBox-SwiftData

This is a demo project that I made to test the new SwiftData framework. I wrote a few blog posts about the topic, where I reference this project. 
Have a look here:
- [Introduction to Data Persistence in SwiftUI with SwiftData](https://www.swiftyplace.com/blog/swiftui-apps-with-swiftdata)
- [Modeling Data in SwiftData](https://www.swiftyplace.com/blog/modeling-data-in-swiftdata)
- [SwiftData Stack: Understanding Schema, Container & Context](https://www.swiftyplace.com/blog/swiftdata-stack-understanding-containers)
- [Data Handling in SwiftData: Create, Read, Update, Delete](https://www.swiftyplace.com/blog/crud-in-swift-data)
- [How to fetch and filter data in SwiftData with Predicates](https://www.swiftyplace.com/blog/fetch-and-filter-in-swiftdata)
- [How to convert a CoreData project to SwiftData](https://www.swiftyplace.com/blog/how-to-convert-a-coredata-project-to-swiftdata)


It is an app where you can collect code snippets.

![](/images/snippbox_demo.jpg)


## SwiftData problems and limitations
I wrote this project with Xcode 14 beta 2. There are still a lot of bugs with SwiftData. You can have a look at the list of reported issues in the latest Xcode release documentation:
https://developer.apple.com/documentation/xcode-release-notes/xcode-15-release-notes
and the iOS 17 beta release notes: https://developer.apple.com/documentation/ios-ipados-release-notes/ios-ipados-17-release-notes

## Data model
I used 3 model types: *Folder*, *Snippet* and *Tag*.
There is a one-to-many relationship between *Folder* and *Snippet* 
and a many-to-many relationship between *Snippet* and *Tag*.

The *Snippet* type is the most interesting one, where I used different property types like Booleans, Integers, custom types, and image data.


## SwiftData and Xcode Previews
I had quite a lot of problems with the previews. In the demo, I used a few different ways to pass SwiftData data to the preview. 
All previews are working. Note that this is very likely to improve in the upcoming betas.

## Filtering and Sorting with SwiftData
SwiftData does not allow dynamically changing sorting and filtering for @Query like CoreData with @FetchResult. But you can set these parameters in the initializers. 
Have a look at the tag list, where I implemented searching and sorting.

![](/images/snippbox_demo_sorting_filtering.jpg)
