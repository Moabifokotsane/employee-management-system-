#!/bin/bash

# Function to update employee information
update_employee() {
  echo "Enter employee name:"
  read name

  # Check if employee exists
  if grep -q "^Name: $name" records.txt; then
    # Prompt user for what information they want to update
    echo "What information would you like to update?"
    select choice in "Name" "Salary" "Department"; do
      case $choice in
        "Name")
          # Prompt user for new name
          echo "Enter new name:"
          read new_name

          # Update name in file
          sed -i "s/^Name: $name,.*$/Name: $new_name/" records.txt
          echo "Name updated successfully"
          break
          ;;
        "Salary")
          # Prompt user for new salary
          echo "Enter new salary:"
          read salary

          # Check if user wants to update salary with a percentage
          echo "Would you like to update the salary with a percentage? (y/n)"
          read answer
          if [[ "$answer" == "y" ]]; then
            echo "Enter percentage (e.g. 10%):"
            read percent
            # Calculate new salary with percentage
            salary=$(echo "$salary * (1 + $percent/100)" | bc -l)
          fi

          # Update salary in file
          sed -i "s/^Name: $name,.*$/& Salary: $salary/" records.txt
          echo "Salary updated successfully"
          break
          ;;
        "Department")
          # Prompt user for new department
          echo "Enter new department:"
          read department

          # Update department in file
          sed -i "s/^Name: $name,.*$/& Department: $department/" records.txt
          echo "Department updated successfully"
          break
          ;;
        *)
          echo "Invalid option"
          ;;
      esac
    done
  else
    echo "Employee not found"
  fi
}

# Call update_employee function
update_employee
    ;;
