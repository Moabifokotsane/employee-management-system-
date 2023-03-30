#!/bin/bash

# Prompt user for name, department, and salary
echo
echo
read -p "Enter name: " name
echo
read -p "Enter department: " department
echo
read -p "Enter salary: " salary
echo
echo "           GENERATING ID NUMBER :"
# Generate ID number
id=$(echo "$name" | cut -c 1-3)_$(date +"%Y%m%d%H%M%S")
sleep 1
echo
echo "         ID GENERATED SUCCESSFULY"
echo
# Save new user information to file
echo "Name: $name" >> records.txt
echo "Department: $department" >> records.txt
echo "Salary: $salary" >> records.txt
echo "ID number: $id" >> records.txt
echo
echo "WAIT FOR YOUR INFORMATION"
sleep 2
echo
# Print out new user information
echo "New user added:"
echo "Name: $name"
echo "Department: $department"
echo "Salary: $salary"
echo "ID number: $id"

    ;;
