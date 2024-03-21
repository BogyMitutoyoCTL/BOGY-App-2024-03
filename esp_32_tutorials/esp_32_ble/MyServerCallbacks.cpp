#include "MyServerCallbacks.h"

// if a new device connecting to the server
void MyServerCallbacks::onConnect(BLEServer *pServer)
{
    Serial.printf("New client connected.\n");
};

// if a device is disconnecting from the server
void MyServerCallbacks::onDisconnect(BLEServer *pServer)
{
    Serial.printf("Client disconnected.\n");
    // do advertising again, that the next client could connect...
    BLEDevice::startAdvertising();
}