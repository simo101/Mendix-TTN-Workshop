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

### Creating the Access Keys
Before we can connect to our devices data we need to ensure that we have created an application and device in the Things Network console.

Follow these guides to get your first device setup:
[https://www.thethingsnetwork.org/docs/applications/add.html](https://www.thethingsnetwork.org/docs/applications/add.html)

Once setup you need to generate an access key. This can be done in the settings section of the application. 

The key needs to have at least message privledges.

![alt text][accesskey]

The access key value can be found on the overview page of the application. You will need to use the key later in the mqtt setup.

![alt text][keys]


## Connecting to the MQTT Broker
### Downloading the client
In order to get data from The Things Network (TTN) we need to subscribe to the MQTT Broker. This will allow us to get notified when new data is sent from our device.

The first thing we need to do is download the MQTT Client from the appstore.

Inside the modeler click on the shopping icon in the top right hand corner and search for MQTT. Then download the client into the project.

![alt text][appstore]

### Subscribing to the topic

Next we need to call a microflow to subscribe to the MQTT Topic. Right click on the MyFirstModule in the project explorer and select add microflow.

![alt text][addmicroflow]

Give the microflow an approriate name.

![alt text][namemicroflow]

Inside the microflow editor select the Action Activity from the menu bar at the top and drag the activity onto the line.

![alt text][microflowactivity]

Double click on the action activity and select mqtt subscribe from the menu.

![alt text][selectmqttsubscribe]

Double click on the MQTT Subscribe actvity and fill in the following:

|Setting|Value|
|---|---|
|Broker Host|eu.thethings.network (if other region replace the eu)|
|Broker port|1883 (8883 is also supported but requires additional certs)|
|Broker organisation|empty|
|Timeout|60|
|Username|Application ID set in the Things Network|
|Password|The Access Key setup earlier in this [step](#Creating-the-Access-Keys)|
|Topic Name|+/devices/+/up|
|On Message Microflow|[Create a new Microflow](#On-Message-Microflow)|
|CA|empty|
|Client certificate|empty|
|Client key|empty|
|Client password|empty|
|QoS|At_Most_Once_0|

### On Message Microflow

On the MQTT Subscribe option click select and then new. Give the microflow a name and click ok. The On Message Microflow will require two string parameters. One for the Payload and one for the Topic. 

![alt text][processmicroflow]

To create the microflow parameter click on the parameter icon on the topbar.

![alt text][parameteroption]

Once we have the parameters added we need to add a log message to the flow to ensure that everything is working correctly.

Add a new activity to the line and select log message. Then configure the log message like so:

![alt text][logmessage]

### Add subscribing microflow to page.
Open up the home page by double clicking on it in the project explorer.

Click add widget from the menu bar. Using the dialog box search for microflow and select microflow button. Then place the button on the page.

Finally select the microflow that we created earlier to subscribe to the topic.


### Running the app
We've now built the required functionality to subscribe. To run the app and test it click on the run locally button. This will start the app running on http://localhost:8080.

![alt text][runlocally]

Using a browser we can open up our app and press the subscribe button. If successful our app should be now subscribed to the Things Network.

## Processing the Payload
To process the payload we need to utilize the Mendix Import Mapping functionality. This allows developers to import data from XML and JSON into Mendix entities.

### Step 1 
The first thing we need to do is get the JSON that is returned in the payload of our microflow. This will appear in the Mendix console when data is sent to The Things Network, If you don't see this then check your connection. You will see a log entry with something similar to the following:

`{
    "app_id": "ttn-node-simon",
    "dev_id": "ttn-node-1",
    "hardware_serial": "0004A30B001FEFFE",
    "port": 3,
    "counter": 27,
    "payload_raw": "D1QAEgou",
    "payload_fields": {
        "battery": 3924,
        "event": "motion",
        "light": 18,
        "temperature": 26.06
    },
    "metadata": {
        "time": "2019-01-29T17:46:37.512499778Z",
        "frequency": 868.5,
        "modulation": "LORA",
        "data_rate": "SF7BW125",
        "airtime": 51456000,
        "coding_rate": "4/5",
        "gateways": [
            {
                "gtw_id": "eui-b827ebfffe49b783",
                "timestamp": 392151467,
                "time": "2019-01-29T17:46:37.4621890Z",
                "channel": 2,
                "rssi": -17,
                "snr": 7.2,
                "rf_chain": 1,
                "latitude": 52.45549,
                "longitude": 0.29627,
                "altitude": 11
            }
        ]
    }
}`

Copy this to your clipboard.

### Step 2
Using the copied JSON we need to create a JSON Structure.

Right click on the MyFirstModule in the project explorer, select add other and click on JSON Structure.
![alt text][addjson]


Paste the copied JSON into the dialog box then click on format and Refresh.
![alt text][jsonstructure]

### Step 3
Now that we have our data payload represented we need to create an import mapping.

Right click on the MyFirstModule in the project explorer and select import mapping.

Inside the import mapping select the JSON structure and click on Expand All.

![alt text][importmapper]

We only are only interested in some of the data from the response so we have selected only the fields required.

Using the mapping we can map data from the JSON response to our domain model. This can be done automatically for you using the Map automatically button. 

We are going to use an entity we have available in the starter app and get the mapper to generate the new attributes for us. Drag the Device Data entity from the connector into the space provided.

![alt text][dragdataentry]

Click the button Map attributes by name. This will map one attribute the time. 

Then click on select on the time attribute line. We need to convert the date string into a date. Select the microflow "ConvertToDateTime".

![alt text][converttodatetime]

Next we need to generate the attributes for our data mapping.

Click Map Automatically button and click close.

![alt text][mapautomatically]

### Step 4
Now that our import mapping is complete we can use it in our microflow to import the data.

Open up your process microflow with the payload parameter.

Create a new activity and select import with mapping.

Inside the mapping select the payload as the variable, the import mapping as our new mapping and yes to store in variable.

![alt text][payloadimport]

## Building the dashboard
Now that we have our data we need a way to visualise it.

Create a new page and select Dashboard TTN.

![alt text][selectdashboardttn]

### Configure the stats
Double Click on the top level dataview and select the microflow "GET_RefreshObj".

![alt text][topdataview]

Select no when asked if you want to fill the contents.


![alt text][selectno]


Next we need to get the latest record for our temperature and light data. Double click on the dataview containing the temperature and set the data source as get latest record microflow. Select No when asked to generate.

![alt text][latestrecord]

Configure the temperature, light and battery by double clicking on the missing parameter labels and then click on edit. Under the parameters section click edit. Select the attributes you wish to show.

![alt text][selectattribute]

### Configure the Graphs
Double click on the area chart and then double click on the series.

Under the data source tab select the DeviceData entity.

![alt text][selectentitychart]


Under the data points tab select the x-axis attribute, y-axis attribute and the x-axis sort attribute.

![alt text][editseries]

Do this process for both area charts.

### Connect up the Subscribe button
Connect up the new subscribe to TTN button to the microflow you created earlier.

### Connect up microflow timer
Double click on the microflow timer widget and on the microflow option select
![alt text][microflowtimerselect]

### Configure Homepage
Next we need to hook up our new page to the navigation. On the default homepage click on select and choose the new page.
![alt text][navigationprofile]

### Run the app
Now that we've setup our dashboard we can run it locally and open the app up in our browser.

Click subscribe to TTN and you should see data appear in the dashboard.

Congratulations you've built your first IoT connected app!


## Making a change

### Adding a decision
Now that we are able to visualise our sensor data the next step is to add proactive actional alerts.

We want to trigger an alert if our light levels go below a certain level.

To start with we will edit our processing microflow for processing the data.

Add a exclusive split to the microflow.

![alt text][exclusivesplit]

Inside the exclusive split add the condition, or one that meets your use case:

`$DeviceData/Light < 15 `

![alt text][exclusivesplitdecision]

Create two decision lines one for true and one for false by dragging from the exclusive split.

### Adding an alert

Next we need to create a new object to store our alert in.

Add a new activity to the true line of the microflow and select create object.

![alt text][createalert]

Add two attributes by pressing the new button and fill in title and message.

### Add to dashboard
Next we need to be able to see the alerts. To help with building this functionality i have included a handy snippet that you can drag and drop onto the page.

Using the project explorer drag the snippet from the explorer onto the page below the subscribe to TTN button. This snippet is in the USEME folder.

![alt text][alertssnippet]



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
[accesskey]: ./img/accesskey.png "Creating a accesskey"
[keys]: ./img/keys.png "Viewing keys"
[processmicroflow]: ./img/processmicroflow.png "Microflow Process"
[parameteroption]: ./img/parameteroption.png "Parameter options"
[logmessage]: ./img/logmessage.png "Log Message"
[runlocally]: ./img/runlocally.png "Run Locally"
[addjson]: ./img/addjson.png "Add JSON"
[jsonstructure]: ./img/jsonstructure.png "Add JSON"
[importmapper]: ./img/importmapper.png "Add JSON"
[dragdataentry]: ./img/dragdataentry.png "Data Entry"

[converttodatetime]: ./img/converttodatetime.png "Convert to Date time"

[converttodatetime]: ./img/converttodatetime.png "Convert to Date time"

[mapautomatically]: ./img/mapautomatically.png "Map automatically"

[payloadimport]: ./img/payloadimport.png "Payload Import"
[selectdashboardttn]: ./img/selectdashboardttn.png "Select Dashboard"
[topdataview]: ./img/topdataview.png "Top Dataview"
[selectno]: 
./img/selectno.png "Payload Mapping"

[latestrecord]: 
./img/latestrecord.png "Latest Record"

[selectattribute]: 
./img/selectattribute.png "Select Attribute"

[selectentitychart]: 
./img/selectentitychart.png "Select Entity Chart"

[editseries]: 
./img/editseries.png "Edit Series"

[microflowtimerselect]: 
./img/microflowtimerselect.png "Microflow timer"

[navigationprofile]: 
./img/navigationprofile.png "Navigation Profile"

[exclusivesplit]: 
./img/exclusivesplit.png "Exclusive split"

[exclusivesplitdecision]: 
./img/exclusivesplitdecision.png "Exclusive split decision"

[createalert]: 
./img/createalert.png "create alert"

[alertssnippet]: 
./img/alertssnippet.png "Alerts Snippet"
