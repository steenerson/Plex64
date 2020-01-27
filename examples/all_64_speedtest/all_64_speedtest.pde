// Plex64 Analog Input Multiplexer shield example sketch, all_64_speedtest.pde
// Version 1, 2020-01-25
// https://github.com/steenerson/Plex64

#include <Plex64.h>
//#include <Wire.h>

// Setup pins and I2C address. These are the default values and are correct
// if the shield is plugged directly into Arduino with stock I2C solder jumpers
static const uint8_t plexE = A0;
static const uint8_t plexF = A1;
static const uint8_t plexG = A2;
static const uint8_t plexH = A3;
static const uint8_t plexAddress = 0x20;

//Create instance
Plex64 plex64(plexAddress, plexE, plexF, plexG, plexH);

void setup() {
  //Run begin(), required to setup I2C port and inputs
  plex64.begin();

  //Uncomment Wire.h include and this line to slow I2C speed from 400kHz->100kHz, may be
  //necessary on some 3.3V systems due to stock 4.7k pullup resistors.
  //Wire.setClock(100000);

  //set D2 as output, you can use a multimeter set to Hz or an oscilloscope to measure the frequency
  pinMode(D2, OUTPUT);
}

void loop() {
  for (int i = 0; i < 16 ; i++) {
    //toggle D2 pin so we can measure the loop frequency
    //digitalWrite(D2, !digitalRead(D2));
    digitalWrite(D2, HIGH);
    //update all 4 channels 
    plex64.setAllChannels(i);
    //toggle D2again
    //digitalWrite(D2, !digitalRead(D2));
    digitalWrite(D2, LOW);
    //read all 4 analog pins
    analogRead(plexE);
    analogRead(plexF);
    analogRead(plexG);
    analogRead(plexH); 
  }
}