nagios-check-bulksms-credits
============================

A Nagios check for monitoring the remaining credits on a BulkSMS account

It's a bit rough and everything is hardcoded. See "changeme" for places to edit.

Configuration
-------------

    define command{
      command_name  check_bulksms
      command_line  $USER1$/check_bulksms.rb
      }
    
    define service{
      use                             generic-service 
      host_name                       bulksms
      service_description             BulkSMS Credit Monitor
      check_command                   check_bulksms
      check_interval                  60
      notification_period             workhours
    }
