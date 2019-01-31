# Building Smart Apps using Mendix and The Things Network
In this workshop you will learn about the Mendix Platform and get hands on experience building your first IoT-enabled smart app.

We will cover:

- Introduction to the Mendix Platform.

- What is a Smart App?

- Understanding of use cases for Mendix and The Things Network.

- Hands-on session using the Mendix Modeler to build out your first app without writing code.

- Deploying your app to the cloud with a single click.

## Installation
### Sign up for Mendix
To get started with your first Mendix Smart App you will need to sign up for the Mendix Platform. 

1. Sign up for the Mendix Platform using this link: [https://signup.mendix.com/link/signup/](https://signup.mendix.com/link/signup/)
2. Use your business email address (Gmail, Hotmail, or Yahoo are not accepted).

    ![alt text][signup]

3. Click the confirmation link in the confirmation email to finalize your account setup.
4. You will be presented with three options to start your Mendix journey. Select the Desktop Modeler option and click Get Started.

    ![alt text][startjourney]

### Installing the Modeler
For this exercise you will need to download and install the Mendix Desktop Modeler.

1. Go to [https://appstore.home.mendix.com/link/modelers/](https://appstore.home.mendix.com/link/modelers/) and download Mendix Desktop Modeler 7.22.2 release or higher.

    ![alt text][download]

2. When the download is complete, install the Desktop Modeler on your Windows machine or a virtual machine if you're using a Mac. The installer will install all the necessary frameworks for the Modeler to run. These include:
    - Microsoft .NET Framework 4.6.2
    - Microsoft Visual C++ 2010 SP1 Redistributable Package
    - Microsoft Visual C++ 2013 Redistributable Package
    - Java Development Kit 1.8


    ![alt text][install]


### Creating your project
To get started you will need to import the [starter package](./starter%20package/SmartHome.mpk) in the Modeler and setup your own project.

1. Open the **Mendix Desktop Modeler**.
2. Sign in with your Mendix account details.
3. Go to **File -> Import Project Package**.

    ![alt text][importpackage]

4. Enter a name for the app and choose a location on your computer to store it.
5. Click OK. The platform will create you a new Team Server repository. Team Server is a version control system that stores your Mendix projects.

    ![alt text][nameproject]

Once complete, you'll be ready to begin the build of your smart app.

### Creating the Access Keys
If you want to connect your Mendix app up to your own data you will need to add a device and generate an application key in The Things Network console. 

NOTE: If you don't have a device, feel free skip this step and use the example keys provided here: [Credential Details](./credentials/example.md)

Follow these guides to get your first device set up:
[https://www.thethingsnetwork.org/docs/applications/add.html](https://www.thethingsnetwork.org/docs/applications/add.html)

Once set up you need to generate an access key. This can be done in the settings section of the application. 

The key needs to have at least message privledges.
    ![alt text][accesskey]

The access key value can be found on the overview page of the application. You will need to use the key later in the mqtt setup.
    ![alt text][keys]


## Connecting to the MQTT Broker
### Downloading the client
In order to get data from The Things Network (TTN) you need to subscribe to the MQTT Broker. This will allow you to get notified when new data is sent from your device.

The first thing you need to do is download the MQTT Client from the App Store.

1. In the Modeler, click on the shopping icon in the top right hand corner and search for MQTT.
2. Download the MQTT Client module into the project.

    ![alt text][appstore]

### Subscribing to the topic

Next we need to call a microflow to subscribe to the MQTT Topic.

1. Right click **MyFirstModule** in the Project Explorer and select **Add microflow**.

    ![alt text][addmicroflow]

2. Give the microflow an approriate name.

    ![alt text][namemicroflow]

3. Once you're in the microflow editor, select the **Action** activity from the menu bar at the top and drag the activity onto the line.

    ![alt text][microflowactivity]

4. Double click on the action activity and select **MQTT subscribe** from the menu.

    ![alt text][selectmqttsubscribe]

5. Double click the MQTT Subscribe actvity top open its properties and fill in the following:

|Setting|Value|
|---|---|
|Broker Host|eu.thethings.network (if other region replace the eu)|
|Broker port|1883 (8883 is also supported but requires additional certs)|
|Broker organisation|empty|
|Timeout|60|
|Username|Application ID set in the Things Network or [example credentials](./credentials/example.md)|
|Password|The Access Key setup earlier in this [step](#Creating-the-Access-Keys) or [example credentials](./credentials/example.md)|
|Topic Name|+/devices/+/up|
|On Message Microflow|[Create a new Microflow](#On-Message-Microflow)|
|CA|empty|
|Client certificate|empty|
|Client key|empty|
|Client password|empty|
|QoS|At_Most_Once_0|

### On Message Microflow

1. On the MQTT Subscribe option click **select** and then **New**.
2. Give the microflow a name and click **OK**. The On Message Microflow will require two string parameters. One for the Payload and one for the Topic. 
2. Click on the parameter icon in the topbar and add two parameters: **Topic** and **Payload**.
    ![alt text][parameteroption]
    
    ![alt text][processmicroflow]

    You now need to add a log message to the flow to ensure that everything is working correctly.

3. Add a new activity to the line and select **Log message**. Then configure the log message like so:

    ![alt text][logmessage]

### Add subscribing microflow to page

1. Open the **Home** page by double clicking on it in the Project Explorer.
2. Click **Add widget...** from the menu bar.
3. Search for *microflow* and select **Call microflow button**.
4. Click on the page where you want to add the button.
5. Finally, select the microflow that you created earlier to subscribe to the topic.


### Running the app

You've now built the required functionality to subscribe.

1. Run the app and test it by selecting the **Run locally** option in the deployment drop-down. This will start the app, running on http://localhost:8080.

    ![alt text][runlocally]

2. Click **View** to open the app.
3. Click **Subscribe** (thge button you added before). If successful, your app should be now subscribed to The Things Network.

## Processing the Payload

To process the payload you need to utilize the Mendix Import Mapping functionality. This allows developers to import data from XML and JSON into Mendix entities.

### Step 1 

The first thing you need to do is get the JSON that is returned in the payload of our microflow. This will appear in the Mendix console when data is sent to The Things Network. If you don't see this, check your connection. 

![alt text][console]

You will see a log entry with something similar to the following:

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

Using the copied JSON, you need to create a JSON Structure.

1. Right click MyFirstModule in the Project Explorer, open **Add other** and select **JSON structure**.

    ![alt text][addjson]

2. Paste the copied JSON into the dialog box.
3. Click on **Format** and then **Refresh**.

    ![alt text][jsonstructure]

### Step 3

Now that you have your data payload represented you need to create an import mapping.

1. Right click **MyFirstModule** in the Project Explorer, open **Add other** and select **Import mapping**.
2. Inside the import mapping, select the JSON structure and click **Expand All**.

    ![alt text][importmapper]

    We are only interested in some of the data from the response so we have selected only the fields required.

    Using the mapping we can map data from the JSON response to our domain model.
    
3. Click **Map automatically**. 

    You are going to use an entity that is available in the starter app and get the mapper to generate the new attributes.
    
4. Drag the **Device Data** entity from the connector into the space provided.

    ![alt text][dragdataentry]

5. Click **Map attributes by name**. This will map one attribute the time. 

6. Click **Select** on the time attribute line.

    You need to convert the date string into a date.
    
7. Select the microflow **ConvertToDateTime**.

    ![alt text][converttodatetime]

    Next you need to generate the attributes for our data mapping.

8. Click **Map Automatically** and then **Close**.

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

![alt text][dashboard]


## Making a change

### Adding a decision
Now that we are able to visualise our sensor data the next step is to add proactive actionable alerts.

We want to trigger an alert if our light levels go below a certain level.

To start with we will edit our processing microflow for processing the data.

Add a exclusive split to the microflow.

![alt text][exclusivesplit]

Inside the exclusive split add the condition, or one that meets your use case:

`$DeviceData/Light < 15 `

![alt text][exclusivesplitdecision]

Create two decision lines one for true and one for false by dragging from the exclusive split.

![alt text][drawexclusivesplit]

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
[selectno]: ./img/selectno.png "Payload Mapping"
[latestrecord]: ./img/latestrecord.png "Latest Record"
[selectattribute]: ./img/selectattribute.png "Select Attribute"
[selectentitychart]: ./img/selectentitychart.png "Select Entity Chart"
[editseries]: ./img/editseries.png "Edit Series"
[microflowtimerselect]: ./img/microflowtimerselect.png "Microflow timer"
[navigationprofile]: ./img/navigationprofile.png "Navigation Profile"
[exclusivesplit]: ./img/exclusivesplit.png "Exclusive split"
[exclusivesplitdecision]: ./img/exclusivesplitdecision.png "Exclusive split decision"
[createalert]: ./img/createalert.png "create alert"
[alertssnippet]: ./img/alertssnippet.png "Alerts Snippet"
[drawexclusivesplit]: ./img/drawexclusivesplit.gif "Alerts Snippet"
[console]: ./img/console.png "console"
[dashboard]: ./img/dashboard.png "dashboard"
