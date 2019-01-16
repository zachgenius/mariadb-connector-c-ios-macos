## maria-connector-c

This library is the MariaDB client library (version 3.0.8), built for iOS and Mac. The original source code built pretty easily on Mac, but there were various small tweaks to get it running on iOS, so I'm sharing it! This library has x86_64 and arm64 architectures built into it.

You can read all about the C api provided at [the MariaDB documentation site](https://mariadb.com/kb/en/library/mariadb-connector-c/). As MariaDB connector is capable with MySQL, you can also read [the MySQL documentation](http://dev.mysql.com/doc/refman/5.7/en/c-api.html)

## Installation

As I'm a lazy guy, I didn't generate a CocoaPod repository at all. You can copy the files from the Sources directory into your project.

Additionally, I prefer you generate your own library from the connector's source code. Tutorials are written in the Project's Wiki.

## Sample Project

Under Project Files there is a sample project demonstrating the libraries use. Most of the details you'll want are on the MariaDB and MySQL document site, though. 

The sample project simply lists the tables within a database. Update the #define statements at the top of ViewController.m to point to a database you have access to in order to see the results.

## Notes and Thanks

I made this project due to the demands of my product. It's inspired by [James Richard]()'s project [mysql-connector-c](https://github.com/ketzusaka/mysql-connector-c). Thanks to his tutorial, I generated the same version's mysql connector. However there're still some errors with the newest mysql connector/c 6.1.11.

With some modification from his tutorial, I successfully generated MariaDB connector/c library through the source code. And now the compiling tutorial is now in the wiki page.


