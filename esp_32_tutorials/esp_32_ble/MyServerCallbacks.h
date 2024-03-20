#pragma once
#include <Arduino.h>
#include <BLEDevice.h>

class MyServerCallbacks : public BLEServerCallbacks
{
public:
    void onConnect(BLEServer *pServer) override;
    void onDisconnect(BLEServer *pServer) override;
};