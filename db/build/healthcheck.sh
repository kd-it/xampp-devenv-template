#!/bin/bash

# Wait for the database to be ready
mysqladmin ping -h localhost --silent -u ${MYSQL_USER} -p${MYSQL_PASSWORD} --wait=5
