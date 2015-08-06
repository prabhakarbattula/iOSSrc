# ReadMe

## About application

This application demonstrates rest api usage. Here we use Bus Transport apis for Tampere. The tests would input text to UISearchDisplayController and verify value is returned. Test covers --

* Verification of Tab bar
* Verification of SearchBar
* Verification of TableView


##Compiling from Commandline

### Clean build
```
xcodebuild -configuration Release -arch i386 -sdk iphonesimulator -workspace busticker.xcworkspace -scheme busticker -derivedDataPath build clean
```

### Build App
>Usually you do not need -derivedDataPath as by default app is generated in <current folder>/build/

* Here we specify specific derivedDataPath

```
xcodebuild -configuration Release -arch i386 -sdk iphonesimulator -workspace busticker.xcworkspace -scheme busticker -derivedDataPath build
```

## Tests

We have two folders --

* arc -- It contains *appium.txt* which defines capabilities needed for `arc`.
* ruby -- It contains rspec test file.