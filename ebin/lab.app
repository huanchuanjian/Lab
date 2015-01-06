{application,lab,
             [{description,"My lab application, o/ ~ ~"},
              {vsn,"1"},
              {registered,[]},
              {applications,[kernel,stdlib,crypto]},
              {mod,{lab_app,[]}},
              {env,[]},
              {modules,[http_handler,lab_app,lab_sup,monitor_test,ms,ops,
                        recv]}]}.
