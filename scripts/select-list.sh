#!/bin/bash

options=("Option 1" "Option 2" "Option 3")

select opt in "${options[@]}"; do
    case $opt in
        "Option 1")
            echo "You selected Option 1"
            break
            ;;
        "Option 2")
            echo "You selected Option 2"
            break
            ;;
        "Option 3")
            echo "You selected Option 3"
            break
            ;;
        *) echo "Invalid option";;
    esac
done

