# leaker

Run Valgrind from school servers without needing to connect to them (beautiful isn't it).

# Run It

- Have your docker running
- Go to the root of your C project
- Pull the docker image and run it
  
```bash
docker pull raeein/leaky:latest
docker run -v $(pwd):/root/build --rm --name leaky raeein/leaky:latest -m /src/main.c -v "arg1 arg2"
```

- If you don't want to run the docker run command each time, add an alias to you shell scripts - if you're on a mac its probably `.zshrc`.
  
```bash
echo "alias leakey=docker run -v $(pwd):/root/build --rm --name leaky raeein/leaky:latest " >> ~/.bash_profile
. ~/.bash_profile
leaky -m src/main.c -v "arg1 arg2"
```

# Why the image is 3 gigs?

This image is based on the school's docker image and I didn't modify it to be sure its the same environment as the school servers.

# Other GCC flags

Pull this repo and change the first line in the Dockerfile - I might add an ARG to the Dockerfile later on.