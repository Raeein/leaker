# leaker

Run Valgrind from school servers without needing to connect to them (beautiful isn't it).

# Run It

- Have your docker running
- Go to the root of your C project
- Pull the docker image and run it
  
```bash
docker pull raeein/leaker:latest
docker run -v $(pwd):/root/build --rm --name leaker raeein/leaker:latest -m /src/main.c -v "arg1 arg2"
```

- Sample output
  
```bash
$ docker run -v $(pwd):/root/build --rm --name leaker raeein/leaker:latest -h

Compile and run Valgrind on school server (kinda). Run this container from the root of your C project.

Syntax:
docker run -v $(pwd):/root/build --rm --name leaker raeein/leaker:latest -m main_path -v "arg1 arg2"

arguments:
-m     Relative path from root of the project to the C file that has the main function.
-v     Arguments required to run the executable. Put all the args in a " " or 
       add them with -v flags. ex: "arg1 arg2" OR -v arg1 -v arg2.
-h     Help Menu.

```

- If you don't want to run the docker run command each time, add an alias to you shell scripts - if you're on a mac its probably `.zshrc`.
  
```bash
echo "alias leaker=docker run -v $(pwd):/root/build --rm --name leaker raeein/leaker:latest " >> ~/.bash_profile
. ~/.bash_profile
leaker -m src/main.c -v "arg1 arg2"
```

# Why the image is 3 gigs?

This image is based on the school's docker image and I didn't modify it to be sure its the same environment as the school servers.

# Other GCC flags

Pull this repo and change the first line in the Dockerfile - I might add an ARG to the Dockerfile later on.