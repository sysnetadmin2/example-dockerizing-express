# ---- Base ----
FROM node:12.16.1-alpine AS base
# install os package
RUN apk add --no-cache make gcc g++ python
# set working directory
RUN mkdir /example-dockerizing-express
WORKDIR /example-dockerizing-express
# copy project file
COPY package.json .

# ---- Dependencies ----
FROM base AS dependencies
# install node modules
RUN npm set progress=false && npm config set depth 0
RUN npm install --only=production
# copy production node_modules aside
RUN cp -R node_modules prod_node_modules
# install all node_modules, including 'devDependencies'
RUN npm install

# ---- Builder ----
FROM dependencies AS builder
COPY --from=dependencies /example-dockerizing-express/node_modules ./node_modules
COPY ./.babelrc ./.babelrc
COPY ./lib ./lib
COPY ./test ./test
RUN npm run build
RUN npm run test

# ---- Release ----
FROM base AS release
# set env
ARG NODE_ENV
ENV NODE_ENV=${NODE_ENV}
# copy production node_modules
COPY --from=dependencies /example-dockerizing-express/prod_node_modules ./node_modules
# copy app sources
COPY --from=builder /example-dockerizing-express/dist ./dist
# expose port and define CMD
EXPOSE 3300
CMD ["sh", "-c", "npm run start:${NODE_ENV}"]