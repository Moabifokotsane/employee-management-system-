#!/bin/bash
#!/bin/bash
echo
echo
echo
echo -e "\e[38;5;208m     ___       __                      \e[0m"
echo -e "\e[38;5;208m    /   | ____/ /___  ____ ___  ____ _/ /_\e[0m"
echo -e "\e[38;5;208m   / /| |/ __  / __ \/ __ \`__ \/ __ \`/ __/\e[0m"
echo -e "\e[38;5;208m  / ___ / /_/ / /_/ / / / / / / /_/ / /_  \e[0m"
echo -e "\e[38;5;208m /_/  |_\__,_/\____/_/ /_/ /_/\__,_/\__/  \e[0m"
echo -e "\n \e[38;5;117m                 Employee Records          by Moabi Fokotsane\e[0m"
echo
echo
echo "Welcome to the Employee Management System"
echo
echo "Please select an option:"
echo "1. Add user"
echo "2. Remove user"
echo "3. Update user"
echo "4. Retrieve user"
echo
read -p "Enter your choice (1-4): " choice
case $choice in
  1)
    echo
    echo "Add user"
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
  2)
    echo "Remove user"
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
  3)
    echo "Update user"
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
  4)
    echo "Retrieve user"
    echo
#!/bin/bash

# function to display employee details
display_employee() {
    echo "Name: $1"
    echo "Department: $2"
    echo "Salary: $3"
    echo "ID number: $4"
    echo ""
}

# read user input for search
read -p "Enter name to search: " search_name
read -p "Do you want to filter by department? (Y/N): " filter_department
if [[ $filter_department == "Y" || $filter_department == "y" ]]; then
    read -p "Enter department to filter: " search_department
fi
read -p "Do you want to filter by salary? (Y/N): " filter_salary
if [[ $filter_salary == "Y" || $filter_salary == "y" ]]; then
    read -p "Enter 'above' or 'below' to filter salary: " salary_filter
    read -p "Enter salary value: " salary_value
fi

# search for employees by name
echo "Employees with name '$search_name':"
if [[ $filter_department == "Y" || $filter_department == "y" ]]; then
    if [[ $filter_salary == "Y" || $filter_salary == "y" ]]; then
        # search with department filter and salary filter
        if [[ $salary_filter == "above" ]]; then
            awk -F':' -v name="$search_name" -v dep="$search_department" -v sal="$salary_value" '($1 ~ name && $2 ~ dep && $3 >= sal) {print $0}' records.txt
        else
            awk -F':' -v name="$search_name" -v dep="$search_department" -v sal="$salary_value" '($1 ~ name && $2 ~ dep && $3 <= sal) {print $0}' records.txt
        fi
    else
        # search with department filter only
        awk -F':' -v name="$search_name" -v dep="$search_department" '($1 ~ name && $2 ~ dep) {print $0}' records.txt
    fi
elif [[ $filter_salary == "Y" || $filter_salary == "y" ]]; then
    # search with salary filter only
    if [[ $salary_filter == "above" ]]; then
        awk -F':' -v name="$search_name" -v sal="$salary_value" '($1 ~ name && $3 >= sal) {print $0}' records.txt
    else
        awk -F':' -v name="$search_name" -v sal="$salary_value" '($1 ~ name && $3 <= sal) {print $0}' records.txt
    fi
else
    # search without filters
    awk -F':' -v name="$search_name" '($1 ~ name) {print $1}' records.txt
   fi

# display total number of employees
echo "Total number of employees: $(wc -l < records.txt)"

# display department employee belongs to
if [[ $filter_department == "Y" || $filter_department == "y" ]]; then
    echo "Employees in department '$search_department':"
    awk -F':' -v dep="$search_department" '($2 ~ dep) {print $0}' records.txt
fi

    ;;
  *)
    echo "Invalid choice"
    ;;
esac
