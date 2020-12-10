FROM node:alpine as builder
WORKDIR '/app'
COPY package.json .
RUN npm install
COPY . .
RUN npm run build

# no need to call this phase <as something>
# this is bc every dockerfile only have 1 FROM
FROM nginx
# AWS elasticbeanstalk look for this and will be mapped by elasticbeanstalk
EXPOSE 80
# --from=<the name of phase>
# nginx image documentation suggested how to copy static html stuff to nginx
COPY --from=builder /app/build /usr/share/nginx/html