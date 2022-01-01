
#!/bin/bash
while true
    do
        export DISPLAY=:0.0

        battery_level=`acpi -b | grep -P -o '[0-9]+(?=%)'`
        is_charging=`acpi -b | grep -P -o Charging`
        is_discharging=`acpi -b | grep -P -o Discharging`

        if [ "$is_charging" = "Charging" ]; then                                
            if [ $battery_level -ge 90 ]; then              
                notify-send -u critical "Please unplug your AC adapter" "Battery level: ${battery_level}% (charged above 90%)" -i battery-full-charged; play /usr/share/sounds/gnome/default/alerts/drip.ogg
             fi
        elif [ "$is_discharging" = "Discharging" ]; then
          if [ $battery_level -le 20 ]; then              
                notify-send -u critical "Please plug your AC adapter" "Battery level: ${battery_level}% (below 20%)" -i battery-full-charged; play /usr/share/sounds/gnome/default/alerts/drip.ogg
             fi
        fi
      sleep 300                   #wait for 300 seconds before checking again

    done
