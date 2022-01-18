# lifutil

This was run as a devcontainer on vscode using Remote Containers

Reopen in container
& 
Build from Dockerfile

Open a terminal in vs code once the container is running. 
I had to manually run this last command from the Dockerfile

```
vncserver && websockify -D --web=/usr/share/novnc/ --cert=~/novnc.pem 80 localhost:5901 && tail -f /dev/null
```

got to http://localhost:6080/vnc.html
or http://localhost/vnc.html

```
C:
```
```
LIFARC.EXE
```

In the terminal on vscode 
```
cp /dos/* /workspaces/<dir_name>/
```

This copies files from dos in the linux container to your local machine where the container was run


Build Container Outside of VS code 
```
docker build -t lifutil
docker run -p 6080:80 lifutil
```

