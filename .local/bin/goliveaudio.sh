#!/bin/bash
pactl load-module module-null-sink sink_name=Virtual1
pactl load-module module-loopback source=alsa_input.usb-SteelSeries_SteelSeries_Arctis_5_00000000-00.analog-chat sink=Virtual1
pactl load-module module-loopback source=Virtual1.monitor sink=alsa_output.usb-SteelSeries_SteelSeries_Arctis_5_00000000-00.analog-chat
