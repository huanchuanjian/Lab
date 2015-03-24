{application,lab,
             [{description,"My lab application, o/ ~ ~"},
              {vsn,"1"},
              {registered,[]},
              {applications,[kernel,stdlib,crypto]},
              {mod,{lab_app,[]}},
              {env,[]},
              {modules,[db_agent,http_handler,lab_app,lab_sup,lib_csv,log_gs,
                        monitor_test,ms,ops,recv]}]}.
