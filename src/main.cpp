/*
 * Blink
 * Turns on an LED on for one second,
 * then off for one second, repeatedly.
 */
#include "Arduino.h"
#include <Adafruit_NeoPixel.h>

// 144 leads at pin 6
#define PIN 6
#define N_LEDS 144

Adafruit_NeoPixel strip = Adafruit_NeoPixel(N_LEDS, PIN, NEO_GRB + NEO_KHZ800);

// 500 ms delay
int delayval = 500;

void setup()
{
		// initialize LED digital pin as an output.
		strip.begin();
}

void loop()
{
		for(int i=0;i<N_LEDS;i++){
				strip.setPixelColor(i, strip.Color(0,150,0));
				strip.show();
				delay(delayval);
		}
}
