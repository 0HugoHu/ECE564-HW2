#  ECE564 HW2 - Persistent Storage

## Extra Functionality

### 1.A LaunchScreen
- Very delicated and animated launch screen powered by ```RealityKit```
- The 3D animation shows all kinds of marks representing different disciplines at the Duke University, while emphasizing the **DUKE** name

|![Assets/hw2_launchscreen1.png]()|![Assets/hw2_launchscreen2.png]()|![Assets/hw2_launchscreen3.png]()|![Assets/hw2_launchscreen4.png]()|
|---|---|---|---|

### 2.Any new functions you want to add
- Applied the **Image Background Removal** to the profile picture
- Added **Gradient Transition** to the background and **Glass Blur Effect** to the Image and TextField
- Created new **Protocols** to the DukePersonVC to pass the error message back, and to the customized GradientImageView for button action's callback

### 3.Unique enhancements to the DukePersonView
- Very awesome UI with **Glass Blur Effect** Textfield and **Gradient Transition** background
- Added the person's name to be more prominent

|![Assets/hw2_person1.png]()|![Assets/hw2_person2.png]()|![Assets/hw2_person4.png]()|![Assets/hw2_person3.png]()|
|---|---|---|---|

<br />

## Code Reference

#### 1.The Launch Screen was modified from the code of (@aheze)[https://github.com/aheze/RealityKitLaunchScreen] on GitHub
The original and modified code are all in ```DukePeople/LaunchScreen``` folder.

#### 2.The Image Backgroud Removal used (BackgroundRemoval)[https://github.com/Ezaldeen99/BackgroundRemoval] dependency on GitHub
Use of the Removal model:
```swift
let image = UIImage(named: "child")
outputImage.image = BackgroundRemoval.init().removeBackground(image: image!)
```

#### 3. The Material Background (aka. the Glass Blur Effect)
Read materials from:
- [UIBlurEffectStyles](https://ikyle.me/blog/2022/uiblureffectstyle)
- [SwiftUI Gradient Blur](https://github.com/unitedadityaa/SwiftUIGradientBlur)
- [Material - A background material type](https://developer.apple.com/documentation/swiftui/material)

#### 4. The DukePersonView's idea is from [Apple 17 Preview](https://www.apple.com/ios/ios-17-preview/): the new phone call interface
~Though someone may have stolen my ideas (who knows)~


<br />

## Usage

### Input Instruction

```text
--------------------------------------- Help ---------------------------------------
Format:
fn=first_name, ln=last_name, em=email,
ro=role, ge=gender, fr=from
- ro must be one of: Student, TA, Professor, Staff, or will be Other
- ge must be one of: Male, Female, otherwise will be Other
- Either of these parameters must not contains ',', space, or '='
- The order of parameters does not matter

1. Add: Add a person to the database.
    DUID is required, all other parameters are optional.
2. Update: Update or add a person with given DUID.
    DUID is required, all other parameters are optional.
3. Delete: Delete a person with given DUID.
    DUID is required, all other parameters are ignored.
4. Find: Find a person with given DUID or given name.
    Either DUID or lName is required, fName is default with "*".
    Use "*" to represent any name. Not case sensitive.
5. List All: List all people in the database.
6. Help: Show this help message.

CopyRight: Yadong (Hugo) Hu, 2023
------------------------------------------------------------------------------------
```

### Test Cases

Please visit last homework's [README.md](https://gitlab.oit.duke.edu/yh342/ece564hw1/-/blob/main/README.md) for more details.

