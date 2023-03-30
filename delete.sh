#!/bin/bash

# Function to remove an employee
remove_employee() {
  echo "Enter the name of the employee you want to remove:"
  read name

  # Check if employee exists
  if grep -q "^Name: $name" records.txt; then
    # Copy employee information to old_records.txt
    grep "^Name: $name" records.txt >> old_records.txt

    # Remove employee from records.txt
    sed -i "/^Name: $name/d" records.txt
    echo "Employee removed successfully"
  else
    echo "Employee not found"
  fi
}

# Call remove_employee function
remove_employee
    ;;
