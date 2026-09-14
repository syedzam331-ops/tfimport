subscription_id = "71a493c0-e420-4676-ab7c-c5d0ea5128a4"

linux_ssh_public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQCC5uquc103cMyXTYTGNKnF4zAVXQemcd4T+tEbjSOX848d77oTRLjmMT4z0qkhKvPahap32AXPVZva3Iu3hswqU/X1k0Kclyp7J5DsLfUaYrwBnB7FR10NLt+u513e21AtZS//K5/jeikCBcPHGuiHM4hJTf+D2Ny9lG/pbP9b+p9/5nv5Kd3vxYAmUttfD1yAfyfh47L4cg/t3ctbHUCdtkizZ9JeRIOKlNctnBX2Kg5UoeDqF5U7trtAY0VwYdEkrtiZcCJVAq4+F2tmzLxn3nOVs+YSJPR7LYIhiDWApnXbLoB7p2QfX8DFcks3/kOW4D9B3X5mc/qoztBsXdqiBC4UnKILv/BEZmLu0X3VeQ0TXUCJEbJC8E7CXuRMG4EhPvD1NigRrTXH217Yyf7uKKTvhGRJ4fV5acP2EZMkrrPWSj7mr30emVFZ/zgrMgkA7oGMzWfXCAp0m8BIPmlhRhfjfyHGwSNRV5JFWnOH4Um48kgB4GcaO499OAf6gFBMT7S/f3pG4hNNvOKLsCt4RXXU9jGs632kzGWi+cUuMUNh7kq8epsRJvbRLP1SmJTNUKO1YBcNU/Ejc0pN8Ln+by/qV4Sv93dOg5h9FN+RuQYjlo5nCwmta530RFmiexhkvifWdoI23/OJFZrRLWdq428a/GBecvOyRkRkat5lmQ== surendrababu1037@gmail.com"

workloads = {
  "rg01" = {
    name_prefix          = "uat-rg01"
    rg_name              = "uat-rg01"
    location_primary     = "eastus"
    location_secondary   = "southindia"
    linux_vm_name        = "uat-linux-01"
    windows_vm_name      = "uat-win-01"
    datafactory_name     = "uat-df-01"
    keyvault_name        = "uat-kv-01"
    log_analytics_name   = "uat-law-01"
    sql_server_name      = "uat-sql-01"
    sql_location         = "eastasia"
    sql_admin_login      = "uatsqladmin01"
    storage_account_name = "uatstg01"
    app_service_name     = "uat-web-01"
    app_service_location = "westus3"
  }

  "rg02" = {
    name_prefix          = "uat-rg02"
    rg_name              = "uat-rg02"
    location_primary     = "eastus"
    location_secondary   = "southindia"
    linux_vm_name        = "uat-linux-02"
    windows_vm_name      = "uat-win-02"
    datafactory_name     = "uat-df-02"
    keyvault_name        = "uat-kv-02"
    log_analytics_name   = "uat-law-02"
    sql_server_name      = "uat-sql-02"
    sql_location         = "eastasia"
    sql_admin_login      = "uatsqladmin02"
    storage_account_name = "uatstg02"
    app_service_name     = "uat-web-02"
    app_service_location = "westus3"
  }

  "rg03" = {
    name_prefix          = "uat-rg03"
    rg_name              = "uat-rg03"
    location_primary     = "eastus"
    location_secondary   = "southindia"
    linux_vm_name        = "uat-linux-03"
    windows_vm_name      = "uat-win-03"
    datafactory_name     = "uat-df-03"
    keyvault_name        = "uat-kv-03"
    log_analytics_name   = "uat-law-03"
    sql_server_name      = "uat-sql-03"
    sql_location         = "eastasia"
    sql_admin_login      = "uatsqladmin03"
    storage_account_name = "uatstg03"
    app_service_name     = "uat-web-03"
    app_service_location = "westus3"
  }

  "rg04" = {
    name_prefix          = "uat-rg04"
    rg_name              = "uat-rg04"
    location_primary     = "eastus"
    location_secondary   = "southindia"
    linux_vm_name        = "uat-linux-04"
    windows_vm_name      = "uat-win-04"
    datafactory_name     = "uat-df-04"
    keyvault_name        = "uat-kv-04"
    log_analytics_name   = "uat-law-04"
    sql_server_name      = "uat-sql-04"
    sql_location         = "eastasia"
    sql_admin_login      = "uatsqladmin04"
    storage_account_name = "uatstg04"
    app_service_name     = "uat-web-04"
    app_service_location = "westus3"
  }
}
