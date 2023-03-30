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
