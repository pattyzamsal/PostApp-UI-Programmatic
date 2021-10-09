# PostsApp
This is a repository with an app that shows a list of posts and where you can access the detail of each of them

## Dependencies
You need to install the following tools to run the project:
- [Xcode 13.0 or newer](https://developer.apple.com/download)
- [HomeBrew](https://brew.sh/)
- [XcodeGen](https://github.com/yonaskolb/XcodeGen#installing)
- [JSONPlaceholder](https://jsonplaceholder.typicode.com/)

## Installation

### Step 1 - Install dependencies
In a terminal, you run the following instruction: `./build_project.sh` 

**Note:** if you receive a message in your terminal as following: `permission denied: ./build_project.sh`, you need to run this instruction `chmod +x build_project.sh` 

<img width="680" alt="Installation" src="https://user-images.githubusercontent.com/4505476/136675275-b41b3c17-0f9b-4d1b-88ec-302aaf73fafa.png">


### Step 2 - Open the project in Xcode
You can open it using your terminal with this command `open PostsApp.xcodeproj` or you can open it in your folder, where it was downloaded, with double click on `PostsApp.xcodeproj`

### Step 3 - Configurate the project
Follow these steps of the next image:

<img width="1400" alt="SetupProject" src="https://user-images.githubusercontent.com/4505476/136675356-1da95653-3938-46d4-b040-6f304c8bda7a.png">

You need to be sure that the target "PROD" have the "PROD.xcconfig" and "STG" have "STG.xcconfig"

## How to run
After the installation, you can run the project in Xcode without any problem. Press the play button or press `cmd+R` in your keyboard.

### Architecture

### Third-party library
All dependencies are managed using Swift Package Manager.

- [Alamofire](https://github.com/Alamofire/Alamofire)
