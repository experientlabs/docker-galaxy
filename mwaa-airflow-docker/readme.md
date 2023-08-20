



In order to build image and launch the cluster, we are using a shell script `mwaa-local-env.sh`
So to build the imare run below command from this projects root directory
```
./mwaa-local-env build-image
```

In order to run the Airflow run below command
```
./mwaa-local-env start
```

Known Isssues:
Sometimes it throws error related to bad interpreter. 
> #0 0.688 /bin/sh: /systemlibs.sh: /bin/sh^M: bad interpreter: No such file or directory

But this is due to windows CR LF characters. In order to fix this, run below command to 
get rid of unwanted characters:
```bash
sed -i -e 's/\r$//' create_mgw_3shelf_6xIPNI1P.sh
```

https://askubuntu.com/questions/304999/not-able-to-execute-a-sh-file-bin-bashm-bad-interpreter

https://github.com/aws/aws-mwaa-local-runner