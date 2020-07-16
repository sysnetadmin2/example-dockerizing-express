# Example Dockerizing Express

## Node Command

```bash

npm run install

npm run dev

npm run build

npm run test

npm run start:[dev, test, production]

```

## Docker Command

```bash

docker build --build-arg NODE_ENV=[dev, test, production] -t IMAGE_NAME .

docker run -p 3000:3000 IMAGE_NAME

```