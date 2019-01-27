# Building Smart Apps using Mendix and The Things Network
Participants will learn about what the Mendix platform is and get hands on experience building their first IoT enabled smart app.

Within this workshop we will cover:

- Introduction to Mendix Platform.

- What is a Smart App?

- Understanding of use cases for Mendix and Things Network.

- Hands-On session using the Mendix Modeler to build out your first app without writing code.

- Deploying your app to the cloud.

## Installation
### Sign up for Mendix
To get started with developing your first Mendix Smart App you will need to sign up for the Mendix Platform. 

To get started use this link to sign up:
[https://signup.mendix.com/link/signup/](https://signup.mendix.com/link/signup/)

Enter in your details and click get started for free. Your email address must be a non gmail or hotmail domain.

![alt text][signup]

Once you have signed up you will need to confirm your account. You should receive an email with a link which once clicked will provision your new account.

![alt text][confirm]

When you confirm your account you will be presented with 3 options to start your Mendix journey. For this exercise we are going to focus on the desktop modeler. 

![alt text][startjourney]

The platform will then provision your account and give you a tour of the platform.

### Installing the Modeler
For this exercise we will need to download and install the Mendix Desktop modeler. The latest modeler downloads can be found here:

[https://appstore.home.mendix.com/link/modelers/](https://appstore.home.mendix.com/link/modelers/)

Download the 7.22.2 release or higher.
![alt text][download]



Install the software on your windows machine or virtual machine. The installer will install all the necessary frameworks for the modeler to run. These include:
- Microsoft .NET Framework 4.6.2
- Microsoft Visual C++ 2010 SP1 Redistributable Package
- Microsoft Visual C++ 2013 Redistributable Package
- Java Development Kit 1.8


![alt text][install]


### Creating your project
To get started with building your first smart application you will need to import up the starter package in the modeler and setup your own project.

To do so go to file -> Import Project Package.

![alt text][importpackage]

The modeler will then ask you to name your app and choose a location on your file system to store it. When you press OK the platform will create you a new Team Server repository, which is the Mendix version control system.

![alt text][nameproject]

Once complete you'll be ready to begin the build of your smart app.

## Building the App

### Connecting to the MQTT Broker

In order to get data from The Things Network (TTN) we need to subscribe to the MQTT Broker. This will allow us to get notified when new data is sent from our device.

The first thing we need to do is download the MQTT Client from the appstore.

Inside the modeler click on the shopping icon in the top right hand corner and search for MQTT. Then download the client into the project.

![alt text][appstore]

Next we need to call a microflow to subscribe to the MQTT Topic. Right click on the MyFirstModule in the project explorer and select add microflow.

![alt text][addmicroflow]

Give the microflow an approriate name.

![alt text][namemicroflow]

Inside the microflow editor select the Action Activity from the menu bar at the top and drag the activity onto the line.

![alt text][microflowactivity]

Double click on the action activity and select mqtt subscribe from the menu.

![alt text][selectmqttsubscribe]



[signup]: ./img/signuppage.png "Signup image"
[confirm]: ./img/confirmaccount.png "Confirm Account"
[startjourney]: ./img/wheretostart.png "Start your Journey"
[download]: ./img/download.png "Download the modeler"
[install]: ./img/install.png "Install the modeler"
[importpackage]: ./img/importprojectpackage.png "Import Project Package"
[nameproject]: ./img/importpackagewithname.png "Naming project"
[appstore]: ./img/appstore.png "Search MQTT in appstore"
[addmicroflow]: ./img/addmicroflow.png "Add Microflow"
[namemicroflow]: ./img/namemicroflow.png "Name the microflow"
[microflowactivity]: ./img/microflowactivity.png "Name the microflow"
[selectmqttsubscribe]: ./img/selectmqttsubscribe.png "Name the microflow"