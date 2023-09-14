#!/bin/sh

connected_monitors=$(xrandr --query | grep " connected" | cut -d " " -f 1)
monitor_count=$(echo "$connected_monitors" | wc -l)
bspwmrc_path="$XDG_CONFIG_HOME/bspwm/bspwmrc"
confirm_pattern="^([yY][eE][sS]|[yY]+)$"

workspaces_prompt () {
  current_monitor=$1

  #Init prompt for adding workspaces
  read -rp "Would you like to add workspaces for $current_monitor [y/n]? " answer

  #If user answers yes 
  if [[ $answer =~ $confirm_pattern ]]; then
    IFS=', '

    #Read input and add workspaces to array
    read -rp "Enter workspaces for $current_monitor: " -a workspaces

    #Create new entry
    new_entry="bspc monitor $current_monitor -d ${workspaces[@]}"
    existing_entry=$(grep "bspc monitor $current_monitor" $bspwmrc_path)

    #Check if existing entry
    if [[ $existing_entry ]]; then
      #IF it is THEN replace existing entry with the new one
      sed -i "s/$existing_entry/$new_entry/" $bspwmrc_path
    else
      #Append new entry to bspwmrc
      echo $new_entry >> $bspwmrc_path
      fi
    else
      echo "Skipping workspaces for $current_monitor" 
    fi
  }

  single_workspace_prompt () {
    current_monitor=$1

    read -rp "Would you like to add workspaces for $current_monitor [y/n]? " answer

    if [[ $answer =~ $confirm_pattern ]]; then
      IFS=', '
      read -rp "Enter workspaces for $current_monitor: " -a workspaces
      new_entry="bspc monitor $current_monitor -d ${workspaces[@]}"
      other_entries=$(grep "^bspc\smonitor" $bspwmrc_path)

      #IF other entries exist then delete them and add new entry
      [[ $other_entries ]] && { sed -i "/^bspc\smonitor/d" $bspwmrc_path; echo $new_entry >> $bspwmrc_path; exit;}

      echo $new_entry >> $bspwmrc_path

    else
      echo "you answered no"
      fi
    }

    selection_menu () {
      PS3="$1" 
      options=($2)
      select opt in "${options[@]}"
      do
        echo "$opt"
        break;
      done
    }


    case "$monitor_count" in
      1) echo "Found 1 monitor: $connected_monitors" | xargs
        primary=$connected_monitors
        single_workspace_prompt $primary
        xrandr --output $primary --auto
        feh --bg-fill $HOME/Pictures/sunset.jpg --no-fehbg
        ;;
      2) echo "Found 2 monitors: $connected_monitors" | xargs
        primary=$(selection_menu "Select Primary monitor: " "${connected_monitors}")
        #Prompt for adding workspaces
        workspaces_prompt $primary

        secondary=$(echo "$connected_monitors" | grep -v "$primary")
        workspaces_prompt $secondary

        direction=$(selection_menu "What side of $primary should $secondary be on? " "left right")

        xrandr --output $primary --auto --output $secondary --$direction-of $primary --auto
        feh --bg-fill $HOME/Pictures/sunset.jpg --no-fehbg
        ;;
      *) echo "$monitor_count monitors found"
        ;;
    esac

