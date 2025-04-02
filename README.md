# Expense Manager App - Auto Ticket Scanner

## Problem Description
In the current digital age, managing personal finances efficiently is crucial. 
One of the common challenges in expense tracking is the manual entry of data from physical 
receipts and tickets. This process is time-consuming and error-prone, 
often discouraging users from maintaining accurate records. 

Our solution is an enhancement for an expense manager app, 
where users can scan their ticket information using their mobile device, 
and the details are automatically added to their expense records.

## Proposed Solution
We have developed a feature in the Expense Manager App that allows users to scan physical tickets and receipts using their mobile device’s camera. The app will extract key details such as the amount, merchant name, date, and other relevant information from the ticket using **ML Kit** for scanning, and **Natural Language Processing (NLP)** to organize and categorize the extracted data.
Once the ticket is scanned, the app will automatically add the extracted data to the user's expense records, saving time and reducing human error. This seamless experience allows users to effortlessly track their expenses and maintain accurate financial records.

## Potential Impact
Implementing this solution would greatly improve the user experience for individuals who rely on receipts for tracking their expenses. The key impacts include:
- **Increased Efficiency:** Users no longer need to manually input details from their receipts, reducing the time spent managing their finances.
- **Improved Accuracy:** Automation reduces the risk of human error in data entry, ensuring more accurate expense records.
- **Convenience:** Users can simply scan receipts on the go, enhancing the overall user experience and encouraging consistent tracking of expenses.
- **Financial Awareness:** By making it easier to track expenses, users are more likely to stay on top of their spending, leading to better financial management.

## AI(s) Used
### 1. **ChatGPT**
- **Purpose:** ChatGPT is used to process and interpret the extracted data. It helps with natural language processing, particularly for converting receipt details into a standardized format and providing additional insights or categorization for the user.
### 2. **ML Kit (Machine Learning Kit)**
- **Purpose:** ML Kit is used for scanning and extracting text data from images of receipts. It leverages machine learning models to recognize text in images and convert it into machine-readable data for further processing and organization.
### 3. **Natural Language Processing (NLP)**
- **Purpose:** NLP is used to organize and categorize the extracted data. Once the information is scanned and converted into text, NLP helps to classify and structure the details (e.g., categorizing expenses into predefined categories like food, travel, or entertainment). It also aids in understanding and disambiguating the data, ensuring that the app categorizes transactions correctly and efficiently.

## Team
- **Alfredo Arrieta Bawab** - Staff Software Engineer, Android
- **Francisco Javier Gomez Vazquez** - Software Engineer
- **Olympia Garrocho González** - QA Software Engineer

## Technology Stack
- **Flutter**: Used for building the mobile app with a cross-platform approach (Android & iOS).
- **OpenAI (ChatGPT)**: Used for natural language processing and data categorization.
- **Google ML Kit**: Used for scanning and interpreting ticket information using machine learning models for text recognition.
- **Natural Language Processing (NLP)**: Used to organize and categorize the extracted data to ensure proper structuring of expense information.

# Getting Started
TODO: Guide users through getting your code up and running on their own system. In this section you can talk about:
1. Installation process
2. Software dependencies
3. Latest releases
4. API references

## Running project on Android Studio:

Create a .env file in the root of your project with the example content:

```dart
OPEN_AI_KEY=actual-openai-key-value
```dart

```dart

1. Open root folder of project
2. Go to "Add Configuration"
3. Add new run configuration
4. Select Flutter
5. On "Dart entrypoint" select main file (apps/`app_name`/lib/main.dart)
6. Select emulator
7. Click on Run

# Build and Test
TODO: Describe and show how to build your code and run the tests. 

# Contribute
TODO: Explain how other users and developers can contribute to make your code better. 

If you want to learn more about creating good readme files then refer the following [guidelines](https://docs.microsoft.com/en-us/azure/devops/repos/git/create-a-readme?view=azure-devops). You can also seek inspiration from the below readme files:
- [ASP.NET Core](https://github.com/aspnet/Home)
- [Visual Studio Code](https://github.com/Microsoft/vscode)
- [Chakra Core](https://github.com/Microsoft/ChakraCore)